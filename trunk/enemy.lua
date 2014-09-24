--[[

    enemy.lua
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

ENEMIES = {}
ENEMIES['toon1'] = 
{
    skin = 'toon/toon1',
    hp = 1,
    speed = 45,
    size = 32
}
ENEMIES['toon2'] = 
{
    skin = 'toon/toon2',
    hp = 2,
    speed = 60,
    size = 32
}
for _,enemyDef in pairs (ENEMIES) do
    enemyDef.skin = love.graphics.newImage (string.format('media/%s.png', enemyDef.skin))
end

local enemy = {mt = {}}

function enemy_createEnemy (strType)
    local obj = {}
    obj.enemyType = strType
    obj.pos = {0, 0}
    obj.rot = 0
    obj.node = 2
    obj.prog = 0
    obj.size = ENEMIES[strType].size
    obj.size2 = ENEMIES[strType].size / 2
    obj.hp = ENEMIES[strType].hp
    
    setmetatable (obj, enemy.mt)
    
    return obj
end

function enemy.mt:__index (k)
    return enemy[k]
end

function enemy:setPosition (x, y)
    self.pos[1] = x
    self.pos[2] = y
end

function enemy:setRotation (r)
    self.rot = r
end

function enemy:setHP (hp)
    self.hp = hp
end