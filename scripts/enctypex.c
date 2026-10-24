#define _POSIX_C_SOURCE 200809L
#include <netdb.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <sys/time.h>
#include <time.h>
#include <unistd.h>

#define MAX_REPLY (4 * 1024 * 1024)

struct cipher {
	unsigned char cards[256];
	unsigned char rotor, ratchet, avalanche, last_plain, last_cipher;
};

struct reader {
	const unsigned char *p;
	size_t left;
};

static unsigned char shuffle_pick(struct cipher *c, int limit, const unsigned char *key, int keylen, unsigned char *rsum, int *keypos)
{
	unsigned int mask = 1, pick;
	int tries = 0;

	if (limit == 0)
		return 0;
	while (mask < (unsigned int)limit)
		mask = (mask << 1) + 1;
	do {
		*rsum = (unsigned char)(c->cards[*rsum] + key[(*keypos)++]);
		if (*keypos >= keylen) {
			*keypos = 0;
			*rsum = (unsigned char)(*rsum + keylen);
		}
		pick = mask & *rsum;
		if (++tries > 11)
			pick %= (unsigned int)limit;
	} while (pick > (unsigned int)limit);
	return (unsigned char)pick;
}

static void cipher_init(struct cipher *c, const unsigned char *key, int keylen)
{
	unsigned char rsum = 0;
	int keypos = 0;

	for (int i = 0; i < 256; i++)
		c->cards[i] = (unsigned char)i;
	for (int i = 255; i >= 0; i--) {
		int j = shuffle_pick(c, i, key, keylen, &rsum, &keypos);
		unsigned char swap = c->cards[i];
		c->cards[i] = c->cards[j];
		c->cards[j] = swap;
	}
	c->rotor = c->cards[1];
	c->ratchet = c->cards[3];
	c->avalanche = c->cards[5];
	c->last_plain = c->cards[7];
	c->last_cipher = c->cards[rsum];
}

static unsigned char cipher_byte(struct cipher *c, unsigned char in)
{
	unsigned char *k = c->cards;
	unsigned char saved;

	c->ratchet = (unsigned char)(c->ratchet + k[c->rotor++]);
	saved = k[c->last_cipher];
	k[c->last_cipher] = k[c->ratchet];
	k[c->ratchet] = k[c->last_plain];
	k[c->last_plain] = k[c->rotor];
	k[c->rotor] = saved;
	c->avalanche = (unsigned char)(c->avalanche + k[saved]);
	c->last_plain = in ^ k[(unsigned char)(k[c->avalanche] + k[c->rotor])] ^ k[k[(unsigned char)(k[c->last_plain] + k[c->last_cipher] + k[c->ratchet])]];
	c->last_cipher = in;
	return c->last_plain;
}

static int take(struct reader *r, size_t n, const unsigned char **out)
{
	if (r->left < n)
		return 0;
	if (out)
		*out = r->p;
	r->p += n;
	r->left -= n;
	return 1;
}

static int take_string(struct reader *r)
{
	const unsigned char *end = memchr(r->p, 0, r->left);

	if (!end)
		return 0;
	return take(r, (size_t)(end - r->p) + 1, NULL);
}

static long parse_list(const unsigned char *data, size_t len, FILE *addresses)
{
	struct reader r = {data, len};
	const unsigned char *b;
	unsigned int default_port, keys, popular;
	unsigned char types[256];
	long count = 0;

	if (!take(&r, 6, &b))
		return -1;
	default_port = (unsigned int)(b[4] << 8 | b[5]);
	if (!take(&r, 1, &b))
		return -1;
	keys = b[0];
	for (unsigned int i = 0; i < keys; i++) {
		if (!take(&r, 1, &b))
			return -1;
		types[i] = b[0];
		if (!take_string(&r))
			return -1;
	}
	if (!take(&r, 1, &b))
		return -1;
	popular = b[0];
	for (unsigned int i = 0; i < popular; i++)
		if (!take_string(&r))
			return -1;
	for (;;) {
		const unsigned char *ip;
		unsigned char flags;
		unsigned int port;

		if (!take(&r, 1, &b))
			return -1;
		flags = b[0];
		if (!take(&r, 4, &ip))
			return -1;
		if (flags == 0 && ip[0] == 0xff && ip[1] == 0xff && ip[2] == 0xff && ip[3] == 0xff)
			return count;
		port = default_port;
		if (flags & 0x10) {
			if (!take(&r, 2, &b))
				return -1;
			port = (unsigned int)(b[0] << 8 | b[1]);
		}
		if ((flags & 0x02) && !take(&r, 4, NULL))
			return -1;
		if ((flags & 0x20) && !take(&r, 2, NULL))
			return -1;
		if ((flags & 0x08) && !take(&r, 4, NULL))
			return -1;
		if (flags & 0x40) {
			for (unsigned int i = 0; i < keys; i++) {
				if (types[i] == 0) {
					if (!take(&r, 1, &b))
						return -1;
					if (b[0] == 0xff && !take_string(&r))
						return -1;
				} else if (!take(&r, types[i] == 1 ? 1 : 2, NULL)) {
					return -1;
				}
			}
		}
		if (flags & 0x80) {
			while (r.left > 0 && r.p[0] != 0)
				if (!take_string(&r) || !take_string(&r))
					return -1;
			if (!take(&r, 1, NULL))
				return -1;
		}
		count++;
		if (addresses)
			fprintf(addresses, "%u.%u.%u.%u:%u\n", ip[0], ip[1], ip[2], ip[3], port);
	}
}

static long decode(const unsigned char *reply, size_t len, const unsigned char *challenge_in, const char *key, FILE *addresses)
{
	unsigned char challenge[8], *plain;
	size_t start, saltlen;
	size_t keylen = strlen(key);
	struct cipher c;
	long count;

	if (len < 1)
		return -1;
	start = (size_t)(reply[0] ^ 0xec) + 2;
	if (len < start)
		return -1;
	saltlen = (size_t)(reply[start - 1] ^ 0xea);
	if (len < start + saltlen)
		return -1;
	memcpy(challenge, challenge_in, sizeof(challenge));
	for (size_t i = 0; i < saltlen; i++)
		challenge[((unsigned char)key[i % keylen] * i) & 7] ^= challenge[i & 7] ^ reply[start + i];
	cipher_init(&c, challenge, sizeof(challenge));
	plain = malloc(len - start - saltlen + 1);
	if (!plain)
		return -1;
	for (size_t i = start + saltlen; i < len; i++)
		plain[i - start - saltlen] = cipher_byte(&c, reply[i]);
	count = parse_list(plain, len - start - saltlen, addresses);
	free(plain);
	return count;
}

static int connect_to(const char *host, const char *port)
{
	struct addrinfo hints = {0}, *res, *ai;
	struct timeval tv = {5, 0};
	int fd = -1;

	hints.ai_family = AF_INET;
	hints.ai_socktype = SOCK_STREAM;
	if (getaddrinfo(host, port, &hints, &res) != 0)
		return -1;
	for (ai = res; ai; ai = ai->ai_next) {
		fd = socket(ai->ai_family, ai->ai_socktype, ai->ai_protocol);
		if (fd < 0)
			continue;
		setsockopt(fd, SOL_SOCKET, SO_RCVTIMEO, &tv, sizeof(tv));
		setsockopt(fd, SOL_SOCKET, SO_SNDTIMEO, &tv, sizeof(tv));
		if (connect(fd, ai->ai_addr, ai->ai_addrlen) == 0)
			break;
		close(fd);
		fd = -1;
	}
	freeaddrinfo(res);
	return fd;
}

int main(int argc, char **argv)
{
	unsigned char request[512], challenge[8], *reply;
	const char *host, *port, *game, *key, *fields = "\\hostname";
	size_t gamelen, n = 0, len = 0;
	long count = -1;
	time_t deadline;
	int fd;

	if (argc < 5) {
		fprintf(stderr, "usage: %s host port gamename key [address-file]\n", argv[0]);
		return 2;
	}
	host = argv[1];
	port = argv[2];
	game = argv[3];
	key = argv[4];
	gamelen = strlen(game);
	if (gamelen == 0 || gamelen > 100 || strlen(key) == 0)
		return 2;

	srand((unsigned int)(time(NULL) ^ getpid()));
	for (int i = 0; i < 8; i++)
		challenge[i] = (unsigned char)(0x21 + rand() % 94);

	n = 2;
	request[n++] = 0;
	request[n++] = 1;
	request[n++] = 3;
	memset(request + n, 0, 4);
	n += 4;
	memcpy(request + n, game, gamelen + 1);
	n += gamelen + 1;
	memcpy(request + n, game, gamelen + 1);
	n += gamelen + 1;
	memcpy(request + n, challenge, 8);
	n += 8;
	request[n++] = 0;
	memcpy(request + n, fields, strlen(fields) + 1);
	n += strlen(fields) + 1;
	memset(request + n, 0, 4);
	n += 4;
	request[0] = (unsigned char)(n >> 8);
	request[1] = (unsigned char)(n & 0xff);

	fd = connect_to(host, port);
	if (fd < 0)
		return 1;
	if (send(fd, request, n, 0) != (ssize_t)n) {
		close(fd);
		return 1;
	}
	reply = malloc(MAX_REPLY);
	if (!reply) {
		close(fd);
		return 1;
	}
	deadline = time(NULL) + 20;
	while (len < MAX_REPLY && time(NULL) < deadline) {
		ssize_t got = recv(fd, reply + len, MAX_REPLY - len, 0);
		if (got <= 0)
			break;
		len += (size_t)got;
		count = decode(reply, len, challenge, key, NULL);
		if (count >= 0)
			break;
	}
	close(fd);
	if (count < 0) {
		free(reply);
		return 1;
	}
	if (argc > 5 && argv[5][0]) {
		FILE *addresses = fopen(argv[5], "w");
		if (addresses) {
			decode(reply, len, challenge, key, addresses);
			fclose(addresses);
		}
	}
	free(reply);
	printf("%ld\n", count);
	return 0;
}
