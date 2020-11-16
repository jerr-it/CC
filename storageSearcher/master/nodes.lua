function load(filename) 
    file = fs.open(filename, "r")
    fileContent = file.readAll()
    
    object = textutils.unserialise(fileContent)
    file.close()
    
    return object
end

function save(filename, nodes)
    file = fs.open(filename, "w")
    content = textutils.serialise(nodes)
    
    file.write(content)
    file.flush()
    file.close()
end