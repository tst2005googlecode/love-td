--[[

    Developed by: Emil Andersen
    
    File: SinglePlayerMenu

--]]

local BUTTON_W, BUTTON_H, BUTTON_M = 150, 50, 15
local back_w, back_h = 150, 50

function SinglePlayerMenuCreate()
    local Map1 = gui.env.button.CreateButton(SCR_W/2 - (BUTTON_W/2), BUTTON_H*3 + BUTTON_M, BUTTON_W, BUTTON_H, 'Map1',t_textColor ,t_buttonColor, t_hoverButtonColor, 'OstrichSans', 'Enter', 'Exit', 'LoadMap' )
    local Map2 = gui.env.button.CreateButton(SCR_W/2 - (BUTTON_W/2), BUTTON_H*4 + BUTTON_M*2, BUTTON_W, BUTTON_H, 'Map2',t_textColor ,t_buttonColor, t_hoverButtonColor, 'OstrichSans', 'Enter', 'Exit', nil )
    local Map3 = gui.env.button.CreateButton(SCR_W/2 - (BUTTON_W/2), BUTTON_H*5 + BUTTON_M*3, BUTTON_W, BUTTON_H, 'Map3',t_textColor ,t_buttonColor, t_hoverButtonColor, 'OstrichSans', 'Enter', 'Exit', nil )
    local Map4 = gui.env.button.CreateButton(SCR_W/2 - (BUTTON_W/2), BUTTON_H*6 + BUTTON_M*4, BUTTON_W, BUTTON_H, 'Map4',t_textColor ,t_buttonColor, t_hoverButtonColor, 'OstrichSans', 'Enter', 'Exit', nil )
    local Map5 = gui.env.button.CreateButton(SCR_W/2 - (BUTTON_W/2), BUTTON_H*7 + BUTTON_M*5, BUTTON_W, BUTTON_H, 'Map5',t_textColor ,t_buttonColor, t_hoverButtonColor, 'OstrichSans', 'Enter', 'Exit', nil )
    local Back = gui.env.button.CreateButton(BUTTON_M, SCR_H - back_h - BUTTON_M, back_w, back_h, 'Back', t_textColor, t_buttonColor, t_hoverButtonColor, 'OstrichSans', 'Enter', 'Exit', 'loadPage', 'mainMenuCreate')
end

function LoadMap(func)
    render.removeAll()
    GameOn = true
    interface.CreateInterface()
end