--[[

    tower.lua
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

TOWERS_LIST = {}
TOWERS = {}
TOWERS['gunner_1'] =
{
    name = 'Gunner', -- Display-friendly name
    desc = 'Standard tower',
    aoe = 0, -- Area of effect. This attribute only affects some projectiles
    rps = 2, -- Rounds per second
    damage = 0.5,
    projectileType = '',
    cost = 10,
    size = {60, 60},
    renderType = 'gunner_1',
    parts = 
    {
        base = {skin = 'gunner_base', joints = {{25, 25}}},
        gun = {skin = 'gunner_gun', joints = {{5, 5}}, muzzle = {45, 5}},
        attach = {{'gun_1', 'base_1'}}
    }
}
TOWERS['gunner_1'].compose = function (r)
    local t = {}
end


TOWERS['gunner_2'] = table.copy (TOWERS['gunner_1'])
TOWERS['gunner_2'].rps = 3
TOWERS['gunner_2'].damage = 1

local tower = {mt = {}}

do
    local skinData = {}
    for k,v in pairs (TOWERS) do
        if (tonumber(k:split('_')[2]) == 1) then
            table.insert (TOWERS_LIST, k)
        end
        for s,n in pairs (v.parts) do
            if (n.skin) then
                if (not skinData[n.skin]) then
                    skinData[n.skin] = love.graphics.newImage (string.format('media/towers/%s.png', n.skin))
                end
                n.skin = skinData[n.skin]
            end
        end
    end
    table.sort (TOWERS_LIST, function(a, b) return TOWERS[a].cost < TOWERS[b].cost end)
end

function tower_createTower (towerType)
    local obj = table.copy (TOWERS[towerType])
    obj.pos = {0, 0}
    obj.rot = 0
    
    setmetatable (obj, tower.mt)
    return obj
end

function tower.mt:__index (k)
    return tower[k]
end