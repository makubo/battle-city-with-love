function love.conf(t)
    _G.initialWidth = 256
    -- PAL
    --_G.initialHeight = 240
    -- NTSC
    _G.initialHeight = 224

    _G.stagesDirectory = "stages"

    t.version = "11.4"

    t.console = true

    t.window.title = "Battle City with LÖVE"         -- The window title (string)
    t.window.icon = "icon.png"                 -- Filepath to an image to use as the window's icon (string)

    t.window.resizable = true
    t.window.minwidth = _G.initialWidth
    t.window.minheight = _G.initialHeight
    t.window.width = t.window.minwidth
    t.window.height = t.window.minheight

end