--[[

    levels.lua
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

LEVELS = {}
LEVELS[1] = 
{
    spawn = 
    {
        {delay = 0,     enemyType = 'toon1',    amount = 5},
        {delay = 15,     enemyType = 'toon1',    amount = 5}
    }
}
LEVELS[2] = 
{
    spawn = 
    {
        {delay = 0,     enemyType = 'toon1',    amount = 5},
        {delay = 15,     enemyType = 'toon1',    amount = 15}
    }
}
LEVELS[3] = 
{
    spawn = 
    {
        {delay = 0,     enemyType = 'toon2',    amount = 5}
    }
}

for k,v in ipairs (LEVELS) do
    for i,j in ipairs (v.spawn) do
        j.spawnInterval = j.spawnInterval or (ENEMIES[j.enemyType].size / ENEMIES[j.enemyType].speed)
    end
end