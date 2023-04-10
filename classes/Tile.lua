require("classes/Tools")
require("classes/GameObject")

Tile = {}

extended(Tile, GameObject)

function Tile:constructor(model)
    local quad
    local texture

    local tile = model or {}
    function tile:setQuad(q)
        quad = q
    end

    function tile:getQuad()
        return quad
    end

    function tile:setTexture(tex)
        texture = tex
    end

    function tile:getTexture()
        return texture
    end

    function tile:isAnimated()
        if self.animation ~= nil then
            return true
        end
        return false
    end

    setmetatable(tile,self)
    self.__index = self
    return tile
end

function Tile:draw(xPos, yPos)
    if xPos == nil then
        xPos = 0
    end
    if yPos == nil then
        yPos = 0
    end
    love.graphics.draw(self:getTexture(), self:getQuad(), xPos, yPos)
end