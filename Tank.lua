local Tank = GameObject:extend({})

function Tank:new(type)

    local _tank = GameObject:new()
    setmetatable(_tank,self)
    self.__index = self

    local _direction = "up"

    local _isMoving = false
    local _speed = 0

    --local _type = type or 0
    local _tileShift = (type or 0) * 8

    local _tileset = TileSet:new(require("gfx.tanks"))
    local _tile = _tileset:getChild(1 + _tileShift)

    local bullets = {}
    local bulletLimit = 1

    _tile:setLayerID(16)

    local _tid = _tank:addChild(_tile)

    function _tank:move(direction)

        if _direction ~= direction and not self:isOppositeDirection(direction) then
            local collider = self:getCollider(1)
            print("turn")
            local x = collider:getX()
            local y = collider:getY()

            print( math.abs(x % 8))

            local dx = (x) % 8
            local dy = (y) % 8

            if dx <= 8/2 then
                collider:setX(x - dx)
            else
                collider:setX(x - dx + 8)
            end

            if dy <= 8/2 then
                collider:setY(y - dy)
            else
                collider:setY(y - dy + 8)
            end
        end
        _direction = direction or _direction
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
        _isMoving = true
    end

    function _tank:isOppositeDirection(direction)
        if _direction == "up" and direction == "down"
            or _direction == "down" and direction == "up"
            or _direction == "left" and direction == "right"
            or _direction == "right" and direction == "left"
        then
            return true
        end
        return false
    end

    function _tank:shoot()
        if #bullets == bulletLimit then
            return
        end

        local bullet = Bullet:new(1)
        -- TODO: stop using magic numbers.... in whole project
        bullet:setLayerID(16)
        bullet:setXPos(self:getXPos())
        bullet:setYPos(self:getYPos())
        _G.scene:addChild(bullet)

        -- TODO: There is no bullet layer on start and the game engine does not support dynamic layers yet. So I update layer list on each shoot.
        -- For now I disabled it because of using an existing layerID
        -- _G.layers = _G.scene:getLayers()
    end

    function _tank:stop()
        _isMoving = false
    end

    function _tank:isMoving()
        return _isMoving
    end

    function _tank:setSpeed(speed)
        _speed = speed
    end

    function _tank:getSpeed()
        return _speed
    end

    function _tank:setDirection(direction)
        _direction = direction
    end

    function _tank:getDirection()
        return _direction
    end

    function _tank:getSpriteObjectID()
        return _tid
    end

    return _tank
end

function Tank:update(dt)
    local collider = self:getCollider(1)
    local direction = self:getDirection()
    local pv = { x = 0 , y = 0}
    if self:isMoving() then
        self:getChildren()[self:getSpriteObjectID()]:resumeAnimation()
        if direction == "up" then
            pv.y = self:getSpeed() * -1
        elseif direction == "left" then
            pv.x = self:getSpeed() * -1
        elseif direction == "down" then
            pv.y = self:getSpeed()
        elseif direction == "right" then
            pv.x = self:getSpeed()
        end
    else
        self:getChildren()[self:getSpriteObjectID()]:pauseAnimation()
    end

    collider:setLinearVelocity(pv.x, pv.y)

    self:setXPos(math.floor(collider:getX() - collider:getRadius()))
    self:setYPos(math.floor(collider:getY() - collider:getRadius()))

    GameObject.update(self,dt)
end

return Tank