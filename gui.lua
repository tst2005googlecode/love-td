--[[

    gui.lua
        
    * DEVELOPERS:   Joachim Andersen

--]]

--[[

    Implements popular GUI components with love.graphics
    
--]]

gui = {objfunc = {}, objects = {}}
local intRandomID = 1
local t_FontData = {['VeraSans'] = love.graphics.newFont(14)}

local gui_mt = {}
function gui_mt:__index (k)
    return gui.objfunc[k]
end

local function create (obj)
    setmetatable (obj, gui_mt)
    table.insert (gui.objects, obj)
    
    return obj
end

--[[

    Buttons
    
--]]

function gui.createButton (intX, intY, intW, intH, strText, t_BgColor, t_TextColor, strFont)
    intRandomID = intRandomID + 1
    local strRectID = 'button' .. intRandomID
    render.add (strRectID, t_BgColor, 'rectangle', 'fill', intX, intY, intW, intH)
    
    local strTextID = 'buttonText', .. intRandomID
    local font = t_FontData[strFont]
    
    render.add (strTextID, t_TextColor, 'print', strText, 
                intX + intW - intW/2 - font:getWidth(strText)/2,
                intY + intH - intH/2 - font:getLineHeight()/2)
    
    return create ({guiType = 'button', rectID = strRectID, textID = strTextID, bbox = {intX, intY, intX+intW, intY+intH}})
end

function gui.objfunc:setButtonText (strText)
    if (self.guiType ~= 'button') then return false end
    
    local t_Settings = render.get (self.textID)
    t_Settings[1] = strText
    return true
end

function gui.objfunc:setButtonPosition (intX, intY)
    if (self.guiType ~= 'button') then return false end
    
    local t_Settings = render.get (self.textID)
    t_Settings[2], t_Settings[3] = intX, intY
    return true
end

--[[

    Generic
    
--]]

function isPointInsideBox (pX, pY, bX, bY, bX2, bY2)
    if ((pX > bX)
    and (pX < bX2)
    and (pY > bY)
    and (pY < bY2)) then
        return true
    end
    
    return false
end


function gui.objfunc:setColor (t_Color)
    local t_Settings = render.get (self.textID)
    t_Settings.color = t_Color
    return true
end

function gui.objfunc:setHoverHandler (strFunc)
    self.hoverHandler = strFunc
end

function gui.objfunc:setClickHandler (strFunc)
    self.clickHandler = strFunc
end

function gui_DoHoverHandler ()
    local int_mX, int_mY = love.mouse.getPosition ()
    for k,GUIObj in ipairs (gui.objects) do
        if (GUIObj.hoverHandler) then
            if (isPointInsideBox(int_mX, int_mY, unpack(GUIObj.bbox)))
                return _G[GUIObj.hoverHandler]
            end
        end
    end
    
    return true
end
registerGameCallbackFunc ('update', 'gui_DoHoverHandler')


