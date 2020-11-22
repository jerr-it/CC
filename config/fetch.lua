--Dependencies

--Modules own files
shell.run("delete config.lua")
shell.run("wget https://raw.githubusercontent.com/cherrysrc/CC/main/storageSearcher/config.lua config.lua")

shell.run("delete setvar.lua")
shell.run("wget https://raw.githubusercontent.com/cherrysrc/CC/main/storageSearcher/setvar.lua setvar.lua")

shell.run("delete create.lua")
shell.run("wget https://raw.githubusercontent.com/cherrysrc/CC/main/storageSearcher/setvar.lua create.lua")
