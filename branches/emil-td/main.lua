--require files to be used
require('mainMenu')
require('GlobalVar')
require('MapMenu')
require('Score')
require('MainGame')

function love.load()
		mainMenu_load()
		MapMenu_load()
		Score_load()
		Game_load()
		crap = love.graphics.newFont('Fonts/towerruinscond.ttf', 20)
end

function love.draw()
	if (MenuInfo.level == 'main' and Playing == false) then
		mainMenu_draw()
	elseif (MenuInfo.level == 'Map' and Playing == false) then
		MapMenu_draw()
	elseif (MenuInfo.level == 'Score' and Playing == false) then
		Score_draw()
	end
	if Playing == true then
		Game_draw()
	end
	showCrap(0,0)
end

function love.update()
	if (MenuInfo.level == 'main' and Playing == false) then
		mainMenu_update()
	elseif (MenuInfo.level == 'Map' and Playing == false) then
	MapMenu_update()
	elseif (MenuInfo.level == 'Score' and Playing == false) then
	Score_update()
	end
	if Playing == true then
		Game_update()
	end
end
-- test functions
function showCrap(x, y)
	local mx, my = love.mouse.getPosition()
	love.graphics.setFont(crap)
	love.graphics.print(mx..', ', x,y)
	love.graphics.print(my, x+50, y)
end
