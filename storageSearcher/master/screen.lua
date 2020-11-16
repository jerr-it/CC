function mprint(screen, text)
    screen.write(text)
end

function mprintln(screen, text)
    screen.write(text)
    local _,y = screen.getCursorPos()
    screen.setCursorPos(1, y+1)
end

function mclear(screen)
    screen.clear()
    screen.setCursorPos(1,1)
end
