require "resources"
require "cardpool"

local logic = {}

function logic:cardDrawPlayer1()
    logic.currentCardIndex = 1
    logic.currentHand = {}
    for i = 1, PlayerResources.p1Resources.handsize do
        local card = assert(Pool[ math.random( #Pool )])
        table.insert(logic.currentHand, { base = card.base, index = card.index })
    end
end

function logic:cardDrawPlayer2()
    logic.currentCardIndex = 1
    logic.currentHand = {}
    for i = 1, PlayerResources.p2Resources.handsize do
        local card = assert(Pool[ math.random( #Pool )])
        table.insert(logic.currentHand, { base = card.base, index = card.index })
    end
end

function logic:switchTurns()
    logic.turn = logic.turn == "player1" and "player2" or "player1"
    if logic.turn == "player1" then
        logic:cardDrawPlayer1()
    else
        logic:cardDrawPlayer2()
    end
end

function logic:left()
    if #logic.currentHand == 5 then
        if logic.currentCardIndex == 1 then logic.currentCardIndex = 2 end
        if logic.currentCardIndex == 3 then logic.currentCardIndex = 1 end
        if logic.currentCardIndex == 5 then logic.currentCardIndex = 4 end
    elseif #logic.currentHand == 4 then
        if logic.currentCardIndex == 1 then logic.currentCardIndex = 2 end
        if logic.currentCardIndex == 4 then logic.currentCardIndex = 3 end
    elseif #logic.currentHand == 3 then
        if logic.currentCardIndex == 3 then logic.currentCardIndex = 2 end
    end
end

function logic:right()
    if #logic.currentHand == 5 then
        if logic.currentCardIndex == 1 then logic.currentCardIndex = 3 end
        if logic.currentCardIndex == 2 then logic.currentCardIndex = 1 end
        if logic.currentCardIndex == 4 then logic.currentCardIndex = 5 end
    elseif #logic.currentHand == 4 then
        if logic.currentCardIndex == 2 then logic.currentCardIndex = 1 end
        if logic.currentCardIndex == 3 then logic.currentCardIndex = 4 end
    elseif #logic.currentHand == 3 then
        if logic.currentCardIndex == 2 then logic.currentCardIndex = 3 end
    end
end

function logic:up()
    if #logic.currentHand == 5 then
        if logic.currentCardIndex == 4 then logic.currentCardIndex = 1 end
        if logic.currentCardIndex == 5 then logic.currentCardIndex = 3 end
    elseif #logic.currentHand == 4 then
        if logic.currentCardIndex == 3 then logic.currentCardIndex = 2 end
        if logic.currentCardIndex == 4 then logic.currentCardIndex = 1 end
    elseif #logic.currentHand == 3 then
        if logic.currentCardIndex == 2 then logic.currentCardIndex = 1 end
        if logic.currentCardIndex == 3 then logic.currentCardIndex = 1 end
    end
end

function logic:down()
    if #logic.currentHand == 5 then
        if logic.currentCardIndex == 1 then logic.currentCardIndex = 5 end
        if logic.currentCardIndex == 2 then logic.currentCardIndex = 4 end
        if logic.currentCardIndex == 3 then logic.currentCardIndex = 5 end
    elseif #logic.currentHand == 4 then
        if logic.currentCardIndex == 2 then logic.currentCardIndex = 3 end
        if logic.currentCardIndex == 1 then logic.currentCardIndex = 4 end
    elseif #logic.currentHand == 3 then
        if logic.currentCardIndex == 1 then logic.currentCardIndex = 3 end
    end
end



return logic
