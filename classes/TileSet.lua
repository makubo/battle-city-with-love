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

    if self.tiles ~= nil then
        print("Animated tile count: " .. #self.tiles)
    else
        print("Animated tile count: 0")
    end

    self.texture = love.graphics.newImage(self.image)
    self:loadTiles()

    setmetatable(tileSet,self)
    self.__index = self
    return tileSet
end

function TileSet:loadTiles()
    local index = self.firstgid
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
            tile:setIndex(index)
            self:addChild(tile)

            index = index + 1
        end
    end

    self:prepareAnimatedTiles()

    return self
end

function TileSet:prepareAnimatedTiles()
    print("Tile count from proc: " .. #self.tiles)
    for _, tile in ipairs(self.tiles) do
            for __, frame in ipairs(tile.animation) do

                print("Origin frame id " .. frame.tileid)

                if frame.tileid ~= tile.id then
                    local donor = self:getChildren()[frame.tileid + _G.tilesetIdCorrection]
                    print("Donor id " .. donor:getIndex())
                    self:getChild(tile.id + _G.tilesetIdCorrection):addQuad(donor.quads[1])

                end
                print("New frame id " .. frame.tileid)
            end

        local tid = tile.id + _G.tilesetIdCorrection
        self:getChild(tid).animation = tile.animation

        print("Add " .. tid .. " to " .. self.name .. " tileset")
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

function TileSet:drawTile(globalTid, xPos, yPos)
    --print("TS draw gid " .. globalTid)
    local tid = self:tidGlobalToLocal(globalTid)
    --print("TS draw tid " .. tid)
    local tile = self:getChildren()[tid]
    tile:draw(xPos, yPos)
end
