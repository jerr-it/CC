local stack = {}

function stack.new() return {} end

function stack.push(stack, item) table.insert(stack, item) end

function stack.pop(stack) return table.remove(stack, #stack) end

return stack
