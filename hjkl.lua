local application = require "hs.application"
local hotkey = require "hs.hotkey"
local window = require "hs.window"
local screen = require "hs.screen"
local fnutils = require "hs.fnutils"

local utils = require "utils"

local hjkl = {
    left = function()
        local win = window.focusedWindow()
        local f = win:frame()

        f.x = f.x - RESIZE.l
        win:setFrame(lockFrameToScreenEdge(f))
    end,
    down = function()
        local win = window.focusedWindow()
        local f = win:frame()

        f.y = f.y + RESIZE.l
        win:setFrame(lockFrameToScreenEdge(f))
    end,
    up = function()
        local win = window.focusedWindow()
        local f = win:frame()

        f.y = f.y - RESIZE.l
        win:setFrame(lockFrameToScreenEdge(f))
    end,
    right = function()
        local win = window.focusedWindow()
        local f = win:frame()

        f.x = f.x + RESIZE.l
        win:setFrame(lockFrameToScreenEdge(f))
    end
}

--[[ Hotkeys to move using hjkl ]]
hotkey.bind({"cmd", "alt"}, "h", hjkl.left, nil, hjkl.left)
hotkey.bind({"cmd", "alt"}, "j", hjkl.down, nil, hjkl.down)
hotkey.bind({"cmd", "alt"}, "k", hjkl.up, nil, hjkl.up)
hotkey.bind({"cmd", "alt"}, "l", hjkl.right, nil, hjkl.right)
