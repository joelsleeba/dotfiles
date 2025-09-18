rule = {
	matches = {
		{
			{ "node.name", "matches", "bluez_output.EC_66_D1_C5_4E_B7.1" },
		},
	},
	apply_properties = {},
}

table.insert(bluez_monitor.rules, rule)
