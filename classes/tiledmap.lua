function loadTiledMap(path)
    local map = require(path)

    map.quads = {}
    map.textures = {}

    -- Load external tilesets and add load texture files
    for i = 1, #map.tilesets do
        if map.tilesets[i].filename ~= nil then
            local firstgid = map.tilesets[i].firstgid

            map.tilesets[i] = require("gfx/" .. map.tilesets[i].name)
            map.tilesets[i].firstgid = firstgid
        end
        table.insert(map.textures,love.graphics.newImage(map.tilesets[i].image))
    end

    --print("textures count: " .. #map.textures)

    local index = 1

    for _, tileset in ipairs(map.tilesets) do
        for y = 0, (tileset.imageheight / tileset.tileheight) - 1 do
            for x = 0, (tileset.imagewidth / tileset.tilewidth) - 1 do
                local quad = love.graphics.newQuad(
                    x * tileset.tilewidth,
                    y * tileset.tileheight,
                    tileset.tilewidth,
                    tileset.tileheight,
                    tileset.imagewidth,
                    tileset.imageheight
                )
                -- print("Load quad #" .. index .. "(" .. x .. "x" .. y .. ") from " .. tileset.image)
                table.insert(map.quads, quad)
                index = index + 1
            end
        end
    end

    -- Prepare animated tiles
    map.animatedTiles = {}
    for _, tileSet in ipairs(map.tilesets) do
        for i, tile in ipairs(tileSet.tiles) do

            local firstgid = map.tilesets[i].firstgid
            --map.animatedTiles[tile.id] = tile
            local globalTileID = tile.id + tileSet.firstgid - 1
            table.insert(map.animatedTiles, globalTileID ,tile)

            map.animatedTiles[globalTileID].frame = 0
            map.animatedTiles[globalTileID].timer = 0
            map.animatedTiles[globalTileID].durationSec = map.animatedTiles[globalTileID].animation[1].duration / 1000

            map.animatedTiles[globalTileID].indeces = {}
            
            print("Add " .. globalTileID)
        end
    end

    function map:getFrameCount(tid)
        local numFrames = 0
        if self.animatedTiles[tid] ~= nil then
            local anim = self.animatedTiles[tid].animation
            numFrames = #anim
        end
        return numFrames
    end

    function map:prepareAnimatedTiles()
        for _, layer in ipairs(self.layers) do 
            for index, tid in ipairs(layer.data) do
                if self:getFrameCount(tid - 1) > 0 then
                    table.insert(self.animatedTiles[tid - 1].indeces, index)
                end
            end
        end
    end

    map:prepareAnimatedTiles()

    function map:getNextTileFrame(tid)
        local numFrames = self:getFrameCount(tid - 1)
        if numFrames > 0 then
            local anim  = self.animatedTiles[tid - 1].animation
            local index = self.animatedTiles[tid - 1].frame % numFrames

            --print("TID: " .. tid .. ", index: "..index)
            tid = anim[index + 1].tileid + 1
        end

        return tid
    end

    function map:update(dt)
        for i, animTile in pairs(self.animatedTiles) do
            if animTile.timer > animTile.durationSec then
                animTile.frame = animTile.frame + 1
                animTile.durationSec = animTile.animation[animTile.frame % #(animTile.animation) + 1].duration / 1000
                animTile.timer = 0
            end
            animTile.timer = animTile.timer + dt
        end
    end

    function map:draw(xPos, yPos)
        for _, layer in ipairs(self.layers) do
            for y = 0, layer.height - 1 do
                for x = 0, layer.width -1 do
                    local index = (x + y * layer.width) + 1
                    local tid = layer.data[index]
                    if tid ~= 0 then
                        -- print("TID = " .. tid)

                        tid = self:getNextTileFrame(tid)

                        local quad = self.quads[tid]
                        local xx = x * self.tilewidth
                        local yy = y * self.tileheight

                        -- print("Draw quad #" .. tid)
                        local textureIndex = 1
                        for i, tileset in ipairs(self.tilesets) do
                            --print(tileset.firstgid .. " " .. tileset.tilecount .. " " .. (tileset.firstgid + tileset.tilecount))
                            --print("check texture " .. i)
                            if tid >= tileset.firstgid and tid < tileset.firstgid + tileset.tilecount then
                                textureIndex = i
                                break
                            end
                        end
                        -- print("Texture index: " .. textureIndex)
                        love.graphics.draw(self.textures[textureIndex], quad, xx + xPos, yy + yPos)
                    end
                end
            end
        end
    end

    return map
end
