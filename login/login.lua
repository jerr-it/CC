package.path = package.path .. ";/?/init.lua"

local config = require("config")
config.load("shadow")

function validate(name, pwd)
    local u_password = config.get(name)
    if not u_password then return false end
    return pwd == u_password
end

while true do
    print("Username:")
    local _, input_usr = pcall(read)
    print("Password:")
    local _, input_pwd = pcall(read)

    if validate(input_usr, input_pwd) then
        term.setTextColor(colours.green)
        print("Welcome " .. input_usr)
        term.setTextColor(colours.white)

        break
    end
    term.setTextColor(colours.red)
    print("Invalid credentials")
    term.setTextColor(colors.white)

    os.sleep(1)
    shell.run("clear")
end
