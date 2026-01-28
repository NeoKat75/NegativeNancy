-- Deck atlas
SMODS.Atlas {
    key = "nancy_decks",
    path = "decks.png",
    px = 71,
    py = 95
}

-- Nancy Deck
SMODS.Back {
    key = "nancy",
    atlas = "nancy_decks",
    pos = { x = 0, y = 0 },
    config = { jokers = {'j_nancy_negativenancy'} },
    discovered = true,
    loc_vars = function(self, info_queue, back)
        return {
            vars = { localize{type = 'name_text', key = self.config.jokers[1], set = 'Joker'} }
        }
    end
}