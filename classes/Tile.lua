Tile = {}

function Tile:new(model)

    local xPos, yPos, children

    xPos = 0
    yPos = 0
    children = {}

    local obj = model or {}
    obj.frame = 1
    obj.timer = 0
    obj.quads = {}
    obj.texture = nil
    obj.animation = nil

    function obj:setXPos(x)
        xPos = x
    end

    function obj:getXPos()
        return xPos
    end

    function obj:setYPos(y)
        yPos = y
    end

    function obj:getYPos()
        return yPos
    end

    function obj:getChildren()
        return children
    end

    function obj:addChild(object)
        table.insert(children, object)
    end

    function obj:getChild(index)
        return children[index]
    end

    function obj:addQuad(q)
        print("Add quad")
        table.insert(self.quads, q)
    end

    function obj:getQuad(index)
        return self.quads[index or self.frame]
    end

    function obj:setTexture(tex)
        print("Set texture")
        self.texture = tex
    end

    function obj:getTexture()
        return self.texture
    end
    
    function obj:setFrame(fr)
        self.frame = fr
    end

    function obj:getFrame()
        return self.frame
    end

    function obj:setTimer(t)
        self.frame = t
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

    if xPos == nil then
        xPos = 0
    end
    if yPos == nil then
        yPos = 0
    end

    print("Daw")

    if self.animation ~= nil then
        print("Tile draw frame" .. self.frame)
    end
    --love.graphics.draw(self:getTexture(), self:getQuad(), xPos, yPos)
    love.graphics.draw(self.texture, self.quads[self.frame], xPos, yPos)

end

function Tile:update(dt)
    --print("Tile update")
    if self.animation ~= nil then
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

return Tile