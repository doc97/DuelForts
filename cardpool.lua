require "cards"

local data = {
    ["build"]       = { 5, 4, 3, 2, 1 },
    ["resource"]    = { 4, 3, 2, 1 },
    ["destroy"]     = { 4, 3, 2, 1 },
    ["shield"]      = { 3, 2, 1 },
    ["special"]     = { 2, 1 }
}

Pool = {}   

-- Build cards
for i = 1, #Cards.build do
    for j = 1, data.build[i] do
        Pool[#Pool + 1] = { ["base"] = "build", ["index"] = i }
    end
end

-- Resource cards
for i = 1, #Cards.resource do
    for j = 1, data.resource[i] do
        Pool[#Pool + 1] = { ["base"] = "resource", ["index"] = i }
    end
end

-- Destroy cards
for i = 1, #Cards.destroy do
    for j = 1, data.destroy[i] do
        Pool[#Pool + 1] = { ["base"] = "destroy", ["index"] = i }
    end
end

-- Shield cards
for i = 1, #Cards.shield do
    for j = 1, data.shield[i] do
        Pool[#Pool + 1] = { ["base"] = "shield", ["index"] = i }
    end
end

-- Special cards
for i = 1, #Cards.special do
    for j = 1, data.special[i] do
        Pool[#Pool + 1] = { ["base"] = "special", ["index"] = i }
    end
end

Pool[#Pool + 1] = { ["base"] = "discard", ["index"] = 1 }
