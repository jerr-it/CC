--Dependencies
shell.run("cd ..")

shell.run("/github cherrysrc CC config")
--...

shell.run("cd storageSearcher")

--Modules own files
shell.run("delete get.lua")
shell.run("wget https://raw.githubusercontent.com/cherrysrc/CC/main/storageSearcher/get.lua get.lua")

shell.run("delete insert.lua")
shell.run("wget https://raw.githubusercontent.com/cherrysrc/CC/main/storageSearcher/insert.lua insert.lua")

--Initial actions, initializing a config file, running initialisation on Dependencies...
shell.run("/config/create storageConfig")
