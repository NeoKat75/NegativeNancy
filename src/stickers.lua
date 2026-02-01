-- Sticker atlas
SMODS.Atlas {
    key = "stickers",
    path = "stickers.png",
    px = 71,
    py = 95
}

SMODS.Sticker {
    key = "baneful",
    badge_colour = HEX('068b54'),
    atlas = "stickers",
    pos = { x = 0, y = 0 },
    config = { extra = { hsize = -1 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { self.config.extra.hsize } }
    end,
    should_apply = function(self, card, center, area, bypass_reroll)
        return G.GAME.modifiers.nancy_enable_banefuls_in_shop and not card.ability.rental
    end,
    calculate = function(self, card, context)
        
    end
}