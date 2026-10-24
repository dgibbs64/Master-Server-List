import datetime
import http.server
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
import urllib.parse

ROOT = Path(__file__).resolve().parents[1]
BASH = shutil.which("bash")
TIMEOUT = shutil.which("timeout")
if not BASH or not TIMEOUT:
    raise RuntimeError("Probe tests require bash and timeout")


class Master(socketserver.ThreadingTCPServer):
    allow_reuse_address = True
    daemon_threads = True

    def __init__(self, mode="list", activate=True, host="127.0.0.1", port=0, push=False):
        self.mode = mode
        self.push = push
        self.requests = []
        self.raw_requests = []
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
        if self.server.push:
            self.request.sendall(b"\\basic\\\\secure\\" + self.server.mode)
            return
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
        self.server.raw_requests.append(data)
        self.server.requests.append((self.request.getsockname()[0], game, time.monotonic()))
        if isinstance(self.server.mode, bytes):
            self.request.sendall(self.server.mode)
        elif self.server.mode == "reject":
            self.request.sendall(b"\\fatal\\1\\error\\Validation error")
        elif self.server.mode == "empty":
            self.request.sendall(b"\\final\\")
        else:
            self.request.sendall(b"\\ip\\192.0.2.1:27960\\final\\")


class SteamApi(http.server.ThreadingHTTPServer):
    daemon_threads = True

    def __init__(self, status=200, body=None):
        self.status = status
        self.body = body
        self.queries = []
        super().__init__(("127.0.0.1", 0), SteamHandler)
        threading.Thread(target=self.serve_forever, daemon=True).start()

    def close(self):
        self.shutdown()
        self.server_close()

    @property
    def url(self):
        return "http://127.0.0.1:%d/IGameServersService/GetServerList/v1/" % self.server_address[1]


class SteamHandler(http.server.BaseHTTPRequestHandler):
    def do_GET(self):
        query = urllib.parse.parse_qs(urllib.parse.urlsplit(self.path).query)
        self.server.queries.append(query)
        body = json.dumps(self.server.body(query) if callable(self.server.body) else self.server.body).encode()
        self.send_response(self.server.status)
        self.send_header("Content-Type", "application/json")
        self.send_header("Content-Length", str(len(body)))
        self.end_headers()
        self.wfile.write(body)

    def log_message(self, *args):
        pass


class QuakeMaster(socketserver.ThreadingUDPServer):
    daemon_threads = True

    def __init__(self, lists):
        self.lists = lists
        self.versions = []
        super().__init__(("127.0.0.1", 0), QuakeHandler)
        threading.Thread(target=self.serve_forever, daemon=True).start()

    def close(self):
        self.shutdown()
        self.server_close()


class QuakeHandler(socketserver.BaseRequestHandler):
    def handle(self):
        data, sock = self.request
        version = int(data.split(b" ")[1])
        self.server.versions.append(version)
        records = b"".join(b"\\" + bytes(int(part) for part in ip.split(".")) + port.to_bytes(2, "big") for ip, port in self.server.lists.get(version, []))
        sock.sendto(b"\xff\xff\xff\xffgetserversResponse" + records + b"\\EOF", self.client_address)


def quake_entry(port, protocol):
    return {"host": "127.0.0.1", "port": port, "probe": {"type": "getservers", "port": port, "protocol": protocol}, "status": "no-response", "last_seen": "2020-01-01"}


def steam_filter_api(servers):
    def matches(server, filter_text):
        parts = filter_text.split("\\")[1:]
        pairs = list(zip(parts[0::2], parts[1::2]))
        negate = 0
        for key, value in pairs:
            if key == "nor":
                negate = int(value)
                continue
            hit = key == "appid" or bool(server.get(key)) == (value == "1")
            if negate:
                negate -= 1
                hit = not hit
            if not hit:
                return False
        return True

    def respond(query):
        limit = int(query["limit"][0])
        found = [s for s in servers if matches(s, query["filter"][0])]
        return {"response": {"servers": [{"addr": s["addr"]} for s in found[:limit]]}}

    return respond


def steam_entry(appid=730):
    return {"host": "127.0.0.1", "port": None, "probe": {"type": "steam", "appid": appid}, "status": "online", "last_seen": "2020-01-01", "servers": 5}


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

    def test_encrypted_lists_are_counted_and_indexed(self):
        fixture = ROOT / "tests/fixtures/vietcong-tk-enctype2.bin"
        server = Master(mode=fixture.read_bytes())
        self.addCleanup(server.close)
        master = entry("127.0.0.1", server.port, "vietcong")
        master["probe"].update(key="bq98mE", format="enctype2")
        result, _, index, addresses = self.run_check([master])
        self.assertEqual((result[0]["status"], result[0]["servers"]), ("online", 57))
        self.assertIn(b"\\list\\cmp\\gamename\\", server.raw_requests[0])
        self.assertEqual(len(index.splitlines()), 1)
        self.assertEqual(len(next(iter(addresses.values())).splitlines()), 57)
        self.assertIn("143.177.195.34:15425\n", next(iter(addresses.values())))

    def test_pushed_encrypted_list_does_not_consume_cipher_bytes_as_challenge(self):
        fixture = ROOT / "tests/fixtures/vietcong-tk-enctype2.bin"
        server = Master(mode=fixture.read_bytes(), push=True)
        self.addCleanup(server.close)
        master = entry("127.0.0.1", server.port, "vietcong")
        master["probe"].update(key="bq98mE", format="enctype2", push=True)
        result, _, _, addresses = self.run_check([master])
        self.assertEqual((result[0]["status"], result[0]["servers"]), ("online", 57))
        self.assertEqual(len(next(iter(addresses.values())).splitlines()), 57)

    def test_space_only_undying_key_is_preserved(self):
        server = Master()
        self.addCleanup(server.close)
        master = entry("127.0.0.1", server.port, "undying")
        master["probe"]["key"] = "      "
        result, _, _, addresses = self.run_check([master])
        self.assertEqual(result[0]["probe"]["key"], "      ")
        self.assertEqual((result[0]["status"], result[0]["servers"]), ("online", 1))
        self.assertIn(b"\\validate\\OdMXTIoM\\final\\", server.raw_requests[0])
        self.assertEqual(next(iter(addresses.values())), "192.0.2.1:27960\n")

    def test_duplicate_game_addresses_are_counted_once(self):
        server = Master(mode=b"\\ip\\192.0.2.1:27960\\ip\\192.0.2.1:27960\\final\\")
        self.addCleanup(server.close)
        result, _, _, addresses = self.run_check([entry("127.0.0.1", server.port, "undying")])
        self.assertEqual((result[0]["status"], result[0]["servers"]), ("online", 1))
        self.assertEqual(next(iter(addresses.values())), "192.0.2.1:27960\n")

    def test_steam_list_is_counted_by_unique_address(self):
        api = SteamApi(body={"response": {"servers": [{"addr": "192.0.2.1:27015"}, {"addr": "192.0.2.2:27016"}, {"addr": "192.0.2.1:27015"}]}})
        self.addCleanup(api.close)
        result, _, _, addresses = self.run_check([steam_entry(730)], STEAM_API_KEY="test-key", STEAM_API_URL=api.url)
        self.assertEqual((result[0]["status"], result[0]["servers"]), ("online", 2))
        self.assertEqual(next(iter(addresses.values())), "192.0.2.1:27015\n192.0.2.2:27016\n")
        self.assertEqual(api.queries[0]["filter"], ["\\appid\\730"])
        self.assertEqual(api.queries[0]["key"], ["test-key"])

    def test_steam_empty_response_is_online_with_zero(self):
        api = SteamApi(body={"response": {}})
        self.addCleanup(api.close)
        result, _, _, _ = self.run_check([steam_entry()], STEAM_API_KEY="test-key", STEAM_API_URL=api.url)
        self.assertEqual((result[0]["status"], result[0]["servers"]), ("online", 0))

    def test_steam_without_key_keeps_previous_status(self):
        api = SteamApi(body={"response": {}})
        self.addCleanup(api.close)
        result, log, _, _ = self.run_check([steam_entry()], STEAM_API_KEY="", STEAM_API_URL=api.url)
        self.assertEqual(result[0], steam_entry())
        self.assertEqual(api.queries, [])
        self.assertIn("no-api-key", log)

    def test_capped_steam_list_is_split_until_complete(self):
        servers = [
            {"addr": "192.0.2.1:27015", "noplayers": 1, "linux": 1, "dedicated": 1},
            {"addr": "192.0.2.2:27015", "noplayers": 1, "linux": 1},
            {"addr": "192.0.2.3:27015", "noplayers": 1},
            {"addr": "192.0.2.4:27015", "linux": 1},
            {"addr": "192.0.2.5:27015"},
        ]
        api = SteamApi(body=steam_filter_api(servers))
        self.addCleanup(api.close)
        result, _, _, addresses = self.run_check([steam_entry()], STEAM_API_KEY="test-key", STEAM_API_URL=api.url, STEAM_CAP="2")
        self.assertEqual((result[0]["status"], result[0]["servers"]), ("online", 5))
        self.assertNotIn("check_error", result[0])
        self.assertEqual(next(iter(addresses.values())).splitlines(), [s["addr"] for s in servers])
        filters = [q["filter"][0] for q in api.queries]
        self.assertIn("\\appid\\730\\noplayers\\1", filters)
        self.assertIn("\\appid\\730\\nor\\1\\noplayers\\1", filters)

    def test_steam_list_still_capped_after_every_split_is_partial(self):
        servers = [{"addr": "192.0.2.%d:27015" % n} for n in range(1, 4)]
        api = SteamApi(body=steam_filter_api(servers))
        self.addCleanup(api.close)
        result, _, _, _ = self.run_check([steam_entry()], STEAM_API_KEY="test-key", STEAM_API_URL=api.url, STEAM_CAP="2")
        self.assertEqual((result[0]["status"], result[0]["servers"], result[0]["check_error"]), ("online", 2, "partial-count"))

    def test_steam_rejected_key_is_no_response(self):
        api = SteamApi(status=403, body={})
        self.addCleanup(api.close)
        result, log, _, _ = self.run_check([steam_entry()], STEAM_API_KEY="bad-key", STEAM_API_URL=api.url)
        self.assertEqual((result[0]["status"], result[0]["check_error"]), ("no-response", "query-failed"))
        self.assertNotIn("bad-key", log)

    def test_protocol_list_counts_unique_servers_across_versions(self):
        master = QuakeMaster({68: [("192.0.2.1", 27960), ("192.0.2.2", 27960)], 43: [("192.0.2.3", 27960), ("192.0.2.1", 27960)]})
        self.addCleanup(master.close)
        result, _, _, addresses = self.run_check([quake_entry(master.server_address[1], [68, 67, 43])])
        self.assertEqual(sorted(master.versions), [43, 67, 68])
        self.assertEqual((result[0]["status"], result[0]["servers"]), ("online", 3))
        self.assertEqual(next(iter(addresses.values())), "192.0.2.1:27960\n192.0.2.2:27960\n192.0.2.3:27960\n")
        self.assertEqual(result[0]["probe"]["protocol"], [68, 67, 43])

    def test_single_protocol_number_still_works(self):
        master = QuakeMaster({68: [("192.0.2.1", 27960)]})
        self.addCleanup(master.close)
        result, _, _, _ = self.run_check([quake_entry(master.server_address[1], 68)])
        self.assertEqual(master.versions, [68])
        self.assertEqual((result[0]["status"], result[0]["servers"]), ("online", 1))

    def test_empty_catalogue(self):
        result, _, index, addresses = self.run_check([])
        self.assertEqual((result, index, addresses), ([], "", {}))


if __name__ == "__main__":
    unittest.main()
