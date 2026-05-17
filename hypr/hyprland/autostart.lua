require("hyprland.config")
hl.on("hyprland.start", function()
	hl.exec_cmd("hyprpaper")
	hl.exec_cmd("waybar")
	hl.exec_cmd("pypr")
	hl.exec_cmd("ydotoold")
	hl.exec_cmd("kanshi")

	-- hl.exec_cmd("hyprpm reload -n")
	-- hl.exec_cmd("udiskie -s")

	hl.exec_cmd("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")

	hl.exec_cmd("wl-paste --type text --watch clipvault store")
	hl.exec_cmd("wl-paste --type image --watch clipvault store")
	hl.exec_cmd("clipvault clear")

	hl.exec_cmd("hypridle")
	hl.exec_cmd("~/.config/userscripts/themeSetter.sh")
	hl.exec_cmd("hyprsunset")
	hl.exec_cmd("dunst")
	hl.exec_cmd("/usr/lib/kdeconnectd")
	hl.exec_cmd("kdeconnect-indicator")

	-- non-once exec (runs every start event)
	hl.exec_cmd("kdeconnect-cli --refresh")
end)
