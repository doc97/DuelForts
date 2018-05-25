require "resources"
require "cardpool"

local screen = {}
local towerWidthPx = 200
local towerHeightPx = love.graphics.getHeight() - 50
local cardWidthPx = 200
local cardHeightPx = 300
local cardSpacePx = 25
local cardHand = 3

function screen:onEnter()

end

function screen:onExit()

end

function screen:update(dt)

end

function screen:draw()
    -- Background
    love.graphics.setColor(0.5, 0.5, 0.8)
    love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())

    -- Text status
    love.graphics.setColor(1, 1, 1)
    love.graphics.printf("Card pool size: "..PlayerResources.p1Resources.health, 0, love.graphics.getHeight() - 50, love.graphics.getWidth(), "center")

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

    -- Draw cards
    love.graphics.setColor(0.5, 0.5, 0.5)

    local hW = love.graphics.getWidth() / 2
    local hH = love.graphics.getHeight() / 2
    if cardHand % 2 == 1 then
        screen:renderCard(hW - cardWidthPx / 2, love.graphics.getHeight() / 2 - cardHeightPx - cardSpacePx)

        if cardHand - 1 > 2 then
            screen:renderCard(hW - cardWidthPx / 2 - cardSpacePx - cardWidthPx, hH - cardHeightPx - cardSpacePx)
            screen:renderCard(hW + cardWidthPx / 2 + cardSpacePx, hH - cardHeightPx - cardSpacePx)
        end
    else
        screen:renderCard(hW - cardSpacePx / 2 - cardWidthPx, hH - cardHeightPx - cardSpacePx)
        screen:renderCard(hW + cardSpacePx / 2, hH / 2 - cardHeightPx - cardSpacePx)
    end

    screen:renderCard(love.graphics.getWidth() / 2 - cardSpacePx / 2 - cardWidthPx, love.graphics.getHeight() / 2 + cardSpacePx)
    screen:renderCard(love.graphics.getWidth() / 2 + cardSpacePx / 2, love.graphics.getHeight() / 2 + cardSpacePx)
end

function screen:renderCard(x, y)
    love.graphics.rectangle("fill", x, y, cardWidthPx, cardHeightPx)
end

function screen:keypressed(key)
    if key == "escape" then
        Screens:setScreen("mainmenu")
    end
end

return screen
