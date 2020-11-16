shell.run("delete customAPI/nodes.lua")
shell.run("wget https://raw.githubusercontent.com/cherrysrc/CC/main/storageSearcher/master/nodes.lua customAPI/nodes.lua")

shell.run("delete customAPI/screen.lua")
shell.run("wget https://raw.githubusercontent.com/cherrysrc/CC/main/storageSearcher/master/screen.lua customAPI/screen.lua")

shell.run("delete find.lua")
shell.run("wget https://raw.githubusercontent.com/cherrysrc/CC/main/storageSearcher/master/find.lua find.lua")

shell.run("delete register.lua")
shell.run("wget https://raw.githubusercontent.com/cherrysrc/CC/main/storageSearcher/master/register.lua register.lua")

shell.run("delete storage.lua")
shell.run("wget https://raw.githubusercontent.com/cherrysrc/CC/main/storageSearcher/master/storage.lua storage.lua")

shell.run("delete unregister.lua")
shell.run("wget https://raw.githubusercontent.com/cherrysrc/CC/main/storageSearcher/master/unregister.lua unregister.lua")
