--Standard MOdules
local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

--Colors
local color = require("layout.dock.color")

local mylayoutbox = awful.widget.layoutbox()
mylayoutbox:buttons(gears.table.join(
  awful.button({}, 1, function()
    awful.layout.inc(1)
  end),
  awful.button({}, 3, function()
    awful.layout.inc(-1)
  end),
  awful.button({}, 4, function()
    awful.layout.inc(1)
  end),
  awful.button({}, 5, function()
    awful.layout.inc(-1)
  end)
))

-- mylayoutbox.forced_height =

local layoutbox = wibox.widget {
  {
    mylayoutbox,
    left   = 1,
    right  = 1,
    top    = 1,
    bottom = 1,
    widget = wibox.container.margin

  },
  bg = color.green,
  widget = wibox.container.background,
  forced_height = dpi(25),
  forced_width = dpi(25),
    shape = function(cr, width, height)
    -- gears.shape.rounded_rect(cr, width, height, 8)
    gears.shape.rounded_rect(cr, width, height, 2)
  end,  

}

return layoutbox
