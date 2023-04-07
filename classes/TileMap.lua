require("classes/TileSet")

TileMap = {}
TileMap.tilesets = {}
TileMap.layers = {}

function TileMap:new(model)
    local newObject = model
    setmetatable(newObject, self)
    self.__index = self

    --newObject.layers = mod.layers

    for i = 1, #newObject.tilesets do
        local ts = nil
        if newObject.tilesets[i].filename ~= nil then
            local firstgid = newObject.tilesets[i].firstgid

            newObject.tilesets[i] = TileSet:new(require("gfx/" .. newObject.tilesets[i].name))
            newObject.tilesets[i].firstgid = firstgid

            print("ff " .. newObject.tilesets[i].firstgid)
            --newObject.model.tilesets[i] = require("gfx/" .. newObject.model.tilesets[i].name)
            --newObject.model.tilesets[i].firstgid = firstgid
        else
            newObject.tilesets[i] = TileSet:new(newObject.tilesets[i])
            --newObject.tilesets[i].firstgid = firstgid
        end
        --table.insert(newObject.tilesets, ts)
        --table.insert(newObject.model.textures,love.graphics.newImage(map.tilesets[i].image))
    end

    return newObject
end

-- TODO: move animation processing to the tileset class????
function TileMap:update(dt)
    --if tilesets
    -- print("Here" .. #self.tilesets[1].quads)
    -- print("Here" .. #self.tilesets[1].animatedTiles)
    for i, tileset in ipairs(self.tilesets) do
        -- print(tileset.name)
        -- print(#tileset.quads)
        -- print(tileset.animatedTiles)
        for _, animTile in pairs(tileset.animatedTiles) do
            if animTile.timer > animTile.durationSec then
                animTile.frame = animTile.frame + 1
                animTile.durationSec = animTile.animation[animTile.frame % #(animTile.animation) + 1].duration / 1000
                animTile.timer = 0
            end
            animTile.timer = animTile.timer + dt
        end
    end
end


-- TODO: draw by layer method
function TileMap:draw(xPos, yPos)
    for _, layer in ipairs(self.layers) do
        for y = 0, layer.height - 1 do
            for x = 0, layer.width -1 do
                local index = (x + y * layer.width) + 1
                local tid = layer.data[index]
                if tid ~= 0 then
                    
                    for i, tileset in ipairs(self.tilesets) do
                        if tileset:isGlobalTidIn(tid) then
            
                            local xx = x * tileset.tilewidth
                            local yy = y * tileset.tileheight
        
                            tileset:drawTile(tid, xx + xPos, yy + yPos)
                        end
                    end
                end
            end
        end
    end
end