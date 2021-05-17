term.setTextColor(colours.red)
print("Are you sure you want to sort the entire storage? [y/n]")
local answer = io.read()
if answer ~= "y" then
    term.setTextColor(colours.white)
    return
end
term.setTextColor(colours.white)

os.loadAPI("config/config.lua")

config.load("storageConfig")

local self = config.get("self")
local buckets = config.get("p_letterChestMap")

function sortChest(chestName)
    local chest = peripheral.wrap(chestName)
    local items = chest.list()
    for idx, data in pairs(items) do
        local n = chest.pushItems(self, idx, 64)
        if n == 0 then error("Turtle inventory full, cant proceed!") end
        shell.run("insert")
    end
end

for _, v in pairs(buckets) do
    for _, chestName in pairs(v) do sortChest(chestName) end
end
