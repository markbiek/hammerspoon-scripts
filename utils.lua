local application = require "hs.application"
local hotkey = require "hs.hotkey"
local window = require "hs.window"
local screen = require "hs.screen"
local fnutils = require "hs.fnutils"

RESIZE = {
    s= 10,
    l= 50
}

--[[--------------------------------------------------------------------------]]
--[[ Misc functions ]]
function outTable(table)
    for k, v in pairs(table) do
        print(k, v)
    end
end

function bottomRightCorner(f)
    -- Screen of the currently focused window
    local screen = window.focusedWindow():screen()
    local screenFrame = screen:frame()

    -- Bottom right corner of the current screen
    local bottomRight = {
        x = screenFrame.x  + screenFrame.w,
        y = screenFrame.y + screenFrame.h
    }

    -- Position the current window in the bottom right corner of the screen
    f.x = bottomRight.x - f.w
    f.y = bottomRight.y - f.h

    return f
end

function getBounds(f)
    return {
        x = f.x + f.w,
        y = f.y + f.h
    }
end

function lockFrameToScreenEdge(f)
    local screen = window.focusedWindow():screen()
    local screenFrame = screen:frame()
    local screenBounds = getBounds(screenFrame)
    local winBounds = getBounds(f)

    if winBounds.x > screenBounds.x then
        f.x = screenBounds.x - f.w
    elseif winBounds.x < 0 then
        f.x = screenFrame.x
    end

    if winBounds.y > screenBounds.y then
        f.y = screenBounds.y - f.h
    elseif winBounds.y < 0 then
        f.y = screenFrame.y
    end

    return f
end
