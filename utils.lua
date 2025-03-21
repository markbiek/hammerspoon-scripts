local application = require "hs.application"
local hotkey = require "hs.hotkey"
local window = require "hs.window"
local screen = require "hs.screen"
local fnutils = require "hs.fnutils"
local spaces = require("hs.spaces")

function debugLog(message)
	local logger = hs.logger.new('utils', 'debug')

	logger.d(message)
end

function getLaptopScreen()
	return "Built-in Retina Display"
end

function getExternalScreen()
	return "LG ULTRAGEAR"
end

function screens()
	local screens = screen.allScreens()
	for i,screen in ipairs(screens) do
		debugLog("Screen " .. i .. ": " .. screen:name())
	end
end

function reloadConfig(files)
    doReload = false
    for _,file in pairs(files) do
        if file:sub(-4) == ".lua" then
            doReload = true
        end
    end
    if doReload then
		hs.alert.show("Hammerspoon config loaded")
		hs.timer.doAfter(0.5, function()
            hs.reload()
        end)
    end
end

function leftThird(win)
	local currentScreen = win:screen()
	local screenFrame = currentScreen:frame()

	win:setFrame(hs.geometry.rect(screenFrame.x, screenFrame.y, screenFrame.w / 3, screenFrame.h))
end

function rightThird(win)
	local currentScreen = win:screen()
	local screenFrame = currentScreen:frame()

	win:setFrame(hs.geometry.rect(screenFrame.x + 2 * (screenFrame.w / 3), screenFrame.y, screenFrame.w / 3, screenFrame.h))
end

function leftTwoThirds(win)
	local currentScreen = win:screen()
	local screenFrame = currentScreen:frame()

	win:setFrame(hs.geometry.rect(screenFrame.x, screenFrame.y, 2 * (screenFrame.w / 3), screenFrame.h))
end

function leftHalf(win)
	local currentScreen = win:screen()
	local screenFrame = currentScreen:frame()

	win:setFrame(hs.geometry.rect(screenFrame.x, screenFrame.y, screenFrame.w / 2, screenFrame.h))
end

function rightHalf(win)
	local currentScreen = win:screen()
	local screenFrame = currentScreen:frame()

	win:setFrame(hs.geometry.rect(screenFrame.x + screenFrame.w / 2, screenFrame.y, screenFrame.w / 2, screenFrame.h))
end

function fullScreen(win)
	local currentScreen = win:screen()
	local screenFrame = currentScreen:frame()

	win:setFrame(screenFrame)
end

function activateAndMove(appName)
	local app = hs.application.find(appName)
	if app == nil then
		hs.alert.show(appName .. " not found!")
		return
	end

	local win = app:mainWindow()
	if win == nil then
		hs.alert.show("No window found for " .. appName)
		return
	end

	local currentScreen = win:screen()
	local nextScreen = currentScreen:toEast()

	if nextScreen == nil then
		hs.alert.show("No monitor to the right!")
		return
	end

	app:activate()
	win:moveToScreen(nextScreen)

	return win
end

function moveWindowToNextSpace()
    local win = hs.window.focusedWindow()
    if not win then
        hs.alert.show("No active window")
        return
    end

    local screen = win:screen()
    local allSpaces = spaces.allSpaces()[screen:getUUID()]
    local currentSpace = spaces.windowSpaces(win)[1]
    
    -- Find the current space index
    local currentIdx = fnutils.indexOf(allSpaces, currentSpace)
    if not currentIdx then
        hs.alert.show("Could not determine current space")
        return
    end
    
    -- Get the next space, wrap around to first if at the end
    local nextIdx = currentIdx % #allSpaces + 1
    local nextSpace = allSpaces[nextIdx]
    
    -- Move the window
    spaces.moveWindowToSpace(win, nextSpace)
    spaces.gotoSpace(nextSpace)  -- Follow the window
end

return {
    debugLog = debugLog,
    getLaptopScreen = getLaptopScreen,
    getExternalScreen = getExternalScreen,
    screens = screens,
    reloadConfig = reloadConfig,
    leftThird = leftThird,
    rightThird = rightThird,
    leftTwoThirds = leftTwoThirds,
    leftHalf = leftHalf,
    rightHalf = rightHalf,
    fullScreen = fullScreen,
    activateAndMove = activateAndMove,
    moveWindowToNextSpace = moveWindowToNextSpace
}
