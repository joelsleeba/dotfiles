rule = {
	matches = {
		{
			{ "node.name", "matches", "alsa_output.pci-0000_00_03.0.hdmi-stereo" },
		},
	},
	apply_properties = {
		["priority.session"] = 1010,
		["priority.driver"] = 1010,
	},
}

table.insert(alsa_monitor.rules, rule)
