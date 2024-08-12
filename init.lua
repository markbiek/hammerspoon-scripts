package.path = '/Users/mark/.hammerspoon/?.lua;' .. package.path

local application = require "hs.application"
local hotkey = require "hs.hotkey"
local window = require "hs.window"
local screen = require "hs.screen"
local fnutils = require "hs.fnutils"

local utils = require "utils"

hotkey.bind({"cmd", "alt", "ctrl"}, "r", function()
    hs.reload()
    hs.alert.show("Hammerspoon config loaded")
end)

myWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()

hs.urlevent.bind("arrangeWindows", function(eventName, params)
	local win

	win = activateAndMove("Code")
	if win == nil then
		return
	end
	fullScreen(win)

	win = activateAndMove("Simplenote")
	if win == nil then
		return
	end
	leftHalf(win)

	win = activateAndMove("Todoist")
	if win == nil then
		return
	end
	rightHalf(win)
end)
