require("classes.Tools")

local tablex = require("pl.tablex")

GameObject = {}

function GameObject:getObjectName()
    return "GameObject"
end

function GameObject:extend(class)
    setmetatable(class,{__index = self})
    return class
end

function GameObject:new(model)

    local obj = model or {}
    setmetatable(obj, self)
    self.__index = self

    local _xPos = 0
    local _yPos = 0
    local _layerId = 0
    local _children = {}

    function obj:setXPos(x)
        _xPos = x
    end

    function obj:getXPos()
        return _xPos
    end

    function obj:setYPos(y)
        _yPos = y
    end

    function obj:getYPos()
        return _yPos
    end

    function obj:setLayerID(id)
        _layerId = id
    end

    function obj:getLayerID()
        return _layerId
    end

    function obj:getChildren()
        return _children
    end

    function obj:addChild(child)
        table.insert(_children, child)
        return #_children
    end

    function obj:getChild(index)
        return _children[index]
    end

    return obj
end

function GameObject:getLayers()
    local layers = {}
    for _, child in ipairs(self:getChildren()) do
        tablex.insertvalues(layers, child:getLayers())
    end

    -- Layers with ID lower than 1 shouldn't be drawn
    if self:getLayerID() > 0 then
        table.insert(layers, self:getLayerID())
    end

    -- Only root objects must have Layer ID -1
    -- This part of code finalize the list of layers
    if self:getLayerID() == -1 then
        layers = removeDuplicateTableValues(layers)
        local sortedLayers = {}
        for _, v in tablex.sortv(layers) do
            table.insert(sortedLayers, v)
        end
        layers = sortedLayers
    end

    return layers
end

function GameObject:update(dt)
    --print(self.getObjectName() .. " update")
    for _, child in ipairs(self:getChildren()) do
        child:update(dt)
    end
end

function GameObject:draw(layerID, xPos, yPos)
    if xPos == nil then
        xPos = 0
    end
    if yPos == nil then
        yPos = 0
    end
    for _, child in ipairs(self:getChildren()) do
        child:draw(layerID, self:getXPos() + xPos, self:getYPos() + yPos)
    end
end
