--[[

    main.lua
        
    * DEVELOPERS:   Joachim Andersen

--]]

--[[

    Main file, contains all game logic and LÖVE callbacks
    
--]]

local PROJECT_FILES = 
{
'gui',
'gui/menu'
}

WIN_W, WIN_H = 800, 600

--[[

    Screen-render handler
    
--]]

local t_DefaultColor = {255, 255, 255, 255}
local t_RenderItems = {}
local t_RenderIDs = {}
render = {}

function love.draw ()
    for _,strItemID in ipairs (t_RenderIDs) do
        local t_Item = t_RenderItems[strItemID]
        if (t_Item.font) then
            love.graphics.setFont (t_Item.font)
        end
        love.graphics.setColor (unpack(t_Item.color or t_DefaultColor))
        love.graphics[t_Item.method](unpack(t_Item))
    end
    
    return true
end

function render.get (strID)
    return t_RenderItems[strID]
end

function render.add (strID, t_Color, font, strMethod, ...)
    t_RenderItems[strID] = {['method'] = strMethod, ['font'] = font, ['color'] = t_Color, ...}
    table.insert (t_RenderIDs, strID)
    return true
end

function render.modify (strID, ...)
    t_RenderItems[strID] = {['method'] = t_RenderItems[strID], ...}
    return true
end

function render.remove (strID)
    t_RenderItems[strID] = nil
    for k,strItemID in ipairs (t_RenderIDs) do
        if (strItemID == strID) then
            table.remove (t_RenderIDs, k)
        end
    end
    
    return true
end

--[[

    Game callback handlers
    
--]]

local t_Callbacks = 
{
    ['focus'] =         {},
    ['keypressed'] =    {},
    ['keyreleased'] =   {},
    ['mousefocus'] =    {},
    ['mousepressed'] =  {},
    ['mousereleased'] = {},
    ['textinput'] =     {},
    ['threaderror'] =   {},
    ['visible'] =       {},
    ['update'] =        {}
}

for strCallback in pairs (t_Callbacks) do
    love[strCallback] = function (...)
        for _,strCallbackFunc in ipairs (t_Callbacks[strCallback]) do
            _G[strCallbackFunc](...)
        end
    end
end

function registerGameCallbackFunc (strCallback, strFunc)
    return table.insert (t_Callbacks[strCallback], strFunc)
end

function deregisterGameCallbackFunc (strCallback, strFunc)
    for k,strCallbackFunc in ipairs (t_Callbacks[strCallback]) do
        return table.remove (t_Callbacks[strCallback], k)
    end
end

--[[

    Game data and logic
    
--]]

local t_GameData = {}

function love.load ()
    
    for i,file in ipairs (PROJECT_FILES) do
        require (file)
    end
    
    menu.create ()
    
    return true
end













