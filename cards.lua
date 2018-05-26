Cards = {
    -- Build
    ["build"] = {
        {
            ["name"] = "All-Nighter",
            ["cost"] = 3,
            ["targetIndex"] = 0,
            ["qty"] = 5,
            ["effectText"] = "Build up your wall by 5 levels." 
        },
        {
            ["name"] = "Full Week",
            ["cost"] = 5,
            ["targetIndex"] = 0,
            ["qty"] = 10,
            ["effectText"] = "Build up your wall by 10 levels."
        },
        {
            ["name"] = "Big Project",
            ["cost"] = 8,
            ["targetIndex"] = 0,
            ["qty"] = 15,
            ["effectText"] = "Build up your wall by 15 levels."
        },
        {
            ["name"] = "Egyptian Effort",
            ["cost"] = 20,
            ["targetIndex"] = 0,
            ["qty"] = 20,
            ["effectText"] = "Build up your wall by 20 levels."
        },
    },

    -- Resource add proper values to qtys
    ["resource"] = {
        {
            ["name"] = "Acquirence",
            ["cost"] = 3,
            ["targetIndex"] = 0,
            ["qty"] = 1,
            ["effectText"] = "Gain 1 extra card and 2 extra resources next turn."
        },
        {
            ["name"] = "Fusion",
            ["cost"] = 6,
            ["targetIndex"] = 0,
            ["qty"] = 3,
            ["effectText"] = "Gain 2 extra cards and 3 extra resources next turn."
        }
        --[[ {
            ["name"] = "Collect large",
            ["cost"] = 0,
            ["targetIndex"] = 0,
            ["qty"] = 5
        },
        {
            ["name"] = "Collect massive",
            ["cost"] = 0,
            ["targetIndex"] = 0,
            ["qty"] = 8
        } ]]
    },

    -- Destroy
    ["destroy"] = {
        {
            ["name"] = "Pranks",
            ["cost"] = 4,
            ["targetIndex"] = 0,
            ["qty"] = -3,
            ["effectText"] = "Destroy your opponents wall by 3 levels."
        },
        {
            ["name"] = "Sabotage",
            ["cost"] = 6,
            ["targetIndex"] = 0,
            ["qty"] = -7,
            ["effectText"] = "Destroy your opponents wall by 7 levels."
        },
        {
            ["name"] = "Raid",
            ["cost"] = 10,
            ["targetIndex"] = 0,
            ["qty"] = -15,
            ["effectText"] = "Destroy your opponents wall by 15 levels."
        },
        {
            ["name"] = "Alexandrian effect",
            ["cost"] = 15,
            ["targetIndex"] = 0,
            ["qty"] = -23,
            ["effectText"] = "Destroy your opponents wall by 23 levels."
        }
    },

    -- Shield
    ["shield"] = {
        {
            ["name"] = "Barricade",
            ["cost"] = 3,
            ["targetIndex"] = 0,
            ["qty"] = 3,
            ["effectText"] = "Raise a wall with a height of 3."
        },
        {
            ["name"] = "Great Wall",
            ["cost"] = 5,
            ["targetIndex"] = 0,
            ["qty"] = 5,
            ["effectText"] = "Raise a wall with a height of 5."
        },
        {
            ["name"] = "Hadrian's Wall",
            ["cost"] = 8,
            ["targetIndex"] = 0,
            ["qty"] = 8,
            ["effectText"] = "Raise a wall with a height of 8."
        }
    },
    
    -- Discard
    ["discard"] = {
        {
            ["name"] = "Espionage",
            ["cost"] = 4,
            ["targetIndex"] = 0,
            ["qty"] = 1,
            ["effectText"] = "Your opponents draws 1 less card next turn."
        },
        {
            ["name"] = "Propaganda",
            ["cost"] = 6,
            ["targetIndex"] = 0,
            ["qty"] = 2,
            ["effectText"] = "Your opponents draws 2 less cards next turn."
        }
    },

    -- Permanents
    ["permanents"] = {
        {
            ["name"] = "Architect 'Archibald'",
            ["cost"] = 5,
            ["health"] = 12,
            ["effectText"] = "Your 'Build'-cards cost 1 less."
        },
        {
            ["name"] = "Bomb Expert 'Vinnie'",
            ["cost"] = 8,
            ["health"] = 7,
            ["effectText"] = "When you deal damage, deal twice as much, but you take the original damage."
        },
        {
            ["name"] = "Builder 'Bobert'",
            ["cost"] = 6,
            ["health"] = 15,
            ["effectText"] = "Your walls have +5 height"
        },
        {
            ["name"] = "Conjurer 'Vinhelm'",
            ["health"] = 6,
            ["cost"] = 7,
            ["effectText"] = "You are guaranteed a special card in your next draw."
        }
    },
    -- Remove permanents

    -- Special
    ["special"] = {
        {
            ["name"] = "Armageddon",
            ["cost"] = 9,
            ["effectText"] = "Destory ALL permanents.",
            ["tag"] = "special"
        },
        {
            ["name"] = "Pox",
            ["cost"] = 13,
            ["effectText"] = "Reduce all resources by 1/3. (Tower levels, wall sizes, number of permanents, and next draws.)",
            ["tag"] = "special"
        },
        {
            ["name"] = "Worker's Strike",
            ["cost"] = 8,
            ["effectText"] = "Halt all building for 2 turns.",
            ["tag"] = "special"
        }
    }
}

