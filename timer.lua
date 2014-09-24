--[[

    timer.lua
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
    
    Implements "timer", delayed execution of a function by time
    
    **************************************************************
    
--]]


local timer = {mt = {}}
local timers = {}

function timer_createTimer (time, func, ...)
    local obj = {}
    
    obj.time = time
    obj.tick = love.timer.getTime ()
    obj.func = func
    obj.state = 'alive'
    obj.args = {...}
    
    setmetatable (obj, timer.mt)
    table.insert (timers, obj)
    return obj
end

function timer:destroy ()
    for k,v in ipairs (timers) do
        if (v == self) then
            table.remove (timers, k)
            v.state = 'dead'
        end
    end
    
    return true
end

function timer_update (dt)
    local tick = love.timer.getTime ()
    for k,v in ipairs (timers) do
        if (tick-v.tick) >= v.time then
            table.remove (timers, k)
            v.func (unpack(v.args))
        end
    end
end
registerGameCallbackFunc ('update', 'timer_update')

function timer.mt:__index (k)
    return timer[k]
end