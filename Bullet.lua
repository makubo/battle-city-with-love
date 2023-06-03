local Bullet = Sprite:extend({})

function Bullet:new(type)

    local _bullet = Sprite:new()
    setmetatable(_bullet,self)
    self.__index = self

    return _bullet
end