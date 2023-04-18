GameObject = {}

function GameObject:getObjectName()
    return "GameObject"
end

function GameObject:new(model)

    local xPos, yPos, children

    xPos = 0
    yPos = 0
    children = {}

    local obj = model or {}

    function obj:setXPos(x)
        xPos = x
    end

    function obj:getXPos()
        return xPos
    end

    function obj:setYPos(y)
        yPos = y
    end

    function obj:getYPos()
        return yPos
    end

    function obj:getChildren()
        return children
    end

    function obj:addChild(object)
        table.insert(children, object)
    end

    function obj:getChild(index)
        return children[index]
    end

    setmetatable(obj, self)
    self.__index = self

    return obj:constructor(model)
end

-- public constructor method for being redefined
function GameObject:constructor(...)
    return self
end

function GameObject:update(dt)
    --print(self.getObjectName() .. " update")
    for _, child in ipairs(self:getChildren()) do
        child:update(dt)
    end
end

function GameObject:draw(xPos, yPos)
    if xPos == nil then
        xPos = 0
    end
    if yPos == nil then
        yPos = 0
    end
    for _, child in ipairs(self:getChildren()) do
        child:draw(self:getXPos() + xPos, self:getYPos() + yPos)
    end
end

return GameObject