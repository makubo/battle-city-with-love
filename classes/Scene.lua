require("classes/Tools")
require("classes/GameObject")
Scene = {}

extended(Scene, GameObject)

function Scene:getObjectName()
    return "Scene"
end
