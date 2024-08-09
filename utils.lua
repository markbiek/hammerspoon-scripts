local application = require "hs.application"
local hotkey = require "hs.hotkey"
local window = require "hs.window"
local screen = require "hs.screen"
local fnutils = require "hs.fnutils"

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