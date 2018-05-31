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
    logic:setResource("player1", "handsize", 5, 0, 5)
end

function logic:cardDrawPlayer2()
    logic.currentCardIndex = 1
    logic.currentHand = {}
    for i = 1, PlayerResources.p2Resources.handsize do
        local card = assert(Pool[ math.random( #Pool )])
        table.insert(logic.currentHand, { base = card.base, index = card.index })
    end
    logic:setResource("player2", "handsize", 5, 0, 5)
end

function logic:switchTurns()
    if logic.turn == "player1" then
        logic.turn = "player2"
        logic:cardDrawPlayer2()
        logic:modResource(logic.turn, "money", 2, 0, 100)
    else
        logic.turn = "player1"
        logic:cardDrawPlayer1()
        logic:modResource(logic.turn, "money", 2, 0, 100)
    end
end

function logic:addPermanent(target, name, hp)
    local new = false
    if target == "player1" then
        if PlayerResources.p1Resources["permanents"][name] == nil then
            new = true
        end
        PlayerResources.p1Resources["permanents"][name] = { health = hp }
    else
        if PlayerResources.p2Resources["permanents"][name] == nil then
            new = true
        end
        PlayerResources.p2Resources["permanents"][name] = { health = hp }
    end

    if new then
        if name == "Architect 'Archibald'" then
            logic:modResource(target, "modBuildCost", -1, -5, 5)
        elseif name == "Bomb Expert 'Vinnie'" then
            logic:setResource(target, "modDamageMult", 2, 1, 2)
        elseif name == "Builder 'Bobert'" then
            logic:setResource(target, "modWallMult", 2, 1, 2)
        elseif name == "Conjurer 'Vinhelm'" then
        end
    end
end

function logic:removePermanent(target, name)
    local exist = false
    if target == "player1" then
        if PlayerResources.p1Resources["permanents"][name] ~= nil then
            exist = true
        end
        PlayerResources.p1Resources["permanents"][name] = nil
    else
        if PlayerResources.p2Resources["permanents"][name] ~= nil then
            exist = true
        end
        PlayerResources.p2Resources["permanents"][name] = nil
    end

    if exist then
        if name == "Architect 'Archibald'" then
            logic:modResource(target, "modBuildCost", 1, 1, 3)
        elseif name == "Bomb Expert 'Vinnie'" then
            logic:setResource(target, "modDamageMult", 1, 1, 2)
        elseif name == "Builder 'Bobert'" then
            logic:setResource(target, "modWallMult", 1, 1, 2)
        elseif name == "Conjurer 'Vinhelm'" then
        end

    end
end

function logic:removeAllPermanents(target)
    if target == "player1" then
        for k, v in pairs(PlayerResources.p1Resources.permanents) do
            logic:removePermanent(target, k)
        end
    else
        for k, v in pairs(PlayerResources.p2Resources.permanents) do
            logic:removePermanent(target, k)
        end
    end
end

function logic:modResource(target, res, qty, min, max)
    if target == "player1" then
        local value = PlayerResources.p1Resources[res]
        PlayerResources.p1Resources[res] = math.max(min, math.min(max, value + qty))
    else
        local value = PlayerResources.p2Resources[res]
        PlayerResources.p2Resources[res] = math.max(min, math.min(max, value + qty))
    end
end

function logic:setResource(target, res, qty, min, max)
    if target == "player1" then
        PlayerResources.p1Resources[res] = math.max(min, math.min(max, qty))
    else
        PlayerResources.p2Resources[res] = math.max(min, math.min(max, qty))
    end
end

function logic:getResource(target, res)
    if target == "player1" then
        return PlayerResources.p1Resources[res]
    else
        return PlayerResources.p2Resources[res]
    end
end

function logic:activateCard(base, card, cost)
    logic:modResource(logic.turn, "money", -cost, 0, 100)
    if base == "special" then
        logic:special(logic.turn, card.name)
    elseif base == "permanents" then
        logic:addPermanent(logic.turn, card.name, card.health)
    elseif base == "destroy"  then
        local mod = logic:getResource(logic.turn, "modDamageMult")
        logic:destroy(logic.turn, card.qty, mod)
    elseif base == "discard" then
        logic:discard(logic.turn, card.qty)
    elseif base == "shield" then
        logic:modResource(logic.turn, card.target, card.qty * logic:getResource(logic.turn, "modWallMult"), 1, 100)
    else
        logic:modResource(logic.turn, card.target, card.qty, 0, 100)
    end
end

function logic:special(player, name)
    if name == "Armageddon" then
        logic:removeAllPermanents("player1")
        logic:removeAllPermanents("player2")
    elseif name == "Pox" then   -- multiply by 1/3 then ceil and add hand size destruction
        local varHealth = math.ceil(PlayerResources.p1Resources.health * 0.5)
        local varShield = math.ceil(PlayerResources.p1Resources.shield * 0.5)
        local varHand = math.ceil(PlayerResources.p1Resources.handsize * 0.5)
        logic:setResource("player1", "health", varHealth, 0, 100)
        logic:setResource("player1", "shield", varShield, 0, 100)
        logic:setResource("player1", "handsize", varHand, 3, 5)
 
        varHealth = math.ceil(PlayerResources.p2Resources.health * 0.5)
        varShield = math.ceil(PlayerResources.p2Resources.shield * 0.5)
        varHand = math.ceil(PlayerResources.p2Resources.handsize * 0.5)
        logic:setResource("player2", "health", varHealth, 0, 100)
        logic:setResource("player2", "shield", varShield, 0, 100)
        logic:setResource("player2", "handsize", varHand, 3, 5)
    end
end

function logic:discard(player, qty)
    local target = "player1"
    if player == "player1" then target = "player2" end
    logic:modResource(target, "handsize", qty, 3, 5)
end

function logic:destroy(player, qty, mod)
    local target = "player1"
    if player == "player1" then target = "player2" end

    local qtyLeft = qty * mod
    local shield = logic:getResource(target, "shield")

    if shield > 0 then
        logic:modResource(target, "shield", qtyLeft, 0, 100)
        if shield < qtyLeft then
            qtyLeft = math.ceil((qtyLeft - shield) / 2)
        else
            qtyLeft = 0
        end
    end

    logic:modResource(target, "health", -qtyLeft, 0, 100)
    for k, v in pairs(logic:getResource(target, "permanents")) do
        v.health = v.health - qtyLeft
        if v.health <= 0 then
            logic:removePermanent(target, k)
        end
    end

    if mod > 1 then logic:destroy(target, qty, 1) end
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
