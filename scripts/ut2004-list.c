#define _POSIX_C_SOURCE 200809L
#include <netdb.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <sys/time.h>
#include <unistd.h>

#define MAX_FRAME (512 * 1024)
#define MAX_SERVERS 100000
#define CLIENT_VERSION 3369

static int fd = -1;

static int read_all(unsigned char *buf, size_t len)
{
	size_t got = 0;

	while (got < len) {
		ssize_t n = recv(fd, buf + got, len - got, 0);
		if (n <= 0)
			return 0;
		got += (size_t)n;
	}
	return 1;
}

static long read_frame(unsigned char **out)
{
	unsigned char head[4], *buf;
	uint32_t len;

	if (!read_all(head, sizeof(head)))
		return -1;
	len = (uint32_t)head[0] | (uint32_t)head[1] << 8 | (uint32_t)head[2] << 16 | (uint32_t)head[3] << 24;
	if (len == 0 || len > MAX_FRAME)
		return -1;
	buf = malloc(len);
	if (!buf)
		return -1;
	if (!read_all(buf, len)) {
		free(buf);
		return -1;
	}
	*out = buf;
	return (long)len;
}

static int write_frame(const unsigned char *payload, size_t len)
{
	unsigned char frame[260];

	if (len > sizeof(frame) - 4)
		return 0;
	frame[0] = (unsigned char)(len & 0xff);
	frame[1] = (unsigned char)(len >> 8 & 0xff);
	frame[2] = frame[3] = 0;
	memcpy(frame + 4, payload, len);
	return send(fd, frame, len + 4, 0) == (ssize_t)(len + 4);
}

static size_t put_string(unsigned char *p, const char *s)
{
	size_t n = strlen(s) + 1;

	p[0] = (unsigned char)n;
	memcpy(p + 1, s, n);
	return n + 1;
}

static size_t put_int(unsigned char *p, uint32_t v)
{
	p[0] = (unsigned char)(v & 0xff);
	p[1] = (unsigned char)(v >> 8 & 0xff);
	p[2] = (unsigned char)(v >> 16 & 0xff);
	p[3] = (unsigned char)(v >> 24 & 0xff);
	return 4;
}

static int frame_is(const unsigned char *frame, long len, const char *word)
{
	size_t n = strlen(word);

	return len >= (long)(n + 2) && frame[0] == n + 1 && memcmp(frame + 1, word, n) == 0 && frame[n + 1] == 0;
}

static int expect(const char *word)
{
	unsigned char *frame;
	long len = read_frame(&frame);
	int ok;

	if (len < 0)
		return 5;
	ok = frame_is(frame, len, word);
	if (!ok && frame_is(frame, len, "DENIED")) {
		free(frame);
		return 4;
	}
	free(frame);
	return ok ? 0 : 5;
}

static int connect_to(const char *host, const char *port)
{
	struct addrinfo hints = {0}, *res, *ai;
	struct timeval tv = {10, 0};
	int s = -1;

	hints.ai_family = AF_INET;
	hints.ai_socktype = SOCK_STREAM;
	if (getaddrinfo(host, port, &hints, &res) != 0)
		return -1;
	for (ai = res; ai; ai = ai->ai_next) {
		s = socket(ai->ai_family, ai->ai_socktype, ai->ai_protocol);
		if (s < 0)
			continue;
		setsockopt(s, SOL_SOCKET, SO_RCVTIMEO, &tv, sizeof(tv));
		setsockopt(s, SOL_SOCKET, SO_SNDTIMEO, &tv, sizeof(tv));
		if (connect(s, ai->ai_addr, ai->ai_addrlen) == 0)
			break;
		close(s);
		s = -1;
	}
	freeaddrinfo(res);
	return s;
}

int main(int argc, char **argv)
{
	unsigned char msg[128], *frame;
	FILE *addresses = NULL;
	uint32_t expected, count = 0;
	size_t n = 0;
	long len;
	int rc = 0;

	if (argc < 3) {
		fprintf(stderr, "usage: %s host port [address-file]\n", argv[0]);
		return 2;
	}
	fd = connect_to(argv[1], argv[2]);
	if (fd < 0)
		return 2;

	len = read_frame(&frame);
	if (len < 0) {
		close(fd);
		return 3;
	}
	free(frame);

	n += put_string(msg + n, "");
	n += put_string(msg + n, "");
	n += put_string(msg + n, "UT2K4CLIENT");
	n += put_int(msg + n, CLIENT_VERSION);
	msg[n++] = 0;
	n += put_string(msg + n, "INT");
	n += put_int(msg + n, 0);
	n += put_int(msg + n, 0);
	n += put_int(msg + n, 0);
	msg[n++] = 0;
	if (!write_frame(msg, n) || (rc = expect("APPROVED")) != 0) {
		close(fd);
		return rc ? rc : 5;
	}
	n = put_string(msg, "00000000");
	if (!write_frame(msg, n) || (rc = expect("VERIFIED")) != 0) {
		close(fd);
		return rc ? rc : 5;
	}
	msg[0] = 0;
	msg[1] = 0;
	if (!write_frame(msg, 2)) {
		close(fd);
		return 5;
	}

	len = read_frame(&frame);
	if (len < 4) {
		if (len >= 0)
			free(frame);
		close(fd);
		return 5;
	}
	expected = (uint32_t)frame[0] | (uint32_t)frame[1] << 8 | (uint32_t)frame[2] << 16 | (uint32_t)frame[3] << 24;
	free(frame);
	if (expected > MAX_SERVERS) {
		close(fd);
		return 5;
	}
	if (argc > 3 && argv[3][0])
		addresses = fopen(argv[3], "w");
	while (count < expected) {
		len = read_frame(&frame);
		if (len < 8)
			break;
		if (addresses)
			fprintf(addresses, "%u.%u.%u.%u:%u\n", frame[0], frame[1], frame[2], frame[3], (unsigned)(frame[4] | frame[5] << 8));
		free(frame);
		count++;
	}
	if (addresses)
		fclose(addresses);
	close(fd);
	if (count < expected)
		return 5;
	printf("%u\n", count);
	return 0;
}
