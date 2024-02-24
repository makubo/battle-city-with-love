local Bullet = Sprite:extend({})

function Bullet:new(direction, x ,y)

    local _tileset = TileSet:new(require("gfx.bullets"))
    local _bullet = _tileset:getChild(direction)

    local collider = world:newCircleCollider(x, y, 1)
    collider:setFixedRotation(true)

    if direction == 1 then
        collider:setLinearVelocity(0, -80)
    elseif direction == 2 then
        collider:setLinearVelocity(-80, 0)
    elseif direction == 3 then
        collider:setLinearVelocity(0, 80)
    elseif direction == 4 then
        collider:setLinearVelocity(80, 0)
    end

    setmetatable(_bullet,self)
    self.__index = self

    _bullet:addCollider(collider)

    return _bullet
end

function Bullet:update()
    local collider = self:getCollider(1)
    self:setXPos(math.floor(collider:getX() - collider:getRadius() - 3))
    self:setYPos(math.floor(collider:getY() - collider:getRadius() - 2))
end

return Bullet
