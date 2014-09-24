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
    audio_getSource('click1'):play ()
    return button:setColor ({0, 0, 0, 200})
end

function menu_ButtonExitHover (button)
    return button:setColor (COLORS.markerblack)
end

function navigation_Return (rect)
    nav.destroy ()
    return menu.create ()
end

function navigation_HoverEnter ()
    local GUIImage = nav.gui.images.returnArrow
    GUIImage:setScale (0.6, 0.6)
    GUIImage:center (GUIImage.centerX, GUIImage.centerY)
end

function navigation_HoverExit ()
    local GUIImage = nav.gui.images.returnArrow
    GUIImage:setScale (0.5, 0.5)
    GUIImage:center (GUIImage.centerX, GUIImage.centerY)
end

function nav.create ()
    nav.gui = {rectangles = {}, images = {}}

    local image_Arrow = love.graphics.newImage ('media/arrow.png')
    local GUIImage = gui.createImage (0, 0, image_Arrow)
    nav.gui.images.returnArrow = GUIImage
    
    GUIImage.centerX = 75
    GUIImage.centerY = 50
    GUIImage:setClickHandler ('navigation_Return')
    GUIImage:setHoverHandler ('navigation_HoverEnter', 'navigation_HoverExit')
    GUIImage:setScale (0.5, 0.5)
    GUIImage:center (GUIImage.centerX, GUIImage.centerY)
end

function nav.destroy ()
    for _,image in pairs (nav.gui.images) do
        image:destroy ()
    end
    
    nav.gui = nil
end

function menu.create ()
    menu.gui = {buttons = {}}
    
    love.graphics.setBackgroundColor (102, 102, 102)
    
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
    audio_getSource('click2'):play ()
    menu.destroy ()
    return game_createGame ('spire')
end

function mapMenu.create ()
    return nav.create ()
end