-- Run debugger
if arg[#arg] == "vsc_debug" and pcall(require, "lldebugger") then require("lldebugger").start() end

-- Set lua module path for the developement execution
package.path = package.path .. ";" .. love.filesystem.getWorkingDirectory() .. "/lib/penlight/lua/?.lua"