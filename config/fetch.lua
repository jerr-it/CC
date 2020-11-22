--Dependencies

--Modules own files
shell.run("delete config.lua")
shell.run("wget https://raw.githubusercontent.com/cherrysrc/CC/main/config/config.lua config.lua")

shell.run("delete setvar.lua")
shell.run("wget https://raw.githubusercontent.com/cherrysrc/CC/main/config/setvar.lua setvar.lua")

shell.run("delete create.lua")
shell.run("wget https://raw.githubusercontent.com/cherrysrc/CC/main/config/create.lua create.lua")
