CreepData = {
    x = nil,
    y = nil,
    w = nil,
    h = nil,
    health = 200*level,
    level = 1,
    amount = 20 * (level/4),
    gold = 2 * (level/2)
    speed = 50
}

CreepData.boss = {
    x = nil,
    y = nil,
    w = nil,
    h = nil,
    image = nil,
    leveltoappear = 5,
    timesappeared = 1,
    health = 1000*timesappared,
    amount = 1,
    gold = 100*timesappared
    speed = 40
}

CreepData.Generated = {}

function moveCreeps(ID, )
    
end

local function GetCreepsNextPoint(currentPoint)
    local point = currentPoint + 1
    if (not MapData[GameInfo.map][point]) then
        return false
    end
    return MapData[GameInfo.map][point]
end