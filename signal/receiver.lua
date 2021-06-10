package.path = package.path .. ";/?/init.lua"

local signal = require("signal")

print("Channel?")
local channel = read()

local modem = signal.find_modem()

if not modem then
    error("No modem found")
    return
end

rednet.open(modem)

while true do
    id, msg = rednet.receive(channel)

    print(id .. ":" .. msg)
end
