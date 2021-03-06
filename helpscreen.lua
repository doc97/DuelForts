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
    love.graphics.printf("Welcome to Duel Forts", 20, 20, love.graphics.getWidth() - 40, "center")
    love.graphics.setFont(Fonts["goudy-48"])
    love.graphics.printf([[
    This is a player versus player game where your goal is to grow
    your own tower high enough or destroy your opponents tower.
    Cards cost resources, and at the start of your turn you will
    draw a new hand of 5 and get two resources. You will only get
    to play one card out of a hand, so choose carefully.

    Good luck.
    ]], 20, 150, love.graphics.getWidth() - 40, "left")
    love.graphics.printf("(Enter)", 20, love.graphics.getHeight() - 80, love.graphics.getWidth() - 40, "center")
end

function screen:keypressed(key)
    if key == "return" then
        Screens:setScreen("controls")
    elseif key == "escape" then
        Screens:setScreen("mainmenu")
    end
end

return screen
