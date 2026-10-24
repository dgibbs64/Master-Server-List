[
	..
	| objects
	| ([to_entries[] | select(.key | test("^(server)?port$"; "i")) | .value | select(. != null and . != "")] | first) as $port
	| to_entries[]
	| select(.key | test("^(ip|address|addresses|serverip|serveraddress|host)$"; "i"))
	| .value
	| if type == "array" then .[] else . end
	| strings
	| capture("(?<h>[A-Za-z0-9-]+(\\.[A-Za-z0-9-]+)+)(:(?<p>[0-9]{1,5}))?/?$")
	| select(.p != null or $port != null)
	| "\(.h | ascii_downcase):\(.p // ($port | tostring))"
]
| unique[]
