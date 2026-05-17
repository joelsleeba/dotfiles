local mainMod = "SUPER"
local extraMod = "SUPER + SHIFT"
local lilMod = "SUPER + ALT"
local moreMod = "SUPER + CTRL"
local advancedMod = "SUPER + SHIFT + CTRL"
local godMod = "SUPER + SHIFT + ALT + CTRL"

local config = require("hyprland.config")
local term = config.term
local phoneName = config.phoneName
local hotspotName = config.hotspotName
local browser = config.browser
local browser_ex = config.browser_ex

-- Volume controls
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
	{ locked = true, repeating = true }
)
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_SINK@ toggle"), { locked = true })
hl.bind(
	"XF86AudioMicMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_SOURCE@ toggle"),
	{ locked = true, repeating = true }
)

-- Brightness
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 5%-"), { locked = true, repeating = true })

-- Player controls
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

-- Application Launch
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(term))
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd("~/.config/userscripts/clipvault_wofi.sh"))
hl.bind(mainMod .. " + A", hl.dsp.exec_cmd("~/.config/userscripts/audiochanger.py"))
hl.bind(
	mainMod .. " + D",
	hl.dsp.exec_cmd("wofi --exec-search --hide-scroll --insensitive --show=run --prompt=execute --columns=2")
)
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(term .. " yazi", { float = true, move = { 0.5, 0.5 } }))
hl.bind(mainMod .. " + O", hl.dsp.exec_cmd("~/.config/userscripts/zathura_history_wofi.sh"))
hl.bind(mainMod .. " + slash", hl.dsp.exec_cmd("pypr toggle dropterm"))
hl.bind(mainMod .. " + backslash", hl.dsp.exec_cmd("pypr toggle ncspot"))

-- Process Control
hl.bind(
	mainMod .. " + B",
	hl.dsp.exec_cmd("rfkill unblock bluetooth && bluetoothctl connect $(cat $HOME/.Boult_Audio)")
)
hl.bind(mainMod .. " + P", hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd("nmcli con up '" .. hotspotName .. "'"))
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd("networkmanager_dmenu"))
hl.bind(moreMod .. " + K", hl.dsp.exec_cmd("kdeconnect-cli --refresh"))
hl.bind(extraMod .. " + K", hl.dsp.exec_cmd("kdeconnect-cli -n " .. phoneName .. " --send-clipboard"))

-- rbw
hl.bind(
	moreMod .. " + SPACE",
	hl.dsp.exec_cmd(
		"rofi-rbw -a copy --selector wofi --selector-args='--insensitive' --prompt Bitwarden --clear-after 30 --clipboarder wl-copy"
	)
)
hl.bind(
	advancedMod .. " + SPACE",
	hl.dsp.exec_cmd("rofi-rbw --selector wofi --selector-args='--insensitive' --prompt Bitwarden --typer ydotool")
)

-- OSTT
hl.bind(lilMod .. " + SPACE", hl.dsp.exec_cmd("ostt launch --paste"))

-- waybar
hl.bind("SUPER_L", hl.dsp.exec_cmd("pkill -SIGUSR1 waybar"))
hl.bind("ALT_R", hl.dsp.exec_cmd("pkill -SIGUSR1 waybar"))
hl.bind(mainMod .. " + SUPER_L", hl.dsp.exec_cmd("pkill -SIGUSR1 waybar"), { transparent = true })

-- dunst
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd("dunstctl close"))
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("dunstctl context"))
hl.bind(extraMod .. " + N", hl.dsp.exec_cmd("dunstctl close-all"))
hl.bind(extraMod .. " + M", hl.dsp.exec_cmd("dunstctl history-pop"))
hl.bind(extraMod .. " + S", hl.dsp.exec_cmd("~/.config/userscripts/toggle-dnd.sh"))

-- help
hl.bind(
	extraMod .. " + slash",
	hl.dsp.exec_cmd(
		"hyprkeys -b -r"
			.. "|sed -E 's/^[a-z]+ = //g'"
			.. "|sed -E 's/^\\$//g'"
			.. "|sed s/mainMod/SUPER/g"
			.. "|sed s/moreMod/SUPER\\ CTRL/g"
			.. "|sed s/extraMod/SUPER\\ SHIFT/g"
			.. "|sed s/advancedMod/SUPER\\ SHIFT\\ CTRL/g"
			.. "|sed s/godMod/SUPER\\ SHIFT\\ ALT\\ CTRL/g"
			.. "|sed s/exec/=/g"
			.. "|wofi -d --prompt=binds"
	)
)

-- screenshot
hl.bind("Print", hl.dsp.exec_cmd("~/.config/userscripts/screenshot.sh"), { locked = true })
hl.bind(mainMod .. " + Print", hl.dsp.exec_cmd("~/.config/userscripts/screenrec.sh"), { locked = true })
hl.bind(
	mainMod .. " + P",
	hl.dsp.exec_cmd(
		"grim -o $(hyprctl monitors -j | jq -r '.[] | select(.focused)| .name') "
			.. '"/tmp/$(date +%Y.%m.%d-%H%M%S).jpg"'
	),
	{ locked = true }
)
hl.bind("XF86SelectiveScreenshot", hl.dsp.exec_cmd('grim -g "$(slurp)" - | wl-copy'))

-- Theme
hl.bind(extraMod .. " + T", hl.dsp.exec_cmd("~/.config/userscripts/toggle-theme.sh"), { locked = true })
hl.bind(extraMod .. " + G", hl.dsp.exec_cmd("~/.config/userscripts/toggle-reading.sh"), { locked = true })
hl.bind(extraMod .. " + D", hl.dsp.exec_cmd("~/.config/userscripts/toggle-monitor.sh"), { locked = true })

-- Session
hl.bind(advancedMod .. " + E", hl.dsp.exit())
hl.bind(advancedMod .. " + R", hl.dsp.exec_cmd("hyprctl reload"))
hl.bind(advancedMod .. " + L", hl.dsp.exec_cmd("hyprlock --immediate-render"))
hl.bind(
	advancedMod .. " + S",
	hl.dsp.exec_cmd("killall hyprlock & hyprlock --immediate-render & systemctl suspend"),
	{ locked = true }
)
hl.bind(godMod .. " + E", hl.dsp.exec_cmd("loginctl terminate-session self"), { locked = true })
hl.bind(godMod .. " + S", hl.dsp.exec_cmd("shutdown now"))

-- Resize Windows
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })
hl.bind(mainMod .. " + R", hl.dsp.submap("resize"))
hl.define_submap("resize", function()
	hl.bind("l", hl.dsp.window.resize({ x = 10, y = 0, relative = true }), { repeating = true })
	hl.bind("h", hl.dsp.window.resize({ x = -10, y = 0, relative = true }), { repeating = true })
	hl.bind("j", hl.dsp.window.resize({ x = 0, y = 10, relative = true }), { repeating = true })
	hl.bind("k", hl.dsp.window.resize({ x = 0, y = -10, relative = true }), { repeating = true })
	hl.bind("right", hl.dsp.window.resize({ x = -10, y = 0, relative = true }), { repeating = true })
	hl.bind("left", hl.dsp.window.resize({ x = 10, y = 0, relative = true }), { repeating = true })
	hl.bind("down", hl.dsp.window.resize({ x = 0, y = 10, relative = true }), { repeating = true })
	hl.bind("up", hl.dsp.window.resize({ x = 0, y = -10, relative = true }), { repeating = true })
	-- Exit submap
	hl.bind("Escape", hl.dsp.submap("reset"))
end)

-- Mouse actions
hl.bind(mainMod .. " + C", hl.dsp.submap("cursor"))
hl.define_submap("cursor", function()
	hl.bind("l", hl.dsp.exec_cmd("ydotool mousemove -f -- 18 0"), { repeating = true })
	hl.bind("h", hl.dsp.exec_cmd("ydotool mousemove -f -- -18 0"), { repeating = true })
	hl.bind("j", hl.dsp.exec_cmd("ydotool mousemove -f -- 0 18"), { repeating = true })
	hl.bind("k", hl.dsp.exec_cmd("ydotool mousemove -f -- 0 -18"), { repeating = true })

	-- Laptop monitor
	hl.bind("r", hl.dsp.cursor.move({ x = 280, y = 175 })) -- Top-Left quadrant center
	hl.bind("u", hl.dsp.cursor.move({ x = 840, y = 175 })) -- Top-Right quadrant center
	hl.bind("v", hl.dsp.cursor.move({ x = 280, y = 525 })) -- Bottom-Left quadrant center
	hl.bind("m", hl.dsp.cursor.move({ x = 840, y = 525 })) -- Bottom-Right quadrant center

	hl.bind("g", hl.dsp.cursor.move({ x = 560, y = 350 })) -- center of screen

	hl.bind("q", hl.dsp.cursor.move({ x = 0, y = 0 })) -- Top-Left corner
	hl.bind("p", hl.dsp.cursor.move({ x = 1120, y = 0 })) -- Top-Right corner
	hl.bind("z", hl.dsp.cursor.move({ x = 0, y = 700 })) -- Bottom-Left corner
	hl.bind("slash", hl.dsp.cursor.move({ x = 1120, y = 700 })) -- Bottom-Right corner

	hl.bind("t", hl.dsp.cursor.move({ x = 560, y = 0 })) -- Top edge mid
	hl.bind("a", hl.dsp.cursor.move({ x = 0, y = 350 })) -- Left edge mid
	hl.bind("semicolon", hl.dsp.cursor.move({ x = 1120, y = 350 })) -- Right edge mid
	hl.bind("b", hl.dsp.cursor.move({ x = 560, y = 700 })) -- Bottom edge mid

	-- hl.bind("r", hl.dsp.cursor.move({ x = 332, y = 208 })) -- Shared Top-Left quadrant center
	-- hl.bind("u", hl.dsp.cursor.move({ x = 996, y = 208 })) -- Shared Top-Right quadrant center
	-- hl.bind("v", hl.dsp.cursor.move({ x = 332, y = 622 })) -- Shared Bottom-Left quadrant center
	-- hl.bind("m", hl.dsp.cursor.move({ x = 996, y = 622 })) -- Shared Bottom-Right quadrant center

	hl.bind("Return", hl.dsp.exec_cmd("ydotool click 0xC0"), { repeating = false })
	hl.bind("Space", hl.dsp.exec_cmd("ydotool click 0xC1"), { repeating = false })
	-- Exit submap
	hl.bind("Escape", hl.dsp.submap("reset"))
end)

-- Window Controls
hl.bind(extraMod .. " + F", hl.dsp.window.fullscreen())
-- hl.bind(extraMod .. " + V", hl.dsp.layout.toggle_split())
-- hl.bind(extraMod .. " + P", hl.dsp.layout.toggle_pseudo())
hl.bind(extraMod .. " + SPACE", hl.dsp.window.float())
hl.bind(extraMod .. " + Q", hl.dsp.window.close())

-- Window Navigation
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "r" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "d" }))

hl.bind(extraMod .. " + H", hl.dsp.window.move({ direction = "l" }))
hl.bind(extraMod .. " + L", hl.dsp.window.move({ direction = "r" }))
hl.bind(extraMod .. " + K", hl.dsp.window.move({ direction = "u" }))
hl.bind(extraMod .. " + J", hl.dsp.window.move({ direction = "d" }))

-- Workspace Navigation
hl.bind(mainMod .. " + 1", hl.dsp.focus({ workspace = 1 }))
hl.bind(mainMod .. " + 2", hl.dsp.focus({ workspace = 2 }))
hl.bind(mainMod .. " + 3", hl.dsp.focus({ workspace = 3 }))
hl.bind(mainMod .. " + 4", hl.dsp.focus({ workspace = 4 }))
hl.bind(mainMod .. " + 5", hl.dsp.focus({ workspace = 5 }))
hl.bind(mainMod .. " + 6", hl.dsp.focus({ workspace = 6 }))
hl.bind(mainMod .. " + 7", hl.dsp.focus({ workspace = 7 }))
hl.bind(mainMod .. " + 8", hl.dsp.focus({ workspace = 8 }))
hl.bind(mainMod .. " + 9", hl.dsp.focus({ workspace = 9 }))
hl.bind(mainMod .. " + 0", hl.dsp.focus({ workspace = 10 }))

hl.bind(mainMod .. " + SHIFT + 1", hl.dsp.window.move({ workspace = 1 }))
hl.bind(mainMod .. " + SHIFT + 2", hl.dsp.window.move({ workspace = 2 }))
hl.bind(mainMod .. " + SHIFT + 3", hl.dsp.window.move({ workspace = 3 }))
hl.bind(mainMod .. " + SHIFT + 4", hl.dsp.window.move({ workspace = 4 }))
hl.bind(mainMod .. " + SHIFT + 5", hl.dsp.window.move({ workspace = 5 }))
hl.bind(mainMod .. " + SHIFT + 6", hl.dsp.window.move({ workspace = 6 }))
hl.bind(mainMod .. " + SHIFT + 7", hl.dsp.window.move({ workspace = 7 }))
hl.bind(mainMod .. " + SHIFT + 8", hl.dsp.window.move({ workspace = 8 }))
hl.bind(mainMod .. " + SHIFT + 9", hl.dsp.window.move({ workspace = 9 }))
hl.bind(mainMod .. " + SHIFT + 0", hl.dsp.window.move({ workspace = 10 }))

hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind("mouse:276", hl.dsp.focus({ workspace = "e+1" }))
hl.bind("mouse:275", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

hl.bind(mainMod .. " + right", hl.dsp.focus({ workspace = "e+1" }), { repeating = true })
hl.bind(mainMod .. " + left", hl.dsp.focus({ workspace = "e-1" }), { repeating = true })
hl.bind(moreMod .. " + h", hl.dsp.focus({ workspace = "e-1" }), { repeating = true })
hl.bind(moreMod .. " + l", hl.dsp.focus({ workspace = "e+1" }), { repeating = true })

-- Nobind mode

-- More App Launches
hl.bind(mainMod .. " + F1", hl.dsp.exec_cmd(term, { float = true }))
hl.bind(mainMod .. " + F2", hl.dsp.exec_cmd("zathura"))
hl.bind(mainMod .. " + F4", hl.dsp.exec_cmd(term .. " zsh -c yazi"))
hl.bind(mainMod .. " + F5", hl.dsp.exec_cmd(browser_ex))
hl.bind(mainMod .. " + F7", hl.dsp.exec_cmd(term .. " zsh -c rmpc", { workspace = 7 }))
