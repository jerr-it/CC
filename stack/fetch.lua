dependencies = {}

files = {"init.lua", "stack_export.lua"}

exposed = {}

function init() print("Version 1.0") end

return {
    dependencies = dependencies,
    files = files,
    exposed = exposed,
    init = init
}
