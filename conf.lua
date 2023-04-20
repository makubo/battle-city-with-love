function love.conf(config)
    _G.initialWidth = 256
    -- PAL
    --_G.initialHeight = 240
    -- NTSC
    _G.initialHeight = 224

    _G.stagesDirectory = "stages"

    _G.tilesetIdCorrection = 1

    config.version = "11.4"

    config.console = true

    config.window.title = "Battle City with LÖVE"         -- The window title (string)
    config.window.icon = "icon.png"                 -- Filepath to an image to use as the window's icon (string)

    config.window.resizable = true
    config.window.minwidth = _G.initialWidth
    config.window.minheight = _G.initialHeight
    config.window.width = config.window.minwidth
    config.window.height = config.window.minheight

end