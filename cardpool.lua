require "cards"

local data = {
    ["build"]       = { 10, 6, 4, 2},
    ["resource"]    = { 8, 4},
    ["destroy"]     = { 8, 5, 3, 2},
    ["shield"]      = { 8, 5, 3},
    ["special"]     = { 3, 3, 2},
    ["permanents"]  = { 7, 3, 10, 4}
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

-- Permanent cards
for i = 1, #Cards.permanents do
    for j = 1, data.permanents[i] do
        Pool[#Pool + 1] = { ["base"] = "special", ["index"] = i}
    end
end

Pool[#Pool + 1] = { ["base"] = "discard", ["index"] = 1 }
