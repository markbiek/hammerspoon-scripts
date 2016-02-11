-- This path should be adjusted to where your hs scripts are
package.path = '/Users/mark/dev/hammerspoon/?.lua;' .. package.path

local application = require "hs.application"
local hotkey = require "hs.hotkey"
local window = require "hs.window"
local screen = require "hs.screen"
local fnutils = require "hs.fnutils"

local RESIZE = {
    s= 10,
    l= 20
}

--[[--------------------------------------------------------------------------]]
--[[ Misc functions ]]
function outTable(table)
    for k, v in pairs(table) do
        print(k, v)
    end
end

hotkey.bind({"cmd", "alt", "ctrl"}, "r", function()
    hs.reload()
    hs.alert.show("Hammerspoon config loaded")
end)
--[[--------------------------------------------------------------------------]]

--[[--------------------------------------------------------------------------]]
--[[ Hotkeys for development workflow ]]
hotkey.bind({"cmd", "alt", "ctrl"}, "d", function()
    local app = application.frontmostApplication()
    local win = window.focusedWindow()
    local screen = win:screen()
    local screenFrame = screen:frame()
    local appWin = app:getWindow(win:title())

    if appWin ~= nil then
        if app:name() == 'MacVim' then
            local f = win:frame()

            f.x = screenFrame.x
            f.y = screenFrame.y
            f.w = 1898
            f.h = 1412

            win:setFrame(f)
        end
    end
end)
--[[--------------------------------------------------------------------------]]

--[[--------------------------------------------------------------------------]]
--[[ Hotkeys to move using hjkl ]]
-- TODO
--[[--------------------------------------------------------------------------]]

--[[--------------------------------------------------------------------------]]
--[[ Hotkeys to resize using wasd ]]
hotkey.bind({"cmd", "alt"}, "w", function()
    local win = window.focusedWindow()
    local f = win:frame()

    f.h = f.h - RESIZE.l
    win:setFrame(f)
end)
hotkey.bind({"cmd", "alt"}, "s", function()
    local win = window.focusedWindow()
    local f = win:frame()

    f.h = f.h + RESIZE.l
    win:setFrame(f)
end)
hotkey.bind({"cmd", "alt"}, "a", function()
    local win = window.focusedWindow()
    local f = win:frame()

    f.w = f.w - RESIZE.l
    win:setFrame(f)
end)
hotkey.bind({"cmd", "alt"}, "d", function()
    local win = window.focusedWindow()
    local f = win:frame()

    f.w = f.w + RESIZE.l
    win:setFrame(f)
end)
--[[--------------------------------------------------------------------------]]

--[[--------------------------------------------------------------------------]]
--[[ Hotkeys to move windows between screens]]
hotkey.bind({"cmd", "alt", "ctrl"}, "left", function()
    local curScreen = screen.mainScreen()
    local origMode = curScreen:currentMode()
    local newMode = nil

    outTable(origMode)

    window.focusedWindow():moveOneScreenWest()

    curScreen = screen.mainScreen()
    newMode = curScreen:currentMode()

    outTable(newMode)
end)

hotkey.bind({"cmd", "alt", "ctrl"}, "right", function()
    window.focusedWindow():moveOneScreenEast()
end)
--[[--------------------------------------------------------------------------]]

-- Fullscreen
hotkey.bind({"cmd", "alt"}, "f", function()
    local win = window.focusedWindow()

    -- Screen of the currently focused window
    local screen = win:screen()
    local screenFrame = screen:frame()

    win:setFrame(screenFrame)
end)

-- Left half
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

-- Right half
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

-- Bottom right corner
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
end)

-- Move up by window height
hotkey.bind({"cmd", "alt", "ctrl"}, "up", function()
    local win = window.focusedWindow()
    local f = win:frame()

    f.y = f.y - f.h
    win:setFrame(f)
end)
