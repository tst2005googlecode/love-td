--[[

	main.lua
		
	* DEVELOPERS: 	Joachim Andersen
					Emil Plovmand

--]]

--[[

	Main file, contains all game logic and callbacks
	
--]]

--[[

	Screen-render handlers
	
--]]

local t_RenderItems = {}
render = {}

function love.draw ()
	for strItemID, t_Item in ipairs (t_RenderItems) do
		love.graphics[t_Item.method](unpack(t_Item))
	end
	
	return true
end

function render.add (strID, strMethod, ...)
	t_RenderItems[strID] = {['method'] = strMethod, ...}
	return true
end

function render.modify (strID, ...)
	t_RenderItems[strID] = {['method'] = t_RenderItems[strID], ...}
	return true
end

function render.remove (strID)
	t_RenderItems[strID] = nil
	return true
end

--[[

	Game process handlers
	
--]]

local t_ProcessCallbacks = {}

function love.update (dt)
	for i,strCallbackFunc in ipairs (t_ProcessCallbacks) do
		_G[strCallbackFunc](dt)
	end
	
	return true
end




















