local wez = require("wezterm")

local config = {}

-- Colors and Appearence
config.color_scheme = "tokyonight"
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.tab_max_width = 10
config.inactive_pane_hsb = {
	saturation = 0.9,
	brightness = 0.8,
}

-- Fonts
config.font_size = 9
config.font = wez.font_with_fallback({
	{ family = "JetBrainsMono NF" },
})

return config
