local config = require("hyprland.config")
local term = config.term
local phoneName = config.phoneName
local hotspotName = config.hotspotName
local browser = config.browser
local browser_ex = config.browser_ex

-- Floating rules
hl.window_rule({ match = { class = "confirm" }, float = true })
hl.window_rule({ match = { class = "dialog" }, float = true })
hl.window_rule({ match = { class = "download" }, float = true })
hl.window_rule({ match = { class = "error" }, float = true })
hl.window_rule({ match = { class = "file_progress" }, float = true })
hl.window_rule({ match = { class = "notification" }, float = true })
hl.window_rule({ match = { class = "splash" }, float = true })
hl.window_rule({ match = { class = "dropterm" }, float = true })
hl.window_rule({ match = { class = "imv" }, float = true })
hl.window_rule({ match = { class = "Windscribe" }, float = true })
hl.window_rule({ match = { class = "confirmreset" }, float = true })
hl.window_rule({ match = { class = "Tor browser" }, float = true })
hl.window_rule({ match = { class = "Pinentry-gtk-2" }, float = true })

-- Stay focused rules
hl.window_rule({
	match = { class = "(pinentry-)(.*)" },
	stay_focused = true,
})
hl.window_rule({
	match = { class = "gcr-prompter" },
	stay_focused = true,
})
-- hl.window_rule({
-- 	match = { title = "ostt" },
-- 	stay_focused = true,
-- })

-- Dropterm
hl.window_rule({ match = { title = "dropterm" }, float = true })
hl.window_rule({
	match = { title = "dropterm" },
	border_color = "rgba(ff000000)",
})

-- Wireshark
hl.window_rule({
	match = { title = "^(Wireshark.*Packet.*)$" },
	float = true,
})

-- OSTT
hl.window_rule({
	match = { class = "ostt-popup" },
	float = true,
	move = { "((monitor_w*0.5)-(window_w*0.5))", "(monitor_h*0.76)" },
})

-- Export dialogs
hl.window_rule({
	match = { title = "^(Export*)$" },
	float = true,
	size = { "(monitor_w*0.5)", "(monitor_h*0.5)" },
})
hl.window_rule({
	match = { class = "xdg-desktop-portal-gtk", title = "^(* Files)$" },
	size = { "(monitor_w*0.5)", "(monitor_h*0.5)" },
})

-- Optional
-- hl.window_rule({
--   match = { title = "^(Yazi)(.*)$" },
--   no_screen_share = true
-- })

-- Idle Inhibition
hl.window_rule({
	match = { class = browser },
	idle_inhibit = "fullscreen",
})

hl.window_rule({
	match = { class = "mpv" },
	idle_inhibit = "focus",
})

-- Assign workspaces
hl.window_rule({
	match = { class = "org.pwmt.zathura" },
	workspace = 2,
})
hl.window_rule({
	match = { class = browser },
	workspace = 5,
	no_initial_focus = true,
})
hl.window_rule({
	match = { class = "mpv" },
	workspace = 6,
})

-- Firefox Rules
hl.window_rule({
	match = { title = "Open File" },
	float = true,
})
hl.window_rule({
	match = { title = "About Mozilla Firefox" },
	float = true,
})
hl.window_rule({
	match = { title = "About LibreWolf" },
	float = true,
})
hl.window_rule({
	match = { title = "Picture-in-Picture" },
	float = true,
	pin = true,
	opacity = "0.95 0.8",
	size = { "(monitor_w*0.3)", "(monitor_h*0.3)" },
	move = { "(monitor_w*0.7)", "(monitor_h*0.645)" },
})
hl.window_rule({
	match = { title = "Firefox — Sharing Indicator" },
	float = true,
	move = { "(monitor_w*0.5)", "(monitor_h*0.5)" },
	suppress_event = "fullscreen",
})
-- hl.window_rule({
--   match = { title = "^(.*Youtube.*)$" },
--   idle_inhibit = "focus"
-- })
hl.window_rule({
	match = { title = "termfilechooser" },
	float = true,
	size = { "(monitor_w*0.5)", "(monitor_h*0.5)" },
})

-- KDE Connect
hl.window_rule({ match = { class = "org.kde.kdeconnect.daemon" }, float = true })
hl.window_rule({ match = { class = "org.kde.kdeconnect.handler" }, float = true })
hl.window_rule({ match = { class = "org.kde.kdeconnect-indicator" }, float = true })
hl.window_rule({ match = { class = "org.kde.kdeconnect.sms" }, float = true })
hl.window_rule({
	name = "kdeconnect-daemon-cleanup",
	match = { title = "KDEConnect Daemon" },
	no_blur = true,
})
hl.window_rule({
	match = { title = "KDEConnect Daemon" },
	border_size = 0,
	no_shadow = true,
	no_focus = true,
	--   pin = true
	suppress_event = "fullscreen",
	float = true,
	min_size = { 1366, 768 },
})
