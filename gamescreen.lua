require "cardpool"

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

    love.graphics.setColor(255, 255, 255)
    love.graphics.printf("Card pool size: "..Pool[#Pool].base, 0, 200, love.graphics.getWidth(), "center")
end

function screen:keypressed(key)
    if key == "escape" then
        Screens:setScreen("mainmenu")
    end
end

return screen
