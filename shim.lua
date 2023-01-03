-- implements the MF_ functions and any global state expected by Data/*.lua
-- globals used in existing functionality
units = {}
undostack = {}
ID_CURR = 0
screenw = nil
screenh = nil

-- new globals for MF_ functions to pass state to main script
wintype = nil
title_1 = ""
title_2 = ""
title_3 = ""

-- Multimedia Fusion provides this interface for creating a new collection of data
mmf = {
    -- dataid param is provided by MF_create return value
    -- no obvious use or need for this, probably relevant to the GUI/engine
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

-- Sets the title and subtitle(s) for a level
function MF_title(t1,t2,t3)
    title_1, title_2, title_3 = t1, t2, t3
end

-- Unknown, called in clear(), possibly GUI related
function MF_clear()
    return
end

function MF_win(wintype)
    _G.wintype = wintype
end

-- Unknown, called in command() and undo(), possibly GUI related
function MF_cleartargets()
    return
end

-- Unknown, called before creating a new unit, return value passed to mmf.newObject
function MF_create(name)
    return
end
