--[[

    Developed by: Emil Andersen
    
    File: Game File

--]]

interface = {}
local SIDEMENU_W, SIDEMENU_H, SIDEMENU_COLOR = 200, SCR_H, {83, 83, 83, 210}
local NEXTWAVE_W, NEXTWAVE_H, NEXTWAVE_M, NEXTWAVE_COLOR, NEXTWAVE_TCOLOR, NEXTWAVE_HCOLOR = 85, 30, 10, {18, 110, 0, 230}, {255, 255, 255, 240}, {13, 70, 0, 250}
local EXIT_W, EXIT_H, EXIT_M = 50, 20, 10

function interface.CreateInterface()
    local SideMenu = gui.env.rectangle.CreateRectangle(SCR_W-SIDEMENU_W, 0, SIDEMENU_W, SIDEMENU_H, SIDEMENU_COLOR)
    local NextWave = gui.env.button.CreateButton(SCR_W-SIDEMENU_W + NEXTWAVE_M, SCR_H-NEXTWAVE_H - NEXTWAVE_M, NEXTWAVE_W, NEXTWAVE_H, 'Next Wave', NEXTWAVE_TCOLOR, NEXTWAVE_COLOR, NEXTWAVE_HCOLOR,'OstrichSans', 'Enter', 'Exit', nil)
    local Hide = gui.env.button.CreateButton(SCR_W - NEXTWAVE_W - NEXTWAVE_M, SCR_H - NEXTWAVE_H - NEXTWAVE_M, NEXTWAVE_W, NEXTWAVE_H, 'Hide Menu', t_textColor, t_buttonColor, {100, 100, 100, 255}, 'OstrichSans', 'Enter', 'Exit', nil)
    local ToMain = gui.env.button.CreateButton(SCR_W - EXIT_W - EXIT_M, EXIT_M, EXIT_W, EXIT_H, 'E', t_textColor, t_buttonColor, {100, 100, 100, 255}, 'OstrichSans', 'Enter', 'Exit', 'loadPage', 'mainMenuCreate' )
      
      
end