Screens = {
    ["mainmenu"] = assert(love.filesystem.load("mainmenuscreen.lua"))(),
    ["game"] = assert(love.filesystem.load("gamescreen.lua"))(),
    ["help"] = assert(love.filesystem.load("helpscreen.lua"))()
}

CurrentScreen = nil

function Screens:setScreen(name)
    if Screens[name] and Screens[name] ~= CurrentScreen then
        CurrentScreen:onExit()
        CurrentScreen = Screens[name]
        CurrentScreen:onEnter()
    end
end
