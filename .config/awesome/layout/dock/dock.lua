local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

--Color
local color = require("layout.dock.color")

--Apps
local Item1 = require("layout.dock.apps.spotify")
local Item2 = require("layout.dock.apps.firefox")
local Item3 = require("layout.dock.apps.kitty")
local Item4 = require("layout.dock.apps.vs_code")
local Item5 = require("layout.dock.apps.osu!")
local Item6 = require("layout.dock.apps.discord")

--Directories
local home = require("layout.dock.directories.home")
local downloads = require("layout.dock.directories.downloads")
local config = require("layout.dock.directories.config")

--Widgets
local task_popup = require("layout.dock.widgets.tasklist")
local layoutbox = require("layout.dock.widgets.layout_switcher")
--local color_picker = require("layout.dock.widgets.color_picker")

--Separator line
local vertical_separator = wibox.widget {
  orientation = 'vertical',
  forced_height = dpi(2.5),
  forced_width = dpi(2.5),
  span_ratio = 0.7,
  widget = wibox.widget.separator,
  color = "#A48DE4",
  border_color = "#A48DE4",
  opacity = 1
}

--Separator
local Separator = wibox.widget.textbox("  ")
Separator.forced_height = dpi(30)

local Separator2 = wibox.widget.textbox(" ")

--Main dock
local dock = awful.popup {
  screen = s,
  opacity = 1,
  bg = "none",
  widget = wibox.container.background,
  ontop = true,
  visible = true,
  maximum_height = dpi(30),
  placement = function(c)
    awful.placement.bottom(c,
      { margins = { top = dpi(0.5), bottom = dpi(0), left = dpi(8), right = 0 } })
  end,
  shape = function(cr, width, height)
    gears.shape.rectangle(cr, width, height, 0)
  end,
  type = "desktop"
}


dock:struts {
  bottom = dpi(15)
}


dock:setup {
  {
    Separator2,
    Separator2,
    Separator2,
    Separator,
    {
      Item1,
      layout = wibox.container.place
    },
    Separator,
    {
      Item2,
      layout = wibox.container.place
    },
    Separator,
    {
      Item3,
      layout = wibox.container.place
    },
    Separator,
    {
      Item4,
      layout = wibox.container.place
    },
    Separator,
    {
      Item5,
      layout = wibox.container.place
    },
    Separator,
    {
      Item6,
      layout = wibox.container.place
    },
    Separator,
    vertical_separator,
    Separator,

    {
      home,
      layout = wibox.container.place
    },
    Separator,

    {
      downloads,
      layout = wibox.container.place
    },
    Separator,
    {
      config,
      layout = wibox.container.place,
    },
    Separator,
    vertical_separator,
    Separator,

    --{
    --  spotify,
    --  layout = wibox.container.place,
    --},
    --Separator,

    {
      task_popup,
      layout = wibox.container.place,
    },
    Separator,

    {
      layoutbox,
      layout = wibox.container.place,
    },
    Separator,
    Separator2,
    Separator2,
    layout = wibox.layout.fixed.horizontal,
  },
  widget = wibox.container.background,
  border_color = color.background_morelight,
}

return dock
