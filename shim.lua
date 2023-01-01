-- implements the MF_ functions and any global state expected by Data/*.lua
-- globals
units = {}
undostack = {}
ID_CURR = 0
screenw = nil
screenh = nil

mmf = {
    newObject = function(dataid)
        return {
            strings = {
                [LEVELID] = "1",
            },
            values = {
                [LEVEL] =  1,
                [SIZE]  = 1,
            },
        }
    end
}

function MF_title(t1,t2,t3)
    title_1, title_2, title_3 = t1, t2, t3
end

function MF_clear()
    return
end

function MF_win(wintype)
    _G.wintype = wintype
end

function MF_cleartargets()
    return
end

function MF_create(name)
    return
end
