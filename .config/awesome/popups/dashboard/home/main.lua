--Standard Modules
local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

--Custom Modules
local color = require("popups.color")
local user = require("popups.user_profile")

--Widgets
local header = require("popups.dashboard.home.widgets.header")
local profile = require("popups.dashboard.home.widgets.profile")
local calender = require("popups.dashboard.home.widgets.calendar")
--local weather = require("popups.dashboard.home.widgets.weather")
local launch = require("popups.dashboard.home.widgets.quick_launch")
local exit = require("popups.dashboard.home.widgets.exit")



--Separator/Background
local Separator = wibox.widget.textbox("    ")
Separator.forced_height = dpi(748)
Separator.forced_width = 500

local Separator2 = wibox.widget.textbox("    ")
Separator.forced_height = dpi(250)
Separator.forced_width = 0
--Sidebar
-- local sidebar = require("popups.dashboard.home.sidebar")

local background = wibox.widget {
 image = "/home/laurinha/.config/awesome/popups/control_center/assets/354.png",
 ontop = true,
 resize = true,
 forced_height = dpi(350),
 forced_width = dpi(517),
--  background = "#F7E1FB00",
 widget = wibox.widget.imagebox,
 opacity = 1,
}

--Main Wibox
local dashboard_home = awful.popup {
  screen = s,
  widget = wibox.container.margin,
  ontop = true,
  visible = false,
  background = "#000000000",
  opacity = 1,
  placement = function(c)
    awful.placement.bottom_left(c,
      { margins = { top = dpi(0), bottom = dpi(30), left = dpi(20), right = dpi(0) } })
  end,
  --shape = function(cr, width, height)
  --  gears.shape.rounded_rect(cr, width, height, 10)
  --end,
}

dashboard_home:setup {
  {

      {
      background,
      widget = wibox.container.margin,
      {
        header,
        profile,
        Separator2,
        {
          exit,
          left = dpi(150),
          right = dpi(0),
          top = dpi(30),
          valign = "center",
          halign = "center",
          -- forced_height = dpi(5),
          widget = wibox.container.margin,
        },
        layout = wibox.layout.fixed.vertical,
      },
      --background,
      layout = wibox.layout.stack,
    },
    -- sidebar,
    layout = wibox.layout.fixed.horizontal
},
  widget = wibox.container.background,
  --shape = function(cr, width, height)
  --  gears.shape.rounded_rect(cr, width, height, 10)
  --end,
  }

return dashboard_home
