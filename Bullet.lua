local Bullet = Sprite:extend({})

function Bullet:new(direction)

    local _tileset = TileSet:new(require("gfx.bullets"))
    local _bullet = _tileset:getChild(1)

    setmetatable(_bullet,self)
    self.__index = self

    return _bullet
end

return Bullet
