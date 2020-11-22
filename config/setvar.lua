--Script for setting a config var in the shell
os.loadAPI("config.lua")
local args = {...}

varconfig = args[1]
varname = args[2]
varvalue = args[3]

config.load(varconfig)

config.set(varname, varvalue)

config.save()
