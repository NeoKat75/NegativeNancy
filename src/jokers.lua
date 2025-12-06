-- Count Jokula
SMODS.Joker {
    key = "countjokula",
    pos = { x = 0, y = 0 },
    rarity = 2,
    blueprint_compat = true,
    cost = 6,
    discovered = true,
    config = { extra = { xmult = 1, gain = 0.01, loss = 0.01 }, },
    loc_txt = {
        name = "Count Jokula",
        text = {
            "While in a round:",
            "Gains {X:mult,C:white}X#2#{} Mult per card {C:attention}drawn{}",
            "Loses {X:mult,C:white}X#3#{} Mult per card {C:attention}played{}",
            "{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult)"
        },
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult, card.ability.extra.gain, card.ability.extra.loss } }
    end,
    calculate = function(self, card, context)
        -- After a hand is drawn
        if context.hand_drawn and not context.blueprint then
            -- Scale xmult up by amount of cards drawn * 'gain'
            card.ability.extra.xmult = card.ability.extra.xmult + #context.hand_drawn * card.ability.extra.gain
            return { message = localize('k_upgrade_ex'), colour = G.C.UI_MULT }
        end
        -- Before a hand is played and if xmult > 1
        if context.press_play and card.ability.extra.xmult > 1 and not context.blueprint then
            -- For timing purposes so played cards can be accessed
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.3,
                func = function()
                    -- Scale xmult down by amount of cards played * 'loss'
                    card.ability.extra.xmult = card.ability.extra.xmult - #G.play.cards * card.ability.extra.loss
                    -- Makes sure xmult is at least 1
                    if card.ability.extra.xmult < 1 then card.ability.extra.xmult = 1 end
                    return true
                end
            }))
            return { message = "Downgrade!", colour = G.C.UI_MULT }
        end
        -- When joker is scored
        if context.joker_main then
            -- Give 'xmult' as xmult
            return { xmult = card.ability.extra.xmult }
        end
    end
}

-- Snack Tray
SMODS.Joker {
    key = "snacktray",
    pos = { x = 0, y = 0 },
    rarity = 2,
    blueprint_compat = false,
    eternal_compat = false,
    cost = 6,
    discovered = true,
    config = { extra = { slots = 3, odds = 3 }, },
    loc_txt = {
        name = "Snack Tray",
        text = {
            "{C:attention}+#1#{} consumable slots",
            "{C:green}#2# in #3#{} chance this gets",
            "eaten when entering {C:attention}shop"
        },
    },
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

-- On the House
SMODS.Joker {
    key = "onthehouse",
    pos = { x = 0, y = 0 },
    rarity = 2,
    blueprint_compat = true,
    cost = 6,
    discovered = true,
    config = { extra = { fullhouse = false }, },
    loc_txt = {
        name = "On the House",
        text = {
            "Once per round, create a",
            "free {C:attention}D6 Tag{} if played hand",
            "contains a {C:attention}Full House"
        },
    },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = 'tag_d_six', set = 'Tag' }
    end,
    calculate = function(self, card, context)
        -- When first hand is drawn
        if context.first_hand_drawn and not context.blueprint then
            -- Wiggle while fullhouse = false
            local eval = function() return card.ability.extra.fullhouse == false and not G.RESET_JIGGLES end
            juice_card_until(card, eval, true)
            -- print("Started juicing!")
        end
        -- When a hand containing full house is played
        if context.before and next(context.poker_hands['Full House']) and card.ability.extra.fullhouse == false then
            -- Give tag
            -- print("Played full house, var is true!")
            G.E_MANAGER:add_event(Event({
                func = (function()
                    add_tag(Tag('tag_d_six'))
                    play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
                    return true
                end)
            }))
            -- Set var to true after scoring for blueprint compat
            return {
                message = "+1 D6 Tag",
                func = function()
                    -- This is for timing purposes, this goes after scoring
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            card.ability.extra.fullhouse = true
                            return true
                        end
                    }))
                end
            }
        end
        -- At end of round if var is true
        if context.end_of_round and context.main_eval and context.game_over == false
        and card.ability.extra.fullhouse == true and not context.blueprint then
            -- Set var back to false
            -- (Main eval prevents calculations in context.individual and context.repetitions at end of round)
            -- print("Reset var to false!")
            card.ability.extra.fullhouse = false
        end
    end
}

-- Window Shopping
SMODS.Joker {
    key = "windowshopping",
    pos = { x = 0, y = 0 },
    rarity = 1,
    blueprint_compat = true,
    cost = 4,
    discovered = true,
    config = { extra = { times = 2 }, },
    loc_txt = {
        name = "Window Shopping",
        text = {
            "Adds {C:attention}double{} your current",
            "{C:attention}hand size{} to Mult"
        },
    },
    calculate = function(self, card, context)
        -- When joker is scored
        if context.joker_main then
            -- Give hand size * 'times' var as mult
            return { mult = G.hand.config.card_limit * card.ability.extra.times }
        end
    end
}

-- Junkie Joker
SMODS.Joker {
    key = "junkiejoker",
    pos = { x = 0, y = 0 },
    rarity = 1,
    blueprint_compat = true,
    cost = 4,
    discovered = true,
    config = { extra = { dollars = 3, cards = 1 }, },
    loc_txt = {
        name = "Junkie Joker",
        text = {
            "Earn {C:money}$#1#{} if played hand",
            "contains exactly {C:attention}#2#",
            "{C:attention}unscored{} card"
        },
    },
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