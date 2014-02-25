require('GlobalVar')
require('towerMenu')

function MapChosed()
	if GameInfo.Map == '1' then
		love.graphics.setColor(255, 255, 255, 255)
		love.graphics.draw(Game_Map1_BG, 0, 0)
		love.graphics.setColor(mapR, mapG, mapB)
		love.graphics.draw(Game_Map1,0,0)
	elseif GameInfo.Map == "2" then
		love.graphics.setColor(255, 255, 255, 255)
		love.graphics.draw(Game_Map2_BG, 0, 0)
		love.graphics.setColor(mapR, mapG, mapB)
		love.graphics.draw(Game_Map2,0,0)
	end
end

local function ExitToGameMenu(x, y, w, h)
	if TowerMenuInfo.Visible == true then
		love.graphics.draw(Game_Exit_Button, x, y)
		local mx, my = love.mouse.getPosition()
		
		if (mx > x and mx < (x+w) and (my > y and my < (y+h)) and love.mouse.isDown('l')) then
			GameInfo.Map = none
			Playing = false
			MenuInfo.level = 'main'
		end
	end
end

--parent functions
function Game_load()
	TowerMenu_load()
	Game_Map1 = love.graphics.newImage('Maps/Map1.png')
	Game_Map1_BG = love.graphics.newImage('Sprites/Map1_Bg.png')
	Game_Map2 = love.graphics.newImage('Maps/Map2.png')
	Game_Map2_BG = love.graphics.newImage('Sprites/Map1_Bg.png')
	Game_Exit_Button = love.graphics.newImage('Sprites/Buttons/Game/ExitGame.png')
	mapR = love.math.random(0,255)
	mapG = love.math.random(0,255)
	mapB = love.math.random(0,255)
end

function Game_draw()
	MapChosed()
	TowerMenu_draw()
	ExitToGameMenu(800 - 20, 0, 20, 20)
end

function Game_update()
	TowerMenu_update()
end
