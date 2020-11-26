--Slot 1: Saplings
os.loadAPI("config/config.lua")

config.load("treeChopper")

--Count of blocks between the center line and the left(or right) line of trees
local sideDist = config.get("sideDist")
--Steps required to the next pair of trees
local forwDist = config.get("forwDist")
--Number of tree pairs in a lane
local rows = config.get("rows")

if sideDist == nil then
    error("Run init to setup your tree-chopper")
end

--only for readability
local slotCount = 16

--Convenience wrapper, performs turtle.forward() 'steps' times
function move(steps)
    for i = 1,steps,1 do
        turtle.forward()
    end
end

--Convenience wrapper, performs turtle.back() 'steps' times
function moveBack(steps)
    for i = 1,steps,1 do
        turtle.back()
    end
end

--Drops the contents of slots 2-16
function dropHarvested()
    for i = 2,slotCount,1 do
        turtle.select(i)
        turtle.drop()
    end
    turtle.select(1)
end

--Function for felling a tree, which is right infront of the turtle
function chopTree()
    --Prevent chopping saplings
    if turtle.compare() then
        return
    end

    turtle.dig()
    turtle.forward()

    turtle.select(2)
    local treeHeight = 0

    while turtle.compareUp() do
        turtle.digUp()
        turtle.up()
        treeHeight = treeHeight + 1
    end

    for i = 1,treeHeight,1 do
        turtle.down()
    end

    turtle.back()
    turtle.select(1)
    turtle.place()
end

--Chops both trees in a lane
function chopRow()
    turtle.turnLeft()
    move(sideDist)
    chopTree()

    turtle.turnLeft()
    turtle.turnLeft()

    move(2 * sideDist)
    chopTree()
    moveBack(sideDist)
    turtle.turnLeft()
end

--Moves the turtle to the next tree pair
function nextRow()
    move(forwDist)
end

for i = 1,rows,1 do
    chopRow()

    if i < rows then
        nextRow()
    end
end

--Return to starting location and dump harvested materials into chest
--(or any inventory, really)
moveBack(rows*forwDist)

turtle.turnLeft()
turtle.turnLeft()

dropHarvested()

turtle.turnLeft()
turtle.turnLeft()
