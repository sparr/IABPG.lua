#!/usr/bin/env lua

-- original game scripts
require("Data.constants")
require("Data.main")
require("Data.map")
require("Data.movement")
require("Data.undo")
require("Data.units")

local has_argparse, argparse = pcall(require,"argparse")
if has_argparse then
    local parser = argparse("IABPG.lua", "Alternate interface for It's A Block Pushing Game.")
    parser:flag("-w --wide", "Wide mode (space between puzzle tiles/blocks)", false)
    args = parser:parse()
else
    args = { wide = false }
end

-- implement compatibility with original game scripts
require("shim")

-- set up the console interface
has_curses, curses = pcall(require,"curses")
if has_curses then
    stdscr = curses.initscr()
    main_screenh, main_screenw = stdscr:getmaxyx()
    screenh, screenw = main_screenh, (args.wide and 40 or 20)
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
else
    os.execute("stty -icanon min 1 -echo")
    screenw, screenh = 40, 20
end

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
