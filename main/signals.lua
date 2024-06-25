-- Standard awesome library
-- local gears = require("gears")
local awful = require("awful")

-- Widget and layout library
-- local wibox = require("wibox")

-- Theme handling library
local beautiful = require("beautiful")

-- local round_rect = function(cr, w, h)
--     gears.shape.rounded_rect(cr, w, h, 10)
-- end

-- Custom Local Library: Common Functional Decoration
require("deco.titlebar")

-- reading
-- https://awesomewm.org/wiki/Signals

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function(c)
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- if not awesome.startup then awful.client.setslave(c) end

        if awesome.startup
            and not c.size_hints.user_position
            and not c.size_hints.program_position then
                -- Prevent clients from being unreachable after screen count changes.
                awful.placement.no_offscreen(c)
        end
end)

-- Автоматически фокусировать неотложные клиенты.
-- Когда я запускаю клиента в определенном месте, я хочу перейти к этому клиенту.
client.connect_signal("property::urgent", function(c)
        c.minimized = false
        c:jump_to()
end)

--[[--
-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)
--]]
--
client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

-- Rounded windows
-- client.connect_signal('manage', function(c)
--     c.shape = round_rect
-- end)

-- }}}
