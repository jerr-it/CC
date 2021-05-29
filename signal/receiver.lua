print("Channel?")
local channel = read()

print("Modem?")
local modem = read()

rednet.open(modem)

while true do
    id, msg = rednet.receive(channel)

    print(id .. ":" .. msg)
end
