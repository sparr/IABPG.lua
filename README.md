# IABPG.lua

This project is not affiliated with IABPG or endorsed by Hempuli.

Alternative client for [IT'S A BLOCK-PUSHING GAME](https://hempuli.itch.io/its-a-block-pushing-game)'s game logic. Replaces the Multimedia Fusion GUI Windows binary with a curses-based Lua console script. Puzzle layout, logic, movement, undo, etc all use the original game scripts.

## Installing

1. clone this repo
2. Download a copy of [IABPG.zip](https://hempuli.itch.io/its-a-block-pushing-game), and unzip it in the same directory
3. (optional) `luarocks install --only-deps iabpg.lua-1.0-1.rockspec` to install curses and argparse

## Playing

The original game uses the arrow keys for moves, and multiple arrow keys for diagonal moves. This implementation uses shift+arrows for diagonals, and also supports `hjklyubn`, as well as the number pad.

As in the original, ctrl+a/d will move between levels if you want to skip ahead.

### Screenshot

```
                    IT'S A BLOCK-PUSHING GAME
                    Arrow keys to move, R to restart, Z to undo
      -------       Game by Arvi Teikari (v.1.0.3b)
      -.....-        Drums by zajo, hookhead, cbeeching & sajmund on Freesound.org
      -.---.-
      -.P@..-
      -----.-
      -....+-
      -------


```