require("classes/GameObject")
require("classes/TileSet")

TileMap = GameObject:extend({})

TileMap.tilesets = {}
TileMap.layers = {}

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
            print("Load tileset from file, fid = " .. tileset.firstgid)

            local tilesetModel = require("gfx/" .. tileset.name)
            tilesetModel.firstgid = tileset.firstgid

            ts = TileSet:new(tilesetModel)

        else
            print("Load embedded tileset, fid = " .. tileset.firstgid)
            ts = TileSet:new(tileset)
        end
        tileMap:addChild(ts)
    end

    return tileMap
end

-- TODO: draw by layer method
function TileMap:draw(xPos, yPos)
    for _, layer in ipairs(self.layers) do
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