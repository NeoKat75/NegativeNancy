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
            "Earn {C:money}$#1#{} if played hand contains",
            "exactly #2# {C:attention}unscored{} card"
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