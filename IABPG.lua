#!/usr/bin/env lua

-- original game scripts
require("Data.constants")
require("Data.main")
require("Data.map")
require("Data.movement")
require("Data.undo")
require("Data.units")

-- implement compatibility with original game scripts
require("shim")

-- globals for the shim functions to pass information to the game script
wintype = nil
title_1 = ""
title_2 = ""
title_3 = ""

-- set up the console interface
curses = require "curses"
stdscr = curses.initscr()
main_screenh, main_screenw = stdscr:getmaxyx()
screenh, screenw = main_screenh, 20
puzzle_window = curses.newwin(screenh, screenw, 0, 0)
text_window = curses.newwin(screenh, main_screenw-screenw, 0, screenw)
color = curses.has_colors()
if color then
    curses.start_color()
    curses.init_pair(1, curses.COLOR_BLACK, curses.COLOR_WHITE);
end

curses.cbreak()             -- disable line buffering, but still capture ctrl+c/ctrl+z
curses.echo(false)          -- don't echo user input
curses.nl(false)            -- disable return key newline translation
puzzle_window:keypad(true)  -- enable capturing arrows, F keys, numpad, etc
curses.curs_set(0)          -- hide the cursor

require("funcs")
require("tables")

init(nil, screenw, screenh)

-- play the game!
draw_titles()
while true do
    draw()
    advance_if_win()
    get_input()
end
