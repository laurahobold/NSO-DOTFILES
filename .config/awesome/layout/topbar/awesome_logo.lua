--Standard Modules
local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

local color = require("layout.topbar.colors")
local dashboard = require("popups.dashboard.home.main")

--Main Logo
local button1 = wibox.widget {
  {
    {
      widget = wibox.widget.imagebox,
      image = os.getenv("HOME") .. "/.config/awesome/layout/topbar/icons/button_start.png",
      resize = true,
      opacity = 1,
    },
    left   = dpi(0),
    right  = dpi(4),
    top    = dpi(2),
    bottom = dpi(2),
    widget = wibox.container.margin
  },
  bg = color.background_morelight,
  shape = gears.shape.rounded_rect,
  widget = wibox.container.background,
}

button1:connect_signal("button::release", function()
  dashboard.visible = not dashboard.visible
  image = os.getenv("HOME") .. "/.config/awesome/layout/topbar/icons/button_start.png"
end)



return button1
