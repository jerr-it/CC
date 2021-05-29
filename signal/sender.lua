local channel

function init(ch, mod)
    channel = ch
    rednet.open(mod)
end

function send(msg) rednet.broadcast(msg, channel) end

function stop() rednet.close() end

return {init = init, send = send, stop = stop}
