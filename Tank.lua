local Tank = GameObject:new()

function Tank:new(type)

    local _tank = GameObject:new()
    setmetatable(_tank,self)
    self.__index = self

    local _direction = "top"

    --local _type = type or 0
    local _tileShift = (type or 0) * 8

    local _tileset = TileSet:new(require("gfx.tanks"))
    local _tile = _tileset:getChild(1 + _tileShift)

    _tile:setLayerID(16)

    local _tid = _tank:addChild(_tile)

    function _tank:turn(direction)
        if direction == "up" then
            self:getChildren()[_tid] = _tileset:getChild(1 + _tileShift)
        elseif direction == "left" then
            self:getChildren()[_tid] = _tileset:getChild(3 + _tileShift)
        elseif direction == "down" then
            self:getChildren()[_tid] = _tileset:getChild(5 + _tileShift)
        elseif direction == "right" then
            self:getChildren()[_tid] = _tileset:getChild(7 + _tileShift)
        end
        self:getChildren()[_tid]:setLayerID(16)
    end

    return _tank
end

return Tank