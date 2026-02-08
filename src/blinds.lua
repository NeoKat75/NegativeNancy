---@diagnostic disable: param-type-mismatch

-- Blind atlas
SMODS.Atlas {
    key = "blinds",
    path = "blinds.png",
    atlas_table = "ANIMATION_ATLAS",
    px = 34,
    py = 34
}

-- The Desert
SMODS.Blind {
    key = "desert",
    atlas = "blinds",
    pos = { x = 0, y = 0 },
    discovered = true,
    boss = { min = 1 },
    boss_colour = HEX("ab7b27"),
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
    atlas = "blinds",
    pos = { x = 0, y = 1 },
    discovered = true,
    boss = { min = 1 },
    boss_colour = HEX("007aad"),
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
    atlas = "blinds",
    pos = { x = 0, y = 2 },
    discovered = true,
    boss = { min = 1 },
    boss_colour = HEX("a000a0")
    -- Functionality handled in a CardArea:shuffle() hook
}

-- The Dam
SMODS.Blind {
    key = "dam",
    atlas = "blinds",
    pos = { x = 0, y = 3 },
    discovered = true,
    boss = { min = 1 },
    boss_colour = HEX("0092c7"),
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
                NegaNancy.wiggle_blind()
                if not G.CONTROLLER.locks.nancy_makenegatives then blind.triggered = true end
            end
        end
    end,
    disable = function(self)
        G.GAME.blind.chips = G.GAME.blind.effect.extra.base
        G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
        NegaNancy.wiggle_blind()
        -- Checking for if blind is won is actually unnecessary here, it does it on its own
    end
}

-- The Crowd
SMODS.Blind {
    key = "crowd",
    atlas = "blinds",
    pos = { x = 0, y = 4 },
    discovered = true,
    boss = { min = 1 },
    boss_colour = HEX("1d6d00"),
    calculate = function(self, blind, context)
        -- Waiting for next smods version to do this!
        if not blind.disabled then
            
        end
    end
}

-- The Wrench
SMODS.Blind {
    key = "wrench",
    atlas = "blinds",
    pos = { x = 0, y = 5 },
    discovered = true,
    boss = { min = 1 },
    boss_colour = HEX("bb3100"),
    config = { extra = { odds = 4, wiggle = false } },
    loc_vars = function(self)
        local num, denom = SMODS.get_probability_vars(self, 1, self.config.extra.odds, 'nancy_wrench')
        return { vars = { num, denom } }
    end,
    collection_loc_vars = function(self)
        return { vars = { 1, self.config.extra.odds } }
    end,
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.before then
                blind.effect.extra.wiggle = false
            end
            if context.destroying_card
                and SMODS.pseudorandom_probability(blind, 'nancy_wrench', 1, blind.effect.extra.odds)
            then
                return { remove = true, func =
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            if not blind.effect.extra.wiggle then
                                blind.effect.extra.wiggle = true
                                NegaNancy.wiggle_blind()
                                blind.triggered = true
                            end
                            return true
                        end
                    }))
                }
            end
        end
    end
}

-- The File
SMODS.Blind {
    key = "file",
    atlas = "blinds",
    pos = { x = 0, y = 6 },
    discovered = true,
    boss = { min = 1 },
    boss_colour = HEX("730082"),
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.after then
                -- From Vanilla Remade's Vampire
                local enhanced = {}
                for _, scored_card in ipairs(context.scoring_hand) do
                    if next(SMODS.get_enhancements(scored_card)) and not scored_card.debuff and not scored_card.vampired then
                        enhanced[#enhanced + 1] = scored_card
                        scored_card.vampired = true
                        scored_card:set_ability('c_base', nil, true)
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                scored_card:juice_up()
                                scored_card.vampired = nil
                                return true
                            end
                        }))
                    end
                end
                if #enhanced > 0 then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            NegaNancy.wiggle_blind()
                            blind.triggered = true
                            return true
                        end
                    }))
                end
            end
        end
    end
}

-- Tourmaline Sun
SMODS.Blind {
    key = "final_sun",
    atlas = "blinds",
    pos = { x = 0, y = 7 },
    discovered = true,
    boss = { showdown = true },
    boss_colour = HEX("4d4d4d"),
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.before then
                local yum = false
                for _, area in ipairs{G.play, G.hand} do
                    for _, card in ipairs(area.cards) do
                        if not NegaNancy.isintable(context.scoring_hand, card) and not card.ability.nancy_tourmalinedebuff then
                            card.ability.nancy_tourmalinedebuff = true
                            SMODS.recalc_debuff(card)
                            card:juice_up()
                            yum = true
                        end
                    end
                end
                if yum then NegaNancy.wiggle_blind(); blind.triggered = true end
            end
        end
    end,
    recalc_debuff = function(self, card, from_blind)
        if card.ability.nancy_tourmalinedebuff then return true else return false end
    end,
    disable = function(self)
        for _, card in ipairs(G.playing_cards) do
            card.ability.nancy_tourmalinedebuff = nil
        end
    end,
    defeat = function(self)
        for _, card in ipairs(G.playing_cards) do
            card.ability.nancy_tourmalinedebuff = nil
        end
    end
}