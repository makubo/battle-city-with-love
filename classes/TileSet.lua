require("classes.GameObject")
require("classes.Tile")

TileSet = GameObject:extend({})

function TileSet:getObjectName()
    return "TileSet"
end

function TileSet:new(model)

    local tileSet = GameObject:new(model)
    setmetatable(tileSet,self)
    self.__index = self

    --local objects = {}
    -- if tileSet.tiles ~= nil then
    --     print("Animated tile count: " .. #tileSet.tiles)
    -- else
    --     print("Animated tile count: 0")
    -- end

    tileSet.texture = love.graphics.newImage(tileSet.image)
    tileSet:loadTileQuads()

    return tileSet
end

function TileSet:loadTileQuads()
    local index = self.firstgid or 1
    for y = 0, self.tilecount / self.columns - 1 do
        for x = 0, self.columns - 1 do
            local quad = love.graphics.newQuad(
                x * self.tilewidth + x * self.spacing + self.margin,
                y * self.tileheight + y * self.spacing + self.margin,
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

    self:prepareTiles()

    return self
end

function TileSet:prepareTiles()
    --print("Tile count from proc: " .. #self.tiles)
    -- Iterate tiles (animations) in tileset file (not object)
    for _, tile in ipairs(self.tiles) do
        local tid = tile.id + _G.tilesetIdCorrection
        if tile.animation then
            for __, frame in ipairs(tile.animation) do

                --print("Origin frame id " .. frame.tileid)

                if frame.tileid ~= tile.id then
                    local donor = self:getChildren()[frame.tileid + _G.tilesetIdCorrection]
                    --print("Donor id " .. donor:getIndex())
                    self:getChild(tid):addQuad(donor:getQuad(1))

                end
                --print("New frame id " .. frame.tileid)
            end
            self:getChild(tid):setAnimation(tile.animation)
        end

        if tile.objectGroup then
            for __, object in ipairs(tile.objectGroup.objects) do
                print(object.type)
                self:getChild(tid):addObject(object)
            end
        end
        --print("Add " .. tid .. " to " .. self.name .. " tileset")
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

function TileSet:getTileByGID(gid)
    local tid = self:tidGlobalToLocal(gid)
    return self:getChildren()[tid]
end

function TileSet:drawTile(globalTid, xPos, yPos)
    --print("TS draw gid " .. globalTid)
    local tid = self:tidGlobalToLocal(globalTid)
    --print("TS draw tid " .. tid)
    local tile = self:getChildren()[tid]
    tile:draw(0, xPos, yPos)
end
