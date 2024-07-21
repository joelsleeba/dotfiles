rule = {
	matches = {
		{
			{ "node.name", "matches", "bluez_output.*" },
		},
	},
	apply_properties = {
		["priority.session"] = 1011,
		["priority.driver"] = 1011,
	},
}

table.insert(bluez_monitor.rules, rule)
