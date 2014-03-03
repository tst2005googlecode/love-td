require('GlobalVar')
require('mainMenu')

function ChooseMap(x, y, width, height, info)
	local mx, my = love.mouse.getPosition()
	
	if ((mx > x) and (mx < x+width)) and ((my > y) and (my < y+height)) then
		if love.mouse.isDown('l') then
			GameInfo.Map = info
			Playing = true
		end
	end
end

--parent functions
function MapMenu_load()
	uBackButton = love.graphics.newImage('Sprites/Buttons/mapMenu/uBack.png')
	hBackButton = love.graphics.newImage('Sprites/Buttons/mapMenu/hBack.png')
	-- map data load
	mapMenu_uMap1 = love.graphics.newImage('Sprites/Buttons/mapMenu/uMap1.png')
	mapMenu_uMap2 = love.graphics.newImage('Sprites/Buttons/mapMenu/uMap2.png')
	mapMenu_uMap3 = love.graphics.newImage('Sprites/Buttons/mapMenu/uMap3.png')
	mapMenu_uMap4 = love.graphics.newImage('Sprites/Buttons/mapMenu/uMap4.png')
	mapMenu_hMap1 = love.graphics.newImage('Sprites/Buttons/mapMenu/hMap1.png')
	mapMenu_hMap2 = love.graphics.newImage('Sprites/Buttons/mapMenu/hMap2.png')
	mapMenu_hMap3 = love.graphics.newImage('Sprites/Buttons/mapMenu/hMap3.png')
	mapMenu_hMap4 = love.graphics.newImage('Sprites/Buttons/mapMenu/hMap4.png')
end

function MapMenu_draw()
	--load BG
	love.graphics.draw(mainMenuBG, 0, 0)
	--Back CLick
	HoverMenu(0, 562, 150, 38, uBackButton, hBackButton)
	-- HoverMenu for maps
	HoverMenu(50, 275, 100, 100, mapMenu_uMap1, mapMenu_hMap1)
	HoverMenu(250, 275, 100, 100, mapMenu_uMap2, mapMenu_hMap2)
	HoverMenu(450, 275, 100, 100, mapMenu_uMap3, mapMenu_hMap3)
	HoverMenu(650, 275, 100, 100, mapMenu_uMap4, mapMenu_hMap4)
end

function MapMenu_update()
	--Back Click
	ClickMenu(0, 562, 150, 38, 'main')
	--CLick for maps
	ChooseMap(50, 275, 100, 100, 'Map1')
	ChooseMap(250, 275, 100, 100, 'Map2')
	ChooseMap(450, 275, 100, 100, 'Map3')
	ChooseMap(650, 275, 100, 100, 'Map4')
end