if pcall(require, "developement") then
    print("Developement run")
end

--lib/penlight/lua/pl/utils.lua

require "classes.TileMap"
require "classes.Scene"
require "classes.Rectangle"

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
end

function love.update(dt)
    _G.scene:update(dt)
end

function love.keypressed(key)
    print("Pressed key: " .. key)
    if key == "right" then
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

    _G.scene:getChildren()[1] = map
    _G.layers = _G.scene:getLayers()
end
