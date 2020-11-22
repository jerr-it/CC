--Module for loading and saving configuration

local iConfig = nil
local iFilename = nil

function load(configName)
    local filename = "/." .. configName
    if not fs.exists(filename) then
        error("Config doesn't exist!")
    end

    local fp = fs.open(filename, "r")

    local fpContent = fp.readAll()

    iConfig = textutils.unserialise(fpContent)
    iFilename = filename
    fp.close()
end

function set(key, value)
    if iConfig == nil then
        error("Trying to set config value, but non is loaded!")
    end
    iConfig[key] = value
end

function get(key)
    if iConfig == nil then
        error("Trying to get config value, but non is loaded!")
    end
    return iConfig[key]
end

function save()
    if iConfig == nil then
        error("Trying to save config value, but non is loaded!")
    end

    local fp = fs.open(iFilename, "w")
    local content = textutils.serialise(iConfig)

    fp.write(content)
    fp.flush()
    fp.close()

    iConfig = nil
    iFilename = nil
end
