-- Script for setting a config var in the shell
local config = require(".config").module
local args = {...}

varconfig = args[1]
varname = args[2]
varvalue = args[3]

config.load(varconfig)

config.set(varname, varvalue)

config.save()
