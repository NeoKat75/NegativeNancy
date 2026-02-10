SMODS.ObjectType {
    key = "nancy_groceries",
    default = "j_nancy_usefuljoker",
    cards = {
        j_nancy_usefuljoker = true,
        j_gros_michel = true,
        j_egg = true,
        j_ice_cream = true,
        j_cavendish = true,
        j_turtle_bean = true,
        j_diet_cola = true,
        j_popcorn = true,
        j_ramen = true,
        j_selzer = true,
        j_credit_card = true,
        j_loyalty_card = true,
        j_burglar = true,
        j_todo_list = true,
        j_vagabond = true,
        j_gift = true,
        j_reserved_parking = true,
        j_trading = true,
        j_trousers = true,
        j_flower_pot = true,
        j_oops = true,
        j_nancy_windowshopping = true,
        j_nancy_returnpolicy = true,
        j_nancy_expiredcoupon = true,
        j_nancy_junkiejoker = true,
        j_nancy_decorativejoker = true,
        j_nancy_snacktray = true,
        j_nancy_onthehouse = true
    }
}

SMODS.Challenge {
    key = 'showcase',
    button_colour = HEX('A000A0'),
    jokers = { { id = 'j_nancy_negativenancy' } },
    rules = { custom = {
        { id = 'nancy_showcase_1' },
        { id = 'nancy_showcase_2' }
    } },
    apply = function(self)
        for k, v in pairs(G.P_BLINDS) do
            if not v.original_mod and v.key ~= 'bl_small' and v.key ~= 'bl_big' then
                G.GAME.banned_keys[v.key] = true
            end
        end
    end
}

SMODS.Challenge {
    key = 'groceries',
    button_colour = HEX('A000A0'),
    jokers = { { id = 'j_nancy_usefuljoker', eternal = true } },
    rules = { custom = {
        { id = 'nancy_groceries_1' },
        { id = 'nancy_groceries_2' }
    } },
    apply = function(self)
        for k, v in pairs(G.P_CENTERS) do
            if v.set == "Joker" and v.rarity ~= 4 and not (v.pools or {}).nancy_groceries then
                G.GAME.banned_keys[v.key] = true
            end
        end
    end
}

SMODS.Challenge {
    key = 'vandalism',
    button_colour = HEX('A000A0'),
    jokers = { { id = 'j_nancy_streetart', eternal = true } },
    restrictions = { banned_cards = {
        { id = 'j_ceremonial' }, { id = 'j_abstract' }, { id = 'j_ride_the_bus' },
        { id = 'j_runner' }, { id = 'j_blue_joker' }, { id = 'j_green_joker' },
        { id = 'j_red_card' }, { id = 'j_square' }, { id = 'j_erosion' },
        { id = 'j_fortune_teller' }, { id = 'j_stone' }, { id = 'j_bull' },
        { id = 'j_flash' }, { id = 'j_trousers' }, { id = 'j_castle' },
        { id = 'j_swashbuckler' }, { id = 'j_wee' }, { id = 'j_bootstraps' },
        { id = 'j_nancy_frugaljoker' }, { id = 'j_nancy_collector' }, { id = 'j_nancy_postmodernjoker' },
        { id = 'j_nancy_deepocean' }, { id = 'j_nancy_slotmachine' }, { id = 'j_nancy_packofbuffoons' },
        { id = 'j_nancy_decorativejoker' }
    } }
}

SMODS.Challenge {
    key = 'stairway',
    button_colour = HEX('A000A0'),
    jokers = {
        { id = 'j_nancy_stairwell' }, { id = 'j_nancy_stairwell' }, { id = 'j_joker' },
        { id = 'j_nancy_stairwell' }, { id = 'j_nancy_stairwell' }
    },
    rules = { custom = { { id = 'nancy_stairway' } } },
    restrictions = { banned_other = {
        { id = 'bl_nancy_desert', type = 'blind' },
        { id = 'bl_nancy_filter', type = 'blind' },
        { id = 'bl_nancy_purse', type = 'blind' }
    } },
    apply = function(self)
        G.E_MANAGER:add_event(Event({
            func = function()
                for _, card in ipairs(G.playing_cards) do
                    SMODS.debuff_card(card, true, 'nancy_stairway')
                end
                return true
            end
        }))
    end
}