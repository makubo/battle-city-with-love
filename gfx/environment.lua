return {
  version = "1.5",
  luaversion = "5.1",
  tiledversion = "1.8.6",
  name = "environment",
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
      id = 0,
      objectGroup = {
        type = "objectgroup",
        draworder = "index",
        id = 4,
        name = "",
        visible = true,
        opacity = 1,
        offsetx = 0,
        offsety = 0,
        parallaxx = 1,
        parallaxy = 1,
        properties = {},
        objects = {
          {
            id = 11,
            name = "",
            type = "collider_wall",
            shape = "rectangle",
            x = 0,
            y = 0,
            width = 8,
            height = 8,
            rotation = 0,
            visible = true,
            properties = {}
          }
        }
      }
    },
    {
      id = 1,
      objectGroup = {
        type = "objectgroup",
        draworder = "index",
        id = 2,
        name = "",
        visible = true,
        opacity = 1,
        offsetx = 0,
        offsety = 0,
        parallaxx = 1,
        parallaxy = 1,
        properties = {},
        objects = {
          {
            id = 1,
            name = "",
            type = "collider_wall",
            shape = "rectangle",
            x = 0,
            y = 0,
            width = 8,
            height = 8,
            rotation = 0,
            visible = true,
            properties = {}
          }
        }
      }
    },
    {
      id = 2,
      objectGroup = {
        type = "objectgroup",
        draworder = "index",
        id = 2,
        name = "",
        visible = true,
        opacity = 1,
        offsetx = 0,
        offsety = 0,
        parallaxx = 1,
        parallaxy = 1,
        properties = {},
        objects = {
          {
            id = 1,
            name = "",
            type = "",
            shape = "rectangle",
            x = 0,
            y = 0,
            width = 8,
            height = 8,
            rotation = 0,
            visible = true,
            properties = {}
          }
        }
      }
    },
    {
      id = 3,
      objectGroup = {
        type = "objectgroup",
        draworder = "index",
        id = 2,
        name = "",
        visible = true,
        opacity = 1,
        offsetx = 0,
        offsety = 0,
        parallaxx = 1,
        parallaxy = 1,
        properties = {},
        objects = {
          {
            id = 1,
            name = "",
            type = "",
            shape = "rectangle",
            x = 0,
            y = 0,
            width = 8,
            height = 8,
            rotation = 0,
            visible = true,
            properties = {}
          }
        }
      }
    },
    {
      id = 4,
      objectGroup = {
        type = "objectgroup",
        draworder = "index",
        id = 2,
        name = "",
        visible = true,
        opacity = 1,
        offsetx = 0,
        offsety = 0,
        parallaxx = 1,
        parallaxy = 1,
        properties = {},
        objects = {
          {
            id = 1,
            name = "",
            type = "",
            shape = "rectangle",
            x = 0,
            y = 0,
            width = 8,
            height = 8,
            rotation = 0,
            visible = true,
            properties = {}
          }
        }
      }
    },
    {
      id = 5,
      objectGroup = {
        type = "objectgroup",
        draworder = "index",
        id = 2,
        name = "",
        visible = true,
        opacity = 1,
        offsetx = 0,
        offsety = 0,
        parallaxx = 1,
        parallaxy = 1,
        properties = {},
        objects = {
          {
            id = 1,
            name = "",
            type = "collider_wall",
            shape = "rectangle",
            x = 0,
            y = 0,
            width = 8,
            height = 8,
            rotation = 0,
            visible = true,
            properties = {}
          }
        }
      }
    },
    {
      id = 11,
      objectGroup = {
        type = "objectgroup",
        draworder = "index",
        id = 2,
        name = "",
        visible = true,
        opacity = 1,
        offsetx = 0,
        offsety = 0,
        parallaxx = 1,
        parallaxy = 1,
        properties = {},
        objects = {
          {
            id = 1,
            name = "",
            type = "collider_water",
            shape = "polygon",
            x = 0,
            y = 0,
            width = 0,
            height = 0,
            rotation = 0,
            visible = true,
            polygon = {
              { x = 0, y = 0 },
              { x = 0, y = 8 },
              { x = 8, y = 8 },
              { x = 8, y = 0 }
            },
            properties = {}
          }
        }
      },
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
          duration = 800
        }
      }
    }
  }
}
