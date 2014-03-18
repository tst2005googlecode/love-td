--[[

    DEVELOPERS - Emil Andersen
    
    Main Menu File

--]]

local t_buttonBgColor = {102, 102, 102, 255}
local t_buttonBGColorHover = {90, 90, 90, 210}
local t_buttonTextColor = {255, 255, 255, 255}

local BUTTON_W, BUTTON_H, BUTTON_M = 150, 50, 10

local BG_COLOR = {23, 23, 23}

local Menu = {gui = {env = {button = {}, image = {}}}}

function quit()
    love.event.quit( )
end

function main_menu_create()
    love.graphics.setBackgroundColor( BG_COLOR )

    Menu.gui.env.button.startGame = gui.createButton(WIN_W /2 - BUTTON_W/2, BUTTON_H*2 + BUTTON_M, BUTTON_W, BUTTON_H, 'Start Game', t_buttonBgColor, t_buttonTextColor, 'OstrichSans', 'gui_setColor', 'gui_setColor', t_buttonBGColorHover, 'sm_menu_create' )
    Menu.gui.env.button.loadGame = gui.createButton(WIN_W /2 - BUTTON_W/2, BUTTON_H*3 + BUTTON_M*2 , BUTTON_W, BUTTON_H, 'Load Game', t_buttonBgColor, t_buttonTextColor, 'OstrichSans', 'gui_setColor', 'gui_setColor', t_buttonBGColorHover, 'load_menu_create')
    Menu.gui.env.button.highScore = gui.createButton(WIN_W /2 - BUTTON_W/2, BUTTON_H*4 + BUTTON_M*3 , BUTTON_W, BUTTON_H, 'HighScores', t_buttonBgColor, t_buttonTextColor, 'OstrichSans', 'gui_setColor', 'gui_setColor', t_buttonBGColorHover, 'score_menu_create')
    Menu.gui.env.button.endGame = gui.createButton(WIN_W /2 - BUTTON_W/2, BUTTON_H*5 + BUTTON_M*4 , BUTTON_W, BUTTON_H, 'End Game', t_buttonBgColor, t_buttonTextColor, 'OstrichSans', 'gui_setColor', 'gui_setColor', t_buttonBGColorHover, 'quit')
    
    return true
end

function map_menu_create()
    love.graphics.setBackgroundColor( BG_COLOR )
    
    Menu.gui.env.button.Map1 = gui.createButton(WIN_W /2 - BUTTON_W/2, BUTTON_H*2 + BUTTON_M, BUTTON_W, BUTTON_H, 'Map 1', t_buttonBgColor, t_buttonTextColor, 'OstrichSans', 'gui_setColor', 'gui_setColor', t_buttonBGColorHover, nil )
    Menu.gui.env.button.Map2 = gui.createButton(WIN_W /2 - BUTTON_W/2, BUTTON_H*3 + BUTTON_M*2, BUTTON_W, BUTTON_H, 'Map 2', t_buttonBgColor, t_buttonTextColor, 'OstrichSans', 'gui_setColor', 'gui_setColor', t_buttonBGColorHover, nil )
    Menu.gui.env.button.Map3 = gui.createButton(WIN_W /2 - BUTTON_W/2, BUTTON_H*4 + BUTTON_M*3, BUTTON_W, BUTTON_H, 'Map 3', t_buttonBgColor, t_buttonTextColor, 'OstrichSans', 'gui_setColor', 'gui_setColor', t_buttonBGColorHover, nil )
    Menu.gui.env.button.Map4 = gui.createButton(WIN_W /2 - BUTTON_W/2, BUTTON_H*5 + BUTTON_M*4, BUTTON_W, BUTTON_H, 'Map 4', t_buttonBgColor, t_buttonTextColor, 'OstrichSans', 'gui_setColor', 'gui_setColor', t_buttonBGColorHover, nil )
    Menu.gui.env.button.MapBack = gui.createButton(0+BUTTON_M, WIN_H-BUTTON_H-BUTTON_M, BUTTON_W, BUTTON_H, 'Back', t_buttonBgColor, t_buttonTextColor, 'OstrichSans', 'gui_setColor', 'gui_setColor', t_buttonBGColorHover, 'main_menu_create' )
    
    return true
end

function sm_menu_create()
     love.graphics.setBackgroundColor( BG_COLOR )
     
      Menu.gui.env.button.LoadSinglePlayer = gui.createButton(WIN_W /2 - BUTTON_W/2, BUTTON_H*2 + BUTTON_M, BUTTON_W, BUTTON_H, 'SinglePlayer', t_buttonBgColor, t_buttonTextColor, 'OstrichSans', 'gui_setColor', 'gui_setColor', t_buttonBGColorHover, 'map_menu_create' )
      Menu.gui.env.button.LoadMultiPlayer = gui.createButton(WIN_W /2 - BUTTON_W/2, BUTTON_H*3 + BUTTON_M*2, BUTTON_W, BUTTON_H, 'MultiPlayer', t_buttonBgColor, t_buttonTextColor, 'OstrichSans', 'gui_setColor', 'gui_setColor', t_buttonBGColorHover, 'multiplayer_menu_create' )
      Menu.gui.env.button.LoadsmBack = gui.createButton(0+BUTTON_M, WIN_H-BUTTON_H-BUTTON_M, BUTTON_W, BUTTON_H, 'Back', t_buttonBgColor, t_buttonTextColor, 'OstrichSans', 'gui_setColor', 'gui_setColor', t_buttonBGColorHover, 'main_menu_create' )
    
    return true
end

function score_menu_create()
    love.graphics.setBackgroundColor( BG_COLOR )
    
    Menu.gui.env.button.scoreBack = gui.createButton(0+BUTTON_M, WIN_H-BUTTON_H-BUTTON_M, BUTTON_W, BUTTON_H, 'Back', t_buttonBgColor, t_buttonTextColor, 'OstrichSans', 'gui_setColor', 'gui_setColor', t_buttonBGColorHover, 'main_menu_create' )

    return true
end

function load_menu_create()
    love.graphics.setBackgroundColor( BG_COLOR )
    
    Menu.gui.env.button.loadBack = gui.createButton(0+BUTTON_M, WIN_H-BUTTON_H-BUTTON_M, BUTTON_W, BUTTON_H, 'Back', t_buttonBgColor, t_buttonTextColor, 'OstrichSans', 'gui_setColor', 'gui_setColor', t_buttonBGColorHover, 'main_menu_create' )

    return true
end

function multiplayer_menu_create()
    love.graphics.setBackgroundColor( BG_COLOR )
    
    Menu.gui.env.button.multiMap1 = gui.createButton(WIN_W /2 - BUTTON_W/2, BUTTON_H*2 + BUTTON_M, BUTTON_W, BUTTON_H, 'Map 1', t_buttonBgColor, t_buttonTextColor, 'OstrichSans', 'gui_setColor', 'gui_setColor', t_buttonBGColorHover, nil )
    Menu.gui.env.button.multiMap2 = gui.createButton(WIN_W /2 - BUTTON_W/2, BUTTON_H*3 + BUTTON_M*2, BUTTON_W, BUTTON_H, 'Map 2', t_buttonBgColor, t_buttonTextColor, 'OstrichSans', 'gui_setColor', 'gui_setColor', t_buttonBGColorHover, nil )
    Menu.gui.env.button.multiMap3 = gui.createButton(WIN_W /2 - BUTTON_W/2, BUTTON_H*4 + BUTTON_M*3, BUTTON_W, BUTTON_H, 'Map 3', t_buttonBgColor, t_buttonTextColor, 'OstrichSans', 'gui_setColor', 'gui_setColor', t_buttonBGColorHover, nil )
    Menu.gui.env.button.multiMap4 = gui.createButton(WIN_W /2 - BUTTON_W/2, BUTTON_H*5 + BUTTON_M*4, BUTTON_W, BUTTON_H, 'Map 4', t_buttonBgColor, t_buttonTextColor, 'OstrichSans', 'gui_setColor', 'gui_setColor', t_buttonBGColorHover, nil )
    Menu.gui.env.button.multiBack = gui.createButton(0+BUTTON_M, WIN_H-BUTTON_H-BUTTON_M, BUTTON_W, BUTTON_H, 'Back', t_buttonBgColor, t_buttonTextColor, 'OstrichSans', 'gui_setColor', 'gui_setColor', t_buttonBGColorHover, 'main_menu_create' )
    
    return true
    
end
