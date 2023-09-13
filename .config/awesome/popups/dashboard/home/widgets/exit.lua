--Standard Modules
local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

--Custom Modules
local color = require("popups.color")
local user = require("popups.user_profile")

-----------------------
--Header text----------
-----------------------


--local textbox = wibox.widget {
--  markup = '<span color="' ..
--      color.green .. '" font="DinkieBitmap 15">' .. "Touch Grass 󱔐" .. '</span>',
--  font = "DinkieBitmap 15",
--  widget = wibox.widget.textbox,
--  --fg = color.white,
--  align = 'center'
--}

---------------------
--Main widget--------
---------------------
local bg = wibox.widget {
  image = ".config/awesome/popups/control_center/assets/button.png",
  resize = true,
  forced_height = dpi(40),
  forced_width = dpi(200),
  widget = wibox.widget.imagebox,
  valign = "center",
  halign = "center",
}

local button = wibox.widget {
  {
    ontop = true,
    widget = wibox.container.margin,
  },
  widget = wibox.container.margin,
  --bg = color.background_lighter,
  --shape = function(cr, width, height)
  --  gears.shape.rounded_rect(cr, width, height, 7)
  --end,
}

local exit_button = wibox.widget {
  bg,
  button,
  widget = wibox.container.margin,
}

--button:connect_signal("mouse::enter", function()
--  button.bg = color.background_lighter2
--end)
--
--button:connect_signal("mouse::leave", function()
--  button.bg = color.background_lighter
--end)
--
--button:connect_signal("button::press", function()
--  button.bg = color.background_morelight
--end)
--
--button:connect_signal("button::release", function()
--  button.bg = color.background_lighter2
--end)


exit_button:connect_signal("button::release", function(_, _, _, button)
  awesome.emit_signal("widget::powermenu2")
end)


return exit_button
