dependencies = {}

files = {"init.lua", "config.lua", "setvar.lua", "create.lua"}

exposed = {"setvar.lua", "create.lua"}

location = "main"

function init() print("Version 1.0") end

return {
    dependencies = dependencies,
    files = files,
    exposed = exposed,
    location = location,
    init = init
}
