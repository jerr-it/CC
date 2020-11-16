function load(filename)
    local file = fs.open(filename, "r")
    local fileContent = file.readAll()

    local object = textutils.unserialise(fileContent)
    file.close()

    return object
end

function save(filename, nodes)
    local file = fs.open(filename, "w")
    local content = textutils.serialise(nodes)

    file.write(content)
    file.flush()
    file.close()
end
