os.loadAPI("customAPI/nodes.lua")

local storage = nodes.load(".nodes")

for k,v in pairs(storage) do
    print(k,v)
end
