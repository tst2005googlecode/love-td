--require files to be used
require('mainMenu')

GameInfo = {
Map = none,
Money = 60,
Lives = 20,
Stage = 0
}

MenuInfo = {level = 'main'}

Playing = false


function love.load()
	if (MenuInfo.level == 'main' and Playing == false) then
		mainMenu_load()
	end
end

function love.draw()
	if (MenuInfo.level == 'main' and Playing == false) then
		mainMenu_draw()
	end
end

function love.update()
	if (MenuInfo.level == 'main' and Playing == false) then
		mainMenu_update()
	end
end

