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
    
    **************************************************************
    
--]]

local map = {mt = {}}

function map_loadMap (strMapName)
    local file = love.filesystem.newFile ('maps/' .. strMapName .. '.def')
    if (not file) then return false end
    
    local obj = {}
    
    file:open ('r')
    local strData = file:read ()
    file:close ()
    
    local t_Data = strData:split ('\n')
    
    obj.pathData = t_Data[1]:split ('|')
    
    for k,strPos in ipairs (obj.pathData) do
        obj.pathData[k] = strPos:split (';')
        if (k > 1) then
            obj.pathData[k-1][3] = getDist2D (obj.pathData[k-1][1], obj.pathData[k-1][2], obj.pathData[k][1], obj.pathData[k][2])
        end
    end
    
    obj.areaData = t_Data[2]:split ('F')
    for k,strGroup in ipairs (obj.areaData) do
        obj.areaData[k] = strGroup:split ('|')
        
        for i,strPos in ipairs (obj.areaData[k]) do
            obj.areaData[k][i] = strPos:split (';')
            obj.areaData[k][i][1] = tonumber (obj.areaData[k][i][1])
            obj.areaData[k][i][2] = tonumber (obj.areaData[k][i][2])
        end
    end
    
    obj.name = strMapName
    obj.Image = love.graphics.newImage ('maps/' .. strMapName .. '.png')
    
    setmetatable (obj, map.mt)
    
    return obj
end

function map.mt:__index (k)
    return map[k]
end

function map:getLength ()
    local fLength = 0
    
    for k,mapNode in ipairs (self.pathData) do
        if (k == #self.pathData) then break end
        
        fLength = fLength + getDist2D (mapNode[1], mapNode[2], self.pathData[k+1][1], self.pathData[k+1][2])
    end
    
    return fLength
end

function map:isPointInsideMapArea (x, y)
    for k,tPoly in ipairs (self.areaData) do
        
        local j = #tPoly
        local oddNodes = false
        
        for i = 1, j do
            if (((tPoly[i][2] < y and tPoly[j][2] >= y)
            or   (tPoly[j][2] < y and tPoly[i][2] >= y))
            and  (tPoly[i][1] <= x or tPoly[j][1] <= x)) then
                if (tPoly[i][1] + (y-tPoly[i][2]) / (tPoly[j][2]-tPoly[i][2]) * (tPoly[j][1]-tPoly[i][1]) < x) then
                    oddNodes = not oddNodes 
                end
            end
        j = i 
        end
        
        if (oddNodes) then return true end
    
    end
    
    return false
end


