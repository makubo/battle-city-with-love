local player = GameObject:new()

-- local stexture = Rectangle:new(0, 0, 16, 16)

-- stexture:setColor({99/255, 0, 0})

-- stexture:setLayerID(15)

-- player:addChild(stexture)

player.direction = "top"


player.tileset = TileSet:new(require("gfx.tanks"))

local tile = player.tileset:getChild(1)

tile:setLayerID(16)

local tileID = player:addChild(tile)

function player:turn(direction)
    if direction == "up" then
        self:getChildren()[tileID] = self.tileset:getChild(1)
    elseif direction == "left" then
        self:getChildren()[tileID] = self.tileset:getChild(3)
    elseif direction == "down" then
        self:getChildren()[tileID] = self.tileset:getChild(5)
    elseif direction == "right" then
        self:getChildren()[tileID] = self.tileset:getChild(7)
    end
    self:getChildren()[tileID]:setLayerID(16)
end


return player