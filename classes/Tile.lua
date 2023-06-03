require("classes.Sprite")

Tile = Sprite:extend({})

function Tile:getObjectName()
    return "Tile"
end

function Tile:new(model)

    local tile = Sprite:new(model or {})
    setmetatable(tile, self)
    self.__index = self

    local objects = {}

    function tile:addObject(o)
        table.insert(objects, o)
    end

    function tile:getObject(i)
        return objects[i or 1]
    end

    function tile:getObjects()
        return objects
    end

    return tile
end
