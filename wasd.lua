local application = require "hs.application"
local hotkey = require "hs.hotkey"
local window = require "hs.window"
local screen = require "hs.screen"
local fnutils = require "hs.fnutils"

local utils = require "utils"

local wasd = {
    shrinkY = function()
        local win = window.focusedWindow()
        local f = win:frame()

        f.h = f.h - RESIZE.l
        win:setFrame(f)
    end,
    growY = function()
        local win = window.focusedWindow()
        local f = win:frame()

        f.h = f.h + RESIZE.l
        win:setFrame(f)
    end,
    shrinkX = function()
        local win = window.focusedWindow()
        local f = win:frame()

        f.w = f.w - RESIZE.l
        win:setFrame(f)
    end,
    growY = function()
        local win = window.focusedWindow()
        local f = win:frame()

        f.w = f.w + RESIZE.l
        win:setFrame(f)
    end
}

--[[ Hotkeys to resize using wasd ]]
hotkey.bind({"cmd", "alt"}, "w", wasd.shrinkY, nil, wasd.shrinkY)
hotkey.bind({"cmd", "alt"}, "s", wasd.growY, nil, wasd.growY)
hotkey.bind({"cmd", "alt"}, "a", wasd.shrinkX, nil, wasd.shrinkX)
hotkey.bind({"cmd", "alt"}, "d", wasd.growY, nil, wasd.growY)
