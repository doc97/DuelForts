require "resources"
require "cardpool"

local screen = {}
local towerWidthPx = 200
local towerHeightPx = love.graphics.getHeight() - 50
local cardWidthPx = 200
local cardHeightPx = 300
local cardSpacePx = 25

local function cardDrawPlayer1()
    p1Hand = {}
    for i = 1, PlayerResources.p1Resources.handsize do
        local card = Pool[ math.random( #Pool )]
        table.insert( p1Hand, { base = card.base, index = card.index } )
    end
end

local function cardDrawPlayer2()
    p2Hand = {}
    for i = 1, PlayerResources.p1Resources.handsize do
        local card = Pool[ math.random( #Pool )]
        table.insert( p2Hand, { base = card.base, index = card.index } )
    end
end

function screen:onEnter()

end

local function renderCard(card, x, y)
    love.graphics.setColor(0.5, 0.5, 0.5)
    love.graphics.rectangle("fill", x, y, cardWidthPx, cardHeightPx)

    love.graphics.setColor(0, 0, 0)
    love.graphics.rectangle("line", x, y, cardWidthPx, cardHeightPx)
    love.graphics.line(x, y + cardHeightPx / 10, x + cardWidthPx, y + cardHeightPx / 10)
    love.graphics.line(x, y + cardHeightPx / 2, x + cardWidthPx, y + cardHeightPx / 2)

    love.graphics.printf(card.name, x, y + cardHeightPx / 50, cardWidthPx, "center")
end

local function renderCards()
    local hand = {
        { name="Card #1" },
        { name="Card #2" },
        { name="Card #3" },
        { name="Card #4" },
        { name="Card #5" }
    }
    local hW = love.graphics.getWidth() / 2
    local hH = love.graphics.getHeight() / 2
    local idx = 1
    if cardHand % 2 == 1 then
        renderCard(hand[idx], hW - cardWidthPx / 2, love.graphics.getHeight() / 2 - cardHeightPx - cardSpacePx)
        idx = idx + 1

        if cardHand - 1 > 2 then
            renderCard(hand[idx], hW - cardWidthPx / 2 - cardSpacePx - cardWidthPx, hH - cardHeightPx - cardSpacePx)
            renderCard(hand[idx + 1], hW + cardWidthPx / 2 + cardSpacePx, hH - cardHeightPx - cardSpacePx)
            idx = idx + 2
        end
    else
        renderCard(hand[idx], hW - cardSpacePx / 2 - cardWidthPx, hH - cardHeightPx - cardSpacePx)
        renderCard(hand[idx + 1], hW + cardSpacePx / 2, hH / 2 - cardHeightPx - cardSpacePx)
        idx = idx + 2
    end

    renderCard(hand[idx], love.graphics.getWidth() / 2 - cardSpacePx / 2 - cardWidthPx, love.graphics.getHeight() / 2 + cardSpacePx)
    renderCard(hand[idx + 1], love.graphics.getWidth() / 2 + cardSpacePx / 2, love.graphics.getHeight() / 2 + cardSpacePx, cardWidthPx)
end

local function renderTowers()
    love.graphics.setColor(0, 0, 1)
    love.graphics.rectangle(
        "fill",
        50,
        love.graphics.getHeight() - towerHeightPx * PlayerResources.p1Resources.health / 100 - 25,
        towerWidthPx,
        towerHeightPx * PlayerResources.p1Resources.health / 100
    )

    love.graphics.setColor(1, 0, 0)
    love.graphics.rectangle(
        "fill",
        love.graphics.getWidth() - 200 - 50,
        love.graphics.getHeight() - towerHeightPx * PlayerResources.p1Resources.health / 100 - 25,
        towerWidthPx,
        towerHeightPx * (PlayerResources.p2Resources.health) / 100
    )
end

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

    renderTowers()
    renderCards()
end

function screen:keypressed(key)
    if key == "escape" then
        Screens:setScreen("mainmenu")
    end
end


return screen
