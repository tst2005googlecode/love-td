--[[

    DEVELOPERS - Emil Andersen
    
    Main File

--]]

WIN_W, WIN_H = 800, 600
t_renderIDs = {}
render = {}
t_HoverObject = {}
t_HoverObjectId = {}
local tid, maxtid = 0, 1

t_IDs = {}

local PROJECT_FILES = {
'gui',
'gui/mainMenu'
}


function love.load()
    for _, files in ipairs(PROJECT_FILES) do
        assert(require(files), 'failed to load' .. files)
    end
    main_menu_create()
    return true
end

function love.draw()
   for _, strItemID in ipairs(t_IDs) do
   if (t_renderIDs[strItemID]) then
        local t_Items = t_renderIDs[strItemID]
        
        if (t_Items.font) then
            love.graphics.setFont(t_Items.font)
        end
        
        love.graphics.setColor(unpack(t_Items.color))
        love.graphics[t_Items.method](unpack(t_Items))
       end
   end
   local mx, my = love.mouse.getPosition()
   
   love.graphics.print(mx .. ' , ' .. my, 20, 20)
   return true
end

function love.update(dt)
    local mx, my = love.mouse.getPosition()
    if (t_HoverObject) then
        for _, strItemID in ipairs(t_HoverObjectId) do
            if (t_HoverObject[strItemID]) then
                local t_item = t_HoverObject[strItemID]
                local t_item2 = t_renderIDs[strItemID]
                if (isPointInsideBox(mx, my, t_item.X, t_item.Y, t_item.X + t_item.W, t_item.Y + t_item.H )) then
                    if ((love.mouse.isDown('l')) and (t_item.ClickHandler)) then
                        if (tid > maxtid) then
                            render.loadPage(t_item.ClickHandler)
                        end
                    end
                    if (t_item.Func_Enter) then
                        _G[t_item.Func_Enter](t_item2, t_item.HoverColor)
                    end
                elseif not (isPointInsideBox(mx, my, t_item.X, t_item.Y, t_item.X + t_item.W, t_item.Y + t_item.H )) then
                    if (t_item.Func_Exit) then
                        _G[t_item.Func_Exit](t_item2, t_item.HoverColorExit)
                    end
                end
            end
        end
   end
   tid = tid +0.1
   return true
end




function render.add (strID, t_color, strMethod, strFont, ...)
    
    t_renderIDs[strID] = {['color'] = t_color, ['method'] = strMethod, ['font'] = strFont, ...}
    table.insert(t_IDs, strID)
    
    return true
end

function render.HoverAdd(strID, intBX, intBY, intBW, intBH, strFunc_Enter, strFunc_Exit, t_color, t_colorExit, strFunc_Click)
    t_HoverObject[strID] = {['X'] = intBX, ['Y'] = intBY, ['W'] = intBW, ['H'] = intBH, ['Func_Enter'] = strFunc_Enter, ['Func_Exit'] = strFunc_Exit, ['HoverColor'] = t_color, ['HoverColorExit'] = t_colorExit, ['ClickHandler'] = strFunc_Click}
    
    table.insert(t_HoverObjectId, strID)
    return true
end

function render.HoverRemove(strID)
    for k, strItemID in ipairs(t_HoverObjectId) do
        if (strItemID == strID) then
            table.remove(t_HoverObject, k)
        end
    end
    
    return true
end

function render.HoverRemoveAll()
    for k in pairs(t_HoverObject) do
        t_HoverObject[k] = nil
    end
    
    return true
end

function render.loadPage(strFunc)
    render.HoverRemoveAll()
    render.removeAll()
    tid = 0
   _G[strFunc]()
   
   return true
end

function render.remove(strID)
    for k, strItemID in ipairs(t_renderIDs) do
        if (strID == strItemID) then
            table.remove(t_renderIDs, k)
        end
    end
    
    return true
end

function render.removeAll()
    for k in pairs(t_renderIDs) do
        t_renderIDs[k] = nil
    end
end

function render.get (strID)
    return t_renderIDs[strID]
end