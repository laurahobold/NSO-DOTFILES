--Standard Modules
local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

--Colors
local color = require("layout.dock.color")
local icon_path = "/icon_packs/Papirus/48x48/places/"

--Main Widget
local button = wibox.widget {
  {
    {
      widget = wibox.widget.imagebox,
      image = os.getenv("HOME") .. icon_path .. "icon_desktop_folder_open2.png",
      resize = true,
      opacity = 1,
    },
    left   = dpi(1),
    right  = dpi(1),
    top    = dpi(1),
    bottom = dpi(1),
    widget = wibox.container.margin
  },
  -- bg = color.background_dark,
  shape = function(cr, width, height)
    -- gears.shape.rounded_rect(cr, width, height, 8)
    gears.shape.rounded_rect(cr, width, height, 8)
  end,  widget = wibox.container.background,
  forced_height = dpi(30),
  forced_width = dpi(30),
}

--Open app on click
button:connect_signal("button::press", function(_, _, _, button)
  if button == 1 then
    awful.spawn.with_shell("nemo ~/Downloads/")
  end
end)


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


return button
