--[[

    main.lua
    code.google.com/p/love-td/
    
    Copyright (C) 2014 love-td

    This program is free software; you can redistribute it and/or
    modify it under the terms of the GNU General Public License
    as published by the Free Software Foundation; either version 2
    of the License, or (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.
    
    **************************************************************
    
    **************************************************************
    
--]]

local PROJECT_FILES = 
{
'gui',
'gui/menu',
'gui/hud',
'utility/utility_string',
'utility/utility_math',
'utility/utility',
'audio',
'timer',
'map',
'tower',
'enemy',
'levels',
'game',
'launcher'
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

function love.draw (...)
    for _,strCallbackFunc in ipairs (t_Callbacks.draw) do
        _G[strCallbackFunc](...)
    end
    if (gui) then
        gui_doRender ()
    end
end

local time = 0

function love.update (dt)
    if (dt > 0.025) then return false end
    time = time + dt
    
    for _,strCallbackFunc in ipairs (t_Callbacks.update) do
        _G[strCallbackFunc](dt)
    end
end

function getTime ()
    return time
end

function love.load () 
    for i,file in ipairs (PROJECT_FILES) do
        require (file)
    end
end











