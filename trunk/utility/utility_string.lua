--[[

    utility_string.lua
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

function string:split (strDelimiter)
    local t = {}
    local intPos = 0
    while true do
        local intPosN = self:find (strDelimiter, intPos)
        if (not intPosN) then 
            table.insert (t, self:sub(intPos, #self))
            break
        end
        
        table.insert (t, self:sub(intPos, intPosN-1))
        intPos = intPosN + 1
    end
    
    return t
end