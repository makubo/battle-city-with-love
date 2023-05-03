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
      filename = "gfx/environment.tsx",
      exportfilename = "gfx/environment.lua"
    }
  },
  layers = {
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 3,
      height = 3,
      id = 10,
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
        15, 12, 15,
        15, 15, 12
      }
    },
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 3,
      height = 3,
      id = 20,
      name = "Buildings",
      visible = true,
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
      id = 30,
      name = "Trees",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      encoding = "lua",
      data = {
        7, 0, 0,
        0, 14, 0,
        0, 0, 0
      }
    }
  }
}
