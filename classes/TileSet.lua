require "classes.Tile"

TileSet = class("TileSet", GameObject)

function TileSet:initialize(model)
    GameObject.initialize(self)

    self.name = model.name
    self.tiles = model.tiles
    self.image = model.image
    self.texture = model.texture

    self.imageheight = model.imageheight
    self.imagewidth = model.imagewidth
    self.tileheight = model.tileheight
    self.tilewidth = model.tilewidth
    self.firstgid = model.firstgid
    self.tilecount = model.tilecount
    self.columns = model.columns

    print("Animated tile count: " .. #self.tiles)

    self.texture = love.graphics.newImage(self.image)
    self:loadTiles()

end

function TileSet:loadTiles()
    local id = 1
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
            print("Create tile " ..x .. " " .. y)
            local tile = Tile:new("ololo")
            --tile:addQuad(quad)
            table.insert(tile.quads, quad)
            tile.texture = self.texture
            tile.id = id
            --self.addChild(tile)
            table.insert(self._children, tile)
            id = id + 1

            self:tilePositionToId(x,y)
        end
    end

    self:prepareAnimatedTiles()

    return self
end

function TileSet:tilePositionToId(x,y)
    return x + y * self.columns + 1
end

function TileSet:prepareAnimatedTiles()
    print("Tile count from proc: " .. #self.tiles)
    for _, tile in ipairs(self.tiles) do

        local tid = tile.id
        --self:getChild(tid - 1).animation = tile.animation
        self._children[tid + 1].animation = tile.animation

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
    --for _, child in ipairs(self:getChildren()) do
    for _, child in ipairs(self._children) do
        child:update(dt)
    end
end

function TileSet:drawTile(globalTid, xPos, yPos)
    local tid = self:tidGlobalToLocal(globalTid)
    --tile = self:getChildren()[tid]
    local tile = self._children[tid]
    tile:draw(xPos, yPos)

    --love.graphics.draw(self.texture, self.quads[tid], xPos, yPos)
end

--return TileSet