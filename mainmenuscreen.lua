local screen = {}
local Fonts = Fonts

MainMenuMusic = love.audio.newSource("assets/Mars.ogg", "static")
GameMusic = love.audio.newSource("assets/Jupiter.ogg", "static")

MainMenuMusic:setLooping(true)
MainMenuMusic:play()

function screen:onEnter()
end

function screen:onExit()

end

function screen:update(dt)

end

function screen:draw()
    love.graphics.setFont(Fonts["goudy-96"])
    love.graphics.setColor(255, 255, 255)
    love.graphics.printf("DUEL FORTS", 0, 100, love.graphics.getWidth(), "center")

    love.graphics.setFont(Fonts["goudy-64"])
    love.graphics.setColor(255, 255, 255)
    love.graphics.printf("Press Enter to begin", 0, 400, love.graphics.getWidth(), "center")
end

function screen:keypressed(key)
    if key == "return" then
        Screens:setScreen("help")
    elseif key == "escape" then
        love.event.quit()
    end
end

return screen
