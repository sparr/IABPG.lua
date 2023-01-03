package = "IABPG.lua"
version = "1.0-1"

source = {
  url = "https://github.com/sparr/IABPG.lua/archive/refs/heads/main.zip",
}

description = {
  summary = "Alternate interface for It's A Block Pushing Game",
  detailed = [[
    Replaces the Windows binary for the game.
    Still uses the original game levels, mechanics, etc scripts.
    Get original game from https://hempuli.itch.io/its-a-block-pushing-game
  ]],
  license = "MIT",
  homepage = "https://github.com/sparr/IABPG.lua",
  maintainer = "sparr0@gmail.com"
}

build = {
  install = {
    bin = {
      "IABPG.lua",
      "funcs.lua",
      "shim.lua",
      "tables.lua",
      "Data/constants.lua",
      "Data/main.lua",
      "Data/map.lua",
      "Data/movement.lua",
      "Data/undo.lua",
      "Data/units.lua",
    }
  },
  type = "none"
}

dependencies = {
   "lua >= 5.1",
   "lcurses",
}