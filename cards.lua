Cards = {
    -- Build
    ["build"] = {
        {
            ["name"] = "All-Nighter",
            ["cost"] = 3,
            ["target"] = "health",
            ["qty"] = 5,
            ["effectText"] = "Build up your tower by 5 levels." 
        },
        {
            ["name"] = "Full Week",
            ["cost"] = 6,
            ["target"] = "health",
            ["qty"] = 10,
            ["effectText"] = "Build up your tower by 10 levels."
        },
        {
            ["name"] = "Big Project",
            ["cost"] = 9,
            ["target"] = "health",
            ["qty"] = 15,
            ["effectText"] = "Build up your tower by 15 levels."
        },
        {
            ["name"] = "Egyptian Effort",
            ["cost"] = 14,
            ["target"] = "health",
            ["qty"] = 20,
            ["effectText"] = "Build up your tower by 20 levels."
        },
    },

    -- Resource add proper values to qtys
    ["resource"] = {
        {
            ["name"] = "Acquirence",
            ["cost"] = 2,
            ["target"] = "money",
            ["qty"] = 5,
            ["effectText"] = "Gain 5 extra money."
        },
        {
            ["name"] = "Fusion",
            ["cost"] = 4,
            ["target"] = "money",
            ["qty"] = 8,
            ["effectText"] = "Gain 7 extra money."
        }
    },

    -- Destroy
    ["destroy"] = {
        {
            ["name"] = "Pranks",
            ["cost"] = 2,
            ["target"] = "health",
            ["qty"] = 3,
            ["effectText"] = "Attack your opponent for 3 damage."
        },
        {
            ["name"] = "Sabotage",
            ["cost"] = 4,
            ["target"] = "health",
            ["qty"] = 6,
            ["effectText"] = "Attack your opponent for 6 damage."
        },
        {
            ["name"] = "Raid",
            ["cost"] = 6,
            ["target"] = "health",
            ["qty"] = 10,
            ["effectText"] = "Attack your opponent for 10 damage."
        },
        {
            ["name"] = "Alexandrian effect",
            ["cost"] = 10,
            ["target"] = "health",
            ["qty"] = 18,
            ["effectText"] = "Attack your opponent for 18 damage."
        }
    },

    -- Shield
    ["shield"] = {
        {
            ["name"] = "Barricade",
            ["cost"] = 3,
            ["target"] = "shield",
            ["qty"] = 3,
            ["effectText"] = "Increase wall height by 3."
        },
        {
            ["name"] = "Great Wall",
            ["cost"] = 5,
            ["target"] = "shield",
            ["qty"] = 5,
            ["effectText"] = "Increase wall height by 5."
        },
        {
            ["name"] = "Hadrian's Wall",
            ["cost"] = 8,
            ["target"] = "shield",
            ["qty"] = 8,
            ["effectText"] = "Increase wall height by 8."
        }
    },
    
    -- Discard
    ["discard"] = {
        {
            ["name"] = "Espionage",
            ["cost"] = 4,
            ["target"] = "handsize",
            ["qty"] = -1,
            ["effectText"] = "Your opponent draws 1 less card next turn."
        },
        {
            ["name"] = "Propaganda",
            ["cost"] = 6,
            ["target"] = "handsize",
            ["qty"] = -2,
            ["effectText"] = "Your opponent draws 2 less cards next turn."
        }
    },

    -- Permanents
    ["permanents"] = {
        {
            ["name"] = "Architect 'Archibald'",
            ["cost"] = 5,
            ["health"] = 5,
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
            ["health"] = 6,
            ["effectText"] = "Doubles the effect of 'Wall' cards"
        },
        {
            ["name"] = "Conjurer 'Vinhelm'",
            ["health"] = 6,
            ["cost"] = 7,
            ["effectText"] = "You are guaranteed a special card every turn."
        }
    },

    -- Special
    ["special"] = {
        {
            ["name"] = "Armageddon",
            ["cost"] = 7,
            ["effectText"] = "Destroy all permanents.",
            ["tag"] = "special"
        },
        {
            ["name"] = "Pox",
            ["cost"] = 13,
            ["effectText"] = "Reduce all resources by half. Tower levels, wall heights, next hand size (one turn).",
            ["tag"] = "special"
        },
        {
            ["name"] = "Worker's Strike",
            ["cost"] = 8,
            ["effectText"] = "Halt all building (tower and wall) for 2 turns.",
            ["tag"] = "special"
        }
    }
}

