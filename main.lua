require "classes/tiledmap"
require("classes/TileMap")

local STAGE_LIST = {}
local STAGE_INDEX = 2

function love.load()
    -- set pixelate scale mode
    love.graphics.setDefaultFilter("nearest", "nearest")

    local files = love.filesystem.getDirectoryItems(_G.stagesDirectory)
    
    for k, file in ipairs(files) do
        table.insert(STAGE_LIST, (string.gsub(file, ".lua", "", 1)))
    end

    print("Stage count " .. #STAGE_LIST)
    --_G.map = loadTiledMap(_G.stagesDirectory .. "/" .. STAGE_LIST[STAGE_INDEX])
    _G.map = TileMap:new(require(_G.stagesDirectory .. "/" .. STAGE_LIST[STAGE_INDEX]))
end

function love.draw()
    local width, height = love.graphics.getDimensions()

    local scaleX = width / _G.initialWidth
    local scaleY = height / _G.initialHeight

    local scale = ( scaleX <= scaleY) and scaleX or scaleY

    love.graphics.scale(scale)
    
    love.graphics.setBackgroundColor( 99/255, 99/255, 99/255, 0 )

    _G.map:draw(16, 8)
   
    love.graphics.print(tostring(scaleX) .. " x " .. tostring(scaleY), 2, 2)
end

function love.update(dt)
    --_G.map:update(dt)
end

function love.keypressed(key)
    print("Pressed key: " .. key)
    nextStage()

    -- if key == "escape" then
    --    love.event.quit()
    -- end
end

function nextStage()
    if STAGE_INDEX >= #STAGE_LIST then
        STAGE_INDEX = 1
    else
        STAGE_INDEX = STAGE_INDEX + 1
    end

    print("Load stage " .. STAGE_INDEX .. " " .. STAGE_LIST[STAGE_INDEX])
    _G.map = loadTiledMap(_G.stagesDirectory .. "/" .. STAGE_LIST[STAGE_INDEX]) 
end
