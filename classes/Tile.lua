require("classes/Tools")
require("classes/GameObject")

Tile = {}

extended(Tile, GameObject)

function Tile:constructor(model)
    local quads = {}
    local texture

    local frame = 1
    local timer = 0

    local tile = model or {}
    tile.frame = 1
    tile.timer = 0
    tile.quads = {}
    function tile:addQuad(q, index)
        table.insert(self.quads, q)
    end

    function tile:getQuad(index)
        return self.quads[index or self.frame]
    end

    function tile:setTexture(tex)
        texture = tex
    end

    function tile:getTexture()
        return texture
    end
    
    function tile:setFrame(fr)
        frame = fr
    end

    function tile:getFrame()
        return frame
    end

    function tile:setTimer(t)
        frame = t
    end

    function tile:getTimer()
        return timer
    end

    function tile:setAnimation(animation)
        print("Add animation with " .. #animation .. " frames")
        self.animation = animation
    end

    function tile:isAnimated()
        if self.animation ~= nil then
            return true
        end
        return false
    end

    setmetatable(tile,self)
    self.__index = self
    return tile
end

function Tile:update(dt)
    print("Tile update")
    if self.animation ~= nil then
        print("Frame number = " .. self.frame)
        local id = self.frame % #(self.animation) + 1
        print("Anim ID = " .. id)
        local durationSec = self.animation[id].duration / 1000
        print("Duration = " .. durationSec)
        print("Timer = " .. self.timer)
        if self.timer >= durationSec then
            --self:setFrame(self:getFrame() % #(self.animation) + 1)
            self.frame = self.frame % #(self.animation) + 1
            print("Frame - " .. self.frame)
            --print("Frame - " .. self:getFrame())
            --animTile.durationSec = 
            --self:setTimer(self:getTimer() - durationSec)
            self.timer = 0
        end
        local timer = self.timer + dt
        self.timer = timer
    end
end

function Tile:draw(xPos, yPos)
    --print("Tile draw")
    if xPos == nil then
        xPos = 0
    end
    if yPos == nil then
        yPos = 0
    end
    --love.graphics.draw(self:getTexture(), self:getQuad(), xPos, yPos)
    love.graphics.draw(self:getTexture(), self.quads[self.frame], xPos, yPos)
    
end