--Script used for gathering
--1.Setting own identity
--2.network connected blocks
os.loadAPI("config/config.lua")

local args = {...}
if #args ~= 1 then
    error("Usage: init <name>")
end

local turtleName = args[1]

local periphs = peripheral.getNames()

--Track the chests
local chests = {}
local chestIdx = 1
--Track the furnaces
--Not used atm
local furnaces = {}
local furnaceIdx = 1

--Dont care about index number
for _,name in pairs(periphs) do
    if string.find(name, "chest") then
        chests[chestIdx] = name
        chestIdx = chestIdx + 1
    elseif string.find(name, "furnace") then
        furnaces[furnaceIdx] = name
        furnaceIdx = furnaceIdx + 1
    end
end

--Save the determined lists
--in the storage config

config.load("storageConfig")

config.set("self", turtleName)
config.set("p_chests", chests)
config.set("p_furnaces", furnaces)

config.save()

print("Storage Searcher initalized")