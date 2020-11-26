--Dependencies
shell.run("cd ..")

shell.run("/github cherrysrc CC config")
--...

shell.run("cd treeChopper")

--Modules own files
shell.run("delete chop.lua")
shell.run("wget https://raw.githubusercontent.com/cherrysrc/CC/main/treeChopper/chop.lua chop.lua")

shell.run("delete init.lua")
shell.run("wget https://raw.githubusercontent.com/cherrysrc/CC/main/treeChopper/init.lua init.lua")

--Initial actions, initializing a config file, running initialisation on Dependencies...
shell.run("/config/create treeChopper")
print("---------------------")
print("*** 1. Switch into the treeChopper directory using 'cd treeChopper'")
print("*** 2. Run 'init <side distance> <forward distance> <rows>' to setup your treeCopper")
print("*** Note: Only works on default stump trees. Fat jungle trees or mutated oaks wont work.")
