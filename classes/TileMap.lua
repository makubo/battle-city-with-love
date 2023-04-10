require("classes/Tools")
require("classes/GameObject")
require("classes/TileSet")

TileMap = {}

extended(TileMap, GameObject)

TileMap.tilesets = {}
TileMap.layers = {}

function TileMap:constructor(model)
    --ocal newObject = model
    -- setmetatable(newObject, self)
    -- self.__index = self

    --newObject.layers = mod.layers

    -- self.tilesets = {}
    -- self.layers = {}

    for i = 1, #self.tilesets do
        local ts = nil
        if self.tilesets[i].filename ~= nil then
            local firstgid = self.tilesets[i].firstgid

            self.tilesets[i] = TileSet:new(require("gfx/" .. self.tilesets[i].name))
            self.tilesets[i].firstgid = firstgid

            print("ff " .. self.tilesets[i].firstgid)
            --newObject.model.tilesets[i] = require("gfx/" .. newObject.model.tilesets[i].name)
            --newObject.model.tilesets[i].firstgid = firstgid
        else
            self.tilesets[i] = TileSet:new(self.tilesets[i])
            --newObject.tilesets[i].firstgid = firstgid
        end
        --table.insert(newObject.tilesets, ts)
        --table.insert(newObject.model.textures,love.graphics.newImage(map.tilesets[i].image))
    end

    return self
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
--function TileMap:draw()
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
        
                            tileset:drawTile(tid, xx + self:getXPos() + xPos, yy + self:getYPos() + yPos)
                        end
                    end
                end
            end
        end
    end
end