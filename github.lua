--Script for getting resources from github
local args = {...}

if #args ~= 3 then
    print("Usage: github <user> <repo> <folder>")
    return
end

local gh_username = args[1]
local gh_repo = args[2]
local gh_folder = args[3]

local gh_url = "https://raw.githubusercontent.com/" .. gh_username .. "/" .. gh_repo .. "/main/" .. gh_folder .. "/fetch.lua"
print("Loading module from: " .. gh_url)

shell.run("mkdir " .. gh_folder)
shell.run("cd " .. gh_folder)

shell.run("delete fetch.lua")
shell.run("wget " .. gh_url .. " fetch.lua")
shell.run("fetch")
shell.run("delete fetch.lua")

shell.run("cd ..")
