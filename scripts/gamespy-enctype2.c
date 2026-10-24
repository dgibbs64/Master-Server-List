/* SPDX-License-Identifier: GPL-2.0-or-later */
#include <limits.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_REPLY (4 * 1024 * 1024)

_Static_assert(sizeof(unsigned int) == 4, "The legacy cipher requires 32-bit unsigned int");
#if defined(__BYTE_ORDER__) && __BYTE_ORDER__ != __ORDER_LITTLE_ENDIAN__
#error The legacy cipher requires a little-endian target
#endif

void encshare1(unsigned int *, unsigned char *, int);
void encshare4(unsigned char *, int, unsigned int *);

static int decode(unsigned char *data, size_t size, const char *key)
{
	unsigned int state[326] = {0};
	unsigned char *list;
	size_t header, length;

	if (size < 8 || size > MAX_REPLY)
		return 1;
	header = data[0] ^ 0xec;
	if (header < 6 || header + 8 > size)
		return 1;
	for (size_t i = 0; i < 6; i++)
		data[i + 1] ^= (unsigned char)key[i];
	encshare4(data + 1, (int)header, state);
	list = data + header + 1;
	length = size - header - 1;
	encshare1(state, list, (int)length);
	for (int i = 0; i < 5 && length && list[length - 1] == 0; i++)
		length--;
	if (length < 7 || memcmp(list + length - 7, "\\final\\", 7))
		return 1;
	length -= 7;
	if (length % 6)
		return 1;
	for (size_t i = 0; i < length; i += 6)
		if (!(list[i + 4] | list[i + 5]))
			return 1;
	for (size_t i = 0; i < length; i += 6)
		printf("\\ip\\%u.%u.%u.%u:%u", list[i], list[i + 1], list[i + 2], list[i + 3], (unsigned int)list[i + 4] << 8 | list[i + 5]);
	puts("\\final\\");
	return 0;
}

int main(int argc, char **argv)
{
	unsigned char *data;
	FILE *input;
	size_t size;
	int bad, rc;

	if (argc != 3 || strlen(argv[1]) != 6)
		return 2;
	input = fopen(argv[2], "rb");
	if (!input)
		return 2;
	data = malloc(MAX_REPLY + 1);
	if (!data) {
		fclose(input);
		return 2;
	}
	size = fread(data, 1, MAX_REPLY + 1, input);
	bad = ferror(input);
	fclose(input);
	rc = bad ? 1 : decode(data, size, argv[1]);
	free(data);
	return rc;
}
