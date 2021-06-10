dependencies = {"cherrysrc CC config"}

files = {"add_user.lua", "login.lua"}

exposed = {"login.lua", "add_user.lua"}

function init()
    print("Version 1.0")
    shell.run("/config/create.lua shadow")
end

return {
    dependencies = dependencies,
    files = files,
    exposed = exposed,
    init = init
}
