require('mainMenu')
require('Highscore')
require('GlobalVar')

function score_printScreen(x1, x2, x3, y, margin)
	local t = scores.getAll()
	for k,v in ipairs(t) do
		love.graphics.print(tostring(v[1]), x1, y+k*margin)
		love.graphics.print(tostring(v[2]), x2, y+k*margin)
		love.graphics.print(tostring(v[3]), x3, y+k*margin)
	end
end

--parent functions
function Score_load()
	scores.initialise(10, true)
	Score_uBackButton = love.graphics.newImage('Sprites/Buttons/scoreMenu/uBack.png')
	Score_hBackButton = love.graphics.newImage('Sprites/Buttons/scoreMenu/hBack.png')
	score_font = love.graphics.newFont('Fonts/towerruinscond.ttf', 35)
end

function Score_draw()
	love.graphics.draw(mainMenuBG, 0, 0)
	HoverMenu(0, 562, 150, 38, Score_uBackButton, Score_hBackButton)
	love.graphics.setFont(score_font)
	score_printScreen(50, 320, 590, -20, 50)
end

function Score_update()
	ClickMenu(0, 562, 150, 38, 'main')
end