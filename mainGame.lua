require('GlobalVar')
require('towerMenu')
require('MapData')

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
		love.graphics.draw(Game_Exit_Button, x, y, 0, 0.3)
		local mx, my = love.mouse.getPosition()
		
		if (mx > x and mx < (x+w) and (my > y and my < (y+h)) and love.mouse.isDown('l')) then
			GameInfo.Map = none
			Playing = false
			MenuInfo.level = 'main'
		end
	end
end

local function MuteGame(x,y, w, h)
    local mx, my = love.mouse.getPosition()
    if GameInfo.Sound_Cooldown > 0 then
        GameInfo.Sound_Cooldown = GameInfo.Sound_Cooldown -1
    end
    if TowerMenuInfo.Visible == true then
        if GameInfo.Sound == true then
            love.graphics.draw(Game_Sound_Button, x, y, 0, 0.30)
            else
            love.graphics.draw(Game_Mute_Sound_Button, x, y, 0, 0.30)
        end
        if (mx > x and mx < (x+w) and (my > y and my < (y+h)) and love.mouse.isDown('l') and GameInfo.Sound_Cooldown <= 0) then
            if GameInfo.Sound == true then
                GameInfo.Sound = false
                GameInfo.Sound_Cooldown = 10
            else
                GameInfo.Sound = true
                GameInfo.Sound_Cooldown = 10
            end
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
    Game_Sound_Button = love.graphics.newImage('Sprites/Buttons/Game/MuteGame.png')
    Game_Mute_Sound_Button = love.graphics.newImage('Sprites/Buttons/game/hover_MuteGame.png')
	mapR = love.math.random(0,255)
	mapG = love.math.random(0,255)
	mapB = love.math.random(0,255)
end

function Game_draw()
	MapChosed()
	TowerMenu_draw()
	ExitToGameMenu(800 - 25, 6, 19.5, 19.5)
    MuteGame(800-50, 6, 19.5, 19.5)
    -- CHeck isPointOutsidepath and tell us
    local mx, my = love.mouse.getPosition()
    local outside = isPointOutsidePath ('Map1', mx, my)
	love.graphics.print (string.format('%s', (outside and "ok") or "no"), 100, 0)
end

function Game_update()
	TowerMenu_update()
end
