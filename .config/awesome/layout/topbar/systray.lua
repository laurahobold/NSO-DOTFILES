--Standard Modules
local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local color = require("layout.topbar.colors")
local dpi = beautiful.xresources.apply_dpi

--Separator
local separator = wibox.widget.textbox("    ")
local separator2 = wibox.widget.textbox("  ")

--Systray Widget
local systray = wibox.widget {
  wibox.widget.systray(),
  spacing = dpi(10),
  forced_height = dpi(30),
  forced_width = dpi(45),
  widget  = wibox.container.margin,
  left   = dpi(0),
  right  = dpi(-10),
  top    = dpi(2),
  bottom = dpi(2),
  visible = true,
}

--Main Widget
local top_left = wibox.widget {
  {
    {
      separator,
      systray,
      layout = wibox.layout.fixed.horizontal,
    },
    widget = wibox.container.background,
    shape  = gears.shape.rounded_rect,
  },
  left   = dpi(1),
  right  = dpi(0),
  top    = dpi(1),
  bottom = dpi(1),
  widget = wibox.container.margin

}

return top_left
