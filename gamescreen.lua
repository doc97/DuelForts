require "resources"
require "cardpool"

local screen = {}
local towerWidthPx = 200
local towerHeightPx = love.graphics.getHeight() - 50
local cardWidthPx = 200
local cardHeightPx = 300
local cardSpacePx = 25
local currentHand = nil

local function cardDrawPlayer1()
    currentHand = {}
    for i = 1, PlayerResources.p1Resources.handsize do
        local card = assert(Pool[ math.random( #Pool )])
        table.insert( currentHand, { base = card.base, index = card.index } )
    end
end

local function cardDrawPlayer2()
    currentHand = {}
    for i = 1, PlayerResources.p2Resources.handsize do
        local card = assert(Pool[ math.random( #Pool )])
        table.insert( currentHand, { base = card.base, index = card.index } )
    end
end

local function renderCard(card, x, y)
    love.graphics.setColor(0.5, 0.5, 0.5)
    love.graphics.rectangle("fill", x, y, cardWidthPx, cardHeightPx)

    love.graphics.setColor(0, 0, 0)
    love.graphics.rectangle("line", x, y, cardWidthPx, cardHeightPx)
    love.graphics.line(x, y + cardHeightPx / 10, x + cardWidthPx, y + cardHeightPx / 10)
    love.graphics.line(x + cardHeightPx / 10, y, x + cardHeightPx / 10, y + cardHeightPx / 10)
    love.graphics.line(x, y + cardHeightPx / 2, x + cardWidthPx, y + cardHeightPx / 2)

    love.graphics.printf(card and card.name or "???", x, y + cardHeightPx / 40, cardWidthPx, "center")
    love.graphics.printf(card and card.cost or "?", x, y + cardHeightPx / 40, cardHeightPx / 10, "center")
end

local function renderCards()
    local hW = love.graphics.getWidth() / 2
    local hH = love.graphics.getHeight() / 2
    local idx = 1
    local card = nil
    if #currentHand % 2 == 1 then
        card = Cards[currentHand[idx].base][currentHand[idx].index]
        renderCard(card, hW - cardWidthPx / 2, love.graphics.getHeight() / 2 - cardHeightPx - cardSpacePx)
        idx = idx + 1

        if #currentHand - 1 > 2 then
            card = Cards[currentHand[idx].base][currentHand[idx].index]
            renderCard(card, hW - cardWidthPx / 2 - cardSpacePx - cardWidthPx, hH - cardHeightPx - cardSpacePx)
            idx = idx + 1

            card = Cards[currentHand[idx].base][currentHand[idx].index]
            renderCard(card, hW + cardWidthPx / 2 + cardSpacePx, hH - cardHeightPx - cardSpacePx)
            idx = idx + 1
        end
    else
        card = Cards[currentHand[idx].base][currentHand[idx].index]
        renderCard(card, hW - cardSpacePx / 2 - cardWidthPx, hH - cardHeightPx - cardSpacePx)
        idx = idx + 1

        card = Cards[currentHand[idx].base][currentHand[idx].index]
        renderCard(card, hW + cardSpacePx / 2, hH / 2 - cardHeightPx - cardSpacePx)
        idx = idx + 1
    end

    card = Cards[currentHand[idx].base][currentHand[idx].index]
    renderCard(card, love.graphics.getWidth() / 2 - cardSpacePx / 2 - cardWidthPx, love.graphics.getHeight() / 2 + cardSpacePx)
    idx = idx + 1

    card = Cards[currentHand[idx].base][currentHand[idx].index]
    renderCard(card, love.graphics.getWidth() / 2 + cardSpacePx / 2, love.graphics.getHeight() / 2 + cardSpacePx, cardWidthPx)
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
    cardDrawPlayer1()
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
