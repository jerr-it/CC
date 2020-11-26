--Script for getting resources from github
local args = {...}

if #args ~= 3 then
    print("Usage: github <user> <repo> <folder>")
    return
end

local gh_username = args[1]
local gh_repo = args[2]
local gh_folder = args[3]

--Construct url for raw github content
local gh_url = "https://raw.githubusercontent.com/" .. gh_username .. "/" .. gh_repo .. "/main/" .. gh_folder .. "/fetch.lua"
print("Loading module from: " .. gh_url)

--Create folder for module
shell.run("mkdir " .. gh_folder)
shell.run("cd " .. gh_folder)

--Download fetch file
shell.run("wget " .. gh_url .. " fetch.lua")

--Load module info as api
os.loadAPI(gh_folder .. "/fetch.lua")

--Install dependencies
for i = 1,#fetch.dependencies,1 do
    shell.run("/github " .. fetch.dependencies[i])
end

--Install module files
local fileURL = "https://raw.githubusercontent.com/" .. gh_username .. "/" .. gh_repo .. "/" .. gh_folder .. "/"
for i = 1,#fetch.files,1 do
    shell.run("delete " .. fetch.files[i])
    shell.run("wget " .. fileURL .. fetch.files[i] .. " " .. fetch.files[i])
end

fetch.init()

--Delete fetch and return to root dir
shell.run("delete fetch.lua")
shell.run("cd ..")
