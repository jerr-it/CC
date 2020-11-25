os.loadAPI("config/config.lua")
local args = {...}

if #args ~= 2 then
    error("Usage: get <amount> <item>")
    return
end

--Load the turtles own network name
--needs to be set using setself
config.load("storageConfig")
local com = config.get("self")
if com == nil then
    error("Self not set! Run 'init <name>' to set identity!")
end

local chests = config.get("p_chests")
local chestCount = #chests

--All blocks connected to the network
local devices = peripheral.getNames()

--Retrieve args
local itemName = args[2]
local itemCount = tonumber(args[1])

local totalFound = 0

--Only defined for readability
local slotCount = 16

--Moves items from chest to turtle
--returns the amount of items moved
--up to 64
--pushItems:
--(target, source slot, amount, target slot)
function getFrom(chest, itemName, itemCount)
    itemName = string.lower(itemName)

    local n = 0

    local items = chest.list()
    for idx,_ in pairs(items) do
        local item = chest.getItemDetail(idx)
        local iName = string.lower(item.displayName)
        local iCount = item.count

        if string.find(iName, itemName, 1, true) then
            for tSlot = 1,slotCount,1 do
                if turtle.getItemSpace(tSlot) >= 1 then
                    n = n + chest.pushItems(com, idx, itemCount, tSlot)
                    iCount = iCount - n

                    if n >= itemCount then
                        return n
                    end

                    if iCount <= 0 then
                        break
                    end
                end
            end
        end
    end

    return n
end

for i = 1,chestCount,1 do
    local chest = peripheral.wrap(chests[i])
    local n = getFrom(chest, itemName, itemCount - totalFound)
    totalFound = totalFound + n

    while n~=0 do
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

print("Found " .. totalFound .. " of " .. itemName)
