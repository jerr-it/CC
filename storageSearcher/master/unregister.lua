os.loadAPI("customAPI/nodes.lua")
local args = {...}

local id = args[1]

local storage = nodes.load(".nodes")

storage[id] = nil

nodes.save(".nodes", storage)
