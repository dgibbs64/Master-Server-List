function valfunc(r) {
	if (r < 26) return sprintf("%c", r + 65)
	if (r < 52) return sprintf("%c", r + 71)
	if (r < 62) return sprintf("%c", r - 4)
	if (r == 62) return "+"
	return "/"
}

function gsseckey(src, key,    t, i, a, b, x, y, z, ks, n, tmp, out, size) {
	for (i = 0; i < 256; i++) t[i] = i
	ks = length(key)
	a = 0
	for (i = 0; i < 256; i++) {
		a = (a + t[i] + ORD[substr(key, (i % ks) + 1, 1)]) % 256
		x = t[a]; t[a] = t[i]; t[i] = x
	}
	a = 0; b = 0; n = length(src)
	for (i = 0; i < n; i++) {
		a = (a + ORD[substr(src, i + 1, 1)] + 1) % 256
		x = t[a]
		b = (b + x) % 256
		y = t[b]
		t[b] = x; t[a] = y
		tmp[i] = xor(ORD[substr(src, i + 1, 1)], t[(x + y) % 256])
	}
	for (size = n; size % 3; size++) tmp[size] = 0
	out = ""
	for (i = 0; i < size; i += 3) {
		x = tmp[i]; y = tmp[i + 1]; z = tmp[i + 2]
		out = out valfunc(rshift(x, 2)) valfunc(or(lshift(and(x, 3), 4), rshift(y, 4))) valfunc(or(lshift(and(y, 15), 2), rshift(z, 6))) valfunc(and(z, 63))
	}
	return out
}

BEGIN {
	for (i = 0; i < 256; i++) ORD[sprintf("%c", i)] = i
	print gsseckey(secure, key)
}
