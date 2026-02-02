-- Stake atlas
SMODS.Atlas {
    key = "stakes",
    path = "stakes.png",
    px = 29,
    py = 29
}

-- Sticker atlas
SMODS.Atlas {
    key = "stickers",
    path = "stickers.png",
    px = 71,
    py = 95
}

SMODS.Stake {
    key = "emerald",
    prefix_config = { applied_stakes = { mod = false }, above_stake = { mod = false } },
    applied_stakes = { "gold" },
    above_stake = "gold",
    atlas = "stakes",
    pos = { x = 0, y = 0 },
    sticker_atlas = "stickers",
    sticker_pos = { x = 1, y = 0 },
    colour = HEX('068b54'),
    shiny = true,
    modifiers = function()
        G.GAME.modifiers.nancy_enable_bindings_in_shop = true
    end
}

-- Functionality and Rental intercompatibility handled via Lovely patches
SMODS.Sticker {
    key = "binding",
    badge_colour = HEX('068b54'),
    atlas = "stickers",
    pos = { x = 0, y = 0 },
    should_apply = false
}