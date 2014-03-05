--[[

    gui/menu.lua
        
    * DEVELOPERS:   Joachim Andersen

--]]

--[[

    Main menu
    
--]]

local MENU_BUTTON_WIDTH = 150
local MENU_BUTTON_HEIGHT = 45

local nav = {}
local mapMenu = {}
local scoreMenu = {}
local loadMenu = {}

menu = {}

function menu_ButtonEnterHover (button)
    return button:setColor ({0, 0, 0, 200})
end

function menu_ButtonExitHover (button)
    return button:setColor (COLORS.markerblack)
end

function navigation_Return (rect)
    nav.destroy ()
    return menu.create ()
end

function nav.create ()
    nav.gui = {rectangles = {}, images = {}}

    local image_Arrow = love.graphics.newImage ('media/arrow.png')
    
    local int_ReturnX, int_ReturnY = 50, 30
    
    nav.gui.rectangles.returnBg = gui.createRectangle ('line', int_ReturnX, int_ReturnY, 85, 45, {0, 0, 0, 128})
    nav.gui.rectangles.returnBg:setClickHandler ('navigation_Return')
    
    nav.gui.images.returnArrow = gui.createImage (int_ReturnX + 11, int_ReturnY-10, image_Arrow)
    nav.gui.images.returnArrow:setScale (0.5, 0.5)
end

function nav.destroy ()
    for _,image in pairs (nav.gui.images) do
        image:destroy ()
    end
    for _,rect in pairs (nav.gui.rectangles) do
        rect:destroy ()
    end
    
    nav.gui = nil
end

function menu.create ()
    menu.gui = {buttons = {}}

    menu.gui.buttons.startButton = gui.createButton (WIN_W / 2 - MENU_BUTTON_WIDTH / 2, WIN_H / 2 - MENU_BUTTON_HEIGHT / 2 - 200, MENU_BUTTON_WIDTH, MENU_BUTTON_HEIGHT, 'Start game', COLORS.markerblack, COLORS.white, 'OstrichSans')
    menu.gui.buttons.loadButton = gui.createButton (WIN_W / 2 - MENU_BUTTON_WIDTH / 2, WIN_H / 2 - MENU_BUTTON_HEIGHT / 2 - 200 + MENU_BUTTON_HEIGHT + 10, MENU_BUTTON_WIDTH, MENU_BUTTON_HEIGHT, 'Load game', COLORS.markerblack, COLORS.white, 'OstrichSans')
    menu.gui.buttons.scoreButton = gui.createButton (WIN_W / 2 - MENU_BUTTON_WIDTH / 2, WIN_H / 2 - MENU_BUTTON_HEIGHT / 2 - 200 + MENU_BUTTON_HEIGHT*2 + 10*2, MENU_BUTTON_WIDTH, MENU_BUTTON_HEIGHT, 'Highscores', COLORS.markerblack, COLORS.white, 'OstrichSans')
    menu.gui.buttons.exitButton  = gui.createButton (WIN_W / 2 - MENU_BUTTON_WIDTH / 2, WIN_H / 2 - MENU_BUTTON_HEIGHT / 2 - 200 + MENU_BUTTON_HEIGHT*3 + 10*3, MENU_BUTTON_WIDTH, MENU_BUTTON_HEIGHT, 'Exit', COLORS.markerblack, COLORS.white, 'OstrichSans')

    menu.gui.buttons.startButton:setClickHandler ('toggleMapMenu')
    
    for _,button in pairs (menu.gui.buttons) do
        button:setHoverHandler ('menu_ButtonEnterHover', 'menu_ButtonExitHover')
    end
    
    return true
end

function menu.destroy ()
    for k,button in pairs (menu.gui.buttons) do
        button:destroy ()
    end
    
    menu.gui = nil
end

--[[

    Map menu
    
--]]

function toggleMapMenu ()
    menu.destroy ()
    return mapMenu.create ()
end

function mapMenu.create ()
    return nav.create ()
end