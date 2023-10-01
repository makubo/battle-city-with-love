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

    -- link to the parent object
    local _parent = nil

    -- sub objects
    local _children = {}

    -- attached colliders
    local _colliders = {}

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

    --TODO: test
    function obj:getXPosRelative(r)
        local parent = self:getParent()
        local relativesXPos = 0
        if r == parent then
            relativesXPos = parent.getXPos()
        else
            relativesXPos = parent:getXPosRelative(r)

        end
        return _xPos + relativesXPos
    end

    --TODO: test
    function obj:getYPosRelative(r)
        local parent = self:getParent()
        local relativesYPos = 0
        if r == parent then
            relativesYPos = parent.getYPos()
        else
            relativesYPos = parent:getYPosRelative(r)

        end
        return _yPos + relativesYPos
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

    ---Add child object and return number of childs
    ---@param child GameObject
    ---@return integer "number of childs"
    function obj:addChild(child)
        child:setParent(self)

        table.insert(_children, child)
        return #_children
    end

    function obj:getChild(index)
        return _children[index]
    end

    function obj:addCollider(collider)
        collider:setObject(self)

        table.insert(_colliders, collider)
        return #_colliders
    end

    function obj:getCollider(index)
        return _colliders[index]
    end

    function obj:destroyColliders()
        for _,col in ipairs(_colliders) do
            col:destroy()
        end
    end

    function obj:clean()
        for i, child in ipairs(_children) do
            child:clean()
            table.remove(_children, i)
        end
        self:destroyColliders()
    end

    ---Set parent object
    ---@param p GameObject
    function obj:setParent(p)
        _parent = p
    end

    function obj:getParent()
        return _parent
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

    -- Root object have no parent 
    -- This part of code finalize the list of layers
    if self:getParent() == nil then
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
    for _, child in ipairs(self:getChildren()) do
        child:draw(layerID, self:getXPos() + (xPos or 0), self:getYPos() + (yPos or 0))
    end
end
