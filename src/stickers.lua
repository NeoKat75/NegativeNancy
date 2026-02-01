-- Sticker atlas
SMODS.Atlas {
    key = "stickers",
    path = "stickers.png",
    px = 71,
    py = 95
}

-- Functionality and Rental intercompatibility handled via Lovely patches
SMODS.Sticker {
    key = "baneful",
    badge_colour = HEX('068b54'),
    atlas = "stickers",
    pos = { x = 0, y = 0 },
    should_apply = false
}