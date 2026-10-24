# GameSpy Enctype 2 cipher

`enctype_shared.c` is Luigi Auriemma's shared GameSpy cipher implementation,
retrieved from https://github.com/ReviveNetwork/node-enctypex/blob/master/enctype_shared.c.
Its original copyright and GPL-2.0-or-later notice are retained; see `COPYING`.

The separately built `scripts/gamespy-enctype2` executable links this cipher with
a bounded list reader. It validates the decrypted end marker and packed records
before returning any server addresses. It supports legacy Enctype 2 replies;
Enctype X remains handled by the existing `enctypex` executable.
