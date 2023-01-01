-- lookup tables

input_key_directions = {
    [curses.KEY_RIGHT]  = 1,
    ['6']               = 1,
    l                   = 1,
    [curses.KEY_UP]     = 2,
    ['8']               = 2,
    k                   = 2,
    [curses.KEY_LEFT]   = 3,
    ['4']               = 3,
    h                   = 3,
    [curses.KEY_DOWN]   = 4,
    ['2']               = 4,
    j                   = 4,
    [curses.KEY_SRIGHT] = 5,
    ['3']               = 5,
    n                   = 5,
    [curses.KEY_SR]     = 6,
    ['9']               = 6,
    u                   = 6,
    [curses.KEY_SLEFT]  = 7,
    ['7']               = 7,
    y                   = 7,
    [curses.KEY_SF]     = 8,
    ['1']               = 8,
    b                   = 8,
}

icon_to_character = {
    p     = string.byte('P'), -- player
    T     = string.byte('+'), -- target
    W     = string.byte('='), -- wall
    B     = string.byte('@'), -- box
    P     = string.byte('-'), -- test
    ['!'] = string.byte('.'), -- tile
    b     = string.byte('%'), -- box_multi
}

input_key_funcs = {
    [1] = prevlevel,
    [4] = nextlevel,
    z = undo,
    r = restart,
    q = exit_func,
}
