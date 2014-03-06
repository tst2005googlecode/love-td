--[[

    DEVELOPERS - Emil Andersen
    
    Main File

--]]

WIN_W, WIN_H = 800, 600
local t_renderIDs = {}
local t_renderItems = {}
render = {}

local PROJECT_FILES = {
'gui',
'gui/mainMenu'
}


function love.load()
    for _, files in ipairs(PROJECT_FILES) do
        require(files)
    end
    
    main_menu_create()
    
    return true
end

function love.draw()
    for _, strItemID in ipairs(t_renderIDs) do
        local t_items = t_renderItems[strItemID]
        if (t_items.font) then
            love.graphics.setFont(t_items.font)
        end
        love.graphics.setColor(unpack(t_items.color))
        love.graphics[t_items.method](unpack(t_items))
    end
    return true
end

function love.update(dt)

end

function render.add (strID, t_color, strMethod, strFont, ...)
    t_renderItems[strID] = {['ID'] = strID, ['method'] = strMethod, ['color'] = t_color, ['font'] = strFont, ...}
    table.insert(t_renderIDs, strID)
    return true
end

function render.remove(strID)
    for i, strItemId in ipairs(t_renderIDs) do
        if (strItemId == strID) then
            table.remove(t_renderIDs, i)
        end
    end
    return true
end

function render.get (strID)
    return t_renderItems[strID]
end