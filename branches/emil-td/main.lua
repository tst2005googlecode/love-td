--require files to be used
require('mainMenu')
require('GlobalVar')
require('MapMenu')

function love.load()
		mainMenu_load()
		MapMenu_load()
end

function love.draw()
	if (MenuInfo.level == 'main' and Playing == false) then
		mainMenu_draw()
	elseif (MenuInfo.level == 'Map' and Playing == false) then
		MapMenu_draw()
	end
end

function love.update()
	if (MenuInfo.level == 'main' and Playing == false) then
		mainMenu_update()
	elseif (MenuInfo.level == 'Map' and Playing == false) then
	MapMenu_update()
	end
end

