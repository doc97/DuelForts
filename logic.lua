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
    if logic.turn == "player1" then
        logic.turn = "player2"
        logic:cardDrawPlayer2()
        logic:modResource(logic.turn, "money", 2)
    else
        logic.turn = "player1"
        logic:cardDrawPlayer1()
        logic:modResource(logic.turn, "money", 2)
    end
end

function logic:modResource(target, res, qty)
    if target == "player1" then
        local value = PlayerResources.p1Resources[res]
        PlayerResources.p1Resources[res] = value + qty
    else
        local value = PlayerResources.p2Resources[res]
        PlayerResources.p2Resources[res] = value + qty
    end
end

function logic:setResource(target, res, qty)
    if target == "player1" then
        PlayerResources.p1Resources[res] = qty
    else
        PlayerResources.p2Resources[res] = qty
    end
end

function logic:getResource(target, res)
    if target == "player1" then
        return PlayerResources.p1Resources[res]
    else
        return PlayerResources.p2Resources[res]
    end
end

function logic:activateCard(base, card)
    if base == "special" then
    elseif base == "permanents" then
    elseif base == "destroy"  then
        if logic.turn == "player1" then logic:destroy("player2", math.abs(card.qty))
        elseif logic.turn == "player2" then logic:destroy("player1", math.abs(card.qty)) end
    elseif base == "discard" then
        --[[ if card.name == "Armageddon" then ]] -- Destroy all permanents
        if card.name == "Pox" then   -- multiply by 2/3 then ceil and add hand size destruction
            local varHealth = PlayerResources.p1Resources.health - math.floor(PlayerResources.p1Resources.health / 3)
            local varShield = PlayerResources.p1Resources.shield - math.floor(PlayerResources.p1Resources.shield / 3)
            logic:modResource("player1", "health", varHealth)
            logic:modResource("player1", "shield", varShield)
            
            local varHealth = PlayerResources.p2Resources.health - math.floor(PlayerResources.p2Resources.health / 3)
            local varShield = PlayerResources.p2Resources.shield - math.floor(PlayerResources.p2Resources.shield / 3)
            logic:modResource("player2", "health", varHealth)
            logic:modResource("player2", "shield", varShield)
        end
        --[[ if card.name == "Worker's Strike" then ]] -- Halt all build for 2 turns
    else
        logic:modResource(logic.turn, card.target, card.qty)
    end
end

function logic:destroy(player, qty)
    local qtyLeft = qty
    local shield = logic:getResource(player, "shield")

    if shield > 0 then
        if shield >= qty then
            qtyLeft = 0
            shield = shield - qty
        else
            qtyLeft = qtyLeft - shield
            shield = 0
        end
        logic:setResource(player, "shield", shield)
    end

    if qtyLeft > 0 then
        logic:modResource(player, "health", -qtyLeft)
    end
end

function logic:left()
    if #logic.currentHand == 5 then
        if logic.currentCardIndex == 2 then logic.currentCardIndex = 1
        elseif logic.currentCardIndex == 3 then logic.currentCardIndex = 2
        elseif logic.currentCardIndex == 5 then logic.currentCardIndex = 4 end
    elseif #logic.currentHand == 4 then
        if logic.currentCardIndex == 2 then logic.currentCardIndex = 1
        elseif logic.currentCardIndex == 4 then logic.currentCardIndex = 3 end
    elseif #logic.currentHand == 3 then
        if logic.currentCardIndex == 3 then logic.currentCardIndex = 2 end
    end
end

function logic:right()
    if #logic.currentHand == 5 then
        if logic.currentCardIndex == 1 then logic.currentCardIndex = 2
        elseif logic.currentCardIndex == 2 then logic.currentCardIndex = 3
        elseif logic.currentCardIndex == 4 then logic.currentCardIndex = 5 end
    elseif #logic.currentHand == 4 then
        if logic.currentCardIndex == 1 then logic.currentCardIndex = 2
        elseif logic.currentCardIndex == 3 then logic.currentCardIndex = 4 end
    elseif #logic.currentHand == 3 then
        if logic.currentCardIndex == 2 then logic.currentCardIndex = 3 end
    end
end

function logic:up()
    if #logic.currentHand == 5 then
        if logic.currentCardIndex == 4 then logic.currentCardIndex = 2
        elseif logic.currentCardIndex == 5 then logic.currentCardIndex = 3 end
    elseif #logic.currentHand == 4 then
        if logic.currentCardIndex == 3 then logic.currentCardIndex = 1
        elseif logic.currentCardIndex == 4 then logic.currentCardIndex = 2 end
    elseif #logic.currentHand == 3 then
        if logic.currentCardIndex == 2 then logic.currentCardIndex = 1
        elseif logic.currentCardIndex == 3 then logic.currentCardIndex = 1 end
    end
end

function logic:down()
    if #logic.currentHand == 5 then
        if logic.currentCardIndex == 1 then logic.currentCardIndex = 4
        elseif logic.currentCardIndex == 2 then logic.currentCardIndex = 5
        elseif logic.currentCardIndex == 3 then logic.currentCardIndex = 5 end
    elseif #logic.currentHand == 4 then
        if logic.currentCardIndex == 1 then logic.currentCardIndex = 3
        elseif logic.currentCardIndex == 2 then logic.currentCardIndex = 4 end
    elseif #logic.currentHand == 3 then
        if logic.currentCardIndex == 1 then logic.currentCardIndex = 3 end
    end
end

return logic
