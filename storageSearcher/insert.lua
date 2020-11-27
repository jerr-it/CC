os.loadAPI("config/config.lua")
config.load("storageConfig")

local self = config.get("self")
local allChests = config.get("p_letterChestMap")

local slotCount = 16

for turtleSlotIdx = 1,slotCount,1 do
    local itemName = turtle.getItemDetail(turtleSlotIdx)
    local chests = allChests[string.sub(itemName,1,1)]

    for chestIdx = 1,#chests,1 do
        local chest = peripheral.wrap(chests[chestIdx])

        chest.pullItems(self, turtleSlotIdx, 64)
        if turtle.getItemCount(turtleSlotIdx) == 0 then
            break
        end
    end
end
