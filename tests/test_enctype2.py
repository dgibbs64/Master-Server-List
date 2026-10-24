"""Recorded binary replies from the three public masters, captured 2026-10-24."""
from pathlib import Path
import subprocess  # nosec B404 - Execute only the repository's compiled decoder.
import tempfile
import unittest

ROOT = Path(__file__).resolve().parents[1]
DECODER = str(ROOT / "scripts/gamespy-enctype2")


class Enctype2Tests(unittest.TestCase):
    def decode(self, data, key="bq98mE"):
        with tempfile.TemporaryDirectory() as folder:
            path = Path(folder) / "reply.bin"
            path.write_bytes(data)
            return subprocess.run([DECODER, key, str(path)], capture_output=True, universal_newlines=True, timeout=3)  # nosec B603 - Fixed local decoder; test bytes are data, never shell code.

    def test_live_reply_fixtures(self):
        for name, key, count, first in [
            ("bf1942", "HpWx9z", 80, "37.187.92.162:23000"),
            ("vietcong-tk", "bq98mE", 57, "143.177.195.34:15425"),
            ("vietcong1", "bq98mE", 54, "143.177.195.34:15425"),
        ]:
            with self.subTest(master=name):
                result = self.decode((ROOT / "tests/fixtures" / (name + "-enctype2.bin")).read_bytes(), key)
                self.assertEqual(result.returncode, 0)
                self.assertTrue(result.stdout.startswith("\\ip\\" + first))
                self.assertEqual(result.stdout.count("\\ip\\"), count)
                self.assertTrue(result.stdout.endswith("\\final\\\n"))

    def test_valid_empty_list(self):
        result = self.decode((ROOT / "tests/fixtures/empty-enctype2.bin").read_bytes())
        self.assertEqual(result.returncode, 0)
        self.assertEqual(result.stdout, "\\final\\\n")

    def test_wrong_key_and_incomplete_replies_are_rejected(self):
        data = (ROOT / "tests/fixtures/vietcong-tk-enctype2.bin").read_bytes()
        for broken in [b"", b"\\final\\", data[:8], data[:20], data[:-12], data[:-7], bytes([0xec]) + data[1:], data + bytes(4 * 1024 * 1024)]:
            with self.subTest(size=len(broken)):
                result = self.decode(broken)
                self.assertNotEqual(result.returncode, 0)
                self.assertEqual(result.stdout, "")
        result = self.decode(data, "ABCDEF")
        self.assertNotEqual(result.returncode, 0)
        self.assertEqual(result.stdout, "")


if __name__ == "__main__":
    unittest.main()