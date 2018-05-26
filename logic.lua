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
    logic:setResource("player1", "handsize", 5)
end

function logic:cardDrawPlayer2()
    logic.currentCardIndex = 1
    logic.currentHand = {}
    for i = 1, PlayerResources.p2Resources.handsize do
        local card = assert(Pool[ math.random( #Pool )])
        table.insert(logic.currentHand, { base = card.base, index = card.index })
    end
    logic:setResource("player2", "handsize", 5)
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
            logic:modResource(target, "modBuildCost", -1)
        elseif name == "Bomb Expert 'Vinnie'" then
            logic:setResource(target, "modDamageMult", 2)
        elseif name == "Builder 'Bobert'" then
            logic:modResource(target, "shield", 5)
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
            logic:modResource(target, "modBuildCost", 1)
        elseif name == "Bomb Expert 'Vinnie'" then
            logic:setResource(target, "modDamageMult", 1)
        elseif name == "Builder 'Bobert'" then
            local newValue = math.max(0, logic:getResource(target, "shield") - 5)
            logic:setResource(target, "shield", newValue)
        elseif name == "Conjurer 'Vinhelm'" then
        end

    end
end

function logic:removeAllPermanents(target)
    if target == "player1" then
        for k, v in pairs(PlayerResources.p1Resources.permanents) do
            removePermanent(k)
        end
    else
        for k, v in pairs(PlayerResources.p2Resources.permanents) do
            removePermanent(k)
        end
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

function logic:activateCard(base, card, cost)
    if base == "special" then
        if card.name == "Armageddon" then logic:removeAllPermanents()
        elseif card.name == "Pox" then   -- multiply by 1/3 then ceil and add hand size destruction
                local varHealth = math.ceil(PlayerResources.p1Resources.health * 0.33)
                local varShield = math.ceil(PlayerResources.p1Resources.shield * 0.33)
                local varHand = math.ceil(PlayerResources.p1Resources.handsize * 0.33)
                logic:modResource("player1", "health", -varHealth)
                logic:modResource("player1", "shield", -varShield)
                logic:modResource("player1", "handsize", -varHand)
                
                local varHealth = math.ceil(PlayerResources.p2Resources.health * 0.33)
                local varShield = math.ceil(PlayerResources.p2Resources.shield * 0.33)
                local varHand = math.ceil(PlayerResources.p2Resources.handsize * 0.33)
                logic:modResource("player2", "health", -varHealth)
                logic:modResource("player2", "shield", -varShield)
                logic:modResource("player2", "handsize", -varHand)
        end
            --[[ if card.name == "Worker's Strike" then ]] -- Halt all build for 2 turns
    elseif base == "permanents" then
        logic:addPermanent(logic.turn, card.name, card.health)
    elseif base == "destroy"  then
        if logic.turn == "player1" then logic:destroy("player2", math.abs(card.qty))
        elseif logic.turn == "player2" then logic:destroy("player1", math.abs(card.qty)) end
    else
        logic:modResource(logic.turn, card.target, card.qty)
    end
    logic:modResource(logic.turn, "money", -cost)
end

function logic:destroy(player, qty)
    local qtyLeft = qty * logic:getResource(player, "modDamageMult")
    local shield = logic:getResource(player, "shield")

    if shield > 0 then
        if shield >= qtyLeft then
            shield = shield - qtyLeft
            qtyLeft = 0
        else
            qtyLeft = qtyLeft - shield
            shield = 0
        end
        logic:setResource(player, "shield", shield)
    end

    if qtyLeft > 0 then
        logic:modResource(player, "health", -qtyLeft)
        if player == "player1" then
            for k, v in pairs(PlayerResources.p1Resources.permanents) do
                v.health = v.health - qtyLeft
                if v.health <= 0 then
                    logic:removePermanent(player, k)
                end
            end
        else
            for k, v in pairs(PlayerResources.p2Resources.permanents) do
                v.health = v.health - qtyLeft
                if v.health <= 0 then
                    logic:removePermanent(player, k)
                end
            end
        end
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
