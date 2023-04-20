--local class = require 'lib.middleclass.middleclass'

GameObject = class('GameObject')

-- function GameObject:getObjectName()
--     return "GameObject"
-- end

function GameObject:initialize()
    --self.name = name

    self._xPos = 0
    self._yPos = 0
    self._children = {}

    --local obj = model or {}

end

function GameObject:setXPos(x)
    self._xPos = x
end

function GameObject:getXPos()
    return self._xPos
end

function GameObject:setYPos(y)
    self._yPos = y
end

function GameObject:getYPos()
    return self._yPos
end

function GameObject:getChildren()
    return self._children
end

function GameObject:addChild(object)
    table.insert(self._children, object)
end

function GameObject:getChild(index)
    return self._children[index]
end

function GameObject:update(dt)
    --print(self.getObjectName() .. " update")
    --for _, child in ipairs(self:getChildren()) do
    for _, child in ipairs(self._children) do
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

--return GameObject
