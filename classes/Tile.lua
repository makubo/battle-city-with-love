Tile = class("Tile", GameObject)

function Tile:initialize(name)
    GameObject.initialize(self)
    print("New tile " .. name)
    --local obj = model or {}

    self.frame = 1
    self.timer = 0
    self.quads = {}
    self.texture = nil
    self.animation = nil

    self.id = nil

end

function Tile:addQuad(q)
    print("Add quad")
    table.insert(self.quads, q)
end

function Tile:getQuad(index)
    return self.quads[index or self.frame]
end

function Tile:setTexture(tex)
    print("Set texture")
    self.texture = tex
end

function Tile:getTexture()
    return self.texture
end

function Tile:setFrame(fr)
    self.frame = fr
end

function Tile:getFrame()
    return self.frame
end

function Tile:setTimer(t)
    self.frame = t
end

function Tile:getTimer()
    return self.timer
end

function Tile:setAnimation(animation)
    print("Add animation with " .. #animation .. " frames")
    self.animation = animation
end

function Tile:isAnimated()
    print("Check animated:" .. self.id)
    if self.animation ~= nil then
        print(self.id .. "is animated tile")
        return true
    end
    print(self.id .. "isn't animated tile")
    return false
end

function Tile:draw(xPos, yPos)
    print("Draw " .. self.id)

    --print("Tile draw")
    -- if xPos == nil then
    --     xPos = 0
    -- end
    -- if yPos == nil then
    --     yPos = 0
    -- end



    if self.animation ~= nil then
        print("Tile draw frame " .. self.frame)
    end
    --love.graphics.draw(self:getTexture(), self:getQuad(), xPos, yPos)
    love.graphics.draw(self.texture, self.quads[self.frame], xPos, yPos)

end

function Tile:update(dt)
    --print("UPDATE:" .. self.id)
    -- print(self)
    --print("Tile update")
    if self.animation ~= nil then
        print("UPDATE animated:" .. self.id)
        print(self)
        --print("Frame number = " .. self.frame)
        local frame = self.frame % #(self.animation) + 1
        --print("Anim ID = " .. frame)
        local durationSec = self.animation[frame].duration / 1000
        --print("Duration = " .. durationSec)
        --print("Timer = " .. self.timer)
        if self.timer >= durationSec then
            -- local frame = self:getFrame() % #(self.animation) + 1
            -- print("Set frame: " .. frame)
            -- self:setFrame(frame)
            self.frame = self.frame % #(self.animation) + 1
            print("Frame - " .. self.frame)
            --print("Frame - " .. self:getFrame())
            --animTile.durationSec = 
            --self:setTimer(self:getTimer() - durationSec)
            --self:setTimer(0)
            self.timer = 0
        end
        local timer = self.timer + dt
        --self:setTimer(timer)
        self.timer = timer
    end
end
