package.path = package.path .. ";/?/init.lua"

local args = {...}

if #args ~= 2 then
    print("Usage: add_user <name> <password>")
    return
end

local u_name = args[1]
local u_pwd = args[2]

local config = require("config")
config.load("shadow")

config.set(u_name, u_pwd)

config.save()
