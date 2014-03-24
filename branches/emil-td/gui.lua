--[[

    Developed by: Emil Andersen
    
    File: Gui File

--]]

gui = {env = {image = {}, button = {}, rectangle = {}}}
local t_FontData = {['VeraSans'] = love.graphics.newFont(14), ['OstrichSans'] = love.graphics.newFont('media/OstrichSans.otf', 22)}

local intId = 1

function gui.env.button.CreateButton(intPosX, intPosY, intWidth, intHeight, strText, t_Color, t_BgColor, t_HColor, strFont, func_strEnter, func_strExit, func_strClick, ... )
    intId = intId + 1
    
    local intTextId = 'Text' .. intId
    local intButtonId = 'Button' .. intId
    local font = t_FontData[strFont]
    
    render.setHandler(intButtonId, func_strEnter, func_strExit, t_HColor, intPosX, intPosY, intWidth, intHeight, func_strClick, ...  )
    
    render.add(intButtonId, 'rectangle', nil, t_BgColor, 'fill', intPosX, intPosY, intWidth, intHeight)
    render.add(intTextId, 'print', font, t_Color, strText, 
    intPosX + intWidth - intWidth/2 - font:getWidth(strText)/2 + 2,
    intPosY + intHeight - intHeight/2 - font:getHeight()/2 + 2, 0)
end

function gui.env.rectangle.CreateRectangle(intPosX, intPosY, intWidth, intHeight, t_Color)
    intId = intId + 1
    
    local intRectId = 'Rectangle' .. intId
    
    render.add(intRectId, 'rectangle', nil, t_Color, 'fill', intPosX, intPosY, intWidth, intHeight)
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