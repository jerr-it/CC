dependencies = {"cherrysrc CC config"}

files = {"get.lua", "insert.lua", "init.lua", "sort.lua"}

exposed = {"get.lua", "insert.lua", "sort.lua"}

function init()
    print("Version 1.0")
    print(
        "*** 1. Switch into the storageSearcher directory using 'cd storageSearcher'")
    print("*** 2. Run 'setup <name>' to setup your storageSearcher")
    print("*** PS. Works only on turtles")
    print(
        "*** PS. You can find the <name> by attaching a modem to your turtle and right clicking it")
end

return {
    dependencies = dependencies,
    files = files,
    exposed = exposed,
    init = init
}
