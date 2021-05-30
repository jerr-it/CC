local sender = {}

sender.channel = nil

function sender.init(ch, mod)
    channel = ch
    rednet.open(mod)
end

function sender.send(msg) rednet.broadcast(msg, channel) end

function sender.stop() rednet.close() end

return sender
