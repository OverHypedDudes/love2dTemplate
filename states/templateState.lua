--[[
This is an example of an image:
-- P1
local BG

*DO NOT* add the "assets/images/(png/dds)" at the start of the URL, the "graphics" module automatically redirects the path to THAT folder. 
]]

--[[
	For making new states, just copy this one and modify it lol
]]

return {
	enter = function(self, previous)

		graphics.setFade(0)
		graphics.fadeIn(0.5)
		--[[
		function TweenBG() -- Animate the Background / Levitation animation
			Timer.tween(1.5, BG, {y = BG.y + 10}, "in-out-quad", function()
				Timer.tween(1.5, BG, {y = BG.y - 10}, "in-out-quad", function()
					TweenBG() -- Loops the animation
				end)
			end)
		end
		TweenBG() -- Summons the tween
		--]]

		-- to change the X, Y position of the BG, use BG.x and BG.y
		-- to change the scale of the BG, use BG.sizeX, BG.sizeY

		-- to load a spritesheet, use sprite = love.filesystem.load("path/to/your/spritesheet.lua")()
		-- to animate a spritesheet, use sprite:animate("animationName", looped)		

		-- This is an example of a image:
		-- P2
		-- BG = graphics.newImage(graphics.imagePath("path/to/your/bg"))

		-- Don't add image loading at the top of the file, else it will load on game startup
	end,
 

	update = function(self, dt)
		-- to update the spritesheet, use sprite:update(dt)
		if not graphics.isFading() then
			-- Code that only runs when the screen is not fading
		end
	end,

	draw = function(self)
		love.graphics.push()
			love.graphics.translate(graphics.getWidth() / 2, graphics.getHeight() / 2)

			-- Put your code here
			-- To draw an image with the graphics module, use BG:draw()
			love.graphics.printf("HELLO WOOOOOOOOOOOOOOOORLD", -140, -25, 300, "center")
		love.graphics.pop()
	end,


	leave = function(self)
		Timer.clear()
	end
}