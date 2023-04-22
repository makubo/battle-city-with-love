require("classes/GameObject")

Tile = GameObject:extend({})

function Tile:new(model)

    local tile = GameObject:new(model)
    setmetatable(tile, self)
    self.__index = self

    local frame = 1
    local timer = 0
    local quads = {}
    local texture = nil
    local animation = nil

    local index = nil

    function tile:addQuad(q)
        table.insert(quads, q)
    end

    function tile:getQuad(i)
        return quads[i or frame]
    end

    function tile:setIndex(i)
        index = i
    end

    function tile:getIndex()
        return index
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
        timer = t
    end

    function tile:getTimer()
        return timer
    end

    function tile:setAnimation(ani)
        print("Add animation with " .. #ani .. " frames")
        animation = ani
    end

    function tile:getAnimation()
        return animation
    end

    function tile:isAnimated()
        if animation ~= nil then
            return true
        end
        return false
    end

    return tile
end

function Tile:draw(xPos, yPos)
    love.graphics.draw(self:getTexture(), self:getQuad(), xPos or 0, yPos or 0)
end

function Tile:update(dt)
    --print("Tile update")
    if self:getAnimation() ~= nil then
    --if false then
        --print("Update index " .. self:getIndex())
        --print("Frame number = " .. self:getFrame())
        --print("Frame number = " .. self.frame)
        --local frame = self.frame % #(self.animation) + 1
        --print("Anim ID = " .. frame)
        local durationSec = self:getAnimation()[self:getFrame()].duration / 1000
        --print("Duration = " .. durationSec)
        --print("Timer = " .. self.timer)
        --if self.timer >= durationSec then
        if self:getTimer() >= durationSec then
             local frame = self:getFrame() % #(self:getAnimation()) + 1
            -- print("Set frame: " .. frame)
             self:setFrame(frame)
            --self.frame = self.frame % #(self.animation) + 1
            --print("Frame - " .. self.frame)
            print("Frame         - " .. self:getFrame())
            print("Frame Tile ID - " .. self:getAnimation()[self:getFrame()].tileid)
            print("Frame Time    - " .. durationSec)
            print("")
            --animTile.durationSec = 
            self:setTimer(self:getTimer() - durationSec)
            --self:setTimer(0)
            --self.timer = self:getTimer() - durationSec
        end
        local timer = self:getTimer() + dt
        self:setTimer(timer)
        --self.timer = timer
    end
end
