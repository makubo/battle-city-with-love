return {
  version = "1.5",
  luaversion = "5.1",
  tiledversion = "1.8.6",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 3,
  height = 3,
  tilewidth = 8,
  tileheight = 8,
  nextlayerid = 5,
  nextobjectid = 1,
  properties = {},
  tilesets = {
    {
      name = "environment",
      firstgid = 1,
      tilewidth = 8,
      tileheight = 8,
      spacing = 0,
      margin = 0,
      columns = 5,
      image = "gfx/environment.png",
      imagewidth = 40,
      imageheight = 24,
      transparentcolor = "#000001",
      objectalignment = "unspecified",
      tileoffset = {
        x = 0,
        y = 0
      },
      grid = {
        orientation = "orthogonal",
        width = 8,
        height = 8
      },
      properties = {},
      wangsets = {},
      tilecount = 15,
      tiles = {
        {
          id = 11,
          animation = {
            {
              tileid = 11,
              duration = 800
            },
            {
              tileid = 12,
              duration = 800
            },
            {
              tileid = 10,
              duration = 200
            }
          }
        }
      }
    },
    {
      name = "environment",
      firstgid = 16,
      filename = "gfx/environment.tsx"
    }
  },
  layers = {
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 3,
      height = 3,
      id = 2,
      name = "Ground",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      encoding = "lua",
      data = {
        15, 15, 15,
        15, 27, 15,
        15, 15, 12
      }
    },
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 3,
      height = 3,
      id = 1,
      name = "Buildings",
      visible = false,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 6,
        0, 0, 0,
        1, 0, 0
      }
    },
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 3,
      height = 3,
      id = 3,
      name = "Trees",
      visible = false,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      encoding = "lua",
      data = {
        7, 0, 0,
        0, 29, 0,
        0, 0, 0
      }
    }
  }
}
