--[[

    projectile.lua
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

PROJECTILES = {}

local projectile = {mt = {}}

function projectile_createProjectile ()
    
end

function projectile.mt:__index (k)
    return projectile (k)
end