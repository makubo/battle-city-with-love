require("classes.GameObject")

Sprite = GameObject:extend({})

function Sprite:getObjectName()
    return "Sprite"
end

function Sprite:new(model)

    local sprite = GameObject:new(model or {})
    setmetatable(sprite, self)
    self.__index = self

    local frame = 1
    local timer = 0
    local quads = {}
    local texture = nil
    local animation = nil

    local _isPaused = false

    local index = nil

    function sprite:addQuad(q)
        table.insert(quads, q)
    end

    function sprite:getQuad(i)
        return quads[i or frame]
    end

    function sprite:setIndex(i)
        index = i
    end

    function sprite:getIndex()
        return index
    end

    function sprite:setTexture(tex)
        texture = tex
    end

    function sprite:getTexture()
        return texture
    end

    function sprite:setFrame(fr)
        frame = fr
    end

    function sprite:getFrame()
        return frame
    end

    function sprite:setTimer(t)
        timer = t
    end

    function sprite:getTimer()
        return timer
    end

    function sprite:setAnimation(ani)
        --print("Add animation with " .. #ani .. " frames")
        animation = ani
    end

    function sprite:getAnimation()
        return animation
    end

    function sprite:isAnimated()
        if animation ~= nil and (not _isPaused) then
            return true
        end
        return false
    end

    function sprite:pauseAnimation()
        _isPaused = true
    end

    function sprite:resumeAnimation()
        _isPaused = false
    end

    return sprite
end

function Sprite:draw(layerID, xPos, yPos)
    if self:getLayerID() == layerID then
        love.graphics.draw(self:getTexture(), self:getQuad(), self:getXPos() + (xPos or 0), self:getYPos() + (yPos or 0))
    end
end

function Sprite:update(dt)
    if self:isAnimated() then
        local durationSec = self:getAnimation()[self:getFrame()].duration / 1000
        if self:getTimer() >= durationSec then
            local frame = self:getFrame() % #(self:getAnimation()) + 1
            self:setFrame(frame)
            self:setTimer(self:getTimer() - durationSec)
        end
        local timer = self:getTimer() + dt
        self:setTimer(timer)
    end
end
