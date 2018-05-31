local screen = {}
local Fonts = Fonts

function screen:onEnter()
end

function screen:onExit()

end

function screen:update(dt)

end

function screen:draw()
    love.graphics.setColor(255, 255, 255)
    love.graphics.setFont(Fonts["goudy-64"])
    love.graphics.printf("Controls\n", 20, 20, love.graphics.getWidth() - 40, "center")

    love.graphics.setFont(Fonts["goudy-48"])
    love.graphics.printf([[
    Left/Right/Up/Down
    Enter
    Space
    Escape
    ]], 50, 150, love.graphics.getWidth() / 2 - 100, "left")
    love.graphics.printf([[
    Choose card
    Play card
    Skip turn
    Exit to main menu
    ]], love.graphics.getWidth() / 2 + 50, 150, love.graphics.getWidth() / 2 - 100, "left")

    love.graphics.printf("(Enter)", 20, love.graphics.getHeight() - 80, love.graphics.getWidth() - 40, "center")
end

function screen:keypressed(key)
    if key == "return" then
        Screens:setScreen("game")
    elseif key == "escape" then
        Screens:setScreen("mainmenu")
    end
end

return screen
