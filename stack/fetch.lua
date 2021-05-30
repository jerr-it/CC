dependencies = {}

files = {"init.lua", "stack.lua"}

exposed = {}

location = "main"

function init() print("Version 1.0") end

return {
    dependencies = dependencies,
    files = files,
    exposed = exposed,
    location = location,
    init = init
}
