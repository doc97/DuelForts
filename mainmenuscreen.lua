local screen = {}

function screen:onEnter()

end

function screen:onExit()

end

function screen:update(dt)

end

function screen:draw()
    love.graphics.setColor(255, 255, 255)
    love.graphics.printf("Press Enter to start", 0, 300, love.graphics.getWidth(), "center")
end

function screen:keypressed(key)
    if key == "return" then
        Screens:setScreen("game")
    elseif key == "escape" then
        love.event.quit()
    end
end

return screen
