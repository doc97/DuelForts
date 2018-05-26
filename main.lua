Fonts = {}
Game = {}

require "screens"

function love.load()
    math.randomseed(os.time())
    math.random() math.random() math.random()

    Fonts["black-chancery-18"] = love.graphics.newFont("assets/black-chancery.ttf", 18)
    Fonts["goudy-64"] = love.graphics.newFont("assets/goudy.ttf", 64)

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
