require('GlobalVar')

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
		if love.mouse.isDown('l') then
			MenuInfo.level = info
		end
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
	
	mainMenuBG = love.graphics.newImage('Sprites/Bg.png')
	
	--load font
	mainMenu_font = love.graphics.newFont('Fonts/towerruinscond.ttf', 100)
end

function mainMenu_draw()
-- Draw Bg for this scene
	love.graphics.draw(mainMenuBG, 0, 0)
-- draw name for game
	love.graphics.setFont(mainMenu_font)
	love.graphics.print('Name TD', 200, 50)
-- draw buttons with Hover function
	HoverMenu(300, 200, 150, 50, uPlayButton, hPlayButton)
	HoverMenu(300, 300, 150, 50, uScoreButton, hScoreButton)
	HoverMenu(300, 400, 150, 50, uExitButton, hExitButton) 
end

function mainMenu_update()
	ClickMenu(300, 200, 150, 50, 'Map')
	ClickMenu(300, 300, 150, 50, 'Score')
	ClickMenu(300, 400, 150, 50, 'Exit')
end
