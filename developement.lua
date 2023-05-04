-- Run debugger
if arg[#arg] == "vsc_debug" and pcall(require, "lldebugger") then require("lldebugger").start() end

-- Set lua module path for the developement execution
-- normal modules
package.path = package.path .. ";" .. love.filesystem.getWorkingDirectory() .. "/lib/?.lua"

-- Penlight
package.path = package.path .. ";" .. love.filesystem.getWorkingDirectory() .. "/lib/penlight/lua/?.lua"

-- Windfield
package.path = package.path .. ";" .. love.filesystem.getWorkingDirectory() .. "/lib/windfield/?/init.lua"
package.path = package.path .. ";" .. love.filesystem.getWorkingDirectory() .. "/lib/windfield/?.lua"
