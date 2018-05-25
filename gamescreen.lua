local screen = {}

function screen:onEnter()

end

function screen:onExit()

end

function screen:update(dt)

end

function screen:draw()
    love.graphics.setColor(0, 0, 255)
    love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
end

function screen:keypressed(key)
    if key == "escape" then
        Screens:setScreen("mainmenu")
    end
end

return screen
