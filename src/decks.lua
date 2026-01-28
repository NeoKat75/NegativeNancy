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
        return { vars = { localize{type = 'name_text', key = self.config.jokers[1], set = 'Joker'} } }
    end
}

-- Twister Deck
SMODS.Back {
    key = "twister",
    atlas = "nancy_decks",
    pos = { x = 1, y = 0 },
    config = { jokers = {'j_nancy_laminator'} },
    discovered = true,
    loc_vars = function(self, info_queue, back)
        return { vars = { localize{type = 'name_text', key = self.config.jokers[1], set = 'Joker'} } }
    end,
    calculate = function(self, back, context)
        if context.starting_shop then
            local targets = {}
            for _, _card in ipairs(G.playing_cards or {}) do
                if _card.edition then targets[#targets+1] = _card end
            end
            if next(targets) then
                for _, _card in ipairs(targets) do
                    local edition = poll_edition('nancy_twisterdeck'..G.GAME.round_resets.ante, nil, nil, true)
                    _card:set_edition(edition, true, true)
                end
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound('gong', 0.94, 0.5)
                        play_sound('gong', 0.94*1.5, 0.5)
                        return true
                    end
                }))
                return { message = localize('nancy_twisted') }
            end
        end
    end
}