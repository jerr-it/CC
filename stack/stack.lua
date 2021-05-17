function new() return {} end

function push(stack, item) table.insert(stack, item) end

function pop(stack) return table.remove(stack, #stack) end

function print(stack) for i = #stack, 1, -1 do print(stack[i]) end end
