/* SPDX-License-Identifier: GPL-2.0-or-later
 * Bounded GameSpy Enctype 2 list reader, linked with Luigi Auriemma's cipher.
 * Cipher source and license: third_party/gamespy-enctype2/.
 */
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

int main(int argc, char **argv)
{
    if (argc != 3 || strlen(argv[1]) != 6) return 2;
    FILE *input = fopen(argv[2], "rb");
    if (!input) return 2;
    unsigned char *data = malloc(MAX_REPLY + 1);
    if (!data) { fclose(input); return 2; }
    size_t size = fread(data, 1, MAX_REPLY + 1, input);
    int bad = ferror(input);
    fclose(input);
    if (bad || size < 8 || size > MAX_REPLY) { free(data); return 1; }
    size_t header = data[0] ^ 0xec;
    if (header < 6 || header + 8 > size) { free(data); return 1; }
    for (size_t i = 0; i < 6; i++) data[i + 1] ^= (unsigned char)argv[1][i];
    unsigned int state[326] = {0};
    encshare4(data + 1, (int)header, state);
    unsigned char *list = data + header + 1;
    size_t length = size - header - 1;
    encshare1(state, list, (int)length);
    /* Some masters append up to five zero padding bytes after the final marker. */
    for (int i = 0; i < 5 && length && list[length - 1] == 0; i++) length--;
    if (length < 7 || memcmp(list + length - 7, "\\final\\", 7)) { free(data); return 1; }
    length -= 7;
    if (length % 6) { free(data); return 1; }
    for (size_t i = 0; i < length; i += 6) {
        unsigned int port = ((unsigned int)list[i + 4] << 8) | list[i + 5];
        if (!port) { free(data); return 1; }
    }
    for (size_t i = 0; i < length; i += 6) {
        unsigned int port = ((unsigned int)list[i + 4] << 8) | list[i + 5];
        printf("\\ip\\%u.%u.%u.%u:%u", list[i], list[i+1], list[i+2], list[i+3], port);
    }
    puts("\\final\\");
    free(data);
    return 0;
}