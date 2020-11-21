--Dependencies
shell.run("/github cherrysrc CC config")

--Modules own files
shell.run("delete get.lua")
shell.run("wget https://raw.githubusercontent.com/cherrysrc/CC/main/storageSearcher/get.lua get.lua")

shell.run("delete insert.lua")
shell.run("wget https://raw.githubusercontent.com/cherrysrc/CC/main/storageSearcher/insert.lua insert.lua")

--Initial actions, initializing a config file, running initialisation on Dependencies...
shell.run("cd config")
shell.run("create storageConfig")
shell.run("cd ..")
