require("classes/GameObject")

Tile = {}

extended(Tile, GameObject)

function Tile:new(model)

    local obj = GameObject:new(model or {})
    local frame = 1
    obj.timer = 0
    obj.quads = {}
    obj.texture = nil
    obj.animation = nil

    local index = nil

    function obj:addQuad(q)
        table.insert(self.quads, q)
    end

    function obj:getQuad(i)
        return self.quads[i or frame]
    end

    function obj:setIndex(i)
        index = i
    end

    function obj:getIndex()
        return index
    end

    function obj:setTexture(tex)
        self.texture = tex
    end

    function obj:getTexture()
        return self.texture
    end

    function obj:setFrame(fr)
        frame = fr
    end

    function obj:getFrame()
        return frame
    end

    function obj:setTimer(t)
        self.timer = t
    end

    function obj:getTimer()
        return self.timer
    end

    function obj:setAnimation(animation)
        print("Add animation with " .. #animation .. " frames")
        self.animation = animation
    end

    function obj:isAnimated()
        if self.animation ~= nil then
            return true
        end
        return false
    end

    setmetatable(obj, self)
    self.__index = self

    return obj
end

function Tile:draw(xPos, yPos)
    --print("Tile draw index " .. self:getIndex())

    -- if xPos == nil then
    --     xPos = 0
    -- end
    -- if yPos == nil then
    --     yPos = 0
    -- end

    -- if self.animation ~= nil then
    --     --print("Tile draw frame" .. self.frame)
    -- end
    love.graphics.draw(self:getTexture(), self:getQuad(), xPos or 0, yPos or 0)

end

function Tile:update(dt)
    --print("Tile update")
    if self.animation ~= nil then
    --if false then
        --print("Update index " .. self:getIndex())
        print("Frame number = " .. self:getFrame())
        --print("Frame number = " .. self.frame)
        --local frame = self.frame % #(self.animation) + 1
        --print("Anim ID = " .. frame)
        local durationSec = self.animation[self:getFrame()].duration / 1000
        --print("Duration = " .. durationSec)
        --print("Timer = " .. self.timer)
        if self.timer >= durationSec then
             local frame = self:getFrame() % #(self.animation) + 1
            -- print("Set frame: " .. frame)
             self:setFrame(frame)
            --self.frame = self.frame % #(self.animation) + 1
            --print("Frame - " .. self.frame)
            print("Frame         - " .. self:getFrame())
            print("Frame Tile ID - " .. self.animation[self:getFrame()].tileid)
            print("Frame Time    - " .. durationSec)
            print("")
            --animTile.durationSec = 
            --self:setTimer(self:getTimer() - durationSec)
            --self:setTimer(0)
            self.timer = self:getTimer() - durationSec
        end
        local timer = self.timer + dt
        --self:setTimer(timer)
        self.timer = timer
    end
end
