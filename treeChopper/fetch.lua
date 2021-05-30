dependencies = {"cherrysrc CC config"}

files = {"chop.lua", "init.lua"}

exposed = {"chop.lua"}

location = "turtle"

function init()
    print("Version 1.0")
    print("*** 1. Switch into the treeChopper directory using 'cd treeChopper'")
    print(
        "*** 2. Run 'setup <side distance> <forward distance> <rows>' to setup your treeCopper")
    print(
        "*** Note: Only works on default stump trees. Fat jungle trees or mutated oaks wont work.")
end

return {
    dependencies = dependencies,
    files = files,
    exposed = exposed,
    location = location,
    init = init
}
