Screens = {
    ["mainmenu"] = assert(love.filesystem.load("mainmenuscreen.lua"))(),
    ["game"] = assert(love.filesystem.load("gamescreen.lua"))(),
    ["gameover"] = assert(love.filesystem.load("gameoverscreen.lua"))(),
    ["help"] = assert(love.filesystem.load("helpscreen.lua"))(),
    ["controls"] = assert(love.filesystem.load("controlsscreen.lua"))()
}

CurrentScreen = nil

function Screens:setScreen(name)
    if Screens[name] and Screens[name] ~= CurrentScreen then
        CurrentScreen:onExit()
        CurrentScreen = Screens[name]
        CurrentScreen:onEnter()
    end
end
