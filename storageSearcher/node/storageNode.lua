--rednet invoked functions
function searchChest(targetName, chest)
    local chest = peripheral.wrap(chest)
    local items = chest.list()

    local count = 0
    for i, item in ipairs(items) do
        local itemName = item["name"]

        if string.find(itemName, targetName) then
            count = count + item["count"]
        end
    end

    return count
end

function find(targetName)
    local count = 0

    count = count + searchChest(targetName, "right")
    count = count + searchChest(targetName, "left")

    return count
end

--others
function run()
    rednet.open("top")

    while true do
        local senderID, msg = rednet.receive()

        local operation = msg["operation"]
        local args = msg["args"]

        if operation == "find" then
            local targetName = args[1]
            local count = find(targetName)

            rednet.send(senderID, {
                ["response"]={count}
            })
        end
    end

    rednet.close()
end

--Start
run()
