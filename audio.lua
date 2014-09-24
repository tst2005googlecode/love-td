--[[

    audio.lua
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
    
    Implements "audio"
    
    **************************************************************
    
--]]

local audio = {}

function audio_getSource (id)
    if (not audio[id]) then
        audio[id] = love.audio.newSource (string.format('media/%s.wav', id), 'static')
    end
    
    return audio[id]
end