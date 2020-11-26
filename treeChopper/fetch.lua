dependencies = {
    "cherrysrc CC config"
}

files = {
    "chop.lua",
    "init.lua"
}

function init()
    shell.run("/config/create treeChopper")
    print("---------------------")
    print("*** 1. Switch into the treeChopper directory using 'cd treeChopper'")
    print("*** 2. Run 'init <side distance> <forward distance> <rows>' to setup your treeCopper")
    print("*** Note: Only works on default stump trees. Fat jungle trees or mutated oaks wont work.")
end
