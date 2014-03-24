--[[

    Developed by: Emil Andersen
    
    File: MainMenu

--]]

local BUTTON_W, BUTTON_H, BUTTON_M = 150, 50, 15

function mainMenuCreate()

    local startGame = gui.env.button.CreateButton(SCR_W/2 - (BUTTON_W/2), BUTTON_H*3 + BUTTON_M, BUTTON_W, BUTTON_H, 'Start Game',t_textColor ,t_buttonColor, t_hoverButtonColor, 'OstrichSans', 'Enter', 'Exit', 'loadPage', 'SinglePlayerMenuCreate' )
    local MultiPlayer = gui.env.button.CreateButton(SCR_W/2 - (BUTTON_W/2), BUTTON_H*4 + BUTTON_M*2, BUTTON_W, BUTTON_H, 'MultiPlayer',t_textColor ,t_buttonColor, t_hoverButtonColor, 'OstrichSans', 'Enter', 'Exit')
    local HighScore = gui.env.button.CreateButton(SCR_W/2 - (BUTTON_W/2), BUTTON_H*5 + BUTTON_M*3, BUTTON_W, BUTTON_H, 'HighScore',t_textColor ,t_buttonColor, t_hoverButtonColor, 'OstrichSans', 'Enter', 'Exit')
    local EndGame = gui.env.button.CreateButton(SCR_W/2 - (BUTTON_W/2), BUTTON_H*6 + BUTTON_M*4, BUTTON_W, BUTTON_H, 'End Game',t_textColor ,t_buttonColor, t_hoverButtonColor, 'OstrichSans', 'Enter', 'Exit')
end

