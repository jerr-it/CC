--rednet invoked functions
function searchChest(targetName, chest)
    chest = peripheral.wrap(chest)
    items = chest.list()
    
    count = 0
    for i, item in ipairs(items) do
        itemName = item["name"]
        
        if string.find(itemName, targetName) then
            count = count + item["count"]
        end
    end
    
    return count
end

function find(targetName)
    count = 0
    count = count + searchChest(targetName, "right")
    
    count = count + searchChest(targetName, "left")
    return count
end

--others
function run()
    rednet.open("top")
    
    while true do
        senderID, msg = rednet.receive()
        
        operation = msg["operation"]
        args = msg["args"]
        
        if operation == "find" then
            targetName = args[1]
            count = find(targetName)
            rednet.send(senderID, {
                ["response"]={count}
            })
        end
    end
    
    rednet.close()
end

--Start
run()