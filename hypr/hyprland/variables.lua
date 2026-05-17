require("hyprland.config")

hl.config({
	general = {
		gaps_in = 4,
		gaps_out = { top = 6, left = 6, right = 6, bottom = 6 },
		border_size = 0,
		no_focus_fallback = false,
		col = {
			active_border = { colors = { "rgba(33ccffee)", "rgba(00ff99ee)" }, angle = "45" },
			inactive_border = "rgba(595959aa)",
		},
		layout = "dwindle",
	},

	decoration = {
		rounding = 5,
		dim_inactive = true,
		dim_strength = 0.10,

		blur = {
			enabled = false,
		},

		shadow = {
			enabled = false,
		},
	},

	animations = {
		enabled = true,
		-- bezier = {
		-- 	"myBezier,0.05,0.9,0.1,1.05",
		-- },
		--
		-- animation = {
		-- 	"windows,1,4,myBezier",
		-- 	"windowsOut,1,7,default,popin 90%",
		-- 	"border,1,10,default",
		-- 	"borderangle,1,8,default",
		-- 	"fade,1,4,default",
		-- 	"workspaces,1,3,default",
		-- },
	},

	input = {
		kb_layout = "us",
		kb_variant = ",querty",
		follow_mouse = 1,
		sensitivity = 0,

		touchpad = {
			natural_scroll = false,
			middle_button_emulation = true,
			drag_lock = true,
			tap_and_drag = true,
		},

		tablet = {
			relative_input = true,
			left_handed = true,
		},
	},

	dwindle = {
		force_split = 2,
		preserve_split = true,
	},

	misc = {
		focus_on_activate = true,
		allow_session_lock_restore = true,
		middle_click_paste = false,
		vrr = true,
	},

	ecosystem = {
		no_update_news = true,
		no_donation_nag = true,
	},
})

hl.gesture({
	fingers = 3,
	direction = "horizontal",
	action = "workspace",
})

hl.device({
	name = "epic-mouse-v1",
	sensitivity = -0.5,
})
hl.device({
	name = "Compx 2.4G Wireless Receiver",
	kb_layout = "us",
	kb_options = "altwin:swap_lalt_lwin",
})
hl.device({
	name = "Compx 2.4G Wireless Receiver Keyboard",
	kb_layout = "us",
	kb_options = "altwin:swap_lalt_lwin",
})
