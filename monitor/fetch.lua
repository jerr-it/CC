--Dependencies
--shell.run("cd ..")
--...
--shell.run(cd monitor)

--Modules own files
shell.run("delete monitor.lua")
shell.run("wget https://raw.githubusercontent.com/cherrysrc/CC/main/monitor/monitor.lua monitor.lua")

--Initial actions, initializing a config file, running initialisation on Dependencies...
