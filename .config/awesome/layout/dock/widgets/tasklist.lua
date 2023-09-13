--Standard Modules
local gears = require("gears")
local wibox = require("wibox")
local awful = require("awful")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

--color and icons
local color = require("layout.dock.color")
local icon_path = "/icon_packs/Papirus/32x32/places/"

-- tasklist buttons
local deco = {
  wallpaper = require("deco.wallpaper"),
  taglist = require("deco.taglist"),
  tasklist = require("deco.tasklist"),
}

local taglist_buttons = deco.taglist()
local tasklist_buttons = deco.tasklist()


--Tasklist Popup box
local popup = awful.popup({
  widget = awful.widget.tasklist({
    screen = screen[1],
    filter = awful.widget.tasklist.filter.allscreen,
    buttons = tasklist_buttons,
    margins = {
      top = dpi(10),
      bottom = dpi(10),
      left = dpi(10),
      right = dpi(10),
    },
    style = {
      shape = function(cr, width, height)
        gears.shape.rounded_rect(cr, width, height, 8)
      end,
    },
    layout = {
      margins = dpi(5),
      spacing = dpi(3),
      forced_num_rows = 2,
      layout = wibox.layout.grid.horizontal,
    },
    widget_template = {
      {
        {
          id = "clienticon",
          widget = awful.widget.clienticon,
          margins = dpi(2),
          resize = false,
        },
        margins = dpi(2),
        widget = wibox.container.margin,
      },
      id = "background_role",
      forced_height = dpi(30),
      forced_width = dpi(30),
      widget = wibox.container.background,
      create_callback = function(self, c, index, objects) --luacheck: no unused
        self:get_children_by_id("clienticon")[1].client = c
      end,
    },
  }),
  shape = function(cr, width, height)
    gears.shape.rounded_rect(cr, width, height, 8)
  end,
  bg = "#F8C8E4",
  border_color = "#F8C8E4",
  border_width = dpi(4),
  ontop = true,
  -- placement    = awful.placement.top_left + awful.placement.no_offscreen,
  placement = function(c)
    local screen_geometry = awful.screen.focused().geometry
    return awful.placement.bottom(c, { margins = { bottom = dpi(35), left = dpi(170) } })
  end,
  
  geometry = { x = 20, y = 20 },
  visible = false,
})

--Button to open the popup box
local button = wibox.widget {
  {
    {
      widget = wibox.widget.imagebox,
      image = os.getenv("HOME") .. "/icon_packs/Papirus/32x32/apps/icon_desktop_asobu.png",
      resize = true,
      opacity = 1,
    },
    left   = dpi(2.1),
    right  = dpi(2.1),
    top    = dpi(2.1),
    bottom = dpi(2.1),
    widget = wibox.container.margin,
  },
  shape = function(cr, width, height)
    -- gears.shape.rounded_rect(cr, width, height, 8)
    gears.shape.rounded_rect(cr, width, height, 8)
  end,
  widget = wibox.container.background,
  forced_height = dpi(30),
  forced_width = dpi(30),
}

--Hover highlight effects
button:connect_signal("mouse::enter", function()
  button.bg = color.background_lighter
end)

button:connect_signal("mouse::leave", function()
  button.bg = color.background_dark
end)

button:connect_signal("button::press", function()
  button.bg = color.background_morelight
end)

button:connect_signal("button::release", function()
  button.bg = color.background_lighter
end)

--Open popup box on click
button:connect_signal("button::release", function()
  popup.visible = not popup.visible
end)

return button
