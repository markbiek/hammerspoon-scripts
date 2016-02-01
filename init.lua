-- This path should be adjusted to where your hs scripts are
package.path = '/Users/mark/dev/hammerspoon/?.lua;' .. package.path

local application = require "hs.application"
local hotkey = require "hs.hotkey"
local window = require "hs.window"
local screen = require "hs.screen"
local fnutils = require "hs.fnutils"

-- CMD-OPT-f full screen
hotkey.bind({"cmd", "alt"}, "f", function()
    local win = window.focusedWindow()

    -- Screen of the currently focused window
    local screen = win:screen()
    local screenFrame = screen:frame()

    win:setFrame(screenFrame)
end)

-- CMD-OPT-left left half
hotkey.bind({"cmd", "alt"}, "left", function()
    local win = window.focusedWindow()
    local f = win:frame()

    -- Screen of the currently focused window
    local screen = win:screen()
    local screenFrame = screen:frame()

    f = screenFrame
    f.w = f.w / 2 - 1

    win:setFrame(f)
end)

-- CMD-OPT-right right half
hotkey.bind({"cmd", "alt"}, "right", function()
    local win = window.focusedWindow()
    local f = win:frame()

    -- Screen of the currently focused window
    local screen = win:screen()
    local screenFrame = screen:frame()

    f = screenFrame
    f.w = f.w / 2
    f.x = f.x + f.w - 2

    win:setFrame(f)
end)

-- Position the current window in the bottom-right corner
hotkey.bind({"cmd", "alt", "ctrl"}, "down", function()
    local win = window.focusedWindow()
    local f = win:frame()

    -- Screen of the currently focused window
    local screen = win:screen()
    local screenFrame = screen:frame()

    -- Bottom right corner of the current screen
    local bottomRight = {
        x = screenFrame.x  + screenFrame.w,
        y = screenFrame.y + screenFrame.h
    }

    -- Position the current window in the bottom right corner of the screen
    f.x = bottomRight.x - f.w
    f.y = bottomRight.y - f.h
    win:setFrame(f)

    -- mjolnir.openconsole();
end)

-- Move the current window up by a distance of the window height
hotkey.bind({"cmd", "alt", "ctrl"}, "up", function()
    local win = window.focusedWindow()
    local f = win:frame()

    f.y = f.y - f.h
    win:setFrame(f)

    -- mjolnir.openconsole();
end)
