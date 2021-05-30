dependencies = {}

files = {"init.lua", "stack.lua"}

exposed = {}

function init() print("Version 1.0") end

return {
    dependencies = dependencies,
    files = files,
    exposed = exposed,
    init = init
}
