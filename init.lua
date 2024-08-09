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

hs.urlevent.bind("arrangeWindows", function(eventName, params)
	local win = activateAndMove("Simplenote")
	if win == nil then
		return
	end

	leftHalf(win)

	local win = activateAndMove("Todoist")
	if win == nil then
		return
	end

	rightHalf(win)

	local win = activateAndMove("Code")
	if win == nil then
		return
	end

	fulLScreen(win)
end)
