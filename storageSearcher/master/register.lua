os.loadAPI("customAPI/nodes.lua")

local args = {...}

local id = args[1]
local name = args[2]

local storage = nodes.load(".nodes")

storage[id] = name

nodes.save(".nodes", storage)
