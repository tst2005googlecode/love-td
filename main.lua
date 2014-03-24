--[[

    Developed by: Emil Andersen
    
    File: Main File

--]]


SCR_W, SCR_H = 800, 600
render = {}
t_renderItems = {}
t_hoverItems = {}
local t_Id = {}
local t_hoverId = {}
local maxTime = 20
local clickCount = 50
t_buttonColor = {83, 83, 83, 255}
t_hoverButtonColor = {83, 83, 83, 190}
t_textColor = {240, 240, 240, 255}
GameOn = false




local t_PROJECTFILES = {
'gui',
'Game',
'gui/Interface',
'gui/MainMenu',
'gui/SinglePlayerMenu'
}

-- Load All Files
function love.load()
    for _, file in ipairs(t_PROJECTFILES) do
        require(file)
    end
    mainMenuCreate()
    Game_load()
end

function love.draw()
    if (GameOn == true) then
        Game_draw()
    end
    local mx, my = love.mouse.getPosition()
    love.graphics.print(mx .. ' , ' .. my)
    -- Draw All Objects
    for _, strItemId in ipairs(t_Id) do
        local t_Items = t_renderItems[strItemId]
        if (t_Items.Method) then
            if (t_Items.Font) then
                love.graphics.setFont(t_Items.Font)
            end
            love.graphics.setColor(t_Items.Color)
            love.graphics[t_Items.Method](unpack(t_Items))
            love.graphics.setColor(255, 255, 255, 255)
        end
    end
    -- Hover Handler
    if (t_hoverItems) then
        for _, strItemId in ipairs(t_hoverId) do
            local t_Items = t_hoverItems[strItemId]
            if (t_Items.Enter and t_Items.Exit) then
                if (isPointInsideBox(mx, my, t_Items.bbox.X, t_Items.bbox.Y, t_Items.bbox.W, t_Items.bbox.H)) then
                    for _, id in ipairs(t_Id) do
                        if (strItemId == id) then
                            local t_Ob = t_renderItems[id]
                            t_Ob.Color = t_Items.Color
                        end
                    end
                    elseif (not(isPointInsideBox(mx, my, t_Items.bbox.X, t_Items.bbox.Y, t_Items.bbox.W, t_Items.bbox.H))) then
                    for _, id in ipairs(t_Id) do
                        if (strItemId == id) then
                            local t_Ob = t_renderItems[id]
                            t_Ob.Color = t_Ob.OColor
                        end
                    end     
                end
            end
        end
    end
end

function love.update(dt)
    local mx, my = love.mouse.getPosition()
    clickCount = clickCount +1
    -- Click Handler
    if (t_hoverItems) then
        for _, strItemId in ipairs(t_hoverId) do
            local t_Items = t_hoverItems[strItemId]
            if (not(t_Items.Click == nil)) then
                if (isPointInsideBox(mx, my, t_Items.bbox.X, t_Items.bbox.Y, t_Items.bbox.W, t_Items.bbox.H) and (clickCount > maxTime)) then
                    for _, id in ipairs(t_Id) do
                        if (strItemId == id) then
                            if (love.mouse.isDown('l')) then
                                clickCount = 0
                                _G[t_Items.Click](unpack(t_Items))
                            end
                        end
                    end
                end
            end
        end
    end
    
    if (GameOn == true) then
        Game_update()
    end
end

function loadPage(func_strPage)
    render.removeAll()
    GameOn = false
    _G[func_strPage]()
    
    return true
end

function render.add(strId, strMethod, strFont, t_Color, ...)
    t_renderItems[strId] = {['Method'] = strMethod, ['Font'] = strFont, ['OColor'] = t_Color, ['Color'] = t_Color, ...}
    table.insert(t_Id, strId)
    
    return true
end

function render.setHandler(strId, func_strEnter, func_strExit, t_Color, intX, intY, intW, intH, func_strClick, ...)
    t_hoverItems[strId] = {['Color'] = t_Color, ['Enter'] = func_strEnter, ['Exit'] = func_strExit, ['bbox'] = {['X'] = intX, ['Y'] = intY, ['W'] = intX + intW, ['H'] = intY + intH}, ['Click'] = func_strClick, ... }
    table.insert(t_hoverId, strId)
    
    return true
end


function render.removeItem(strId)
    for k, strItemId in ipairs(t_Id) do
        if (strId == strItemId) then
            t_renderItems[strItemId] = nil
            table.remove(t_Id, strItemId)
        end
    end
    return true
end

function render.removeAll()
    for k in pairs(t_Id) do
        t_renderItems[k] = nil
        t_Id[k] = nil
    end
    for t in pairs(t_hoverId) do
        t_hoverItems[t] = nil
        t_hoverId[t] = nil
    end
    
    return true
end