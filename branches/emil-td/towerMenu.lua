require('GlobalVar')
require('mainMenu')

function DrawMenu()
	if TowerMenuInfo.Visible == true then
		love.graphics.setColor(TowerMenuInfo.Color)
		love.graphics.rectangle('fill', 800 - TowerMenuInfo.Width, 0, TowerMenuInfo.Width, TowerMenuInfo.Height)
		love.graphics.setColor(255, 255, 255, 255)
		HoverMenu((800 - TowerMenuInfo.Width), 600-25, 50, 20, uShowMenuButton, hShowMenuButton)
	else
		love.graphics.setColor(255, 255, 255, 255)
		HoverMenu((800 - 50), 600-25, 50, 20, hShowMenuButton, uShowMenuButton)
	end
end

local function HideMenu()
	local mx, my = love.mouse.getPosition()
	if ((mx > 800 - TowerMenuInfo.Width) and (mx < (800 - TowerMenuInfo.Width) + 50)) and ((my > 600-25) and (my < (600-25)+20)) and TowerMenuInfo.Visible == true then
		if love.mouse.isDown('l') then 
			TowerMenuInfo.Visible = false
		end
		elseif ((mx > 800 - 50) and (mx < (800 - 50) + 50)) and ((my > 600-25) and (my < (600-25)+20)) and TowerMenuInfo.Visible == false then
			if love.mouse.isDown('l') then
				TowerMenuInfo.Visible = true
			end
	end
end

-- parent functions
function TowerMenu_load()
	uShowMenuButton = love.graphics.newImage('Sprites/Buttons/uShowButton.png')
	hShowMenuButton = love.graphics.newImage('Sprites/Buttons/hShowButton.png')
end

function TowerMenu_draw()
		DrawMenu()
end

function TowerMenu_update()
	HideMenu()
end
