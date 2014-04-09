function getTickCount ()
    return love.timer.getTime() * 1000
end

function table.removeValue (t, v)
    for i,j in ipairs (t) do
        if (j == v) then
            table.remove (t, i)
        end
    end
    
    return t
end