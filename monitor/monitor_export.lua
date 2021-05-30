local monitor = {}

-- Monitor utility module
monitor.iMonitor = nil
monitor.nativeTerm = nil

monitor.oldCursor = {}

-- Set the monitor to be used by all the other functions
-- Should be the peripheral name of the monitor
function monitor.set(monitorName) iMonitor = peripheral.wrap(monitorName) end

-- Clear function
-- Resets cursor to base position
function monitor.clear()
    iMonitor.clear()
    iMonitor.setCursorPos(1, 1)
end

-- Print function
function monitor.print(text) iMonitor.write(text) end

-- Print function with newline
function monitor.println(text)
    local _, y = iMonitor.getCursorPos()
    iMonitor.write(text)
    iMonitor.setCursorPos(1, y + 1)
end

-- Returns the size of the selected monitor
function monitor.size() return iMonitor.getSize() end

-- setCursorPos wrapper
function monitor.setCursor(x, y) iMonitor.setCursorPos(x, y) end

-- getCursorPos wrapper
function monitor.getCursor() return iMonitor.getCursorPos() end

-- Reset used colors back to standard white on black
function monitor.resetColours()
    iMonitor.setTextColour(colours.white)
    iMonitor.setBackgroundColor(colours.black)
end

-- setTextColour wrapper
function monitor.setTextColour(col) iMonitor.setTextColour(col) end

-- getTextColour wrapper
function monitor.setBackgroundColor(col) iMonitor.setBackgroundColour(col) end

-- Enables drawing on the monitor
-- Redirects the terminal output to the monitor
-- required, because monitor has no actual drawing api
-- Stores the current cursor position to be able to return to it later
function monitor.enableDrawing()
    local x, y = iMonitor.getCursorPos()
    setOldCursor(x, y)
    nativeTerm = term.redirect(iMonitor)
end

-- drawPixel wrapper
function monitor.drawPixel(x, y, c) paintutils.drawPixel(x, y, c) end

-- drawLine wrapper
function monitor.drawLine(x1, y1, x2, y2, c)
    paintutils.drawLine(x1, y1, x2, y2, c)
end

-- drawBox wrapper
function monitor.drawBox(x1, y1, x2, y2, c) paintutils.drawBox(x1, y1, x2, y2, c) end

-- drawFilledBox wrapper
function monitor.drawFilledBox(x1, y1, x2, y2, c)
    paintutils.drawFilledBox(x1, y1, x2, y2, c)
end

-- Disables drawing
-- Restores cursor position
function monitor.disableDrawing()
    iMonitor.setCursorPos(getOldCursor())
    resetColours()
    term.redirect(nativeTerm)
end

-- Convenience function for setting old cursor
function monitor.setOldCursor(x, y)
    oldCursor.x = x
    oldCursor.y = y
end

-- Convenience function for getting old cursor
function monitor.getOldCursor() return oldCursor.x, oldCursor.y end

return monitor
