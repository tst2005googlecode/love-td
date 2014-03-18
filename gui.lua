--[[

    DEVELOPERS - Emil Andersen
    
    GUI file

--]]

local intOBID = 1
local t_FontData = {['VeraSans'] = love.graphics.newFont(14), ['OstrichSans'] = love.graphics.newFont('media/OstrichSans.otf', 22)}

gui = {}


function gui.createButton(intX, intY, intW, intH, strText, t_BgColor, t_TextColor, strFont, Func_Enter, Func_Exit, t_HoverColor, strFunc_ClickH)

    intOBID = intOBID +1
    
    local font = t_FontData[strFont]
    local fontX = intX + intW - intW/2 - font:getWidth(strText)/2 + 2
    local fontY = intY + intH - intH/2 - font:getHeight()/2 + 2
    
    local intRectID = 'Button' .. intOBID
    local intTextID = 'Text' .. intOBID
    
    render.HoverAdd(intRectID, intX, intY, intW, intH, Func_Enter, Func_Exit, t_HoverColor, t_BgColor, strFunc_ClickH )
    
    render.add(intRectID, t_BgColor, 'rectangle', nil, 'fill', intX, intY, intW, intH)
    render.add(intTextID, t_TextColor, 'print', font, strText, fontX, fontY)
    
    
    return true
end

function gui.createRectangle(intX, intY, intW, intH, t_BgColor)
    intOBID = intOBID +1
    
    local intRectID = 'Rectangle' .. intOBID
    
    render.add(intRectID, t_BgColor, 'rectangle', nil, 'fill', intX, intY, intW, intH)
    
    return true
end

function gui.createImage(intX, intY, intW, intH, image)
    intOBID = intOBID +1
    
    local ImgID = 'Image' .. intOBID
    
    render.add(ImgID, {255, 255, 255, 255}, 'draw', nil, image, intX, intY, 0 )
    
    return true
end

function gui_setColor(strID, t_Color)
    strID.color = t_Color 
       
    return true
end

function isPointInsideBox (pX, pY, bX, bY, bX2, bY2)
    if ((pX > bX)
    and (pX < bX2)
    and (pY > bY)
    and (pY < bY2)) then
        return true
    end
    
    return false
end