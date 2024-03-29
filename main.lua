data = require "data"
require "modules.errHandler"
curOS = love.system.getOS()

    -- Load Libraries
    Timer = require "lib.timer"
    Gamestate = require "lib.gamestate"
    lovelyToasts = require "lib.lovelyToasts"
	push = require "lib.push"

    -- Load Modules
	status = require "modules.status"
	graphics = require "modules.graphics"

	push.setupScreen(800, 600, {upscale = "normal"})

function love.load()

--  [[Load States]]

	template = require "states.templateState"
--	EXAMPLE STATE /// STATE = require "states.YOURSTATE"

--  [[Load fonts and stuff]]
	graphics.font("font", "assets/fonts/metro.otf")



    -- Load the Gamestate lib
    Gamestate.switch(template) -- Change this to your new state, or just rename the template one.
end

function love.resize(width, height)
	push.resize(width, height)
end

function love.keypressed(key)

--	[[Extra things lol]]

	if key == "f1" then
		love.filesystem.createDirectory("screenshots")

		love.graphics.captureScreenshot("screenshots/" .. os.time() .. ".png")
		lovelyToasts.show("Screenshot taken", 3) -- Show toast for 3 seconds
	elseif key == "f2" then
		love.system.openURL("file://" .. love.filesystem.getSaveDirectory() .. "/screenshots")
		lovelyToasts.show("Opening the screenshots folder...", 3)
	elseif key == "f11" then
		fullscreen = not fullscreen
		love.window.setFullscreen(fullscreen)
		love.resize(love.graphics.getDimensions())
	else
		Gamestate.keypressed(key)
	end
end

function love.update(dt)
    dt = math.min(dt, 1 / 30) -- 30 fps minimum

    lovelyToasts.update(dt)
    if status.getNoResize() then
		Gamestate.update(dt)
	else
		graphics.font("font", "assets/fonts/metro.otf")
		graphics.screenBase(push.getWidth(), push.getHeight())
		graphics.setColor(1, 1, 1) -- Fade effect on
		Gamestate.update(dt)
		love.graphics.setColor(1, 1, 1) -- Fade effect off
		graphics.screenBase(love.graphics.getWidth(), love.graphics.getHeight())
		graphics.font("font", "assets/fonts/metro.otf")
	end
    Timer.update(dt)

end

function love.draw()
    if status.getNoResize() then
		graphics.setColor(1, 1, 1) -- Fade effect on
		Gamestate.draw()
		love.graphics.setColor(1, 1, 1) -- Fade effect off
		graphics.font("font", "assets/fonts/metro.otf")

		if status.getLoading() then
--			love.graphics.print("Loading...", graphics.getWidth() - 175, graphics.getHeight() - 50)
			love.graphics.setColor(0, 0, 0, 0.5)
			love.graphics.rectangle("fill", 0, 0, 1280, 720)
			love.graphics.setColor(1, 1, 1)
			love.graphics.printf("Loading...", 0, graphics.getHeight() - 50, 1280, "center", 0, 1.3, 1.3)
		end
	else
		graphics.screenBase(push.getWidth(), push.getHeight())
		push.start()
			graphics.setColor(1, 1, 1) -- Fade effect on
			Gamestate.draw()
			love.graphics.setColor(1, 1, 1) -- Fade effect off
			graphics.font("font", "assets/fonts/metro.otf")
			lovelyToasts.draw()

			if status.getLoading() then
				love.graphics.setColor(0, 0, 0, 0.5)
				love.graphics.rectangle("fill", 0, 0, 1280, 720)
				love.graphics.setColor(1, 1, 1)
				love.graphics.printf("Loading...", graphics.getWidth() - 175, graphics.getHeight() - 50, 1280, "center", 0, 1.3, 1.3)
			end
		push.finish()
	end
	graphics.screenBase(love.graphics.getWidth(), love.graphics.getHeight())
end
