--[[

    DEVELOPERS - Emil Andersen
    
    gui/mainMenu file

--]]

local t_buttonBgColor = {102, 102, 102}
local t_buttonTextColor = {255, 255, 255}

local BUTTON_W, BUTTON_H, BUTTON_M = 150, 50, 10

local BG_COLOR = {0, 0, 120}

function main_menu_create()
    MainMenu = {buttons = {}}
    
    
    MainMenu.buttons.startGame = gui.createButton(WIN_W /2 - BUTTON_W/2, BUTTON_H *3 + BUTTON_M, BUTTON_W, BUTTON_H, 'start Game', t_buttonBgColor, t_buttonTextColor, 'OstrichSans')
    MainMenu.buttons.Highscore = gui.createButton(WIN_W /2 - BUTTON_W/2, BUTTON_H *4 + BUTTON_M*2 , BUTTON_W, BUTTON_H, 'Highscore', t_buttonBgColor, t_buttonTextColor, 'OstrichSans')
    MainMenu.buttons.EndGame = gui.createButton(WIN_W /2 - BUTTON_W/2, BUTTON_H *5 + BUTTON_M*3 , BUTTON_W, BUTTON_H, 'End Game', t_buttonBgColor, t_buttonTextColor, 'OstrichSans')
    
    for _, button in ipairs(MainMenu.buttons) do
        button:setHoverHandler('menu_ButtonEnterHover', 'menu_ButtonExitHover')
    end
    
    return true
end

function menu_ButtonEnterHover (button)
    return button:setColor ({0, 0, 0, 200})
end

function menu_ButtonExitHover (button)
    return button:setColor (t_buttonBgColor)
end

