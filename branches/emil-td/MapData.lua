MapData = {Width = 42, Margin = 21}

MapData.Map1 = {
	{70, 0},
	{70, 495},
	{216, 495},
	{216, 363},
	{364, 363},
	{364, 561},
	{711, 561},
	{711, 274},
	{262, 274},
	{262, 168},
	{703, 168},
	{703, 0}
}

MapData.Map2 = {
	{70, 0},
	{70, 536},
	{725, 536},
	{725, 106},
	{574, 106},
	{574, 403},
	{429, 403},
	{429, 114},
	{321, 114},
	{321, 410},
	{208, 410},
	{208, 0}

}


function IsOutsidePath(map, x, y)
    if (not MapData[map]) then return false end
    if (not x) or (not y) then return false end
    
    local d = MapData.Width/2 + MapData.Margin
    
    for k,node in ipairs(MapData[map]) do
        if (MapData[map][k+1]) then
            local node2 = MapData[map][k+1]
            local rotation = FindRotation (node[1], node[2], node2[1], node2[2])
            if (rotation == 0) or (rotation == 270) then
                if ((x > node[1]-MapData.Margin) and (x < node2[1]+MapData.Margin) and (y < node2[2]+MapData.Margin) and (y > node[2]-MapData.Margin)) then
                    return false
                end
            end
            
            if (rotation == 90) or (rotation == 180) then
                if ((x > node2[1]-MapData.Margin) and (x < node[1]+MapData.Margin) and (y < node[2]+MapData.Margin) and (y > node2[2]-MapData.Margin)) then
                    return false
                end
            end
            
        end
    end
    return true
end

local function GetMapDistance(x, y, x2, y2)
    local Dx = x2 - x
    local Dy = y2 - y
    return math.sqrt(Dx^2 + Dy^2)
end

function GetMapLength(map)
    local c = 0
    for k, node in ipairs(MapData[map]) do
        if (MapData[map][k+1]) then
            c = c + GetMapDistance(node[1], node[2], MapData[map][k+1][1], MapData[map][k+1][2])
        end
    end
    return c
end

    function FindRotation(x, y, x2, y2)
        local t = -math.deg (math.atan2(x2-x,y2-y))
        if t < 0 then t = t + 360 end
        return t
    end