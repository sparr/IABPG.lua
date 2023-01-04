function exit_func()
    if has_curses then
        curses.endwin()
    else
        os.execute("stty sane")
    end
    os.exit()
end

local units_display = {}

function draw_unit(u, invert_color)
    if has_curses then
        if color and invert_color then
            puzzle_window:attron(curses.color_pair(1))
        end
        puzzle_window:mvaddch(
            u.values[YPOS]+math.floor(gdata.values[MIDY]),
            u.values[XPOS] * (args.wide and 2 or 1) + math.floor(gdata.values[MIDX]),
            string.byte(icon_to_character[u.icon]))
        if color and invert_color then
            puzzle_window:attroff(curses.color_pair(1))
        end
    else
        units_display[u.values[YPOS]][u.values[XPOS]] = icon_to_character[u.icon]
    end
end

function draw_titles()
    if has_curses then
        text_window:clear()
        text_window:addstr(title_1 .. "\n\n")
        text_window:addstr(title_2 .. "\n\n")
        text_window:addstr(title_3)
        text_window:refresh()
    else
        print(title_1 .. "\n")
        print(title_2 .. "\n")
        print(title_3 .. "\n")

        -- reset puzzle display for non-curses mode
        if not has_curses then
            for row=-1,gdata.values[YMAP]+2 do
                units_display[row] = {}
                for col=-1,gdata.values[XMAP]+2 do
                    units_display[row][col] = " "
                end
            end
        end
    end
end

function draw()
    if has_curses then
        -- clear the screen
        puzzle_window:clear()
    end
    -- draw tiles
    for i,u in ipairs(units) do
        if u.pushtype ~= nil and u.pushtype == -2 then
            draw_unit(u)
        end
    end
    -- draw targets
    for i,u in ipairs(units) do
        if u.pushtype ~= nil and u.pushtype == -1 then
            draw_unit(u, true)
        end
    end
    -- draw blocks
    for i,u in ipairs(units) do
        if u.pushtype ~= nil and u.pushtype >= 0 then
            draw_unit(u, findtarget(u.values[XPOS], u.values[YPOS]))
        end
    end
    -- draw player
    for i,u in ipairs(units) do
        if u.player ~= nil and u.player then
            draw_unit(u, findtarget(u.values[XPOS], u.values[YPOS]))
        end
    end
    if has_curses then
        -- actually put it all on the screen
        puzzle_window:refresh()
    else
        for row=-1,gdata.values[YMAP]+2 do
            line = ""
            for col=-1,gdata.values[XMAP]+2 do
                line = line .. units_display[row][col] .. (args.wide and " " or "")
            end
            print(line)
        end
    end
end

function get_input()
    local c
    if has_curses then
        c = puzzle_window:getch()
        if c >= 32 and c < 256 then -- printable key
            c = string.char(c)
        end
    else
        -- very hacky escape sequence handling
        c = io.read(1)
        if string.byte(c)==27 then -- escape sequence
            io.read(1) -- discard the [
            c = io.read(1)
            if c<"A" or c>"Z" then
                io.read(1) -- discard the repeat count
                m = io.read(1) -- could be a modifier
                if m>="0" and m<="9" then
                    -- has a modifier key pressed
                    c = string.char(string.byte(io.read(1))+4)
                else
                    c = m
                end
            end
        end
    end
    if input_key_directions[c] then
        command(dirs[input_key_directions[c]][1], dirs[input_key_directions[c]][2], input_key_directions[c]-1)
    elseif input_key_funcs[c] then
        input_key_funcs[c]()
    end
end

function advance_if_win()
    if wintype ~= nil then
        wintype = wintype and 1 or 0
        if has_curses then
            text_window:mvaddstr(screenh-1, 0, "Win!")
            text_window:getch()
        else
            print("Win!\n")
            io.read(1)
        end
        nextlevel(wintype)
        draw_titles()
        draw()
        wintype = nil
    end
end