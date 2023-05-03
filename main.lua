if pcall(require, "developement") then
    print("Developement run")
end

--lib/penlight/lua/pl/utils.lua

require "classes.TileMap"
require "classes.Scene"
require "classes.Rectangle"

require "math"

local STAGE_LIST = {}
local STAGE_INDEX = 3
local STAGES = {}

function love.load()
    -- set pixelate scale mode
    love.graphics.setDefaultFilter("nearest", "nearest")

    local files = love.filesystem.getDirectoryItems(_G.stagesDirectory)

    for _, file in ipairs(files) do
        local stageName = (string.gsub(file, ".lua", "", 1))
        table.insert(STAGE_LIST, (string.gsub(file, ".lua", "", 1)))
        table.insert(STAGES, require(_G.stagesDirectory .. "/" .. stageName))
    end

    print("Stage count " .. #STAGE_LIST)
    local map = TileMap:new(STAGES[STAGE_INDEX])
    map:setXPos(16)
    map:setYPos(8)

    _G.scene = Scene:new()
    _G.scene:addChild(map)

    -- Set scene as root object
    _G.scene:setLayerID(-1)

    local background = Rectangle:new(0, 0, _G.initialWidth, _G.initialHeight)
    background:setColor({99/255, 99/255, 99/255})
    background:setLayerID(1)

    _G.scene:addChild(background)

    require("pl.tablex")

    _G.layers = _G.scene:getLayers()

    local wf = require("windfield")

    _G.world = wf.newWorld()
    player = world:newCircleCollider(32, 0, 7.75)
    --world:newBSGRectangleCollider(32, 0, 15, 15, 2)
    player:setFixedRotation(true)

    -- wall1 = world:newRectangleCollider(0,16, 16, 32)
    -- wall1:setType("static")
    -- wall2 = world:newRectangleCollider(32,0, 16, 32)
    -- wall2:setType("static")

    _G.colliders = createColliders(map:loadObjects())

    _G.playerVelocity = { x = 0, y = 0}
end

function love.draw()
    local width, height = love.graphics.getDimensions()

    local scaleX = width / _G.initialWidth
    local scaleY = height / _G.initialHeight

    local scale = 1

    -- Calculate coordinates for scene centration
    local shiftX = 0
    local shiftY = 0
    if scaleX <= scaleY then
        scale = scaleX
        shiftX = 0
        shiftY = ( height - _G.initialHeight * scale ) / scale / 2
    else
        scale = scaleY
        shiftX = ( width - _G.initialWidth * scale ) / scale / 2
        shiftY = 0
    end

    love.graphics.scale(scale)

    for _, layer in ipairs(_G.layers) do
        _G.scene:draw(layer, shiftX, shiftY)
    end
    world:draw()
end

function love.update(dt)

    local pv = { x = 0 , y = 0}

    if love.keyboard.isDown("right") then
        pv.x = 50
    elseif love.keyboard.isDown("left") then
        pv.x = -50
    elseif love.keyboard.isDown("up") then
        pv.y = -50
    elseif love.keyboard.isDown("down") then
        pv.y = 50
    end

    if pv.x ~= _G.playerVelocity.x or pv.y ~= _G.playerVelocity.y then
        if pv.x == 0 and pv.y == 0 then
            print("Stop")
        else
            print("Change direction")
            local x = player:getX()
            local y = player:getY()

            print( math.abs(x % 8))


            local dx = (x) % 8
            local dy = (y - 0.25) % 8

            if dx <= 8/2 then 
                player:setX(x - dx)
            else
                player:setX(x - dx + 8)
            end

            if dy <= 8/2 then 
                player:setY(y - dy + 0.25)
            else
                player:setY(y - dy + 8 + 0.25)
            end
        end

        _G.playerVelocity.x, _G.playerVelocity.y = pv.x, pv.y    
    end

    player:setLinearVelocity(_G.playerVelocity.x, _G.playerVelocity.y)

    _G.scene:update(dt)
    world:update(dt)
end

function love.keypressed(key)
    print("Pressed key: " .. key)
    if key == "return" then
        nextStage()
    end

    if key == "escape" then
       love.event.quit()
    end
end

function nextStage()
    if STAGE_INDEX >= #STAGES then
        STAGE_INDEX = 1
    else
        STAGE_INDEX = STAGE_INDEX + 1
    end

    print("Load stage " .. STAGE_INDEX .. " (" .. STAGE_LIST[STAGE_INDEX] .. ")")

    local map = TileMap:new(STAGES[STAGE_INDEX])
    map:setXPos(16)
    map:setYPos(8)

    _G.colliders = createColliders(map:loadObjects())

    _G.scene:getChildren()[1] = map
    _G.layers = _G.scene:getLayers()
end

function createColliders(objects)
    local colliders = {}
    for _, obj in ipairs(objects) do
        --table.insert(object.colliders, obj)
        for __, col in ipairs(obj.colliders) do
            if col.shape == "rectangle" then
                local coll = _G.world:newRectangleCollider(obj.tileMap:getXPos() + obj.mapPosX + col.x, obj.tileMap:getYPos() + obj.mapPosY + col.y, col.width, col.height)
                coll:setType("static")
                coll:setObject(obj)

                table.insert(colliders, coll)
            end
        end
    end
    return colliders
end

-- function updateColliders(colliders)
--     for _, col in ipairs(colliders) do
--         col:setPosition(col:getObject().tileMap:getXPos() + (col:getObject().mapPosX + col.x, (col:getObject().tileMap:getYPos() + (col:getObject().mapPosY + col.y)
--         -- call:getObject()
--         --     if col.shape == "rectangle" then
--         --         local coll = _G.world:newRectangleCollider(obj.tileMap:getXPos() + obj.mapPosX + col.x, obj.tileMap:getYPos() + obj.mapPosY + col.y, col.width, col.height)
--         --         coll:setType("static")
--         --     end
--     end
-- end