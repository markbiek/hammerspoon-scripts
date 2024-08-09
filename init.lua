hs.urlevent.bind("arrangeWindows", function(eventName, params)
	local appName = "Simplenote"
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

	local screenFrame = nextScreen:frame()
	win:setFrame(hs.geometry.rect(screenFrame.x, screenFrame.y, screenFrame.w / 2, screenFrame.h))
end)
