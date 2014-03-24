--[[

    Developed by: Emil Andersen
    
    File: Game File

--]]

function Game_load()
    LMap1 = love.graphics.newImage('Maps/Map1.png')
    LMap2 = love.graphics.newImage('Maps/Map2.png')
end

function Game_draw()
    love.graphics.draw(LMap1, 0, 0)
end

function Game_update()
    
end