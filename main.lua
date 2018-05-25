require "screens"

function love.load()
    love.window.setTitle("Duel Forts")

    CurrentScreen = Screens["mainmenu"]
    CurrentScreen:onEnter()
end

function love.update(dt)
    CurrentScreen:update(dt)
end

function love.draw()
    CurrentScreen:draw()
end

function love.quit()
    CurrentScreen:onExit()
end
