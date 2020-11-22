--Script for creating a new config file
local args = {...}

if #args ~= 1 then
    error("Usage: create <config name>")
end

local fp = fs.open("." .. args[1], "w")
fp.write("{}")
fp.close()
print("Created new config: " .. args[1])
