dependencies = {}

files = {"init.lua", "receiver.lua", "sender.lua"}

exposed = {"receiver.lua"}

location = "main"

function init() print("Version 1.0") end

return {
    dependencies = dependencies,
    files = files,
    exposed = exposed,
    location = location,
    init = init
}
