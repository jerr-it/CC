local config = require(".config").module
config.load("storageConfig")

local self = config.get("self")
local allChests = config.get("p_letterChestMap")

local slotCount = 16

function split(s, delim)
    parts = {};
    for match in (s .. delim):gmatch("(.-)" .. delim) do
        table.insert(parts, match);
    end
    return parts;
end

-- Moves an empty chest from its current bucket to the specified one
function annexChest(understaffedBucket)
    for bucket, chests in pairs(allChests) do
        for idx, chestName in pairs(chests) do
            local chest = peripheral.wrap(chestName)

            -- If its an empty chest, annex it
            if #chest.list() == 0 then
                table.remove(chests, idx)
                table.insert(allChests[understaffedBucket], chestName)

                config.set("p_letterChestMap", allChests)
                config.save()
                return
            end
        end
    end
end

for turtleSlotIdx = 1, slotCount, 1 do
    local item = turtle.getItemDetail(turtleSlotIdx)

    if item then
        local itemName = split(item.name, ":")[2]
        local chests = allChests[string.sub(itemName, 1, 1)]

        for chestIdx = 1, #chests, 1 do
            local chest = peripheral.wrap(chests[chestIdx])

            chest.pullItems(self, turtleSlotIdx, 64)
            if turtle.getItemCount(turtleSlotIdx) == 0 then break end
        end

        -- Not all items could be inserted
        -- Bucket is full
        -- Move empty chests from other buckets to this bucket
        if turtle.getItemCount(turtleSlotIdx) >= 1 then
            annexChest(string.sub(itemName, 1, 1))
            shell.run("insert")
            return
        end
    end
end
