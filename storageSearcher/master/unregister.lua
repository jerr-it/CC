os.loadAPI("customAPI/nodes.lua")
local args = {...}

id = args[1]

storage = nodes.load(".nodes")

storage[id] = nil

nodes.save(".nodes", storage)