os.loadAPI("customAPI/nodes.lua")

storage = nodes.load(".nodes")

for k,v in pairs(storage) do
    print(k,v)
end