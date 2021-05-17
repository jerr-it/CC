os.loadAPI("config/config.lua")
local args = {...}

if #args ~= 2 then
    error("Usage: get <amount> <item>")
    return
end

local spaceAvailable = false
for i = 1, 16, 1 do
    if turtle.getItemSpace(i) > 0 then
        spaceAvailable = true
        break
    end
end

if not spaceAvailable then error("Turtle inventory full!") end

-- Load the turtles own network name
-- needs to be set using setself
config.load("storageConfig")
local com = config.get("self")
if com == nil then error("Self not set! Run 'init <name>' to set identity!") end

-- All blocks connected to the network
local devices = peripheral.getNames()

-- Retrieve args
local itemName = args[2]
local itemCount = tonumber(args[1])

local totalFound = 0

local allChests = config.get("p_letterChestMap")

local chests = allChests[string.sub(itemName, 1, 1)]
local chestCount = #chests

-- Moves items from chest to turtle
-- returns the amount of items moved
-- up to 64
-- pushItems:
-- (target, source slot, amount, target slot)
function getFrom(chest, itemName, itemCount)
    itemName = string.lower(itemName)

    local n = 0

    local items = chest.list()
    for idx, _ in pairs(items) do
        local item = chest.getItemDetail(idx)
        local iName = item.name

        if string.find(iName, itemName, 10, true) then
            n = n + chest.pushItems(com, idx, itemCount - n)

            if n >= itemCount then return n end
        end
    end

    return n
end

for i = 1, chestCount, 1 do
    local chest = peripheral.wrap(chests[i])
    local n = getFrom(chest, itemName, itemCount - totalFound)
    totalFound = totalFound + n

    while n ~= 0 do
        if totalFound >= itemCount then
            print("Found all items!")
            return
        end
        -- will be placed in first slot
        n = getFrom(chest, itemName, itemCount - totalFound)
        totalFound = totalFound + n
    end

    if totalFound >= itemCount then
        print("Found all items!")
        return
    end
end

print("Found " .. totalFound .. " of " .. itemName)
