--Standard Modules
local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

--Custom Modules
local color = require("popups.color")
local bling = require("bling")

--Widgets
local Separator = wibox.widget.textbox("    ")
Separator.forced_height = dpi(50)
Separator.forced_width = dpi(150)

-------------------------------
--Media elements---------------
-------------------------------

--Album art
local art = wibox.widget {
  image = os.getenv("HOME") .. "/.config/awesome/popups/control_center/assets/music.svg",
  resize = true,
  forced_height = dpi(50),
  forced_width = dpi(150),
  widget = wibox.widget.imagebox, --channel if you want to
  halign = "center"
}

--Player name
local name_widget = wibox.widget {
  markup = 'No players',
  align = 'left',
  valign = 'bottom',
  widget = wibox.widget.textbox,
  font = "DinkieBitmap 15",
  forced_width = dpi(50),
  forced_height = dpi(20),
  halign = "center"
}

--Title
local title_widget = wibox.widget {
  markup = '<span color="' ..
      color.blueish_white .. '" font="DinkieBitmap Bold 20">' .. "Nothing Playing" .. '</span>',
  align = 'center',
  valign = 'top',
  widget = wibox.widget.textbox,
  font = "DinkieBitmap Bold 15",
  forced_width = dpi(50),
  forced_height = dpi(20),
  halign = "center",
  valign = "center",

}

--Channel name
local artist_widget = wibox.widget {
  markup = '<span color="' ..
      color.white .. '" font="DinkieBitmap 15">' .. "Unknown Artist" .. '</span>',
  align = 'center',
  valign = 'top',
  widget = wibox.widget.textbox,
  font = "DinkieBitmap 15",
  forced_width = dpi(50),
  forced_height = dpi(20),
  halign = "center",
  valign = "center",
}

-- Get Song Info
local playerctl = bling.signal.playerctl.lib()
playerctl:connect_signal("metadata",
  function(_, title, artist, album_path, album, new, player_name)
    -- Set art widget
    art:set_image(gears.surface.load_uncached(album_path))

    -- Set player name, title and artist widgets
    name_widget:set_markup_silently(player_name)
    title_widget:set_markup_silently('<span color="' ..
      color.blueish_white .. '" font="DinkieBitmap Bold 20">' .. title .. '</span>')
    artist_widget:set_markup_silently('<span color="' ..
      color.white .. '" font="DinkieBitmap Bold 15">' .. artist .. '</span>')
  end)


----------------------------
--Position Slider-----------
----------------------------

--local media_slider = wibox.widget({
--  widget = wibox.widget.slider,
--  bar_shape = function(cr, width, height)
--    gears.shape.rounded_rect(cr, width, height, 25)
--  end,
--  bar_height = dpi(15),
--  bar_color = color.white,
--  bar_active_color = color.red,
--  handle_shape = gears.shape.circle,
--  handle_color = color.red,
--  handle_width = dpi(15),
--  handle_border_width = 0,
--  handle_border_color = "#4682b8",
--  minimum = 0,
--  maximum = 100,
--  value = 0
--})



--Update position value
--local update_media_position = function()
--  awful.spawn.easy_async("playerctl position", function(stdout)
--    if stdout == "" then
--      local position = 0
--      media_slider.value = position
--    else
--      local position = tonumber(stdout)
--      media_slider.value = position
--    end
--  end)
--end

--local media_slider_position_timer = gears.timer({
--  timeout = 1,
--  call_now = true,
--  autostart = true,
--  callback = update_media_position,
--})

--local update_media_length = function()
--  awful.spawn.easy_async("timeout 0.4s playerctl -F metadata -f '{{mpris:length}}'", function(stdout)
--    if stdout == "" then
--      local position = 100
--      media_slider.maximum = position
--    else
--      local position = tonumber(stdout)
--      media_slider.maximum = position / 1000000
--    end
--  end)
--end

--local media_length_slider_timer = gears.timer({
--  timeout = 1,
--  call_now = true,
--  autostart = true,
--  callback = update_media_length,
--})

----------------------------------
-- length and position text-------
----------------------------------

--local length_text = wibox.widget {
--  markup = '<span color="' ..
--      color.blueish_white .. '" font="Ubuntu Nerd Font 11">' .. "00:00" .. '</span>',
--  align = 'center',
--  valign = 'top',
--  widget = wibox.widget.textbox,
--  font = "CaskaydiaCove Nerd Font 12",
--  forced_width = dpi(100),
--  forced_height = dpi(15),
--  halign = "right"
--}
--
--local position_text = wibox.widget {
--  markup = '<span color="' ..
--      color.blueish_white .. '" font="Ubuntu Nerd Font 11">' .. "00:00" .. '</span>',
--  align = 'center',
--  valign = 'top',
--  widget = wibox.widget.textbox,
--  font = "CaskaydiaCove Nerd Font 12",
--  forced_width = dpi(100),
--  forced_height = dpi(15),
--  halign = "left"
--}


--
--local update_length_text = function()
--  awful.spawn.easy_async("timeout 0.4s playerctl -F metadata -f '{{mpris:length}}'", function(stdout)
--    if stdout == "" then
--      local text = '00:00'
--      length_text:set_markup_silently('<span color="' ..
--        color.blueish_white .. '" font="Ubuntu Nerd Font 11">' .. text .. '</span>')
--    else
--      local length = tonumber(stdout) / 1000000
--      local minutes = math.floor(length / 60)
--      local formattedminutes = string.format("%02d", minutes)
--      local seconds = math.floor(length % 60)
--      local formattedseconds = string.format("%02d", seconds)
--
--      length_text:set_markup_silently('<span color="' ..
--        color.blueish_white ..
--        '" font="Ubuntu Nerd Font 11">' .. formattedminutes .. ':' .. formattedseconds .. '</span>')
--    end
--  end)
--end
--
--local update_length_text_timer = gears.timer({
--  timeout = 1,
--  call_now = true,
--  autostart = true,
--  callback = update_length_text,
--})

--local update_position_text = function()
--  awful.spawn.easy_async("playerctl position", function(stdout)
--    if stdout == "" then
--      local text = '00:00'
--      position_text:set_markup_silently('<span color="' ..
--        color.blueish_white .. '" font="Ubuntu Nerd Font 11">' .. text .. '</span>')
--    else
--      local length = tonumber(stdout)
--      local minutes = math.floor(length / 60)
--      local formattedminutes = string.format("%02d", minutes)
--      local seconds = math.floor(length % 60)
--      local formattedseconds = string.format("%02d", seconds)
--      position_text:set_markup_silently('<span color="' ..
--        color.blueish_white ..
--        '" font="Ubuntu Nerd Font 11">' .. formattedminutes .. ':' .. formattedseconds .. '</span>')
--    end
--  end)
--end
--
--local update_position_text_timer = gears.timer({
--  timeout = 1,
--  call_now = true,
--  autostart = true,
--  callback = update_position_text,
--})


--local media_container = {
--  {
--    media_slider,
--    widget = wibox.container.margin,
--    top = dpi(1),
--    bottom = dpi(0),
--    -- right = dpi(15),
--    -- left = dpi(5),
--    forced_width = dpi(370),
--    forced_height = dpi(20)
--  },
--  {
--    {
--      {
--        position_text,
--        widget = wibox.container.margin,
--        right = dpi(85)
--      },
--      {
--        length_text,
--        widget = wibox.container.margin,
--        left = dpi(85)
--      },
--      layout = wibox.layout.fixed.horizontal
--    },
--    widget = wibox.container.margin,
--    top = dpi(2),
--  },
--  layout = wibox.layout.fixed.vertical,
--}

---------------------------------
--Buttons------------------------
---------------------------------

--Play pause button
local button = wibox.widget {
  image = os.getenv("HOME") .. "/.config/awesome/popups/media_player/assets/pause.png",
  resize = true,
  forced_height = dpi(25),
  forced_width = dpi(25),
  widget = wibox.widget.imagebox,
  valign = "center",
  halign = "center"
}

--Play pause button functionality
local is_playing = false

button:buttons(gears.table.join(
  awful.button({}, 1, function()
    playerctl:play_pause()
    is_playing = not is_playing
    if is_playing then
      if title_widget.markup == '<span color="' .. color.blueish_white .. '" font="DinkieBitmap Bold 20">' .. "Nothing Playing" .. '</span>' then
        button:set_image(os.getenv("HOME") .. "/.config/awesome/popups/media_player/assets/pause.png")
      else
        button:set_image(os.getenv("HOME") .. "/.config/awesome/popups/media_player/assets/play.png")
      end
    else
      if title_widget.markup == '<span color="' .. color.blueish_white .. '" font="DinkieBitmap Bold 20">' .. "Nothing Playing" .. '</span>' then
        button:set_image(os.getenv("HOME") .. "/.config/awesome/popups/media_player/assets/pause.png")
      else
        button:set_image(os.getenv("HOME") .. "/.config/awesome/popups/media_player/assets/pause.png")
      end
    end
  end)
))

--Next & previous button
local next = wibox.widget {
  image = os.getenv("HOME") .. "/.config/awesome/popups/media_player/assets/next-button.png",
  resize = true,
  forced_height = dpi(25),
  forced_width = dpi(25),
  widget = wibox.widget.imagebox,
  valign = "center",
  halign = "center",
  left = dpi(5),
}

next:connect_signal("button::press", function(_, _, _, button)
  if button == 1 then
    awful.spawn.with_shell("playerctl next")
  end
end)


local previous = wibox.widget {
  image = os.getenv("HOME") .. "/.config/awesome/popups/media_player/assets/previous.png",
  resize = true,
  forced_height = dpi(25),
  forced_width = dpi(25),
  widget = wibox.widget.imagebox,
  valign = "center",
  halign = "center"
}

previous:connect_signal("button::press", function(_, _, _, button)
  if button == 1 then
    awful.spawn.with_shell("playerctl previous")
  end
end)


-- 15s backward forward
local forward = wibox.widget {
  image = os.getenv("HOME") .. "/.config/awesome/popups/media_player/assets/15sforward.png",
  resize = true,
  forced_height = dpi(25),
  forced_width = dpi(25),
  widget = wibox.widget.imagebox,
  valign = "center",
  halign = "center"
}

-- 15s backward forward
local bait = wibox.widget {
  resize = true,
  forced_height = dpi(25),
  forced_width = dpi(25),
  widget = wibox.widget.imagebox,
  valign = "center",
  halign = "center"
}

forward:connect_signal("button::press", function(_, _, _, button)
  if button == 1 then
    awful.spawn.with_shell("playerctl position 15+")
  end
end)



local backward = wibox.widget {
  image = os.getenv("HOME") .. "/.config/awesome/popups/media_player/assets/15sbackward.png",
  resize = true,
  forced_height = dpi(25),
  forced_width = dpi(25),
  widget = wibox.widget.imagebox,
  valign = "center",
  halign = "center"
}

backward:connect_signal("button::press", function(_, _, _, button)
  if button == 1 then
    awful.spawn.with_shell("playerctl position 15-")
  end
end)

-- background img
local background = wibox.widget {
  image = os.getenv("HOME") .. "/.config/awesome/popups/media_player/assets/mdplyr.png",
  resize = true,
  forced_height = dpi(307),
  forced_width = dpi(715),
  widget = wibox.widget.imagebox,
  valign = "center",
  halign = "center"
}
-----------------------------------------------
--Main Wibox-----------------------------------
-----------------------------------------------

local media = awful.popup {
  screen = s,
  widget = wibox.container.background,
  forced_height = dpi(307),
  forced_width = dpi(715),
  ontop = true,
  visible = false,
  placement = function(c)
    awful.placement.bottom_right(c,
      { margins = { top = dpi(50), bottom = dpi(30), left = dpi(8), right = dpi(8) } })
  end,
  opacity = 1,
}

media:setup { {
  {
    background,
    {
      {
        {
          bottom = dpi(-270),
          left = dpi(90),
          title_widget,
          widget = wibox.container.margin,
        },
        {
          bottom = dpi(-330),
          left = dpi(90),
          artist_widget,
          widget = wibox.container.margin,
        },
        Separator,
        Separator,
        {
          art,
          forced_height = dpi(150),
          forced_width = dpi(150),
          widget = wibox.container.margin,
          bottom = dpi(0),
          --top = dpi(120),
          left = dpi(30),
          valign = "center",
          halign = "center",
        },
        {
          {
            backward,
            widget = wibox.container.margin,
            left = dpi(320),
            top = dpi(-40),
          },
          {
            previous,
            widget = wibox.container.margin,
            top = dpi(-40),
            left = dpi(10),
          },
          {
            button,
            widget = wibox.container.margin,
            top = dpi(-40),
            left = dpi(10),
          },
          {
            next,
            widget = wibox.container.margin,
            top = dpi(-40),
            left = dpi(10),
          },
          {
            forward,
            widget = wibox.container.margin,
            top = dpi(-40),
            left = dpi(10),
          },
          {
            bait,
            widget = wibox.container.margin,
          },
          layout = wibox.layout.fixed.horizontal,
        },
        layout = wibox.layout.fixed.vertical
      },
      widget = wibox.container.margin,
    },
    layout = wibox.layout.stack
  },
  layout = wibox.layout.fixed.vertical,

},
  widget = wibox.container.background,
}

return media
