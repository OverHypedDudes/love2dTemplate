--[[
This is an example of an image:

local BG = graphics.newImage(love.graphics.newImage(graphics.imagePath("path/to/your/bg")))

*DO NOT* add the "assets/images" at the start of the URL, the "graphics" module automatically redirects the path to THAT folder. 
]]

--[[
	For making new states, just copy this one and modify it lol
]]

return {
	enter = function(self, previous)

		graphics.setFade(0)
		graphics.fadeIn(0.5)

--[[	function TweenBG() -- Animate the Background / Levitation animation
			Timer.tween(1.5, BG, {y = BG.y + 10}, "in-out-quad", function()
				Timer.tween(1.5, BG, {y = BG.y - 10}, "in-out-quad", function()
					TweenBG() -- Loops the animation
				end)
			end)
		end
		TweenBG() -- Summons the tween
]]
		
	end,


	update = function(self, dt)
		if not graphics.isFading() then
			-- Put your code here

			if not Gamestate.current().mousemoved then
				love.mouse.setVisible(true)
			end
		end
	end,

	draw = function(self)
		love.graphics.push()
			love.graphics.translate(graphics.getWidth() / 2, graphics.getHeight() / 2)

			-- Put your code here
			-- oh, also, there's the func for the example image
			-- BG:draw()
			love.graphics.print("HELLO WOOOOOOOOOOOOOOOORLD")

			love.graphics.push()
				love.graphics.setColor(1, 1, 1)
			love.graphics.pop()
		love.graphics.pop()
	end,


	leave = function(self)
		Timer.clear()
	end
}