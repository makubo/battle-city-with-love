if pcall(require, "developement") then
    print("Developement run")
end

-- engine classes
require "classes.TileMap"
require "classes.Scene"
require "classes.Rectangle"

--3rd party classes
Windfield = require "windfield"
Camera    = require "hump.camera"

-- game classes
Tank   = require "Tank"
Bullet = require "Bullet"

local STAGE_LIST = {}
local STAGE_INDEX = 3
local STAGES = {}

DRAW_COLLIDER = false

function love.load()

    _G.camera = Camera(_G.initialWidth / 2,_G.initialHeight / 2)
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

    _G.world = Windfield.newWorld()

    _G.scene = createScene(map)

    player = {}
    player[1] = Tank:new(0)
    --require("player")

    player[1]:setSpeed(40)
    player[1]:setLayerID(15)

    _G.scene:addChild(player[1])

    _G.layers = _G.scene:getLayers()

    playerColl = world:newCircleCollider(0, 0, 7.5)
    playerColl:setFixedRotation(true)

    player[1]:addCollider(playerColl)

    _G.colliders = createColliders(map:loadObjects())

    --_G.playerVelocity = { x = 0, y = 0}
end

function love.draw()
    --print("draw function")
    camera:zoomTo(scaleToInscribedSize(_G.initialWidth,_G.initialHeight))

    camera:attach()
        for _, layer in ipairs(_G.layers) do
            _G.scene:draw(layer)
            --, shiftX, shiftY)
        end
        if DRAW_COLLIDER then
            world:draw()
        end
    camera:detach()
end

function love.update(dt)

    if love.keyboard.isDown("right") then
        player[1]:move("right")
    elseif love.keyboard.isDown("left") then
        player[1]:move("left")
    elseif love.keyboard.isDown("up") then
        player[1]:move("up")
    elseif love.keyboard.isDown("down") then
        player[1]:move("down")
    else
        player[1]:stop()
    end

    updateColliders(_G.colliders)

    _G.scene:update(dt)
    world:update(dt)
end

function love.keypressed(key)
    print("Pressed key: " .. key)
    if key == "return" then
        nextStage()
    end

    if key == "space" then
        player[1]:shoot()
    end

    if key == "escape" then
       love.event.quit()
    end

    if key == "f12" then
        DRAW_COLLIDER = not DRAW_COLLIDER
    end
end

function nextStage()

    _G.scene:destroyColliders()
    _G.scene = nil
    collectgarbage()
    if STAGE_INDEX >= #STAGES then
        STAGE_INDEX = 1
    else
        STAGE_INDEX = STAGE_INDEX + 1
    end

    print("Load stage " .. STAGE_INDEX .. " (" .. STAGE_LIST[STAGE_INDEX] .. ")")

    local map = TileMap:new(STAGES[STAGE_INDEX])
    map:setXPos(16)
    map:setYPos(8)

    destroyColliders(_G.colliders)

    _G.colliders = createColliders(map:loadObjects())

    _G.scene = createScene(map)
    -- TODO: make something with the player
    _G.scene:addChild(player[1])
    _G.layers = _G.scene:getLayers()
end

function createScene(map)
    local scene = Scene:new()
    scene:addChild(map)

    -- Set scene as root object
    scene:setLayerID(-1)

    local background = Rectangle:new(0, 0, _G.initialWidth, _G.initialHeight)
    background:setColor({99/255, 99/255, 99/255})
    background:setLayerID(1)

    scene:addChild(background)

    local borders = {
        top    = world:newLineCollider(map:getXPos(), map:getYPos(), map:getXPos() + map:getPixelWidth(), map:getYPos()),
        bottom = world:newLineCollider(map:getXPos(), map:getYPos() + map:getPixelHeight(),  map:getXPos() + map:getPixelWidth(), map:getYPos() + map:getPixelHeight()),
        left   = world:newLineCollider(map:getXPos(), map:getYPos(), map:getXPos(), map:getYPos() + map:getPixelHeight()),
        right  = world:newLineCollider(map:getXPos() + map:getPixelWidth(), map:getYPos(), map:getXPos() + map:getPixelWidth(), map:getYPos() + map:getPixelHeight()),
    }

    borders.top:setType("static")
    borders.bottom:setType("static")
    borders.left:setType("static")
    borders.right:setType("static")

    scene:addCollider(borders.top)
    scene:addCollider(borders.bottom)
    scene:addCollider(borders.left)
    scene:addCollider(borders.right)

    return scene
end


-- TODO: move to the Game object
function createColliders(objects)
    local colliders = {}
    for _, obj in ipairs(objects) do
        --table.insert(object.colliders, obj)
        for __, col in ipairs(obj.objects) do
            if col.shape == "rectangle" then
                local coll = _G.world:newRectangleCollider(obj.tileMap:getXPos() + obj.mapPosX + col.x, obj.tileMap:getYPos() + obj.mapPosY + col.y, col.width, col.height, col.type)
                coll:setType("static")

                -- make recursion
                col.collider = coll
                coll:setObject(obj)

                table.insert(colliders, coll)
            elseif col.shape == "polygon" then
                local vertices = {}
                for ___, pol in ipairs(col.polygon) do
                    table.insert(vertices, obj.tileMap:getXPos() + obj.mapPosX + pol.x)
                    table.insert(vertices, obj.tileMap:getYPos() + obj.mapPosY + pol.y)
                end
                local coll = _G.world:newPolygonCollider(vertices, col.type)
                coll:setType("static")

                -- make recursion
                col.collider = coll
                coll:setObject(obj)

                table.insert(colliders, coll)
            end
        end
    end
    return colliders
end

function updateColliders(colliders)
    --print("Update coll")
    for _, col in ipairs(colliders) do

        for __, object in ipairs(col:getObject().objects) do
            -- print("Update coll")
            -- print(object.collider)
            -- print(col)
            if col.__tostring == object.__tostring then
            --if col == object then
                --col:setPosition(col:getObject().tileMap:getXPos() + (col:getObject().mapPosX + col.x, (col:getObject().tileMap:getYPos() + (col:getObject().mapPosY + col.y)
                -- print("Found")
            else
                -- print("NO Found")
            end
        end
        --col:setPosition(col:getObject().tileMap:getXPos() + (col:getObject().mapPosX + col.x, (col:getObject().tileMap:getYPos() + (col:getObject().mapPosY + col.y)
        -- call:getObject()
        --     if col.shape == "rectangle" then
        --         local coll = _G.world:newRectangleCollider(obj.tileMap:getXPos() + obj.mapPosX + col.x, obj.tileMap:getYPos() + obj.mapPosY + col.y, col.width, col.height)
        --         coll:setType("static")
        --     end
    end
end

function scaleToInscribedSize(w,h)
    local width, height = love.graphics.getDimensions()

    local scaleX = width / w
    local scaleY = height / h

    local scale = 1

    if scaleX <= scaleY then
        scale = scaleX
    else
        scale = scaleY
    end

    return scale
end

function destroyColliders(cols)
    for _,col in ipairs(cols) do
        col:destroy()
    end
end
