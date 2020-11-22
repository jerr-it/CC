--Script for getting resources from github
local args = {...}

local gh_username = args[1]
local gh_repo = args[2]
local gh_folder = args[3]

local gh_url = "https://raw.githubusercontent.com/" .. gh_username .. "/" .. gh_repo .. "/main/" .. gh_folder .. "/fetch.lua"
print("Loading module from: " .. gh_url)

shell.run("delete fetch.lua")
shell.run("wget " .. gh_url .. " fetch.lua")
shell.run("fetch")
