require("classes/Tools")
require("classes/GameObject")
require("classes/TileSet")

TileMap = {}

extended(TileMap, GameObject)

TileMap.tilesets = {}
TileMap.layers = {}

function TileMap:getObjectName()
    return "TileMap"
end

function TileMap:constructor()
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

            self:addChild(self.tilesets[i])
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