require "resources"
require "cardpool"

local screen = {}
local towerHeightPx = love.graphics.getHeight() - 50
local towerWidthPx = 200

function screen:onEnter()

end

function screen:onExit()

end

function screen:update(dt)

end

function screen:draw()
    love.graphics.setColor(0.5, 0.5, 0.8)
    love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())

    love.graphics.setColor(1, 1, 1)
    love.graphics.printf("Card pool size: "..PlayerResources.p1Resources.health, 0, 200, love.graphics.getWidth(), "center")

    -- Draw towers
    love.graphics.setColor(0, 0, 1)
    love.graphics.rectangle(
        "fill",
        50,
        towerHeightPx * (100 - PlayerResources.p1Resources.health) / 100,
        towerWidthPx,
        towerHeightPx * (PlayerResources.p1Resources.health) / 100
    )

    love.graphics.setColor(1, 0, 0)
    love.graphics.rectangle(
        "fill",
        love.graphics.getWidth() - 200 - 50,
        towerHeightPx * (100 - PlayerResources.p2Resources.health) / 100,
        towerWidthPx,
        towerHeightPx * (PlayerResources.p2Resources.health) / 100
    )
end

function screen:keypressed(key)
    if key == "escape" then
        Screens:setScreen("mainmenu")
    end
end

return screen
