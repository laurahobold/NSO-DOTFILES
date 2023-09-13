-- module("anybox.titlebar", package.seeall)

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")

local color = require("deco.colors")
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = gears.table.join(
        awful.button({}, 1, function()
            c:emit_signal("request::activate", "titlebar", { raise = true })
            awful.mouse.client.move(c)
        end),
        awful.button({}, 3, function()
            c:emit_signal("request::activate", "titlebar", { raise = true })
            awful.mouse.client.resize(c)
        end)
    )


    local top_titlebar = awful.titlebar(c, {
        height    = 25,
        size      = 25,
        position  = "top",
        bg_normal = color.background_dark,
        fg = "#4D23CF",
        font = "DinkieBitmap 6",
        -- bg_normal = '#00001180',
        bg_focus  = color.background_lighter,
        -- bg_focus  = '#00000099',
        border_width = 1,
        border_normal = "#4D23CF",
    })
    -- buttons for the titlebar
    local buttons = gears.table.join(
        awful.button({}, 1, function()
            client.focus = c
            c:raise()
            awful.mouse.client.move(c)
        end),
        awful.button({}, 3, function()
            client.focus = c
            c:raise()
            awful.mouse.client.resize(c)
        end)
    )
    top_titlebar:setup {
        {
            -- Right
            {
                awful.titlebar.widget.stickybutton(c),
                layout = wibox.layout.fixed.horizontal()
            },
            widget = wibox.container.margin,
            top = 2,
            bottom = 2,
            right = 6,
            left = 3,
            border_width = 2,
            border_normal = "#4D23CF",
        },
        {
            -- Middle
                {
                -- Title
                    font = "DinkieBitmap 15",
                    align  = 'left',
                    widget = awful.titlebar.widget.titlewidget(c)
                },
            buttons = buttons,
            layout  = wibox.layout.flex.vertical
        },
        {
            {
                -- Left
                awful.titlebar.widget.minimizebutton(c),
                awful.titlebar.widget.maximizedbutton(c),
                awful.titlebar.widget.closebutton(c),
                spacing = 5,
                layout = wibox.layout.fixed.horizontal()
            },
            widget = wibox.container.margin,
            top = 2,
            bottom = 2,
            right = 6,
            left = 3
        },
        layout = wibox.layout.align.horizontal,
        border_width = 8,
        border_normal = "#4D23CF"
    }
end)