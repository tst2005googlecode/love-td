--[[

    main.lua
        
    * DEVELOPERS:   Joachim Andersen

--]]

--[[

    Main file, contains all game logic and LÖVE callbacks
    
--]]

local PROJECT_FILES = {''}

--[[

    Screen-render handler
    
--]]

local t_DefaultColor = {255, 255, 255, 255}
local t_RenderItems = {}
render = {}

function love.draw ()
    for strItemID, t_Item in ipairs (t_RenderItems) do
        love.grapics.setColor (unpack(t_Item.color or t_DefaultColor))
        love.graphics[t_Item.method](unpack(t_Item))
    end
    
    return true
end

function render.get (strID)
    return t_RenderItems[strID]
end

function render.add (strID, t_Color, strMethod, ...)
    t_RenderItems[strID] = {['method'] = strMethod, ['color'] = t_Color, ...}
    return true
end

function render.modify (strID, ...)
    t_RenderItems[strID] = {['method'] = t_RenderItems[strID], ...}
    return true
end

function render.remove (strID)
    t_RenderItems[strID] = nil
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

for strCallback in pairs (t_CallBacks) do
    function love[strCallback] (...)
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
    
    return true
end
















