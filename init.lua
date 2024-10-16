package.path = '/Users/mark/.hammerspoon/?.lua;' .. package.path

local application = require "hs.application"
local hotkey = require "hs.hotkey"
local window = require "hs.window"
local screen = require "hs.screen"
local fnutils = require "hs.fnutils"

local utils = require("utils")

hotkey.bind({"cmd", "alt", "ctrl"}, "r", function()
    hs.reload()
    hs.alert.show("Hammerspoon config loaded")
end)

myWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()

hs.urlevent.bind("arrangeWindows", function(eventName, params)
	local externalScreen = getExternalScreen()
	local windowLayout = {}

	local appsToArrange = {
        {"Simplenote", hs.layout.left50},
        {"Todoist", hs.layout.right50},
        {"Cursor", hs.layout.maximized}
    }

	for _, appInfo in ipairs(appsToArrange) do
        local appName, position = appInfo[1], appInfo[2]
		local app = hs.application.find(appName)

        if app ~= nil then
            table.insert(windowLayout, {appName, nil, externalScreen, position, nil, nil})
        end
    end

    hs.layout.apply(windowLayout)
end)