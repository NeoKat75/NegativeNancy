-- Voucher atlas
SMODS.Atlas {
    key = "vouchers",
    path = "vouchers.png",
    px = 71,
    py = 95
}

-- Dainty Scarf
SMODS.Voucher {
    key = 'scarf',
    atlas = 'vouchers',
    pos = { x = 0, y = 0 },
    discovered = true,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = 'e_negative_playing_card', set = 'Edition', config = { extra = 1 } }
    end,
    calculate = function(self, card, context)
        if context.modify_scoring_hand and context.other_card.edition and context.other_card.edition.key == "e_negative" then
            return { add_to_hand = true }
        end
    end
}

-- Velvet Purse
SMODS.Voucher {
    key = 'purse',
    atlas = 'vouchers',
    pos = { x = 1, y = 0 },
    discovered = true,
    requires = { 'v_nancy_scarf' },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = 'e_negative_playing_card', set = 'Edition', config = { extra = 1 } }
    end
}