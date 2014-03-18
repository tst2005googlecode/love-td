--[[

    DEVELOPERS - Emil Andersen
    
    interface Game File

--]]

t_InterfaceMenu = {t_sidecolor = {255, 23, 23}, button = {}}

local BUTTON_W, BUTTON_H, BUTTON_M = 125, 35, 10
local sideMenuX = WIN_W - 200
local t_waveBgColor, t_waveTextColor, t_waveHoverColor = {20, 180, 0, 230}, {230, 230, 230, 255}, {20, 150, 0, 255}

function t_InterfaceMenu.sideMenushow()
    rightSideMenuOverlay = gui.createRectangle(sideMenuX, 0, 200, WIN_H, t_InterfaceMenu.t_sidecolor)
end

function t_InterfaceMenu.sideMenuHide()
    
end

function t_InterfaceMenu.overlay()
    t_InterfaceMenu.button.nextWave = gui.createButton(sideMenuX - BUTTON_W-BUTTON_M, WIN_H-BUTTON_H-BUTTON_M, BUTTON_W, BUTTON_H, 'Next Wave', t_waveBgColor, t_waveTextColor, 'OstrichSans', 'gui_setColor', 'gui_setColor', t_waveHoverColor, nil  )
end