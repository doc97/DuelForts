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

local function renderCard(x, y)
    love.graphics.rectangle("fill", x, y, cardWidthPx, cardHeightPx)
end

local function renderCards()
    love.graphics.setColor(0.5, 0.5, 0.5)

    local hW = love.graphics.getWidth() / 2
    local hH = love.graphics.getHeight() / 2
    if cardHand % 2 == 1 then
        renderCard(hW - cardWidthPx / 2, love.graphics.getHeight() / 2 - cardHeightPx - cardSpacePx)

        if cardHand - 1 > 2 then
            renderCard(hW - cardWidthPx / 2 - cardSpacePx - cardWidthPx, hH - cardHeightPx - cardSpacePx)
            renderCard(hW + cardWidthPx / 2 + cardSpacePx, hH - cardHeightPx - cardSpacePx)
        end
    else
        renderCard(hW - cardSpacePx / 2 - cardWidthPx, hH - cardHeightPx - cardSpacePx)
        renderCard(hW + cardSpacePx / 2, hH / 2 - cardHeightPx - cardSpacePx)
    end

    renderCard(love.graphics.getWidth() / 2 - cardSpacePx / 2 - cardWidthPx, love.graphics.getHeight() / 2 + cardSpacePx)
    renderCard(love.graphics.getWidth() / 2 + cardSpacePx / 2, love.graphics.getHeight() / 2 + cardSpacePx)
end

local function renderTowers()
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
