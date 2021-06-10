local sender = {}

sender.channel = nil

function sender.init(ch, mod)
    channel = ch
    rednet.open(mod)
end

function sender.find_modem()
    for _, side in ipairs(rs.getSides()) do
        if peripheral.getType(side) == "modem" and
            peripheral.call(side, "isWireless") then return side end
    end
    return nil
end

function sender.send(msg) rednet.broadcast(msg, channel) end

function sender.stop() rednet.close() end

return sender
