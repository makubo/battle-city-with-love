--require("classes/Tools"
--local GameObject = require "classes.GameObject"
--local class = require "lib.middleclass.middleclass"

--GameObject = class('GameObject')

Scene = class("Scene", GameObject)

function Scene:initialize(name)
    GameObject.initialize(self)
    self.name = name
end

-- extended(Scene, GameObject)

-- function Scene:getObjectName()
--     return "Scene"
-- end

--return Scene