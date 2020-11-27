--Script for getting resources from github
local args = {...}

if #args < 3 or #args > 4 then
    print("Usage: github <user> <repo> <folder> [branch]")
    return
end

local gh_username = args[1]
local gh_repo = args[2]
local gh_folder = args[3]
local gh_branch = nil

if args[4] then
    gh_branch = args[4]
end

--Construct url for raw github content

local gh_url = nil
if gh_branch then
    gh_url = "https://raw.githubusercontent.com/" .. gh_username .. "/" .. gh_repo .. "/" .. gh_branch .. "/" .. gh_folder .. "/"
else
    gh_url = "https://raw.githubusercontent.com/" .. gh_username .. "/" .. gh_repo .. "/main/" .. gh_folder .. "/"
end

print("Loading module from: " .. gh_url .. "fetch.lua")

--Create folder for module
shell.run("mkdir " .. gh_folder)
shell.run("cd " .. gh_folder)

--Download fetch file
shell.run("wget " .. gh_url .. "fetch.lua" .. " fetch.lua")

--Load module info as api
os.loadAPI(gh_folder .. "/fetch.lua")

--Install dependencies
shell.run("cd ..")
for i = 1,#fetch.dependencies,1 do
    shell.run("/github " .. fetch.dependencies[i])
end
shell.run("cd " .. gh_folder)

--Guarantee, that were using the correct fetch here
--Without this, the fetch object would still contain dependencies, files from the last dependency in the previous loop
os.loadAPI(gh_folder .. "/fetch.lua")
--Install module files
for i = 1,#fetch.files,1 do
    shell.run("delete " .. fetch.files[i])
    shell.run("wget " .. gh_url .. fetch.files[i] .. " " .. fetch.files[i])
end

fetch.init()

--Delete fetch and return to root dir
shell.run("delete fetch.lua")
shell.run("cd ..")
