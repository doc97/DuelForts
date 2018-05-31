Fonts = {}
Game = {}

require "screens"

function love.load()
    math.randomseed(os.time())
    math.random() math.random() math.random()

    Fonts["default"] = love.graphics.getFont()
    Fonts["black-chancery-18"] = love.graphics.newFont("assets/black-chancery.ttf", 18)
    Fonts["black-chancery-24"] = love.graphics.newFont("assets/black-chancery.ttf", 24)
    Fonts["black-chancery-32"] = love.graphics.newFont("assets/black-chancery.ttf", 32)
    Fonts["black-chancery-48"] = love.graphics.newFont("assets/black-chancery.ttf", 48)
    Fonts["goudy-24"] = love.graphics.newFont("assets/goudy.ttf", 24)
    Fonts["goudy-48"] = love.graphics.newFont("assets/goudy.ttf", 48)
    Fonts["goudy-64"] = love.graphics.newFont("assets/goudy.ttf", 64)
    Fonts["goudy-96"] = love.graphics.newFont("assets/goudy.ttf", 96)
    Fonts["herne-18"] = love.graphics.newFont("assets/Herne-Regular.otf", 18)

    love.window.setTitle("Duel Forts")
    love.window.setMode(0, 0, { fullscreen = true, borderless = true })

    CurrentScreen = Screens["mainmenu"]
    CurrentScreen:onEnter()
end

function love.update(dt)
    CurrentScreen:update(dt)
end

function love.draw()
    CurrentScreen:draw()
end

function love.keypressed(key)
    CurrentScreen:keypressed(key)
end

function love.quit()
    CurrentScreen:onExit()
end
