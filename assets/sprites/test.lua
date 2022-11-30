return graphics.newSprite(
    love.graphics.newImage(graphics.imagePath("path/to/sprite")), -- do not include assets/images/(png/dds)
	{
		{x = 0, y = 0, width = 150, height = 150, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 1: ANIM
	},
	{
		["ANIM"] = {start = 1, stop = 1, speed = 0, offsetX = 0, offsetY = 0}
	},
	"ANIM",
	false
)