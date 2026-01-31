-- Joker atlas
SMODS.Atlas {
    key = "nancy_jokers",
    path = "jokers.png",
    px = 71,
    py = 95
}

-- Window Shopping
SMODS.Joker {
    key = "windowshopping",
    atlas = "nancy_jokers",
    pos = { x = 0, y = 0 },
    rarity = 1,
    blueprint_compat = true,
    cost = 4,
    discovered = true,
    config = { extra = { times = 2 }, },
    calculate = function(self, card, context)
        -- When joker is scored
        if context.joker_main then
            -- Give hand size * 'times' var as mult
            return { mult = G.hand.config.card_limit * card.ability.extra.times }
        end
    end
}

-- Golden Fingers
SMODS.Joker {
    key = "goldenfingers",
    atlas = "nancy_jokers",
    pos = { x = 1, y = 0 },
    rarity = 1,
    blueprint_compat = true,
    cost = 5,
    discovered = true,
    config = { extra = { payout = 1 }, },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.payout } }
    end,
    calculate = function(self, card, context)
        if context.other_consumeable then
            -- Use money buffer!!
            G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + card.ability.extra.payout
            return {
                dollars = card.ability.extra.payout,
                message_card = context.other_consumeable,
                -- Reset money buffer!!
                func = function() -- This is for timing purposes, it runs after the dollar manipulation
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            G.GAME.dollar_buffer = 0
                            return true
                        end
                    }))
                end
            }
        end
    end
}

-- Count Jokula
SMODS.Joker {
    key = "countjokula",
    atlas = "nancy_jokers",
    pos = { x = 2, y = 0 },
    rarity = 2,
    blueprint_compat = true,
    perishable_compat = false,
    cost = 7,
    discovered = true,
    config = { extra = { xmult = 1, gain = 0.01, loss = 0.02 }, },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult, card.ability.extra.gain, card.ability.extra.loss } }
    end,
    calculate = function(self, card, context)
        -- After a hand is drawn
        if (context.hand_drawn or context.other_drawn) and not context.blueprint then
            local amount = 0
            if context.hand_drawn then amount = #context.hand_drawn end
            if context.other_drawn then amount = #context.other_drawn end
            -- Scale xmult up by amount of cards drawn * 'gain'
            card.ability.extra.xmult = card.ability.extra.xmult + amount * card.ability.extra.gain
            return { message = localize{type = 'variable', key = 'a_xmult', vars = { card.ability.extra.xmult }}, colour = G.C.UI_MULT }
        end
        -- Before a hand is scored and if xmult > 1
        if context.before and card.ability.extra.xmult > 1 and not context.blueprint then
            -- Scale xmult down by amount of cards scored * 'loss'
            card.ability.extra.xmult = card.ability.extra.xmult - #context.scoring_hand * card.ability.extra.loss
            -- Makes sure xmult is at least 1
            if card.ability.extra.xmult < 1 then card.ability.extra.xmult = 1 end
            return { message = localize("nancy_downgrade"), colour = G.C.UI_MULT }
        end
        -- When joker is scored
        if context.joker_main then
            -- Give 'xmult' as xmult
            return { xmult = card.ability.extra.xmult }
        end
    end
}

-- Laminator
SMODS.Joker {
    key = "laminator",
    atlas = "nancy_jokers",
    pos = { x = 3, y = 0 },
    rarity = 2,
    blueprint_compat = true,
    cost = 7,
    discovered = true,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.e_foil
        info_queue[#info_queue + 1] = G.P_CENTERS.e_holo
        info_queue[#info_queue + 1] = G.P_CENTERS.e_polychrome
        info_queue[#info_queue + 1] = { key = 'e_negative_playing_card', set = 'Edition', config = { extra = 1 } }
    end,
    calculate = function(self, card, context)
        if context.first_hand_drawn then
            local joker = context.blueprint_card or card
            G.E_MANAGER:add_event(Event({
                func = function()
                    -- Table of non-editioned cards
                    local targets = {}
                    for _, _card in ipairs(G.hand.cards) do
                        if not _card.edition then
                            targets[#targets + 1] = _card
                        end
                    end
                    -- If there are any, apply random edition
                    if next(targets) then
                        local _card = pseudorandom_element(targets, "nancy_laminator")
                        local edition = poll_edition("nancy_laminator", nil, nil, true)
                        _card:set_edition(edition, true)
                        _card:juice_up()
                        joker:juice_up()
                    end
                    return true
                end
            }))
        end
    end
}

-- Frugal Joker
SMODS.Joker {
    key = "frugaljoker",
    atlas = "nancy_jokers",
    pos = { x = 4, y = 0 },
    rarity = 2,
    blueprint_compat = true,
    perishable_compat = false,
    cost = 7,
    discovered = true,
    config = { extra = { gain = 2, mult = 0 }, },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = 'e_negative_playing_card', set = 'Edition', config = { extra = 1 } }
        return { vars = { card.ability.extra.gain, card.ability.extra.mult } }
    end,
    in_pool = function(self, args)
        for _, _card in ipairs(G.playing_cards or {}) do
            if _card.edition and _card.edition.key == "e_negative" then
                return true
            end
        end
        return false
    end,
    calculate = function(self, card, context)
        -- Upgrade mult when discarding negatives
        if context.discard and not context.blueprint
            and context.other_card.edition and context.other_card.edition.key == "e_negative"
            and not context.other_card.debuff
        then
            card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.gain
            return { message = localize('k_upgrade_ex') }
        end
        -- Scoooooore!
        if context.joker_main then
            return { mult = card.ability.extra.mult }
        end
    end
}

-- Return Policy
SMODS.Joker {
    key = "returnpolicy",
    atlas = "nancy_jokers",
    pos = { x = 0, y = 1 },
    rarity = 1,
    blueprint_compat = true,
    cost = 5,
    discovered = true,
    config = { extra = { amount = 3, tally = 0, growth = 1 }, },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_TAGS.tag_top_up
        info_queue[#info_queue + 1] = G.P_TAGS.tag_uncommon
        info_queue[#info_queue + 1] = G.P_TAGS.tag_rare
        return { vars = { card.ability.extra.amount, card.ability.extra.tally, card.ability.extra.growth } }
    end,
    calculate = function(self, card, context)
        -- If selling a Joker
        if context.selling_card and context.card.ability.set == "Joker" then
            -- If this Joker is the last one needed to be sold
            if card.ability.extra.tally == card.ability.extra.amount - 1 then
                -- Determine tag
                local tag = "tag_nancy_secret" -- Legendary/failsafe tag
                if context.card:is_rarity(1) then tag = "tag_top_up" end
                if context.card:is_rarity(2) then tag = "tag_uncommon" end
                if context.card:is_rarity(3) then tag = "tag_rare" end
                -- Give tag
                G.E_MANAGER:add_event(Event({
                    func = function()
                        add_tag(Tag(tag))
                        play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
                        return true
                    end
                }))
                -- Apply if top-up tag
                if tag == "tag_top_up" then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            for i = 1, #G.GAME.tags do
                                if G.GAME.tags[i]:apply_to_run{type = 'immediate'} then break end
                            end
                            return true
                        end
                    }))
                end
                -- Reset tally after activation for blueprint compat
                return {
                    message = localize("nancy_raritytag"),
                    func = function()
                        -- This is for timing purposes, this goes after activation
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                if card.ability.extra.tally ~= 0 then
                                    card.ability.extra.amount = card.ability.extra.amount + card.ability.extra.growth
                                end
                                card.ability.extra.tally = 0
                                return true
                            end
                        }))
                    end
                }
            -- Erm actually no blueprint here to avoid multiple increments
            elseif not context.blueprint then
                -- Increment tally after activation for blueprint compat
                return {
                    message = (card.ability.extra.tally + 1) .. "/" .. card.ability.extra.amount,
                    func = function()
                        -- This is for timing purposes, this goes after activation
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                card.ability.extra.tally = card.ability.extra.tally + 1
                                return true
                            end
                        }))
                    end
                }
            end
        end
    end
}

-- Collector
SMODS.Joker {
    key = "collector",
    atlas = "nancy_jokers",
    pos = { x = 1, y = 1 },
    rarity = 1,
    blueprint_compat = true,
    cost = 5,
    discovered = true,
    config = { extra = { chips = 2 }, },
    loc_vars = function(self, info_queue, card)
        if G.playing_cards and #G.playing_cards > 0 then
            return { vars = { card.ability.extra.chips, card.ability.extra.chips * NegaNancy.uniquecards(G.playing_cards) } }
        else
            return { vars = { card.ability.extra.chips, card.ability.extra.chips * 52 } }
        end
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return { chips = card.ability.extra.chips * NegaNancy.uniquecards(G.playing_cards) }
        end
    end
}

-- Negative Nancy
SMODS.Joker {
    key = "negativenancy",
    atlas = "nancy_jokers",
    pos = { x = 2, y = 1 },
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = false,
    cost = 9,
    discovered = true,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = 'e_negative_playing_card', set = 'Edition', config = { extra = 1 } }
    end,
    calculate = function(self, card, context)
        if G.hand and G.hand.cards and context.selling_self then
            -- Put non-editioned cards in a table
            local targets = {}
            for _, _card in ipairs(G.hand.cards) do
                if not _card.edition then
                    targets[#targets + 1] = _card
                end
            end
            -- Do the thing if there are any targets
            if next(targets) then NegaNancy.makenegatives(targets) end
        end
    end
}

-- Post-Modern Joker
SMODS.Joker {
    key = "postmodernjoker",
    atlas = "nancy_jokers",
    pos = { x = 3, y = 1 },
    rarity = 1,
    blueprint_compat = true,
    cost = 4,
    discovered = true,
    config = { extra = { percard = 15 }, },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = 'e_negative_playing_card', set = 'Edition', config = { extra = 1 } }
        local negacards = 0
        if G.deck and G.deck.cards then
            for _, _card in ipairs(G.deck.cards) do
                if _card.edition and _card.edition.key == "e_negative" then negacards = negacards + 1 end
            end
        end
        return { vars = { card.ability.extra.percard, card.ability.extra.percard * negacards } }
    end,
    in_pool = function(self, args)
        for _, _card in ipairs(G.playing_cards or {}) do
            if _card.edition and _card.edition.key == "e_negative" then
                return true
            end
        end
        return false
    end,
    calculate = function(self, card, context)
        if context.joker_main and G.deck and G.deck.cards then
            local negacards = 0
            for _, _card in ipairs(G.deck.cards) do
                if _card.edition and _card.edition.key == "e_negative" then negacards = negacards + 1 end
            end
            return { chips = card.ability.extra.percard * negacards }
        end
    end
}

-- Expired Coupon
SMODS.Joker {
    key = "expiredcoupon",
    atlas = "nancy_jokers",
    pos = { x = 4, y = 1 },
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = false,
    cost = 3,
    discovered = true,
    config = { extra = { limit = 25, reduction = 2 }, },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.limit, card.ability.extra.reduction } }
    end,
    add_to_deck = function(self, card, from_debuff)
        -- Set sell value to 0
        card.ability.extra_value = -(math.floor(self.cost / 2))
        card:set_cost()
    end,
    calculate = function(self, card, context)
        -- If selling card while blind req is over 5 chips and player has any money
        if context.selling_self and G.GAME.blind.in_blind
            and G.GAME.blind.chips > 5 and G.GAME.dollars > G.GAME.bankrupt_at
        then
            -- Calc available money and cap it at limit, spend money
            local money = math.abs(G.GAME.bankrupt_at - G.GAME.dollars)
            if money > card.ability.extra.limit then money = card.ability.extra.limit end
            ease_dollars(-money)
            -- Calc chip reduction and do it, wiggle blind
            local chipmod = G.GAME.blind.chips * ((money * card.ability.extra.reduction) / 100)
            G.GAME.blind.chips = math.floor(G.GAME.blind.chips - chipmod)
            G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
            G.GAME.blind:wiggle()
            -- Win blind if enough score (from Vanilla Remade wiki)
            if G.GAME.chips >= G.GAME.blind.chips then
                G.E_MANAGER:add_event(Event({
                    blocking = false,
                    func = function()
                        if G.STATE == G.STATES.SELECTING_HAND then
                            G.STATE = G.STATES.HAND_PLAYED
                            G.STATE_COMPLETE = true
                            end_round()
                            return true
                        end
                    end
                }))
            end
        end
    end
}

-- Deep Ocean
SMODS.Joker {
    key = "deepocean",
    atlas = "nancy_jokers",
    pos = { x = 0, y = 2 },
    rarity = 3,
    blueprint_compat = true,
    perishable_compat = false,
    cost = 8,
    discovered = true,
    config = { extra = { chips = 0, gain = 25 }, },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = 'e_negative_playing_card', set = 'Edition', config = { extra = 1 } }
        return { vars = { card.ability.extra.gain, card.ability.extra.chips } }
    end,
    in_pool = function(self, args)
        for _, _card in ipairs(G.playing_cards or {}) do
            if _card.edition and _card.edition.key == "e_negative" then
                return true
            end
        end
        return false
    end,
    calculate = function(self, card, context)
        if context.before and not context.blueprint then
            local yes = false
            for _, _card in ipairs(context.scoring_hand) do
                if _card.edition and _card.edition.key == "e_negative" and not _card.debuff then yes = true; break end
            end
            if yes then
                card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.gain
                return { message = localize('k_upgrade_ex') }
            else
                if card.ability.extra.chips > 0 then
                    card.ability.extra.chips = 0
                    return { message = localize('k_reset') }
                end
            end
        end
        if context.joker_main then
            return { chips = card.ability.extra.chips }
        end
    end
}

-- Double Take
SMODS.Joker {
    key = "doubletake",
    atlas = "nancy_jokers",
    pos = { x = 1, y = 2 },
    rarity = 3,
    blueprint_compat = true,
    cost = 9,
    discovered = true,
    config = { extra = { odds = 2, retriggers = 1 }, },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = 'e_negative_playing_card', set = 'Edition', config = { extra = 1 } }
        local num, denom = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'nancy_doubletake')
        return { vars = { num, denom } }
    end,
    in_pool = function(self, args)
        for _, _card in ipairs(G.playing_cards or {}) do
            if _card.edition and _card.edition.key == "e_negative" then
                return true
            end
        end
        return false
    end,
    calculate = function(self, card, context)
        if (context.repetition and context.cardarea == G.play)
            or (context.repetition and context.cardarea == G.hand and (next(context.card_effects[1]) or #context.card_effects > 1))
        then
            if context.other_card.edition and context.other_card.edition.key == "e_negative" then
                if SMODS.pseudorandom_probability(card, 'nancy_doubletake', 1, card.ability.extra.odds) then
                    return { repetitions = card.ability.extra.retriggers }
                end
            end
        end
    end
}

-- Stairwell
SMODS.Joker {
    key = "stairwell",
    atlas = "nancy_jokers",
    pos = { x = 2, y = 2 },
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = false,
    cost = 7,
    discovered = true,
    config = { extra = { amount = 2, growth = 1 }, },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = 'e_negative_playing_card', set = 'Edition', config = { extra = 1 } }
        return { vars = { card.ability.extra.amount, card.ability.extra.growth } }
    end,
    calculate = function(self, card, context)
        -- Scaling
        if context.end_of_round and not context.game_over and context.main_eval and not context.blueprint then
            card.ability.extra.amount = card.ability.extra.amount + card.ability.extra.growth
            return { message = localize('k_upgrade_ex') }
        end
        -- Wiggle wiggle
        if context.first_hand_drawn and card.ability.extra.amount >= G.hand.config.card_limit and not context.blueprint then
            -- Wiggle when amount > hand size
            local eval = function() return not G.RESET_JIGGLES end
            juice_card_until(card, eval, true)
        end
        -- Doing the thing
        if G.hand and G.hand.cards and context.selling_self then
            -- Put non-editioned cards in a table
            local targets = {}
            for _, _card in ipairs(G.hand.cards) do
                if not _card.edition then
                    targets[#targets + 1] = _card
                end
            end
            -- Select random eligible cards 
            if next(targets) then
                local finaltargets = {}
                if card.ability.extra.amount >= #targets then
                    finaltargets = targets
                else
                    -- Select amount of random cards from targets (ily btw)
                    for i = 1, card.ability.extra.amount do
                        local _card, _index = pseudorandom_element(targets, "nancy_stairwell")
                        finaltargets[#finaltargets+1] = _card
                        table.remove(targets, tonumber(_index))
                    end
                end
                NegaNancy.makenegatives(finaltargets)
            end
        end
    end
}

-- Exorcist
SMODS.Joker {
    key = "exorcist",
    atlas = "nancy_jokers",
    pos = { x = 3, y = 2 },
    rarity = 3,
    blueprint_compat = true,
    cost = 8,
    discovered = true,
    config = { extra = { xmult = 4, active = false }, },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = 'e_negative_playing_card', set = 'Edition', config = { extra = 1 } }
        local activetext
        if card.ability.extra.active then activetext = "(Active!)" else activetext = "(Inactive...)" end
        return { vars = { card.ability.extra.xmult, activetext } }
    end,
    in_pool = function(self, args)
        for _, _card in ipairs(G.playing_cards or {}) do
            if _card.edition and _card.edition.key == "e_negative" then
                return true
            end
        end
        return false
    end,
    calculate = function(self, card, context)
        -- Activate if inactive and negative card is destroyed
        if context.remove_playing_cards and not context.blueprint and not card.ability.extra.active then
            for _, _card in ipairs(context.removed) do
                if _card.edition and _card.edition.key == "e_negative" then
                    card.ability.extra.active = true
                    return { message = localize{type = "variable", key = 'loyalty_active'} }
                end
            end
        end
        -- Reset after beating boss blind if active
        if context.ante_change and context.ante_end and not context.blueprint and card.ability.extra.active then
            card.ability.extra.active = false
            return { message = localize('k_reset') }
        end
        -- Score if active
        if context.joker_main and card.ability.extra.active then
            return { xmult = card.ability.extra.xmult }
        end
    end
}

-- Initiation
SMODS.Joker {
    key = "initiation",
    atlas = "nancy_jokers",
    pos = { x = 4, y = 2 },
    rarity = 2,
    blueprint_compat = false,
    eternal_compat = false,
    cost = 8,
    discovered = true,
    config = { extra = { size = 1 }, },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = 'e_negative_playing_card', set = 'Edition', config = { extra = 1 } }
        return { vars = { card.ability.extra.size } }
    end,
    in_pool = function(self, args)
        for _, _card in ipairs(G.playing_cards or {}) do
            if _card.edition and _card.edition.key == "e_negative" then
                return true
            end
        end
        return false
    end,
    calculate = function(self, card, context)
        if context.after and #G.hand.cards > 0 and not context.blueprint then
            -- Check if hand contains non-negatives, stop calculation if yes
            for _, _card in ipairs(G.hand.cards) do
                if not _card.edition or (_card.edition and _card.edition.key ~= "e_negative") then return end
            end
            G.E_MANAGER:add_event(Event({
                func = function()
                    for _, _card in ipairs(G.hand.cards) do
                        _card:juice_up()
                    end
                    G.hand:change_size(card.ability.extra.size)
                    play_sound('gong', 0.94, 0.5)
                    play_sound('gong', 0.94*1.5, 0.5)
                    SMODS.destroy_cards(card)
                    return true
                end
            }))
            return {
                message = localize{type = 'variable', key = 'a_handsize', vars = { card.ability.extra.size }}
            }
        end
    end
}

-- Cutoff Card
SMODS.Joker {
    key = "cutoffcard",
    atlas = "nancy_jokers",
    pos = { x = 0, y = 3 },
    rarity = 2,
    blueprint_compat = true,
    cost = 6,
    discovered = true,
    config = { extra = { used = false }, },
    calculate = function(self, card, context)
        -- When hand is drawn and you got da cards
        if context.hand_drawn and next(G.consumeables.cards) and not card.juice and not context.blueprint then
            -- Wiggle while used = false
            local eval = function() return card.ability.extra.used == false and not G.RESET_JIGGLES end
            juice_card_until(card, eval, true)
        end
        -- Do the thing (nancy_cutoff is for blueprint compat, destroying cards happens later)
        if context.selling_card and card.ability.extra.used == false and G.GAME.blind.in_blind
            and context.card.ability.consumeable and G.hand and #G.hand.cards > 0
        then
            G.E_MANAGER:add_event(Event({
                func = function()
                    local targets = {}
                    for _, _card in ipairs(G.hand.cards) do
                        if not _card.ability.nancy_cutoff then
                            targets[#targets + 1] = _card
                        end
                    end
                    if next(targets) then
                        local _card = pseudorandom_element(targets, "nancy_cutoffcard")
                        _card.ability.nancy_cutoff = true
                        SMODS.destroy_cards(_card, nil, true)
                        card.ability.extra.used = true
                    end
                    return true
                end
            }))
        end
         -- At end of round if var is true
        if context.end_of_round and context.main_eval and not context.game_over
            and card.ability.extra.used == true and not context.blueprint
        then
            card.ability.extra.used = false
        end
    end
}

-- Quality of Life
SMODS.Joker {
    key = "qualityoflife",
    atlas = "nancy_jokers",
    pos = { x = 1, y = 3 },
    rarity = 1,
    blueprint_compat = true,
    cost = 4,
    discovered = true,
    config = { extra = { levels = 1 }, },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.levels } }
    end,
    calculate = function(self, card, context)
        if context.other_drawn then
            local pokerhand = G.FUNCS.get_poker_hand_info(context.other_drawn)
            SMODS.upgrade_poker_hands({hands = {pokerhand}, level_up = card.ability.extra.levels, from = context.blueprint_card or card})
        end
    end
}

-- Slot Machine
SMODS.Joker {
    key = "slotmachine",
    atlas = "nancy_jokers",
    pos = { x = 2, y = 3 },
    rarity = 2,
    blueprint_compat = true,
    perishable_compat = false,
    cost = 7,
    discovered = true,
    config = { extra = { gain = 7, mult = 0, sevens = {} }, },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = 'debuffed_playing_card', set = 'Other' }
        return { vars = { card.ability.extra.gain, card.ability.extra.mult } }
    end,
    calculate = function(self, card, context)
        if context.before and not context.blueprint then
            -- print("before")
            -- Gather scoring undebuffed 7s
            card.ability.extra.sevens = {}
            for _, _card in ipairs(context.scoring_hand) do
                if _card:get_id() == 7 and not _card.debuff then
                    card.ability.extra.sevens[#card.ability.extra.sevens+1] = _card
                end
            end
            -- If sevens, upgrade once for each 7
            if next(card.ability.extra.sevens) then
                card.ability.extra.mult = card.ability.extra.mult + (card.ability.extra.gain * #card.ability.extra.sevens)
                return { message = localize('k_upgrade_ex') }
            end
        end
        -- If sevens, debuff them and clear table
        if context.after and not context.blueprint and next(card.ability.extra.sevens) then
            G.E_MANAGER:add_event(Event({
                func = function()
                    -- print("after")
                    for _, _card in ipairs(card.ability.extra.sevens) do
                        SMODS.debuff_card(_card, true, "nancy")
                    end
                    card:juice_up()
                    play_sound('tarot2', 1, 0.4)
                    G.E_MANAGER:add_event(Event({
                        blocking = false,
                        blockable = false,
                        trigger = 'after',
                        delay = 0.06*G.SETTINGS.GAMESPEED,
                        func = function()
                            play_sound('tarot2', 0.76, 0.4)
                            return true
                        end
                    }))
                    return true
                end
            }))
        end
        -- Score!
        if context.joker_main then
            return { mult = card.ability.extra.mult }
        end
    end
}

-- Pump & Dump
SMODS.Joker {
    key = "pumpdump",
    atlas = "nancy_jokers",
    pos = { x = 3, y = 3 },
    rarity = 3,
    blueprint_compat = false,
    cost = 9,
    discovered = true,
    config = { extra = { money = 6, cards = 0, reset = false }, },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = 'e_negative_playing_card', set = 'Edition', config = { extra = 1 } }
        return { vars = { card.ability.extra.money, card.ability.extra.money * card.ability.extra.cards } }
    end,
    in_pool = function(self, args)
        for _, _card in ipairs(G.playing_cards or {}) do
            if _card.edition and _card.edition.key == "e_negative" then
                return true
            end
        end
        return false
    end,
    calculate = function(self, card, context)
        -- Scale per destroyed card, only show upgrade message once per destruction event
        if context.remove_playing_cards and not context.blueprint then
            local yes = false
            for _, _card in ipairs(context.removed) do
                if _card.edition and _card.edition.key == "e_negative" then
                    card.ability.extra.cards = card.ability.extra.cards + 1
                    yes = true
                end
            end
            if yes then return { message = localize('k_upgrade_ex') } end
        end
        -- Reset when entering shop after beating boss blind
        if context.ante_change and context.ante_end and not context.blueprint and card.ability.extra.cards > 0 then
            card.ability.extra.reset = true
        end
        if context.starting_shop and not context.blueprint and card.ability.extra.reset then
            card.ability.extra.cards = 0
            card.ability.extra.reset = false
            return { message = localize('k_reset') }
        end
    end,
    -- Gives end of round money
    calc_dollar_bonus = function(self, card)
        if card.ability.extra.cards > 0 then
            return card.ability.extra.money * card.ability.extra.cards
        end
    end
}

-- Junkie Joker
SMODS.Joker {
    key = "junkiejoker",
    atlas = "nancy_jokers",
    pos = { x = 4, y = 3 },
    rarity = 1,
    blueprint_compat = true,
    cost = 5,
    discovered = true,
    config = { extra = { dollars = 3, cards = 1 }, },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.dollars, card.ability.extra.cards } }
    end,
    calculate = function(self, card, context)
        -- Before scoring
        if context.before then
            -- If unscored cards = 'cards' variable
            if #context.full_hand - #context.scoring_hand == card.ability.extra.cards then
                -- Gives money in 'dollars' variable using the money buffer
                G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + card.ability.extra.dollars
                return {
                    dollars = card.ability.extra.dollars,
                    -- Clears the money buffer
                    func = function()
                        -- This is for timing purposes, this goes after the dollar modification
                        -- It resets the buffer in an event after scoring
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                G.GAME.dollar_buffer = 0
                                return true
                            end
                        }))
                    end
                }
            end
        end
    end
}

-- Pack of Buffoons
SMODS.Joker {
    key = "packofbuffoons",
    atlas = "nancy_jokers",
    pos = { x = 0, y = 4 },
    rarity = 2,
    blueprint_compat = true,
    cost = 7,
    discovered = true,
    config = { extra = { gain = 3 }, },
    loc_vars = function(self, info_queue, card)
        local mult = 0
        if G.GAME.nancy_jokerlist then mult = NegaNancy.tablelength(G.GAME.nancy_jokerlist) * card.ability.extra.gain end
        return { vars = { card.ability.extra.gain, mult } }
    end,
    calculate = function(self, card, context)
        if context.joker_main and G.GAME.nancy_jokerlist then
            return { mult = NegaNancy.tablelength(G.GAME.nancy_jokerlist) * card.ability.extra.gain }
        end
        if context.card_added and context.card.ability.set == "Joker"
            and G.GAME.nancy_jokerlist and not G.GAME.nancy_jokerlist[context.card.config.center.key]
        then
            return { message = localize('k_upgrade_ex') }
        end
    end
}

-- Lack of the Draw
SMODS.Joker {
    key = "lackofthedraw",
    atlas = "nancy_jokers",
    pos = { x = 1, y = 4 },
    rarity = 2,
    blueprint_compat = true,
    cost = 7,
    discovered = true,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = 'e_negative_playing_card', set = 'Edition', config = { extra = 1 } }
        local luck
        if math.random(10) == 10 then luck = "Luck" else luck = "Lack" end
        return { vars = { G.GAME.starting_params.discard_limit, luck } }
    end,
    in_pool = function(self, args)
        for _, _card in ipairs(G.playing_cards or {}) do
            if _card.edition and _card.edition.key == "e_negative" then
                return true
            end
        end
        return false
    end,
    calculate = function(self, card, context)
        -- When last card is being discarded, if discaring max amount of cards
        if context.discard and context.other_card == context.full_hand[#context.full_hand]
            and #context.full_hand == G.GAME.starting_params.discard_limit
        then
            -- Check if discard contains non-negatives, stop calculation if yes
            for _, _card in ipairs(context.full_hand) do
                if not _card.edition or (_card.edition and _card.edition.key ~= "e_negative") then return end
            end
            -- Add the spectral card (from Vanilla Remade's Sixth Sense)
            if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                G.GAME.consumeable_buffer = (G.GAME.consumeable_buffer or 0) + 1
                return {
                    message = localize('k_plus_spectral'),
                    colour = G.C.SECONDARY_SET.Spectral,
                    func = function()
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                SMODS.add_card{
                                    set = 'Spectral',
                                    key_append = 'nancy_lackofthedraw' -- Optional, useful for manipulating the random seed and checking the source of the creation in `in_pool`.
                                }
                                G.GAME.consumeable_buffer = 0
                                return true
                            end
                        }))
                    end
                }
            end
        end
    end
}

-- Street Art
SMODS.Joker {
    key = "streetart",
    atlas = "nancy_jokers",
    pos = { x = 2, y = 4 },
    rarity = 3,
    blueprint_compat = true,
    perishable_compat = false,
    cost = 8,
    discovered = true,
    config = { extra = { chips = 0, mult = 0, donezo = false }, },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips, card.ability.extra.mult } }
    end,
    calculate = function(self, card, context)
        -- Upgrade when The Arm delevels your poker hand
        if context.before -- and not context.blueprint (var 'donezo' accounts for blueprint for correct message display)
            and G.GAME.blind and G.GAME.blind.config.blind.key == "bl_arm" and G.GAME.blind.triggered
        then
            if not card.ability.extra.donezo then
                card.ability.extra.chips = card.ability.extra.chips + G.GAME.hands[context.scoring_name].l_chips
                card.ability.extra.mult = card.ability.extra.mult + G.GAME.hands[context.scoring_name].l_mult
                SMODS.calculate_effect({message = localize('k_upgrade_ex')}, card)
            end
            card.ability.extra.donezo = true
        end
        -- Delevel your poker hand and upgrade
        if context.before and G.GAME.hands[context.scoring_name].level > 1 then
            local joker = context.blueprint_card or card
            return {
                func = function()
                    SMODS.upgrade_poker_hands({hands = {context.scoring_name}, level_up = -1, from = joker})
                    card.ability.extra.chips = card.ability.extra.chips + G.GAME.hands[context.scoring_name].l_chips
                    card.ability.extra.mult = card.ability.extra.mult + G.GAME.hands[context.scoring_name].l_mult
                    SMODS.calculate_effect({message = localize('k_upgrade_ex')}, card)
                end
            }
        end
        -- Do the thing
        if context.joker_main then
            card.ability.extra.donezo = false
            return {
                chips = card.ability.extra.chips,
                mult = card.ability.extra.mult
            }
        end
    end
}

-- Stimulus Cheque
SMODS.Joker {
    key = "stimuluscheque",
    atlas = "nancy_jokers",
    pos = { x = 3, y = 4 },
    rarity = 1,
    blueprint_compat = true,
    cost = 5,
    discovered = true,
    config = { extra = { money = 2 }, },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = 'debuffed_playing_card', set = 'Other' }
        return { vars = { card.ability.extra.money } }
    end,
    calculate = function(self, card, context)
        if context.before then
            -- For each debuffed card in hand
            for _, _card in ipairs(G.hand.cards) do
                if _card.debuff then
                    -- Juice da card
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            _card:juice_up()
                            return true
                        end
                    }))
                    -- Muhnee buffer
                    G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + card.ability.extra.money
                    -- Do the thing!
                    SMODS.calculate_effect({
                        dollars = card.ability.extra.money,
                        message_card = context.blueprint_card or card,
                        -- Reset muhnee buffer
                        func = function()
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    G.GAME.dollar_buffer = 0
                                    return true
                                end
                            }))
                        end
                    }, card)
                end
            end
        end
    end
}

-- Useful Joker
SMODS.Joker {
    key = "usefuljoker",
    atlas = "nancy_jokers",
    pos = { x = 4, y = 4 },
    rarity = 1,
    blueprint_compat = true,
    cost = 2,
    discovered = true,
    add_to_deck = function(self, card, from_debuff)
        -- Equalize cost and sell value
        card.ability.extra_value = math.ceil(self.cost / 2)
        card:set_cost()
        -- Say a funny when obtained, say a special funny if it's a copy
        if next(SMODS.find_card("j_nancy_usefuljoker")) then
            SMODS.calculate_effect({ message = localize("nancy_usefuljoker_clone"), sound = "voice"..math.random(11) }, card)
        else
            SMODS.calculate_effect({ message = localize("nancy_usefuljoker_"..math.random(11, 15)), sound = "voice"..math.random(11) }, card)
        end
	end,
    calculate = function(self, card, context)
        -- Returns a random message from config.extra with a random jimbo sound byte (voice1-voice11)
        if context.joker_main then
            if not G.GAME.blind.triggered then
                return { message = localize("nancy_usefuljoker_"..math.random(1, 10)), sound = "voice"..math.random(11) }
            end
        end
        -- Message when boss blind effect is triggered
        if context.debuffed_hand or context.joker_main then
            if G.GAME.blind.triggered then
                return { message = localize("nancy_usefuljoker_"..math.random(16, 20)), sound = "voice"..math.random(11) }
            end
        end
        -- Message when starting blind
        if context.setting_blind then
            return { message = localize("nancy_usefuljoker_"..math.random(21, 25)), sound = "voice"..math.random(11) }
        end
        -- Message when winning blind
        if context.end_of_round and context.main_eval and not context.game_over then
            return { message = localize("nancy_usefuljoker_"..math.random(26, 30)), sound = "voice"..math.random(11) }
        end
        -- Message when entering shop
        if context.starting_shop then
            return { message = localize("nancy_usefuljoker_"..math.random(31, 35)), sound = "voice"..math.random(11) }
        end
        -- Message when leaving shop
        if context.ending_shop then
            return { message = localize("nancy_usefuljoker_"..math.random(36, 40)), sound = "voice"..math.random(11) }
        end
        -- Message when getting sold
        if context.selling_self then
            return { message = localize("nancy_usefuljoker_"..math.random(41, 45)), sound = "voice"..math.random(11) }
        end
    end
}

-- Decorative Joker
SMODS.Joker {
    key = "decorativejoker",
    atlas = "nancy_jokers",
    pos = { x = 0, y = 5 },
    rarity = 1,
    blueprint_compat = true,
    cost = 4,
    discovered = true,
    config = { extra = { mult = 3 }, },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = 'debuffed_playing_card', set = 'Other' }
        local totalmult = 0
        if G.playing_cards and #G.playing_cards > 0 then
            for _, _card in ipairs(G.playing_cards) do
                if _card.debuff then totalmult = totalmult + card.ability.extra.mult end
            end
        end
        return { vars = { card.ability.extra.mult, totalmult } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local totalmult = 0
            if G.playing_cards and #G.playing_cards > 0 then
                for _, _card in ipairs(G.playing_cards) do
                    if _card.debuff then totalmult = totalmult + card.ability.extra.mult end
                end
            end
            return { mult = totalmult }
        end
    end
}

-- Snack Tray
SMODS.Joker {
    key = "snacktray",
    atlas = "nancy_jokers",
    pos = { x = 1, y = 5 },
    rarity = 2,
    blueprint_compat = false,
    eternal_compat = false,
    cost = 7,
    discovered = true,
    config = { extra = { slots = 3, odds = 3 }, },
    loc_vars = function(self, info_queue, card)
        -- Function that return the odds after the game affects them
        local num, denom = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'nancy_snacktray')
        return { vars = { card.ability.extra.slots, num, denom } }
    end,
    -- Add consumable slots when joker obtained
    add_to_deck = function(self, card, from_debuff)
        G.consumeables:change_size(card.ability.extra.slots)
	end,
    -- Remove consumable slots when joker removed
	remove_from_deck = function(self, card, from_debuff)
        G.consumeables:change_size(-card.ability.extra.slots)
	end,
    calculate = function(self, card, context)
        -- When entering the shop
        if context.starting_shop and not context.blueprint then
            -- If the probability procs after affected by the game
            if SMODS.pseudorandom_probability(card, 'nancy_snacktray', 1, card.ability.extra.odds) then
                -- Destroy card (with food effect)
                SMODS.destroy_cards(card, nil, nil, true)
                return { message = localize('k_eaten_ex') }
            else
                return { message = localize('k_safe_ex') }
            end
        end
    end
}

-- Exposure Therapy
SMODS.Joker {
    key = "exposuretherapy",
    atlas = "nancy_jokers",
    pos = { x = 2, y = 5 },
    soul_pos = { x = 2, y = 6 },
    rarity = 4,
    blueprint_compat = false,
    cost = 20,
    discovered = true,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = 'e_negative_playing_card', set = 'Edition', config = { extra = 1 } }
    end,
    calculate = function(self, card, context)
        if (context.hand_drawn or context.other_drawn) and not context.blueprint then
            local targets = {}
            for _, _card in ipairs(G.deck.cards) do
                if _card.edition and _card.edition.key == "e_negative" and not _card.ability.nancy_exposed then
                    _card.ability.nancy_exposed = true
                    targets[#targets+1] = _card
                end
            end
            if next(targets) then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound('gong', 0.94, 0.5)
                        play_sound('gong', 0.94*1.5, 0.5)
                        for _, _card in ipairs(targets) do
                            draw_card(G.deck, G.hand, nil, nil, G.GAME.sort, _card)
                            _card.ability.nancy_exposed = nil
                        end
                        -- Trigger Shredder Tags after drawing cards
                        if G.GAME.tags then
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    for _, _tag in ipairs(G.GAME.tags) do
                                        if _tag:apply_to_run{type = 'nancy_shredder'} then break end
                                    end
                                    return true
                                end
                            }))
                        end
                        return true
                    end
                }))
                return { message = localize("nancy_exposed") }
            end
            -- Trigger Shredder Tags even if no cards were drawn cuz they won't trigger themselves if this Joker is present
            if not next(targets) then
                if G.GAME.tags then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            for _, _tag in ipairs(G.GAME.tags) do
                                if _tag:apply_to_run{type = 'nancy_shredder'} then break end
                            end
                            return true
                        end
                    }))
                end
            end
        end
    end
}

-- On the House
SMODS.Joker {
    key = "onthehouse",
    atlas = "nancy_jokers",
    pos = { x = 3, y = 5 },
    rarity = 2,
    blueprint_compat = true,
    cost = 8,
    discovered = true,
    config = { extra = { fullhouse = false }, },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = 'tag_d_six', set = 'Tag' }
    end,
    calculate = function(self, card, context)
        -- When last hand is drawn
        if context.hand_drawn and G.GAME.current_round.hands_left == 1 and not context.blueprint then
            -- Wiggle while one hand left
            local eval = function() return G.GAME.current_round.hands_left == 1 and not G.RESET_JIGGLES end
            juice_card_until(card, eval, true)
        end
        -- Record if played hand contains a full house
        if context.before and not context.blueprint then
            if next(context.poker_hands['Full House']) then
                card.ability.extra.fullhouse = true
            else
                card.ability.extra.fullhouse = false
            end
        end
        -- At end of round, if last played hand contained a full house
        if context.end_of_round and context.main_eval and not context.game_over and card.ability.extra.fullhouse then
            -- Give tag
            G.E_MANAGER:add_event(Event({
                func = (function()
                    add_tag(Tag('tag_d_six'))
                    play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
                    return true
                end)
            }))
            return { message = localize("nancy_d6tag") }
        end
    end
}

-- Consolation Prize
SMODS.Joker {
    key = "consolationprize",
    atlas = "nancy_jokers",
    pos = { x = 4, y = 5 },
    rarity = 3,
    blueprint_compat = true,
    cost = 8,
    discovered = true,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = 'debuffed_playing_card', set = 'Other' }
    end,
    calculate = function(self, card, context)
        if context.joker_main and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
            local yes = false
            for _, _card in ipairs(context.scoring_hand) do
                if _card.debuff then yes = true; break end
            end
            if yes then
                -- Code from Vanilla Remade's Vagabond
                G.GAME.consumeable_buffer = (G.GAME.consumeable_buffer or 0) + 1
                G.E_MANAGER:add_event(Event({
                    func = function()
                        SMODS.add_card{
                            set = 'Tarot',
                            key_append = 'nancy_consolationprize' -- Optional, useful for manipulating the random seed and checking the source of the creation in `in_pool`.
                        }
                        G.GAME.consumeable_buffer = 0
                        return true
                    end
                }))
                return {
                    message = localize('k_plus_tarot'),
                }
            end
        end
    end
}