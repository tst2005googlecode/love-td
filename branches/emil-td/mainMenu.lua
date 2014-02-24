require('main')

function HoverMenu(x, y, width, height, firstImg, secondImg)
	local mx, my = love.mouse.getPosition()
	
	if ((mx > x) and (mx < x+width)) and ((my > y) and (my < y+height)) then
		love.graphics.draw(secondImg, x, y)
		else
		love.graphics.draw(firstImg, x, y)
	end
end

function ClickMenu(x, y, width, height, info)
	local mx, my = love.mouse.getPosition()
	
	if ((mx > x) and (mx < x+width)) and ((my > y) and (my < y+height)) then
		
	end
end

-- parent functions
function mainMenu_load()
-- load pictures to be used
	uPlayButton = love.graphics.newImage('Sprites/Buttons/mainMenu/uPlaybutton.png')
	uScoreButton = love.graphics.newImage('Sprites/Buttons/mainMenu/uScorebutton.png')
	uExitButton = love.graphics.newImage('Sprites/Buttons/mainMenu/uExitbutton.png')
	hPlayButton = love.graphics.newImage('Sprites/Buttons/mainMenu/hPlaybutton.png')
	hScoreButton = love.graphics.newImage('Sprites/Buttons/mainMenu/hScorebutton.png')
	hExitButton = love.graphics.newImage('Sprites/Buttons/mainMenu/hExitbutton.png')
end

function mainMenu_draw()
-- draw buttons with Hover function
	HoverMenu(300, 200, 150, 50, uPlayButton, hPlayButton)
	HoverMenu(300, 300, 150, 50, uScoreButton, hScoreButton)
	HoverMenu(300, 400, 150, 50, uExitButton, hExitButton) 
end

function mainMenu_update()

end
