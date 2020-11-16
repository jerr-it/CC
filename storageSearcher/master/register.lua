os.loadAPI("customAPI/nodes.lua")

local args = {...}

id = args[1]
name = args[2]

storage = nodes.load(".nodes")

storage[id] = name

nodes.save(".nodes", storage)