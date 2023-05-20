local player = GameObject:new()

local stexture = Rectangle:new(0, 0, 16, 16)

stexture:setColor({99/255, 0, 0})

stexture:setLayerID(15)

player:addChild(stexture)

player.direction = "top"


player.tileset = TileSet:new(require("gfx.tanks"))

local tile = player.tileset:getChildren()[1]

tile:setLayerID(16)

player:addChild(tile)

return player