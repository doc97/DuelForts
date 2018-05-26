local screen = {}
local Fonts = Fonts
local Game = Game

function screen:onEnter()
end

function screen:onExit()

end

function screen:update(dt)

end

function screen:draw()
    love.graphics.setFont(Fonts["goudy-64"])
    love.graphics.setColor(255, 255, 255)
    love.graphics.printf("Winner: "..(Game.winner and Game.winner or "No winner").."\n\n\nPress any key to continue", 0, 300, love.graphics.getWidth(), "center")
end

function screen:keypressed(key)
    Screens:setScreen("mainmenu")
end

return screen
