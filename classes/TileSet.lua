require("classes/Tools")
require("classes/GameObject")
require("classes/Tile")

TileSet = {}

extended(TileSet, GameObject)

--TileSet.quads = {}
--TileSet.animatedTiles = {}
--TileSet.firstgid = 1

function TileSet:getObjectName()
    return "TileSet"
end

function TileSet:constructor()
    -- local newObject = model
    -- setmetatable(newObject, self)
    -- self.__index = self

    local tileSet = {}

    print("Tile count: " .. #self.tiles)

    self.texture = love.graphics.newImage(self.image)
    self:loadTiles()
    

    --print("Quads length: " .. #self.quads)

    -- setmetatable(newObject, self)
    -- self.__index = self

    setmetatable(tileSet,self)
    self.__index = self
    return tileSet
    
end

function TileSet:loadTiles()
    --local index = 1
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
            -- print("Load quad #" .. index .. "(" .. x .. "x" .. y .. ") from " .. tileset.image)
            --table.insert(self.quads, quad)

            local tile = Tile:new()
            tile:addQuad(quad)
            tile:setTexture(self.texture)
            self:addChild(tile)

            --index = index + 1
        end
    end

    self:prepareAnimatedTiles()

    return self
end

function TileSet:prepareAnimatedTiles()
    print("Tile count from proc: " .. #self.tiles)
    for _, tile in ipairs(self.tiles) do

        local tid = tile.id
        -- table.insert(self.animatedTiles, tid ,tile)
        -- self.animatedTiles[tid].frame = 0
        -- self.animatedTiles[tid].timer = 0
        -- self.animatedTiles[tid].durationSec = self.animatedTiles[tid].animation[1].duration / 1000

        --tilek = 
        self:getChild(tid - 1):setAnimation(tile.animation)
        --tilek:
        
        print("Add " .. tid .. " to " .. self.name)
    end

    --print("Anim tile count" .. #self.animatedTiles)
    return self
end

-- function TileSet:getFrameCount(tid)
--     local numFrames = 0
--     if self.animatedTiles[tid] ~= nil then
--         local anim = self.animatedTiles[tid].animation
--         numFrames = #anim
--     end
--     return numFrames
-- end

function TileSet:isGlobalTidIn(globalTid)
    if globalTid >= self.firstgid and globalTid <= self.tilecount + self.firstgid - 1 then
        return true
    end
    return false
end

-- function TileSet:isTidIn(tid)
--     if tid >= 1 and tid <= self.tilecount then
--         return true
--     end
--     return false
-- end

function TileSet:tidGlobalToLocal(globalTid)
    return globalTid - self.firstgid + 1
end

-- function TileSet:getGlobalFrameCount(globalTid)
--     local tid = globalTid - self.firstgid + 1
--     local numFrames = 0
--     if self.animatedTiles[tid] ~= nil then
--         local anim = self.animatedTiles[tid].animation
--         numFrames = #anim
--     end
--     return numFrames
-- end

function TileSet:update(dt)
    print(self:getObjectName() .. " update")
    for _, child in ipairs(self:getChildren()) do
        child:update(dt)
    end
end

function TileSet:drawTile(globalTid, xPos, yPos)
    local tid = self:tidGlobalToLocal(globalTid)
    self:getChildren()[tid]:draw(xPos, yPos)
    --love.graphics.draw(self.texture, self.quads[tid], xPos, yPos)
end