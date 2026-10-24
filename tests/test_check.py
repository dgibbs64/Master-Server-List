import datetime
import json
import os
from pathlib import Path
import socketserver
import shutil
import subprocess  # nosec B404 - Tests execute repository scripts with argument lists.
import tempfile
import threading
import time
import unittest

ROOT = Path(__file__).resolve().parents[1]
BASH = shutil.which("bash")
TIMEOUT = shutil.which("timeout")
if not BASH or not TIMEOUT:
    raise RuntimeError("Probe tests require bash and timeout")


class Master(socketserver.ThreadingTCPServer):
    allow_reuse_address = True
    daemon_threads = True

    def __init__(self, mode="list", activate=True, host="127.0.0.1", port=0):
        self.mode = mode
        self.requests = []
        super().__init__((host, port), Handler, bind_and_activate=False)
        self.server_bind()
        self.port = self.server_address[1]
        if activate:
            self.start()

    def start(self):
        self.server_activate()
        self.thread = threading.Thread(target=self.serve_forever, daemon=True)
        self.thread.start()

    def close(self):
        if hasattr(self, "thread"):
            self.shutdown()
        self.server_close()


class Handler(socketserver.BaseRequestHandler):
    def handle(self):
        self.request.settimeout(3)
        self.request.sendall(b"\\basic\\\\secure\\ABCDEF")
        data = b""
        try:
            while data.count(b"\\final\\") < 2:
                chunk = self.request.recv(4096)
                if not chunk:
                    return
                data += chunk
        except (TimeoutError, ConnectionError):
            return
        game = data.split(b"\\gamename\\")[1].split(b"\\")[0].decode()
        self.server.requests.append((self.request.getsockname()[0], game, time.monotonic()))
        if self.server.mode == "reject":
            self.request.sendall(b"\\fatal\\1\\error\\Validation error")
        elif self.server.mode == "empty":
            self.request.sendall(b"\\final\\")
        else:
            self.request.sendall(b"\\ip\\192.0.2.1:27960\\final\\")


def entry(host, port, game):
    return {"host": host, "port": 27900, "probe": {"type": "gamespy", "port": port, "gamename": game, "key": "ABCDEF"}, "status": "no-response", "last_seen": "2020-01-01", "check_error": "old-error"}


class CheckTests(unittest.TestCase):
    def run_check(self, masters, on_line=None, **settings):
        with tempfile.TemporaryDirectory() as folder:
            path = Path(folder) / "servers.json"
            path.write_text(json.dumps({"games": [{"name": "Fixture", "masters": masters}]}))
            env = {**os.environ, "MASTER_MIN_INTERVAL": "0", "MASTER_RETRY_DELAY": "0", "ADDRESS_DIR": str(Path(folder) / "addresses"), "NO_PROXY": "*", **settings}
            # All arguments are fixed executables, repository paths or temporary fixtures.
            process = subprocess.Popen([TIMEOUT, "30", BASH, str(ROOT / "scripts/check.sh"), str(path)], env=env, stdout=subprocess.DEVNULL, stderr=subprocess.PIPE, universal_newlines=True)  # nosec B603
            lines = []
            for line in process.stderr:
                lines.append(line)
                if on_line:
                    on_line(line)
            process.stderr.close()
            process.wait(timeout=30)
            self.assertEqual(process.returncode, 0, "".join(lines))
            index = (Path(folder) / "addresses/index.tsv").read_text()
            addresses = {name.name: name.read_text() for name in (Path(folder) / "addresses").glob("*.txt")}
            return json.loads(path.read_text())["games"][0]["masters"], "".join(lines), index, addresses

    def test_round_robin_hosts_and_zero_is_online(self):
        server = Master(mode="empty")
        self.addCleanup(server.close)
        other = Master(mode="empty", host="127.0.0.2", port=server.port)
        self.addCleanup(other.close)
        other.requests = server.requests
        masters = [entry(host, server.port, game) for host in ["127.0.0.1", "127.0.0.2"] for game in ["a", "b"]]
        result, _, _, _ = self.run_check(masters)
        self.assertEqual([(host, game) for host, game, _ in server.requests], [("127.0.0.1", "a"), ("127.0.0.2", "a"), ("127.0.0.1", "b"), ("127.0.0.2", "b")])
        self.assertTrue(all(m["status"] == "online" and m["servers"] == 0 and "check_error" not in m for m in result))

    def test_later_pass_recovers_cached_endpoint_and_indexes_both_lists(self):
        server = Master(activate=False)
        self.addCleanup(server.close)
        started = False

        def recover(line):
            nonlocal started
            if "attempt=1/3" in line and "connection-failed" in line and not started:
                started = True
                server.start()

        result, log, index, addresses = self.run_check([entry("127.0.0.1", server.port, game) for game in ["a", "b"]], on_line=recover, MASTER_RETRY_DELAY="1")
        self.assertIn("cached-endpoint-failure", log)
        self.assertIn("attempt=2/3", log)
        self.assertTrue(all(m["status"] == "online" and m["servers"] == 1 for m in result))
        self.assertEqual(len(index.splitlines()), 2)
        self.assertEqual(len(addresses), 2)
        self.assertTrue(all(text == "192.0.2.1:27960\n" for text in addresses.values()))
        today = datetime.datetime.now(datetime.timezone.utc).date().isoformat()
        self.assertTrue(all(m["last_seen"] == today for m in result))

    def test_validation_failure_is_not_a_connection_failure(self):
        server = Master(mode="reject")
        self.addCleanup(server.close)
        result, log, _, _ = self.run_check([entry("127.0.0.1", server.port, "a")])
        self.assertEqual(len(server.requests), 3)
        self.assertEqual(result[0]["check_error"], "validation-rejected")
        self.assertEqual(result[0]["last_seen"], "2020-01-01")
        self.assertIn("Validation error", log)
        self.assertNotIn("cached-endpoint-failure", log)

    def test_same_ip_aliases_share_a_cooldown(self):
        server = Master()
        self.addCleanup(server.close)
        self.run_check([entry("127.0.0.1", server.port, "a"), entry("localhost", server.port, "b")], MASTER_MIN_INTERVAL="2")
        self.assertEqual(len(server.requests), 2)
        self.assertGreaterEqual(server.requests[1][2] - server.requests[0][2], 1.0)

    def test_transient_dns_failure_gets_a_later_retry(self):
        server = Master()
        self.addCleanup(server.close)
        with tempfile.TemporaryDirectory() as folder:
            wrapper = Path(folder) / "getent"
            counter = Path(folder) / "calls"
            counter.write_text("0")
            real_getent = shutil.which("getent")
            wrapper.write_text("#!/bin/sh\ncount=$(cat \"$DNS_CALLS\")\ncount=$((count + 1))\necho \"$count\" > \"$DNS_CALLS\"\n[ \"$count\" -gt 2 ] || exit 2\nexec " + real_getent + " \"$@\"\n")
            wrapper.chmod(0o755)
            result, log, _, _ = self.run_check([entry("127.0.0.1", server.port, "a")], PATH=folder + os.pathsep + os.environ["PATH"], DNS_CALLS=str(counter))
        self.assertIn("dns-resolution-failed", log)
        self.assertIn("attempt=2/3", log)
        self.assertEqual(result[0]["status"], "online")
        self.assertNotIn("check_error", result[0])
        self.assertEqual(len(server.requests), 1)

    def test_invalid_interval_does_not_modify_the_catalogue(self):
        with tempfile.TemporaryDirectory() as folder:
            path = Path(folder) / "servers.json"
            original = '{"games": []}'
            path.write_text(original)
            result = subprocess.run([BASH, str(ROOT / "scripts/check.sh"), str(path)], env={**os.environ, "MASTER_MIN_INTERVAL": "bad"}, capture_output=True, universal_newlines=True, timeout=3)  # nosec B603 - Fixed local script and temporary fixture.
            self.assertNotEqual(result.returncode, 0)
            self.assertIn("non-negative integer", result.stderr)
            self.assertEqual(path.read_text(), original)

    def test_empty_catalogue(self):
        result, _, index, addresses = self.run_check([])
        self.assertEqual((result, index, addresses), ([], "", {}))


if __name__ == "__main__":
    unittest.main()
