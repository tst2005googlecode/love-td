--[[

    gui.lua
        
    * DEVELOPERS:   Joachim Andersen

--]]

--[[

    Implements popular GUI components with love.graphics
    
--]]

gui = {env = {image = {}, button = {}, rectangle = {}, label = {}, generic = {}}, objects = {}}
COLORS = {['white'] = {255, 255, 255, 255}, ['black'] = {0, 0, 0, 255}, ['markerblack'] = {0, 0, 0, 128}}

local t_FontData = {['VeraSans'] = love.graphics.newFont(14), ['OstrichSans'] = love.graphics.newFont('media/OstrichSans.otf', 22)}
local currentHoverGUIObject

local guiGenericEnv_mt = {__index = function(t,k) return gui.env.generic[k] end}
setmetatable (gui.env.image, guiGenericEnv_mt)
setmetatable (gui.env.label, guiGenericEnv_mt)
setmetatable (gui.env.button, guiGenericEnv_mt)
setmetatable (gui.env.rectangle, guiGenericEnv_mt)

local function create (obj)
    setmetatable (obj, {__index = function(t,k) return gui.env[obj.guiType][k] end})
    table.insert (gui.objects, obj)
    
    return obj
end

--[[

    GUI engine
    
-]]

function gui_doRender ()
    for _,GUIObj in ipairs (gui.objects) do
        GUIObj:render ()
    end
end
registerGameCallbackFunc ('draw', 'gui_doRender')

--[[

    Buttons
    
--]]

function gui.createButton (intX, intY, intW, intH, strText, t_BgColor, t_TextColor, strFont)
    local font = t_FontData[strFont]
    
    local GUIObj = {}
    GUIObj.guiType  = 'button'
    GUIObj.text     = strText
    GUIObj.x        = intX
    GUIObj.y        = intY
    GUIObj.textX    = intX + intW - intW/2 - font:getWidth(strText)/2 + 2
    GUIObj.textY    = intY + intH - intH/2 - font:getHeight()/2 + 2
    GUIObj.w        = intW
    GUIObj.h        = intH
    GUIObj.color    = t_BgColor
    GUIObj.txtColor = t_TextColor
    GUIObj.font     = font
    GUIObj.bbox     = {intX, intY, intX+intW, intY+intH}
    
    return create (GUIObj)
end

function gui.env.button:render ()
    love.graphics.setColor (self.color)
    love.graphics.rectangle ('fill', self.x, self.y, self.w, self.h)
    
    love.graphics.setColor (self.txtColor)
    love.graphics.setFont (self.font)
    
    love.graphics.print (self.text, self.textX, self.textY)
end

function gui.env.button:destroy ()
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

function gui.env.button:setText (strText)
    self.text = strText
    self.textX = self.x - self.w/2 - self.font:getWidth(strText)/2 + 2
    
    return true
end

function gui.env.button:setColor (t_BgColor, t_TextColor)
    if (t_BgColor) then
        self.color = t_BgColor
    end
    if (t_TextColor) then
        self.txtColor = t_TextColor
    end
    
    return true
end

function gui.env.button:setPosition (intX, intY)
    local int_DiffX, int_DiffY = intX - self.x, intY - self.y
    self.x = intX
    self.y = intY
    self.textX = self.textX + int_DiffX
    self.textY = self.textY + int_DiffY
    
    self.bbox[1] = intX
    self.bbox[2] = intY
    self.bbox[3] = intX + self.w
    self.bbox[4] = intY + self.h
    
    return true
end

--[[

    Images
    
--]]

function gui.createImage (intX, intY, image)
    local intW, intH = image:getDimensions ()
    
    local GUIObj = {}
    GUIObj.guiType      = 'image'
    GUIObj.x            = intX
    GUIObj.y            = intY
    GUIObj.orientation  = 0
    GUIObj.scaleX       = 1
    GUIObj.scaleY       = 1
    GUIObj.image        = image
    GUIObj.bbox         = {intX, intY, intX+intW, intY+intH}
    
    return create (GUIObj)
end

function gui.env.image:render ()
    love.graphics.setColor (255, 255, 255, 255)
    
    love.graphics.draw (self.image, self.x, self.y, self.orientation, self.scaleX, self.scaleY)
end

function gui.env.image:destroy ()
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

function gui.env.image:center (intX, intY)
    local intW, intH = self.image:getDimensions ()
    intW = intW * self.scaleX
    intH = intH * self.scaleY
    
    self.x = intX - intW/2
    self.y = intY - intH/2
    
    self.bbox[1] = self.x
    self.bbox[2] = self.y
    self.bbox[3] = self.x + intW
    self.bbox[4] = self.y + intH
end

function gui.env.image:setScale (int_sX, int_sY)
    int_sX = int_sX or self.scaleX
    int_sY = int_sY or self.scaleY
    local intW, intH = self.image:getDimensions ()
    self.bbox[3] = self.x + intW * int_sX
    self.bbox[4] = self.y + intH * int_sY
    
    self.scaleX = int_sX
    self.scaleY = int_sY
    
    return true
end

function gui.env.image:setPosition (intX, intY)
    local intW, intH = self.image:getDimensions ()
    self.x = intX
    self.y = intY
    
    self.bbox[1] = intX
    self.bbox[2] = intY
    self.bbox[3] = intX + intW
    self.bbox[4] = intY + intH
    
    return true
end

--[[

    Labels
    
--]]

function getTextRealWidth (strText, font)
    local t_Lines = strText:split ('\n')
    
    local intW = 0
    for _,strLine in ipairs (t_Lines) do
        local intLineWidth = font:getWidth (strLine)
        if (intLineWidth > intW) then
            intW = intLineWidth
        end
    end
    
    return intW
end

function getTextRealHeight (strText, font)
    local t_Lines = strText:split ('\n')
    
    local intH = 0
    for _ in ipairs (t_Lines) do
        intH = intH + font:getHeight
    end
    
    return intH
end

function gui.createLabel (strText, intX, intY, t_Color, strFont)
    local font = t_FontData[strFont]
    local intW = getTextRealWidth (strText, font)
    local intH = getTextRealHeight (strText, font)

    local GUIObj = {}
    GUIObj.guiType  = 'label'
    GUIObj.x        = intX
    GUIObj.y        = intY
    GUIObj.w        = intW
    GUIObj.h        = intH
    GUIObj.color    = t_Color
    GUIObj.text     = strText
    GUIObj.font     = font
    GUIObj.bbox     = {intX, intY, intX + intW, intY + intH}
    
    return create (GUIObj)
end

function gui.env.label:destroy ()
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

function gui.env.label:render ()
    love.graphics.setColor (self.color)
    love.graphics.setFont (self.font)
    
    love.graphics.print (self.text, self.x, self.y)
end

function gui.env.label:setPosition (intX, intY)
    self.x = intX
    self.y = intH
    
    self.bbox[1] = intX
    self.bbox[2] = intY
    self.bbox[3] = intX + self.w
    self.bbox[4] = intY + self.h
end

--[[

    Rectangles
    
--]]

function gui.createRectangle (strMode, intX, intY, intWidth, intHeight, t_Color)
    local GUIObj = {}
    GUIObj.guiType  = 'rectangle'
    GUIObj.x        = intX
    GUIObj.y        = intY
    GUIObj.w        = intWidth
    GUIObj.h        = intHeight
    GUIObj.color    = t_Color
    GUIObj.mode     = strMode
    GUIObj.bbox     = {intX, intY, intX + intWidth, intY + intHeight}
    
    return create (GUIObj)
end

function gui.env.rectangle:render ()
    love.graphics.setColor (self.color)
    love.graphics.rectangle (self.mode, self.x, self.y, self.w, self.h)
end

function gui.env.rectangle:setPosition (intX, intY)
    self.x = intX
    self.y = intY
    
    self.bbox[1] = intX
    self.bbox[2] = intY
    self.bbox[3] = intX + self.w
    self.bbox[4] = intY + self.h
    
    return true
end

function gui.env.rectangle:destroy ()
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
    self.color = t_Color
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


