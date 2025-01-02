local awful = require("awful")
-- local gears = require("gears")
local hostname = io.popen("uname -n"):read()

local function run_once(cmd)
	local findme = cmd
	local firstspace = cmd:find(" ")
	if firstspace then
		findme = cmd:sub(0, firstspace - 1)
	end
	awful.spawn.with_shell(string.format("pgrep -u $USER -x %s > /dev/null || (%s)", findme, cmd), false)
end

ImaGes = "still"
if hostname == "pcRU" or "vaio" then
	ImaGes = "down"
end

run_once("feh --bg-fill --randomize ~/mount/yandex/wallpapers/" .. ImaGes)

-- run_once('xmodmap -e "pointer = 3 2 1 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 4 5')
-- run_once("~/.local/bin/greenclip daemon")

-- return autostart
