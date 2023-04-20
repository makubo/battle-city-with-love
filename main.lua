if arg[#arg] == "vsc_debug" then require("lldebugger").start() end

--if pcall(require, "lldebugger") then require("lldebugger").start() end
--if pcall(require, "mobdebug") then require("mobdebug").start() end

require "classes/TileMap"
require "classes/Scene"

local STAGE_LIST = {}
local STAGE_INDEX = 4

function love.load()
    -- set pixelate scale mode
    love.graphics.setDefaultFilter("nearest", "nearest")
    -- TODO, set background as an object
    love.graphics.setBackgroundColor( 99/255, 99/255, 99/255, 0 )

    local files = love.filesystem.getDirectoryItems(_G.stagesDirectory)

    for _, file in ipairs(files) do
        table.insert(STAGE_LIST, (string.gsub(file, ".lua", "", 1)))
    end

    print("Stage count " .. #STAGE_LIST)
    local map = TileMap:new(require(_G.stagesDirectory .. "/" .. STAGE_LIST[STAGE_INDEX]))
    map:setXPos(16)
    map:setYPos(8)

    _G.scene = Scene:new()
    _G.scene:addChild(map)
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

    --local scale = ( scaleX <= scaleY) and scaleX or scaleY

    love.graphics.scale(scale)

    _G.scene:draw(shiftX, shiftY)
    --_G.scene:draw()

    --love.graphics.print(tostring(scaleX) .. " x " .. tostring(scaleY), 2, 2)
    --love.graphics.print(tostring(shiftX) .. " x " .. tostring(shiftY), 2, 2)
end

function love.update(dt)
    _G.scene:update(dt)
end

function love.keypressed(key)
    print("Pressed key: " .. key)
    nextStage()

    if key == "escape" then
       love.event.quit()
    end
end

function nextStage()
    if STAGE_INDEX >= #STAGE_LIST then
        STAGE_INDEX = 1
    else
        STAGE_INDEX = STAGE_INDEX + 1
    end

    print("Load stage " .. STAGE_INDEX .. " " .. STAGE_LIST[STAGE_INDEX])

    local map = TileMap:new(require(_G.stagesDirectory .. "/" .. STAGE_LIST[STAGE_INDEX]))
    map:setXPos(16)
    map:setYPos(8)

    _G.scene:getChildren()[1] = map
    --TileMap:new(require(_G.stagesDirectory .. "/" .. STAGE_LIST[STAGE_INDEX]))
    
    --loadTiledMap(_G.stagesDirectory .. "/" .. STAGE_LIST[STAGE_INDEX]) 
end
