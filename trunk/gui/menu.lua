--[[

    gui/menu.lua
        
    * DEVELOPERS:   Joachim Andersen

--]]

--[[

    Main menu
    
--]]

local MENU_BUTTON_WIDTH = 150
local MENU_BUTTON_HEIGHT = 45

menu = {gui = {buttons = {}}}

function menu_ButtonEnterHover (button)
    button:setButtonColor ({0, 0, 0, 200})
end

function menu_ButtonExitHover (button)
    button:setButtonColor (COLORS.markerblack)
end

function menu.create ()
    love.graphics.setBackgroundColor (102, 102, 102)
    
    menu.gui.buttons.startButton = gui.createButton (WIN_W / 2 - MENU_BUTTON_WIDTH / 2, WIN_H / 2 - MENU_BUTTON_HEIGHT / 2 - 200, MENU_BUTTON_WIDTH, MENU_BUTTON_HEIGHT, 'Start game', COLORS.markerblack, COLORS.white, 'OstrichSans')
    menu.gui.buttons.scoreButton = gui.createButton (WIN_W / 2 - MENU_BUTTON_WIDTH / 2, WIN_H / 2 - MENU_BUTTON_HEIGHT / 2 - 200 + MENU_BUTTON_HEIGHT + 10, MENU_BUTTON_WIDTH, MENU_BUTTON_HEIGHT, 'Highscores', COLORS.markerblack, COLORS.white, 'OstrichSans')
    menu.gui.buttons.exitButton  = gui.createButton (WIN_W / 2 - MENU_BUTTON_WIDTH / 2, WIN_H / 2 - MENU_BUTTON_HEIGHT / 2 - 200 + MENU_BUTTON_HEIGHT*2 + 10*2, MENU_BUTTON_WIDTH, MENU_BUTTON_HEIGHT, 'Exit', COLORS.markerblack, COLORS.white, 'OstrichSans')

    for _,button in pairs (menu.gui.buttons) do
        button:setHoverHandler ('menu_ButtonEnterHover', 'menu_ButtonExitHover')
    end
end

function menu.destroy ()
    for k,button in pairs (menu.gui.buttons) do
        button:destroy ()
    end
    menu.gui.buttons = nil
end