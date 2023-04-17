require("classes/Tools")
require("classes/GameObject")
require("classes/Tile")

TileSet = {}

extended(TileSet, GameObject)

function TileSet:getObjectName()
    return "TileSet"
end

function TileSet:constructor()

    local tileSet = {}

    print("Tile count: " .. #self.tiles)

    self.texture = love.graphics.newImage(self.image)
    self:loadTiles()

    setmetatable(tileSet,self)
    self.__index = self
    return tileSet
    
end

function TileSet:loadTiles()
    for y = 0, (self.imageheight / self.tileheight) - 1 do
        for x = 0, (self.imagewidth / self.tilewidth) - 1 do
            local quad = love.graphics.newQuad(
                x * self.tilewidth,
                y * self.tileheight,
                self.tilewidth,
                self.tileheight,
                self.imagewidth,
                self.imageheight
            )

            local tile = Tile:new()
            tile:addQuad(quad)
            tile:setTexture(self.texture)
            self:addChild(tile)
        end
    end

    self:prepareAnimatedTiles()

    return self
end

function TileSet:prepareAnimatedTiles()
    print("Tile count from proc: " .. #self.tiles)
    for _, tile in ipairs(self.tiles) do

        local tid = tile.id
        self:getChild(tid - 1).animation = tile.animation

        print("Add " .. tid .. " to " .. self.name)
    end

    return self
end

function TileSet:isGlobalTidIn(globalTid)
    if globalTid >= self.firstgid and globalTid <= self.tilecount + self.firstgid - 1 then
        return true
    end
    return false
end

function TileSet:tidGlobalToLocal(globalTid)
    return globalTid - self.firstgid + 1
end

function TileSet:update(dt)
    for _, child in ipairs(self:getChildren()) do
        child:update(dt)
    end
end

function TileSet:drawTile(globalTid, xPos, yPos)
    local tid = self:tidGlobalToLocal(globalTid)
    tile = self:getChildren()[tid]
    tile:draw(xPos, yPos)

    --love.graphics.draw(self.texture, self.quads[tid], xPos, yPos)
end

return TileSet