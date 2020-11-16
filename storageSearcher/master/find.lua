monitor = peripheral.find("monitor")
--load custom library for monitors
os.loadAPI("customAPI/screen.lua")
os.loadAPI("customAPI/nodes.lua")

local args = {...}
local msgObj = {
    ["operation"]="find",
    ["args"]={args[1]}
}

local storage = nodes.load(".nodes")

function run()
    rednet.open("top")

    screen.mclear(monitor)
    --ask every node if it has this item
    for id,name in pairs(storage) do
        rednet.send(tonumber(id), msgObj)
        --1 second timeout
        local _,answer = rednet.receive(10)
        local count = answer["response"][1]
        screen.mprintln(monitor, name .. " has " .. count .. " of " .. args[1])
    end

    rednet.close()
end

--start
run()
