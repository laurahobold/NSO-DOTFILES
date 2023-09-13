-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

-- Custom Local Library: Common Functional Decoration
local deco = {
  wallpaper = require("deco.wallpaper"),
  taglist = require("deco.taglist"),
  tasklist = require("deco.tasklist"),
}

local taglist_buttons = deco.taglist()
local tasklist_buttons = deco.tasklist()
local color = require("layout.topbar.colors")
local _M = {}

--Spacer
local separator = wibox.widget.textbox(" ")
local dockborder = wibox.widget.textbox("                                                                                 ")

local calendar_widget = require("deco.calendar")

--Separator line
local vertical_separator = wibox.widget {
  orientation = 'vertical',
  forced_height = dpi(2.5),
  forced_width = dpi(2),
  span_ratio = 0.7,
  widget = wibox.widget.separator,
  color = "#A48DE4",
  border_width = 5,
  opacity = 1
}

---------------------------
--Widgets------------------
---------------------------

--textclock widget
mytextclock = wibox.widget.textclock(
  '<span color="#4D23CF" font="DinkieBitmap 12"> %a %b %d, %H:%M </span>', 10)


--calendar-widget
local cw = calendar_widget({
  theme = "nord",
  placement = "right",
  start_sunday = true,
  radius = 8,
  previous_month_button = 1,
  padding = 5,
  next_month_button = 3,
})
mytextclock:connect_signal("button::press", function(_, _, _, button)
  if button == 1 then
    cw.toggle()
  end
end)


--Fancy taglist widget
awful.screen.connect_for_each_screen(function(s)
  local fancy_taglist = require("fancy_taglist")
  mytaglist = fancy_taglist.new({
    screen   = s,
    taglist  = { buttons = taglist_buttons },
    tasklist = { buttons = tasklist_buttons },
    filter   = awful.widget.taglist.filter.all,
    opacity = 1,
    shape = function(cr, width, height)
      -- gears.shape.rounded_rect(cr, width, height, 8)
      gears.shape.rounded_rect(cr, width, height, 8)
    end,
  })
end)

--Taglist widget
local fancy_taglist = wibox.widget {
  {
    mytaglist,
    widget = wibox.container.background,
    shape  = gears.shape.rounded_rect,
    bg     = color.background_lighter
  },
  left   = dpi(2),
  right  = dpi(2),
  top    = dpi(2),
  bottom = dpi(2),
  widget = wibox.container.margin,
}

local awesome_logo = require("layout.topbar.awesome_logo")
local power_button = require("layout.topbar.power_button")
local top_left = require("layout.topbar.top_left")
local systray = require("layout.topbar.systray")

-------------------------------------------
-- the wibar
-------------------------------------------

mywibox =
    awful.wibar({
      position = "bottom",
      -- margins = { top = dpi(7), left = dpi(8), right = dpi(8), bottom = 0 },
      margins = { top = dpi(0), left = dpi(0), right = dpi(0), bottom = 0 },
      screen = s,
      height = dpi(30),

      opacity = 1,
      fg = color.white,
      bg = "#f7e0fb",
      shape = function(cr, width, height)
        -- gears.shape.rounded_rect(cr, width, height, 8)
        gears.shape.rounded_rect(cr, width, height, 0)
      end,

    })

--Main Wibar
mywibox:setup({
  layout = wibox.layout.stack,
  expand = "none",
  {
    layout = wibox.layout.align.horizontal,
    {
      dockborder,
      -- Left widgets
      layout = wibox.layout.fixed.horizontal,
      separator,
      awesome_logo,
      separator,
      vertical_separator,
      separator,
      fancy_taglist,
      separator,
    },
    nil,
    {
      -- Right widgets
      layout = wibox.layout.fixed.horizontal,
      systray,
      top_left,
      vertical_separator,
      separator,
      {
        mytextclock,
        valign = "center",
        halign = "right",
        layout = wibox.container.place
      },
      vertical_separator,
      power_button,
      dockborder
    },
  },

})

return mywibox
