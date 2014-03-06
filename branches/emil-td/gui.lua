--[[

    DEVELOPERS - Emil Andersen
    
    GUI file

--]]

local intOBID = 1
local t_FontData = {['VeraSans'] = love.graphics.newFont(14), ['OstrichSans'] = love.graphics.newFont('media/OstrichSans.otf', 22)}

gui = {env = {images = {}, buttons = {}, generic = {}}}


function gui.createButton(intX, intY, intW, intH, strText, t_BgColor, t_TextColor, strFont)
    intOBID = intOBID +1
    local buttonID = 'Button' .. intOBID
    local textID = 'Text' .. intOBID
    local font = t_FontData[strFont]
    local FontMidX, FontMidY = (intX + intW - intW/2 - font:getWidth(strText)/2 + 2), (intY + intH - intH/2 - font:getHeight()/2 + 2)
    
    
    render.add(buttonID, t_BgColor, 'rectangle',nil,'fill', intX, intY, intW, intH)
    render.add(textID, t_TextColor, 'print', font, strText, FontMidX, FontMidY )
end

function gui.env.buttons:setColor(t_BgColor, t_TextColor)
    
    
end