local wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

--Custom Modules
local color = require("popups.color")
local user = require("popups.user_profile")

------------------------
--Profile Image---------
------------------------

local image = wibox.widget {
  image = user.image_path,
  widget = wibox.widget.imagebox,
  resize = true,
  forced_height = dpi(80),
  forced_width = dpi(80),
  left = dpi(50),
}

------------------------
--Profile Texts---------
------------------------

-- Distro ----------
--------------------

-- local distro = io.popen('distro | grep "Name:" | awk ' ..
--   "'{sub(/^Name: /, " .. '""' .. "); print}' | awk '" .. '{print $1 " " $2 " " $3}' .. "'"
--
-- ):read("*all")

local distro = io.popen([[distro | grep "Name:" | awk '{sub(/^Name: /, ""); print}' | awk '{print $1 " " $2 " " $3}'
]]):read("*all")



local text = '<span color="' .. color.blueish_white .. '" font="DinkieBitmap 15">' .. '  :   ' .. 'linux mint' .. '</span>'
local icon = '<span color="' .. color.magenta .. '" font="DinkieBitmap 15">' .. '' .. '</span>'


local distro_text = wibox.widget {
  {
    -- text = user.name,
    markup = icon .. text,
    font = "DinkieBitmap 15",
    widget = wibox.widget.textbox,
    fg = color.white,
    -- forced_width = dpi(300),
  },
  distro_textbox,
  widget = wibox.container.margin,
  top = dpi(5),
  bottom = dpi(5),
  right = dpi(5),
  left = dpi(25),
  forced_height = dpi(40)
}

awful.spawn.easy_async_with_shell(
  [[distro | grep "Name:" | awk '{sub(/^Name: /, ""); print}' | awk '{print $1 " " $2 " " $3}']], function(out)
    distro_textbox.markup = icon .. '<span color="' ..
        color.magenta .. '" font="DinkieBitmap 15">' .. '  :   ' .. out .. '</span>'
  end)


-- Window Manager----
---------------------
local text2 = '<span color="' ..
    color.blueish_white .. '" font="DinkieBitmap 15">' .. '  :   ' .. 'awesome wm' .. '</span>'
local icon2 = '<span color="' .. color.magenta .. '" font="DinkieBitmap 15">' .. '' .. '</span>'

local wm_text = wibox.widget {
  {
    -- text = user.name,
    markup = icon2 .. text2,
    font = "DinkieBitmap 15",
    widget = wibox.widget.textbox,
    fg = color.blueish_white,
    -- forced_width = dpi(300),
  },
  widget = wibox.container.margin,
  top = dpi(5),
  bottom = dpi(5),
  right = dpi(5),
  left = dpi(25),
  forced_height = dpi(40)
}

--Uptime----------
------------------
local uptime = 3

local text3 = '<span color="' ..
    color.blueish_white .. '" font="DinkieBitmap 15">' .. '  :   ' .. uptime .. '</span>'
local icon3 = '<span color="' .. color.magenta .. '" font="DinkieBitmap 15">' .. '󱎫' .. '</span>'

local uptime_textbox = wibox.widget {
  markup = icon3 .. text3,
  font = "5DinkieBitmap 15",
  widget = wibox.widget.textbox,
  fg = color.blueish_white,
}

local uptime_text = wibox.widget {
  uptime_textbox,
  widget = wibox.container.margin,
  top = dpi(5),
  bottom = dpi(5),
  right = dpi(5),
  left = dpi(25),
  forced_height = dpi(40)
}

awful.spawn.easy_async("uptime -p", function(out)
  uptime_textbox.markup = icon3 .. '<span color="' ..
      color.blueish_white .. '" font="DinkieBitmap 15">' .. '  :   ' .. out:gsub("up ", "") .. '</span>'
end)

local update_uptime = function()
  awful.spawn.easy_async("uptime -p", function(out)
    uptime_textbox.markup = icon3 .. '<span color="' ..
        color.blueish_white .. '" font="DinkieBitmap 15">' .. '  :   ' .. out:gsub("up ", "") .. '</span>'
  end)
end

local update_uptime_timer = gears.timer({
  timeout = 60,
  call_now = true,
  autostart = true,
  callback = update_uptime,
})


------------------------
--Main Widget-----------
------------------------
local profile = wibox.widget {
  {
    image,
    {
      {
        {
          {
            distro_text,
            wm_text,
            uptime_text,
            layout = wibox.layout.fixed.vertical
          },
          widget = wibox.container.margin,
          top = dpi(4),
          bottom = dpi(4),
          forced_width = dpi(370)
        },
        widget = wibox.container.background,
        bg = color.background_lighter,
        shape = function(cr, width, height)
          gears.shape.rounded_rect(cr, width, height, 10)
        end,

      },
      widget = wibox.container.margin,
      left = dpi(12)
    },
    layout = wibox.layout.fixed.horizontal
  },
  widget = wibox.container.margin,
  top = dpi(17),
  bottom = dpi(0),
  left = dpi(20),
  right = dpi(12),
  forced_width = dpi(430)
}

return profile
