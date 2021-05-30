dependencies = {}

files = {"init.lua", "config_export.lua", "setvar.lua", "create.lua"}

exposed = {"setvar.lua", "create.lua"}

function init() print("Version 1.0") end

return {
    dependencies = dependencies,
    files = files,
    exposed = exposed,
    init = init
}
