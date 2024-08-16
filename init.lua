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
	local externalScreen = getExternalScreen()

	local windowLayout = {
        {"Simplenote", nil, externalScreen, hs.layout.left50, nil, nil},
        {"Todoist", nil, externalScreen, hs.layout.right50, nil, nil},
        {"Code", nil, externalScreen, hs.layout.maximized, nil, nil},
    }
    hs.layout.apply(windowLayout)
end)