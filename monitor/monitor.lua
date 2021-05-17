-- Monitor utility module
local iMonitor = nil
local nativeTerm = nil

local oldCursor = {}

-- Set the monitor to be used by all the other functions
-- Should be the peripheral name of the monitor
function set(monitorName) iMonitor = peripheral.wrap(monitorName) end

-- Clear function
-- Resets cursor to base position
function clear()
    iMonitor.clear()
    iMonitor.setCursorPos(1, 1)
end

-- Print function
function print(text) iMonitor.write(text) end

-- Print function with newline
function println(text)
    local _, y = iMonitor.getCursorPos()
    iMonitor.write(text)
    iMonitor.setCursorPos(1, y + 1)
end

-- Returns the size of the selected monitor
function size() return iMonitor.getSize() end

-- setCursorPos wrapper
function setCursor(x, y) iMonitor.setCursorPos(x, y) end

-- getCursorPos wrapper
function getCursor() return iMonitor.getCursorPos() end

-- Reset used colors back to standard white on black
function resetColours()
    iMonitor.setTextColour(colours.white)
    iMonitor.setBackgroundColor(colours.black)
end

-- setTextColour wrapper
function setTextColour(col) iMonitor.setTextColour(col) end

-- getTextColour wrapper
function setBackgroundColor(col) iMonitor.setBackgroundColour(col) end

-- Enables drawing on the monitor
-- Redirects the terminal output to the monitor
-- required, because monitor has no actual drawing api
-- Stores the current cursor position to be able to return to it later
function enableDrawing()
    local x, y = iMonitor.getCursorPos()
    setOldCursor(x, y)
    nativeTerm = term.redirect(iMonitor)
end

-- drawPixel wrapper
function drawPixel(x, y, c) paintutils.drawPixel(x, y, c) end

-- drawLine wrapper
function drawLine(x1, y1, x2, y2, c) paintutils.drawLine(x1, y1, x2, y2, c) end

-- drawBox wrapper
function drawBox(x1, y1, x2, y2, c) paintutils.drawBox(x1, y1, x2, y2, c) end

-- drawFilledBox wrapper
function drawFilledBox(x1, y1, x2, y2, c)
    paintutils.drawFilledBox(x1, y1, x2, y2, c)
end

-- Disables drawing
-- Restores cursor position
function disableDrawing()
    iMonitor.setCursorPos(getOldCursor())
    resetColours()
    term.redirect(nativeTerm)
end

-- Convenience function for setting old cursor
function setOldCursor(x, y)
    oldCursor.x = x
    oldCursor.y = y
end

-- Convenience function for getting old cursor
function getOldCursor() return oldCursor.x, oldCursor.y end
