require('GlobalVar')
require('towerMenu')

function MapChosed()
	if GameInfo.Map == '1' then
		love.graphics.setColor(mapR, mapG, mapB)
		love.graphics.draw(Game_Map1,0,0)
	end
end

--parent functions
function Game_load()
	TowerMenu_load()
	Game_Map1 = love.graphics.newImage('Maps/Map1.png')
	mapR = love.math.random(0,255)
	mapG = love.math.random(0,255)
	mapB = love.math.random(0,255)
end

function Game_draw()
	MapChosed()
	TowerMenu_draw()
end

function Game_update()
	TowerMenu_update()
end
