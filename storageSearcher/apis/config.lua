--Module for loading and saving configuration

local iConfig = nil
local iFilename = nil

function load(filename)
    local fp = fs.open(filename, "r")
    if fp == nil then
        iConfig = {}
        iFilename = filename
        return
    end
    
    local fpContent = fp.readAll()
    
    iConfig = textutils.unserialise(fpContent)
    iFilename = filename
    fp.close()   
end

function set(key, value)
    iConfig[key] = value
end

function get(key)
    return iConfig[key]
end

function save()
    local fp = fs.open(iFilename, "w")
    local content = textutils.serialise(iConfig)

    fp.write(content)
    fp.flush()
    fp.close()    
end