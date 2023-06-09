require("classes.GameObject")
require("classes.TileSet")

TileMap = GameObject:extend({})

TileMap.tilesets = {}
TileMap.layers = {}
TileMap.colliders = {}

function TileMap:getObjectName()
    return "TileMap"
end

function TileMap:new(model)

    local tileMap = GameObject:new(model)
    setmetatable(tileMap, self)
    self.__index = self

    for _, tileset in  ipairs(tileMap.tilesets) do
        local ts = nil
        if tileset.filename ~= nil then
            --print("Load tileset from file, fid = " .. tileset.firstgid)

            local tilesetModel = require("gfx/" .. tileset.name)
            tilesetModel.firstgid = tileset.firstgid

            ts = TileSet:new(tilesetModel)

        else
            --print("Load embedded tileset, fid = " .. tileset.firstgid)
            ts = TileSet:new(tileset)
        end
        tileMap:addChild(ts)
    end

    --tileMap:loadObjects()

    return tileMap
end

function TileMap:loadObjects()
    local objects = {}
    for _, layer in ipairs(self.layers) do
        for y = 0, layer.height - 1 do
            for x = 0, layer.width -1 do
                local index = (x + y * layer.width) + 1
                local gid = layer.data[index]
                if gid ~= 0 then
                    for i, tileset in ipairs(self:getChildren()) do
                        if tileset:isGlobalTidIn(gid) then

                            local xx = x * tileset.tilewidth
                            local yy = y * tileset.tileheight

                            local tile = tileset:getTileByGID(gid)

                            if #tile:getObjects() > 0 then
                                --for __, obj in ipairs(tile:getObjects()) do
                                    local object = {
                                        tileMap = self,
                                        layer = layer.id, -- on what layer
                                        index = index,    -- on what position
                                        mapPosX = xx,
                                        mapPosY = yy,
                                        objects = tile:getObjects()
                                    }
                                    --table.insert(object.colliders, obj)
                                --end
                                table.insert(objects, object)
                            end
                        end
                    end
                end
            end
        end
    end
    return objects
end

function TileMap:getLayers()
    local layers = {}
    for _, layer in ipairs(self.layers) do
        table.insert(layers, layer.id)
    end

    return layers
end

-- TODO: draw by layer method
function TileMap:draw(layerID, xPos, yPos)
    for _, layer in ipairs(self.layers) do
        if layer.id == layerID then

            for y = 0, layer.height - 1 do
                for x = 0, layer.width -1 do
                    local index = (x + y * layer.width) + 1
                    local tid = layer.data[index]
                    if tid ~= 0 then

                        for i, tileset in ipairs(self:getChildren()) do
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
end

function TileMap:getPixelHeight()
    return self.height * self.tileheight
end

function TileMap:getPixelWidth()
    return self.width * self.tilewidth
end
