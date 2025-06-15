--[[
    Shared locked objects (Mod for MineTest)
    Allows to restrict usage of blocks to a certain player or a group of
    players.
    Copyright (C) 2013 Sokomine

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
--]]

-- Version 2.10

-- Changelog:
-- 30.07.2018 * Merged PR from adrido from 25.02.2016: Added new Locks config Formspec.
-- 30.07.2018 * Removed deprecated minetest.env usage.
-- 30.07.2018 * Front side of chest does not get pipeworks image anymore.
--              Instead it always shows the locks texture as overlay.
-- 30.07.2018 * Fixed bug with pipeworks.
--            * Repaired password.
--            * Converted back to unix file format.
-- 08.05.2014 * Changed animation of shared locked furnace (removed pipeworks overlay on front, changed to new animation type)
-- 10.01.2013 * Added command to toggle for pipeworks output
--            * Added pipeworks support for chests and furnace.
-- 17.12.2013 * aborting input with ESC is possible again
-- 01.09.2013 * fixed bug in input sanitization
-- 31.08.2013 * changed receipe for key to avoid crafting conflickt with screwdriver
-- 10.07.2013 * removed a potential bug (now uses string:gmatch)
--            * added shared locked furnaces



locks = {};

minetest.register_privilege("openlocks", { description = "allows to open/use all locked objects", give_to_singleplayer = false});
minetest.register_privilege("diglocks",  { description = "allows to open/use and dig up all locked objects", give_to_singleplayer = false});


dofile(minetest.get_modpath("locks").."/src/locks_framework.lua");
dofile(minetest.get_modpath("locks").."/src/locks_craft.lua");

dofile(minetest.get_modpath("locks").."/src/shared_locked_chest.lua");
dofile(minetest.get_modpath("locks").."/src/shared_locked_sign_wall.lua");
dofile(minetest.get_modpath("locks").."/src/shared_locked_xdoors2.lua");
dofile(minetest.get_modpath("locks").."/src/shared_locked_furnace.lua");
