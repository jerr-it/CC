os.loadAPI("config.lua")
local args = {...}

varname = args[1]
varvalue = args[2]

config.load(".config")

config.set(varname, varvalue)

config.save()
