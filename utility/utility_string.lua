function string:split (strDelimiter)
    local t = {}
    local intPos = 0
    while true do
        local intPosN = self:find (strDelimiter, intPos)
        if (not intPosN) then 
            table.insert (t, self:sub(intPos, #self))
            break
        end
        
        table.insert (t, self:sub(intPos, intPosN-1))
        intPos = intPosN + 1
    end
    
    return t
end