dependencies = {"cherrysrc CC stack", "cherrysrc CC signal"}

files = {"mine.lua"}

exposed = {"mine.lua"}

function init() print("Version 1.0") end

return {
    dependencies = dependencies,
    files = files,
    exposed = exposed,
    init = init
}
