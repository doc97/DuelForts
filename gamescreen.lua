require "resources"
require "cardpool"

local screen = {}
local Fonts = Fonts

local logic = assert(love.filesystem.load("logic.lua"))()

local towerWidthPx = 200
local towerHeightPx = love.graphics.getHeight() - 50
local cardWidthPx = 200
local cardHeightPx = 300
local cardSpacePx = 25

local function getBaseXY(up)
    local hW = love.graphics.getWidth() / 2
    local hH = love.graphics.getHeight() / 2
    local x = hW
    local y = hH

    if up then
        if #logic.currentHand % 2 == 0 then
            x = hW + cardSpacePx / 2 - math.floor((#logic.currentHand - 2) / 2) * (cardWidthPx + cardSpacePx)
        else
            x = hW - cardWidthPx / 2 - math.floor((#logic.currentHand - 2) / 2) * (cardWidthPx + cardSpacePx)
        end
        y = hH - cardHeightPx - cardSpacePx
    else
        x = hW + cardSpacePx / 2 - (cardWidthPx + cardSpacePx)
        y = hH + cardSpacePx
    end

    return x, y
end

local function renderCard(base, card, x, y)
    love.graphics.setColor(0.5, 0.5, 0.5)
    if base == "build" then
        love.graphics.setColor(0.05, 0.98, 0.02) -- Green
    elseif base == "resource" then
        love.graphics.setColor(0.16, 0.25, 0.89) -- Blue
    elseif base == "destroy" then 
        love.graphics.setColor(0.91, 0.01, 0.01) -- Red
    elseif base == "special" then
        love.graphics.setColor(0.63, 0.01, 0.68) -- Purple
    elseif base == "discard" then
        love.graphics.setColor(0.40, 0.65, 0.01) -- Dark Green
    elseif base == "permanents" then
        love.graphics.setColor(0.89, 0.93, 0.17) -- Yellow
    elseif base == "shield" then
        love.graphics.setColor(0.62, 0.88, 0.19) -- Greenish Yellow
    end

    love.graphics.rectangle("fill", x, y, cardWidthPx, cardHeightPx)
    love.graphics.setColor(0, 0, 0)
    love.graphics.rectangle("line", x, y, cardWidthPx, cardHeightPx)
    love.graphics.line(x, y + cardHeightPx / 10, x + cardWidthPx, y + cardHeightPx / 10)
    love.graphics.line(x + cardHeightPx / 10, y, x + cardHeightPx / 10, y + cardHeightPx / 10)
    love.graphics.line(x, y + cardHeightPx / 2, x + cardWidthPx, y + cardHeightPx / 2)

    love.graphics.printf(card and card.name or "???", x + cardHeightPx / 10, y + cardHeightPx / 50, cardWidthPx - cardHeightPx / 10, "center")
    love.graphics.printf(card and card.cost or "?", x, y + cardHeightPx / 40, cardHeightPx / 10, "center")
    if card.qty ~= nil then
        love.graphics.printf(card and card.effectText or "??", x, y + cardHeightPx - 95, cardWidthPx, "center")
    elseif card.health ~= nil then
        love.graphics.printf(card and card.health or "????", x, y + cardHeightPx - 110, cardWidthPx, "center")
        love.graphics.printf(card and card.effectText or "?????", x, y + cardHeightPx - 95, cardWidthPx, "center")
    elseif card.tag ~= nil then 
        love.graphics.printf(card and card.effectText or "??????", x, y +cardHeightPx - 95, cardWidthPx, "center")
    end
end

local function renderCards()
    local hW = love.graphics.getWidth() / 2
    local hH = love.graphics.getHeight() / 2
    local idx = 1
    local card = nil
    
    local x, y = getBaseXY(true)
    for i = 0, #logic.currentHand - 3 do
        card = Cards[logic.currentHand[idx].base][logic.currentHand[idx].index]
        renderCard(logic.currentHand[idx].base, card, x + i * (cardWidthPx + cardSpacePx), y)
        idx = idx + 1
    end

    x, y = getBaseXY(false)
    for i = 0, 1 do
        card = Cards[logic.currentHand[idx].base][logic.currentHand[idx].index]
        renderCard(logic.currentHand[idx].base, card, x + i * (cardWidthPx + cardSpacePx), y)
        idx = idx + 1
    end
end

local function renderCurrentCardIndicator()
    local x, y = 0, 0
    if #logic.currentHand == 5 then
        if logic.currentCardIndex < 4 then
            x, y = getBaseXY(true)
            if logic.currentCardIndex == 1 then
                x = x + cardWidthPx + cardSpacePx
            elseif logic.currentCardIndex == 3 then
                x = x + 2 * (cardWidthPx + cardSpacePx)
            end
        else
            x, y = getBaseXY(false)
            if logic.currentCardIndex == 5 then
                x = x + cardWidthPx + cardSpacePx
            end
        end
    end

    if #logic.currentHand == 4 then
        if logic.currentCardIndex < 3 then
            x, y = getBaseXY(true)
            if logic.currentCardIndex == 1 then
                x = x + cardWidthPx + cardSpacePx
            end
        else
            x, y = getBaseXY(false)
            if logic.currentCardIndex == 4 then
                x = x + cardWidthPx + cardSpacePx
            end
        end
    end

    if #logic.currentHand == 3 then
        if logic.currentCardIndex < 2 then
            x, y = getBaseXY(true)
        else
            x, y = getBaseXY(false)
            if logic.currentCardIndex == 3 then
                x = x + cardWidthPx + cardSpacePx
            end
        end
    end

    love.graphics.setColor(0.5, 0.5, 0)
    love.graphics.rectangle("fill", x - 5, y - 5, cardWidthPx + 10, cardHeightPx + 10)
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


-- Card layout
-- 2  1  3
--  4   5
function screen:onEnter()
    PlayerResources.p1Resources["handsize"] = 5
    PlayerResources.p2Resources["handsize"] = 3
    logic:cardDrawPlayer1()
    logic.turn = "player1"
end

function screen:onExit()

end

function screen:update(dt)

end

function screen:draw()
    love.graphics.setFont(Fonts["black-chancery-18"])

    -- Background
    love.graphics.setColor(0.5, 0.5, 0.8)
    love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())

    -- Text status
    love.graphics.setColor(1, 1, 1)
    love.graphics.printf("Card pool size: "..PlayerResources.p1Resources.health, 0, love.graphics.getHeight() - 50, love.graphics.getWidth(), "center")
    love.graphics.printf("Turn: "..logic.turn, 0, love.graphics.getHeight() - 25, love.graphics.getWidth(), "center")
    love.graphics.printf("Index: "..logic.currentCardIndex, 0, 25, love.graphics.getWidth(), "center")

    renderTowers()
    renderCurrentCardIndicator()
    renderCards()
end

function screen:keypressed(key)
    if key == "escape" then
        Screens:setScreen("mainmenu")
    elseif key == "return" then
        logic:switchTurns()
    elseif key == "left" then
        logic:left()
    elseif key == "right" then
        logic:right()
    elseif key == "up" then
        logic:up()
    elseif key == "down" then
        logic:down()
    end
end

return screen
