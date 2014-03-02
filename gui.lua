--[[

    gui.lua
        
    * DEVELOPERS:   Joachim Andersen

--]]

--[[

    Implements popular GUI components with love.graphics
    
--]]

gui = {env = {image = {}, button = {}, generic = {}}, objects = {}}
COLORS = {['white'] = {255, 255, 255, 255}, ['black'] = {0, 0, 0, 255}, ['markerblack'] = {0, 0, 0, 128}}
local intRandomID = 1
local t_FontData = {['VeraSans'] = love.graphics.newFont(14), ['OstrichSans'] = love.graphics.newFont('media/OstrichSans.otf', 22)}
local currentHoverGUIObject

local guiGenericEnv_mt = {__index = function(t,k) return gui.env.generic[k] end}
setmetatable (gui.env.image, guiGenericEnv_mt)
setmetatable (gui.env.button, guiGenericEnv_mt)

local function create (obj)
    setmetatable (obj, {__index = function(t,k) return gui.env[obj.guiType][k] end})
    table.insert (gui.objects, obj)
    
    return obj
end

--[[

    Buttons
    
--]]

function gui.createButton (intX, intY, intW, intH, strText, t_BgColor, t_TextColor, strFont)
    intRandomID = intRandomID + 1
    local strRectID = 'button' .. intRandomID
    local font = t_FontData[strFont]
    
    render.add (strRectID, t_BgColor, font, 'rectangle', 'fill', intX, intY, intW, intH)
    
    local strTextID = 'buttonText' .. intRandomID
    
    render.add (strTextID, t_TextColor, font, 'print', strText, 
                intX + intW - intW/2 - font:getWidth(strText)/2 + 2,
                intY + intH - intH/2 - font:getHeight()/2 + 2)
    
    return create ({guiType = 'button', rectID = strRectID, textID = strTextID, bbox = {intX, intY, intX+intW, intY+intH}})
end

function gui.env.button:destroy ()
    render.remove (self.rectID)
    render.remove (self.textID)
    
    if (currentHoverGUIObject == self) then
        currentHoverGUIObject = nil
    end
    
    for k,GUIObj in ipairs (gui.objects) do
        if (GUIObj == self) then
            table.remove (gui.objects, k)
        end
    end
    
    self = nil
end

function gui.env.button:setButtonText (strText)
    local t_Settings = render.get (self.textID)
    t_Settings[1] = strText
    
    local intW = self.bbox[3] - self.bbox[1]
    t_Settings[2] = self.bbox[3] - intW/2 - t_Settings.font:getWidth(strText)/2 + 2
    
    return true
end

function gui.env.button:setButtonColor (t_BgColor, t_TextColor)
    local t_TextSettings = render.get (self.textID)
    local t_RectSettings = render.get (self.rectID)
    
    if (t_BgColor) then
        t_RectSettings.color = t_BgColor
    end
    if (t_TextColor) then
        t_TextSettings.color = t_TextColor
    end
    
    return true
end

function gui.env.button:setButtonPosition (intX, intY)
    local t_TextSettings = render.get (self.textID)
    local t_RectSettings = render.get (self.rectID)
    
    -- Update render setting
    local int_DiffX, int_DiffY = intX - self.bbox[1], intY - self.bbox[2]
    t_TextSettings[2], t_TextSettings[3] = t_TextSettings[2] + int_DiffX, t_TextSettings[3] + int_DiffY
    t_RectSettings[2], t_RectSettings[3] = intX, intY
    
    -- Update bbox
    self.bbox[3], self.bbox[4] = self.bbox[3]-self.bbox[1] + intX, iself.bbox[4]-self.bbox[2] + intY
    self.bbox[1], self.bbox[2] = intX, intY
    
    return true
end

--[[

    Images
    
--]]

function gui.createImage (intX, intY, image)
    intRandomID = intRandomID + 1
    local strImageID = 'image' .. intRandomID
    render.add (strImageID, nil, nil, 'draw', image, intX, intY)
    
    local intW, intH = image:getDimensions ()
    return create ({guiType = 'image', imageID = strImageID, imageSource = image, bbox = {intX, intY, intX + intW, intY + intH}})
end

function gui.env.image:setImagePosition (intX, intY)
    local t_Settings = render.get (self.imageID)
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

function gui.env.generic:setColor (t_Color)
    local t_Settings = render.get (self.textID)
    t_Settings.color = t_Color
    return true
end

function gui.env.generic:setHoverHandler (strFunc_Enter, strFunc_Exit)
    self.hoverHandler = {['enter'] = strFunc_Enter, ['exit'] = strFunc_Exit}
end

function gui.env.generic:setClickHandler (strFunc)
    self.clickHandler = strFunc
end

function gui_ClickHandler (int_mX, int_mY, strButton)
    if (strButton ~= 'l') then return false end
    for k,GUIObj in ipairs (gui.objects) do
        if (GUIObj.clickHandler) then
            if (isPointInsideBox(int_mX, int_mY, unpack(GUIObj.bbox))) then
                return _G[GUIObj.clickHandler](GUIObj, int_mX, int_mY)
            end
        end
    end
end
registerGameCallbackFunc ('mousepressed', 'gui_ClickHandler')

function gui_DoHoverHandler ()
    local int_mX, int_mY = love.mouse.getPosition ()
    if (currentHoverGUIObject) then
        if (not isPointInsideBox(int_mX, int_mY, unpack(currentHoverGUIObject.bbox))) then
            _G[currentHoverGUIObject.hoverHandler['exit']](currentHoverGUIObject)
            currentHoverGUIObject = nil
        end
        
        return true
    end
    
    for k,GUIObj in ipairs (gui.objects) do
        if (GUIObj.hoverHandler) then
            if (isPointInsideBox(int_mX, int_mY, unpack(GUIObj.bbox))) then
                currentHoverGUIObject = GUIObj
                return _G[GUIObj.hoverHandler['enter']](GUIObj, int_mX, int_mY)
            end
        end
    end
    
    return true
end
registerGameCallbackFunc ('update', 'gui_DoHoverHandler')


