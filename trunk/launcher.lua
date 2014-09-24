--[[

    launcher.lua
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


local intro = audio_getSource ('intro')
intro:setVolume (0.3)
intro:setLooping (true)
intro:play ()
--[[
local splash = gui.createImage (0, 0, love.graphics.newImage('media/8210.png'))
local rect = gui.createRectangle ('fill', 0, 0, WIN_W, WIN_H, {0, 0, 0, 255})

local s = 1
local f = 255
local b = false

function launcher_update (dt)
    s = s + ((b and dt) or -dt)
    if (s > 1) then
        deregisterGameCallbackFunc ('update', 'launcher_update')
        timer_createTimer (1, menu.create)
        splash:destroy ()
        rect:destroy ()
    end
    if (s < 0) then
        deregisterGameCallbackFunc ('update', 'launcher_update')
        timer_createTimer (2,
            function ()
                b = true
                s = 0
                registerGameCallbackFunc ('update', 'launcher_update')
            end
        )
    end
    rect:setColor ({0, 0, 0, f * s})
end
registerGameCallbackFunc ('update', 'launcher_update')
--]]

menu.create ()