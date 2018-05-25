require "screens"

function love.load()
    love.window.setTitle("Duel Forts")
    love.window.setMode(0, 0, { fullscreen = true, borderless = true })
    math.randomseed(os.time())
    math.random() math.random() math.random()
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
