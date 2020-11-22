os.loadAPI("apis/config.lua")
config.load(".config")
self = config.get("self")

local slotCount = 16

function insert(slot)
    local devices = peripheral.getNames()
    for _,device in pairs(devices) do
        if string.find(device, "chest") then
            local chest = peripheral.wrap(device)

            chest.pullItems(self, slot, 64)
            if turtle.getItemCount(slot) == 0 then
                return
            end
        end
    end
end

for i = 1,slotCount,1 do
    insert(i)
end
