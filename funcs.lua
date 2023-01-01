function exit_func()
    curses.endwin()
    os.exit()
end

function draw_unit(u)
    puzzle_window:mvaddch(
        u.values[YPOS]+math.floor(gdata.values[MIDY]),
        u.values[XPOS]+math.floor(gdata.values[MIDX]),
        icon_to_character[u.icon])
end

function draw_titles()
    text_window:clear()
    text_window:mvaddstr(0, 0, title_1)
    text_window:mvaddstr(1, 0, title_2)
    text_window:mvaddstr(2, 0, title_3)
    text_window:refresh()
end

function draw()
    -- clear the screen
    puzzle_window:clear()
    -- draw tiles
    for i,u in ipairs(units) do
        if u.pushtype ~= nil and u.pushtype == -2 then
            draw_unit(u)
        end
    end
    -- draw targets
    for i,u in ipairs(units) do
        if u.pushtype ~= nil and u.pushtype == -1 then
            draw_unit(u)
        end
    end
    -- draw blocks
    for i,u in ipairs(units) do
        if u.pushtype ~= nil and u.pushtype >= 0 then
            draw_unit(u)
        end
    end
    -- draw player
    for i,u in ipairs(units) do
        if u.player ~= nil and u.player then
            draw_unit(u)
        end
    end
    -- actually put it all on the screen
    puzzle_window:refresh()
end

function get_input()
    local c = puzzle_window:getch()
    if c >= 32 and c < 256 then -- printable key
        c = string.char(c)
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
        text_window:mvaddstr(screenh-1, 0, "Win!")
        text_window:getch()
        nextlevel(wintype)
        draw_titles()
        draw()
        wintype = nil
    end
end