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
'gui/menu',
'utility/utility_string',
'maps'
}

WIN_W, WIN_H = 800, 600

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
    ['update'] =        {},
    ['draw'] =          {}
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
        if (strCallbackFunc == strFunc) then
            return table.remove (t_Callbacks[strCallback], k)
        end
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
    
    love.graphics.setBackgroundColor (102, 102, 102)
    
    menu.create ()
    
    return true
end













