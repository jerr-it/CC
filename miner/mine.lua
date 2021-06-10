package.path = package.path .. ";/?/init.lua"

local stack = require("stack")
local signal = require("signal")

print("tunnel count? ")
local tunnel_count = tonumber(read())
print("tunnel length? ")
local tunnel_len = tonumber(read())

local modem_side = signal.find_modem()

if modem_side == nil then
    print("No modem found")
    return
else
    signal.init("turtle_status_channel", modem_side)
end

local liquids = {"water", "lava"}
function is_liquid(block_data)
    for i = 1, #liquids, 1 do
        if string.find(block_data.name, liquids[i]) then return true end
    end
    return false
end

function out_of_fuel()
    local fuel_level = turtle.getFuelLevel()
    local x, y, z = gps.locate(0.1)

    if fuel_level == 0 then
        if x == nil then
            signal.send("Out of fuel at unknown location")
        else
            signal.send("Out of fuel at (" .. x .. ", " .. y .. ", " .. z .. ")")
        end
    end
end

function forward()
    turtle.forward()
    out_of_fuel()
end

function back()
    turtle.back()
    out_of_fuel()
end

function up()
    turtle.up()
    out_of_fuel()
end

function down()
    turtle.down()
    out_of_fuel()
end

-- Performs a persistent dig in the given direction
-- Returns whether or not an ore was found
function dig(dig_fn, inspect_fn)
    local prev_has_block, prev_data = false, nil
    local has_block, data = inspect_fn()

    if has_block then if is_liquid(data) then has_block = false end end

    while has_block do
        dig_fn()

        prev_has_block, prev_data = has_block, data
        has_block, data = inspect_fn()

        if has_block then if is_liquid(data) then has_block = false end end
    end

    if prev_has_block then return is_ore(prev_data) end

    return false
end

function is_ore(data) return string.find(data["name"], "ore") ~= nil end

-- Returns a map of the surrounding blocks
local order = {"front", "right", "back", "left"}
function scan_position()
    local map = {["contains_ore"] = false}

    local has_block, data = turtle.inspectUp()
    if has_block then map["top"] = is_ore(data) end

    has_block, data = turtle.inspectDown()
    if has_block then map["down"] = is_ore(data) end

    for i = 1, 4, 1 do
        has_block, data = turtle.inspect()
        if has_block then map[order[i]] = is_ore(data) end
        turtle.turnRight()
    end

    map.contains_ore =
        map.front or map.back or map.left or map.right or map.top or map.down

    return map
end

function move_back_turn_left()
    back()
    turtle.turnLeft()
end

function move_back_turn_right()
    back()
    turtle.turnRight()
end

function move_back_turn_twice()
    back()
    turtle.turnRight()
    turtle.turnRight()
end

-- Digs one step of the tunnel
function dig_step()
    local scan = scan_position()
    local move_stack = stack.new()

    while true do
        if scan.contains_ore then
            continue = false

            if scan.front then
                dig(turtle.dig, turtle.inspect)
                forward()

                scan.front = false
                scan.contains_ore = scan.front or scan.back or scan.left or
                                        scan.right or scan.top or scan.down

                stack.push(move_stack, {["action"] = back, ["scan"] = scan})
                continue = true
            end

            if not continue and scan.top then
                dig(turtle.digUp, turtle.inspectUp)
                up()

                scan.top = false
                scan.contains_ore = scan.front or scan.back or scan.left or
                                        scan.right or scan.top or scan.down

                stack.push(move_stack, {["action"] = down, ["scan"] = scan})
                continue = true
            end

            if not continue and scan.down then
                turtle.digDown()
                down()

                scan.down = false
                scan.contains_ore = scan.front or scan.back or scan.left or
                                        scan.right or scan.top or scan.down

                stack.push(move_stack, {["action"] = up, ["scan"] = scan})
                continue = true
            end

            if not continue and scan.right then
                turtle.turnRight()
                dig(turtle.dig, turtle.inspect)
                forward()

                scan.right = false
                scan.contains_ore = scan.front or scan.back or scan.left or
                                        scan.right or scan.top or scan.down

                stack.push(move_stack,
                           {["action"] = move_back_turn_left, ["scan"] = scan})
                continue = true
            end

            if not continue and scan.left then
                turtle.turnLeft()
                dig(turtle.dig, turtle.inspect)
                forward()

                scan.left = false
                scan.contains_ore = scan.front or scan.back or scan.left or
                                        scan.right or scan.top or scan.down

                stack.push(move_stack,
                           {["action"] = move_back_turn_right, ["scan"] = scan})
                continue = true
            end

            if not continue and scan.back then
                turtle.turnLeft()
                turtle.turnLeft()
                dig(turtle.dig, turtle.inspect)
                forward()

                scan.back = false
                scan.contains_ore = scan.front or scan.back or scan.left or
                                        scan.right or scan.top or scan.down

                stack.push(move_stack,
                           {["action"] = move_back_turn_twice, ["scan"] = scan})
                continue = true
            end

            scan = scan_position()
        else
            local previous = stack.pop(move_stack)
            if previous == nil then break end

            previous.action()

            scan = previous.scan
        end
    end

    dig(turtle.dig, turtle.inspect)
    forward()
end

-- Digs a side tunnel, perpendicular to the main tunnel
function dig_tunnel()
    for i = 1, tunnel_len, 1 do dig_step() end

    dig(turtle.digDown, turtle.inspectDown)
    turtle.down()
    turtle.turnLeft()
    turtle.turnLeft()

    for i = 1, tunnel_len, 1 do dig_step() end

    turtle.up()
    turtle.turnLeft()
    turtle.turnLeft()
end

-- Returns true if the last slot of the turtle contains atleast one item
function is_full() return turtle.getItemCount(16) > 0 end

-- Places a chest and dumps all items into it
function dump_items(progress)
    for i = 1, progress * 3, 1 do back() end

    for i = 1, 16, 1 do
        turtle.select(i)
        turtle.dropDown()
    end

    turtle.select(1)

    for i = 1, progress * 3, 1 do forward() end
end

for i = 1, tunnel_count, 1 do
    dig_step()
    dig(turtle.digDown, turtle.inspectDown)

    dig_step()
    dig(turtle.digDown, turtle.inspectDown)

    dig_step()
    dig(turtle.digDown, turtle.inspectDown)

    turtle.turnRight()
    dig_tunnel()
    turtle.turnLeft()
    turtle.turnLeft()
    dig_tunnel()
    turtle.turnRight()

    if is_full() then dump_items(i) end
end

for i = 1, tunnel_count * 3, 1 do back() end

signal.stop()
