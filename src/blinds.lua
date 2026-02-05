-- The Desert
SMODS.Blind {
    key = "desert",
    discovered = true,
    boss = { min = 1 },
    boss_colour = HEX("A000A0"),
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.debuff_card and context.debuff_card.area ~= G.jokers and context.debuff_card.edition then
                return { debuff = true }
            end
        end
    end
}

-- The Filter
SMODS.Blind {
    key = "filter",
    discovered = true,
    boss = { min = 1 },
    boss_colour = HEX("A000A0"),
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.stay_flipped and context.to_area == G.hand and context.other_card.edition then
                return { stay_flipped = true }
            end
        end
    end,
    disable = function(self)
        for i = 1, #G.hand.cards do
            if G.hand.cards[i].facing == 'back' then
                G.hand.cards[i]:flip()
            end
        end
        for _, card in ipairs(G.playing_cards) do
            card.ability.wheel_flipped = nil
        end
    end
}

-- The Purse
SMODS.Blind {
    key = "purse",
    discovered = true,
    boss = { min = 1 },
    boss_colour = HEX("A000A0")
    -- Functionality handled in a CardArea:shuffle() hook
}

-- The Dam
SMODS.Blind {
    key = "dam",
    discovered = true,
    boss = { min = 1 },
    boss_colour = HEX("A000A0"),
    config = { extra = { inc = 0, base = 0 } },
    calculate = function(self, blind, context)
        if context.setting_blind then
            blind.effect.extra.base = blind.chips
            blind.effect.extra.inc = math.ceil(blind.chips / 100) -- 1% of base requirement
        end
        if not blind.disabled then
            if context.hand_drawn then
                local chipmod = #context.hand_drawn * blind.effect.extra.inc
                blind.chips = math.ceil(blind.chips + chipmod)
                blind.chip_text = number_format(blind.chips)
                blind:wiggle()
            end
        end
    end,
    disable = function(self)
        G.GAME.blind.chips = G.GAME.blind.effect.extra.base
        G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
        G.GAME.blind:wiggle()
        -- Checking for if blind is won is actually unnecessary here, it does it on its own
    end
}