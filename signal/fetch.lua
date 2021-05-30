dependencies = {}

files = {"init.lua", "receiver.lua", "sender.lua"}

exposed = {"receiver.lua"}

function init() print("Version 1.0") end

return {
    dependencies = dependencies,
    files = files,
    exposed = exposed,
    init = init
}
