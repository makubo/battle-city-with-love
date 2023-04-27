require("classes.GameObject")

Rectangle = GameObject:extend({})

function Rectangle:getObjectName()
    return "Rectangle"
end

function Rectangle:new(x, y, width, height, color)

    local rect = GameObject:new()
    setmetatable(rect, self)
    self.__index = self

    local _width = width
    local _height = height

    local _mode = "fill"
    local _rx = nil
    local _ry = nil
    local _segments = nil
    local _color = color or {0, 1, 0, 1}

    rect:setYPos(y)
    rect:setXPos(x)

    function rect:setWidth(w)
        _width = w
    end

    function rect:getWidth()
        return _width
    end

    function rect:setHeight(h)
        _height = h
    end

    function rect:getHeight()
        return _height
    end

    function rect:setMode(m)
        _mode = m
    end

    function rect:getMode()
        return _mode
    end

    function rect:setColor(col)
        _color = col
    end

    function rect:getColor()
        return _color
    end

    function rect:setXRad(rx)
        _rx = rx
    end

    function rect:getXRad()
        return _rx
    end

    function rect:setYRad(ry)
        _ry = ry
    end

    function rect:getYRad()
        return _ry
    end

    function rect:setSegments(s)
        _segments = s
    end

    function rect:getSegments()
        return _segments
    end

    return rect
end

function Rectangle:draw(layerID, xPos, yPos)
    if layerID ~= self:getLayerID() then
        return
    end
    local r, g, b, a = love.graphics.getColor()
    love.graphics.setColor(self:getColor())
    love.graphics.rectangle(self:getMode(), self:getXPos() + (xPos or 0),self:getYPos() + (yPos or 0), self:getWidth(), self:getHeight())
    love.graphics.setColor(r, g, b, a)
end