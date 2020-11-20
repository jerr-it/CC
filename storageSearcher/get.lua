os.loadAPI("customAPI/config.lua")
local args = {...}

if #args < 2 then
    error("Usage: get <amount> <item>")
    return
end

--Load the turtles own network name
--needs to be set using setself
config.load(".config")
local com = config.get("self")

--Moves items from chest to turtle
--returns the amount of items moved
--up to 64
--pushItems:
--(target, source slot, amount, target slot)
function getFrom(chest, itemName, itemCount) 
    local items = chest.list()
    for idx,data in pairs(items) do
        local name = data["name"]
        if string.find(name, itemName) then
            local n = chest.pushItems(com, idx, itemCount, 1)
            return n
        end
    end
    return 0
end

--Select the turtles first free slot
--Only defined for readability
local slotCount = 16
local stackSize = 64
function getFreeSlot()
    for i = 2,slotCount,1 do
        currentCount = turtle.getItemCount(i)
        if currentCount == 0 then
            return i
        end
    end
    --No free slot
    error("No free slots found!")
    return -1
end

--All blocks connected to the network
local devices = peripheral.getNames()

--Retrieve args
local itemName = args[2]
local itemCount = tonumber(args[1])

local totalFound = 0
local targetSlot = getFreeSlot()

--check all network devices
for _,device in pairs(devices) do
    --ignore non-chests
    if string.find(device, "chest") then
        local chest = peripheral.wrap(device)
        local n = getFrom(chest, itemName, itemCount - totalFound)
        totalFound = totalFound + n
        
        while n~=0 do
            turtle.transferTo(targetSlot)
            if turtle.getItemCount(targetSlot) >= stackSize then
                targetSlot = getFreeSlot()
            end
            
            if totalFound >= itemCount then
                print("Found all items!")
                return
            end
            --will be placed in first slot
            n = getFrom(chest, itemName, itemCount - totalFound)
            totalFound = totalFound + n
        end
        
        if totalFound >= itemCount then
            print("Found all items!")
            return
        end
    end
end

print("Found " .. totalFound .. " of " .. itemName)