-- Soup Bowl
SMODS.Joker {
    key = "soupbowl",
    pos = { x = 0, y = 0 },
    rarity = 2,
    blueprint_compat = false,
    eternal_compat = false,
    cost = 6,
    discovered = true,
    config = { extra = { slots = 3, odds = 3 }, },
    loc_txt = {
        name = "Soup Bowl",
        text = {
            "{C:attention}+#1#{} consumable slots",
            "{C:green}#2# in #3#{} chance this gets",
            "eaten when entering {C:attention}shop"
        },
    },
    loc_vars = function(self, info_queue, card)
        local num, denom = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'nancy_soupbowl')
        return { vars = { card.ability.extra.slots, num, denom } }
    end,
    add_to_deck = function(self, card, from_debuff)
        G.consumeables.config.card_limit = G.consumeables.config.card_limit + card.ability.extra.slots
	end,
	remove_from_deck = function(self, card, from_debuff)
        G.consumeables.config.card_limit = G.consumeables.config.card_limit - card.ability.extra.slots
	end,
    calculate = function(self, card, context)
        if context.starting_shop and not context.blueprint then
            if SMODS.pseudorandom_probability(card, 'nancy_soupbowl', 1, card.ability.extra.odds) then
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
                message = "Rewarded!",
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