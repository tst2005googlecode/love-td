--[[

    game.lua
    code.google.com/p/love-td/
    
    Copyright (C) 2014 Atli Ægisson

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

local draw = love.graphics.draw

local gameVar = {} -- Variables describing the game progress
local gameObj = {enemies = {}, towers = {}} -- Objects associated to this game

local gameControl = {}
local function addControlCallback (control, func)
    if (not gameControl[control]) then gameControl[control] = {} end
    return table.insert (gameControl[control], func)
end

local function removeControlCallback (control, func)
    for k,v in ipairs (gameControl[control]) do
        if (v == func) then
            table.remove (gameControl[control], k)
        end
        if (#gameControl[control] == 0) then
            gameControl[control] = nil
        end
        return true
    end
end

function game_createGame (strMapName)
    gameObj.map = map_loadMap (strMapName)
    
    gameVar.level = 0
    gameVar.cash = 100
    gameVar.lives = 20
    
    gameObj.hud = hud_createHUD ()
    gameObj.towers = {}
    
    gameObj.hud:setCash (gameVar.cash)
    gameObj.hud:setHealth (gameVar.lives)
    
    audio_getSource('intro'):stop()
    
    registerGameCallbackFunc ('draw', 'game_draw')
    registerGameCallbackFunc ('keypressed', 'game_control')
    addControlCallback (' ', 'game_nextWave')
    
    return true
end

function game_control (key, isrepeat)
    if not gameControl[key] then return false end
    for k,v in ipairs (gameControl[key]) do
        _G[v](key, isrepeat)
    end
    
    return true
end

function game_nextWave ()
    if (gameVar.queue) then
        return false
    end
    
    if (not LEVELS[gameVar.level+1]) then return false end
    
    gameVar.level = gameVar.level + 1
    gameObj.hud:setWave (gameVar.level)
    
    gameVar.spawnIndex = 1
    gameVar.spawnTick = 0
    gameVar.queue = {}
    
    registerGameCallbackFunc ('update', 'game_updateWave')
end

function game_updateWave (dt)
    local spawnData = LEVELS[gameVar.level].spawn[gameVar.spawnIndex]
    local tick = getTime ()
    
    -- Queue enemies to spawn
    if (spawnData) then
        if ((tick - gameVar.spawnTick) > spawnData.delay) then
            for i = 1, spawnData.amount do
                table.insert (gameVar.queue, {spawnData.enemyType, spawnData.spawnInterval, tick+LEVELS[gameVar.level].spawn[gameVar.spawnIndex].spawnInterval*i})
            end
            gameVar.spawnTick = tick
            gameVar.spawnIndex = gameVar.spawnIndex + 1
        end
    end
    
    -- Spawn next enemy in queue
    if (gameVar.queue[1]) then
        if ((tick - gameVar.queue[1][3]) >= gameVar.queue[1][2]) then
            table.insert (gameObj.enemies, enemy_createEnemy(table.remove(gameVar.queue, 1)[1]))
        end
    end
    
    local p = gameObj.map.pathData
    
    -- Update enemies
    for k,enemy in ipairs (gameObj.enemies) do
        local n = enemy.node
        if (n == 2) then
            enemy.baseRot = getAngle (p[1][1], p[1][2], p[2][1], p[2][2])
        end
        
        enemy.prog = enemy.prog + (ENEMIES[enemy.enemyType].speed / p[n-1][3]) * dt
        if (enemy.prog < 1) then
            enemy:setPosition (p[n-1][1] + (p[n][1]-p[n-1][1]) * enemy.prog, p[n-1][2] + (p[n][2]-p[n-1][2]) * enemy.prog)
        else
            enemy.prog = 0
            enemy.node = enemy.node + 1
            
            if (not p[enemy.node]) then
                table.remove (gameObj.enemies, k)
                gameVar.lives = gameVar.lives - 1
                gameObj.hud:setHealth (gameVar.lives)
                
                if (#gameObj.enemies == 0) then
                    gameVar.queue = nil
                    deregisterGameCallbackFunc ('update', 'game_updateWave')
                end
            end
        end
    end
end

function game_draw ()
    love.graphics.setColor (255, 255, 255, 255)
    draw (gameObj.map.Image, 0, 0)
    
    -- Draw enemies
    for k,enemy in ipairs (gameObj.enemies) do
        draw (ENEMIES[enemy.enemyType].skin, enemy.pos[1], enemy.pos[2], math.rad(enemy.rot - 90), 1, 1, enemy.size2, enemy.size2)
    end
    
    -- Draw towers
    
    -- Draw projectiles
    
    -- Draw animations
end
