Scene = {}

Scene.childs = {}
Scene.xPos = 0
Scene.yPos = 0

-- TODO: implement scene
function Scene:new()
    local newObject = {}
    setmetatable(newObject, self)
    self.__index = self

    newObject.xPos = 0
    newObject.yPos = 0

    return newObject
end

function Scene:add(object)
    table.insert(self.childs, object)
end

function Scene:update(dt)
    for _, child in ipairs(self.childs) do
        child:update(dt)
    end
end

-- TODO: implement layer logic
function Scene:draw(xPos, yPos)
    if xPos == nil then
        xPos = 0
    end
    if yPos == nil then
        yPos = 0
    end
    for _, child in ipairs(self.childs) do
        child:draw(self.xPos + xPos, self.yPos + yPos)
    end
end