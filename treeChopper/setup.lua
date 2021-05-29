local config = require(".config").module
local args = {...}

if #args ~= 3 then
    error("Usage: setup <side distance> <forward distance> <rows>")
end

shell.run("/config/create treeChopper")

sideDist = tonumber(args[1])
forwDist = tonumber(args[2])
rows = tonumber(args[3])

config.load("treeChopper")

config.set("sideDist", sideDist)
config.set("forwDist", forwDist)
config.set("rows", rows)

config.save()
