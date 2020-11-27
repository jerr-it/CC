os.loadAPI("config/config.lua")
config.load("storageConfig")

local self = config.get("self")
local chests = config.get("p_chests")

local slotCount = 16

function insert(slot)
    for i = 1,#chests,1 do
        local chest = peripheral.wrap(chests[i])

        chest.pullItems(self, slot, 64)
        if turtle.getItemCount(slot) == 0 then
            return
        end
    end
end

for i = 1,slotCount,1 do
    insert(i)
end
