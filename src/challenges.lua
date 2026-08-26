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
        j_trousers = true,
        j_flower_pot = true,
        j_nancy_windowshopping = true,
        j_nancy_returnpolicy = true,
        j_nancy_expiredcoupon = true,
        j_nancy_decorativejoker = true,
        j_nancy_snacktray = true,
        j_nancy_onthehouse = true
    }
}

SMODS.Challenge {
    key = 'showcase',
    button_colour = HEX('BF00BF'),
    jokers = { { id = 'j_nancy_negativenancy' } },
    rules = { custom = {
        { id = 'nancy_showcase_1' },
        { id = 'nancy_showcase_2' }
    } },
    restrictions = { banned_cards = { { id = 'v_hieroglyph' }, { id = 'v_petroglyph' } } },
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
    button_colour = HEX('BF00BF'),
    jokers = { { id = 'j_nancy_usefuljoker', eternal = true } },
    rules = { custom = { { id = 'nancy_groceries' } } },
    apply = function(self)
        for k, v in pairs(G.P_CENTERS) do
            if v.set == "Joker" and v.rarity ~= 4 and not (v.pools or {}).nancy_groceries then
                G.GAME.banned_keys[v.key] = true
            end
        end
    end
}

SMODS.Challenge {
    key = 'stairway',
    button_colour = HEX('BF00BF'),
    jokers = {
        { id = 'j_nancy_stairwell' }, { id = 'j_nancy_stairwell' }, { id = 'j_joker' },
        { id = 'j_nancy_stairwell' }, { id = 'j_nancy_stairwell' }
    },
    rules = { custom = { { id = 'nancy_stairway' } } },
    restrictions = {
        banned_cards = {
            { id = 'j_nancy_stimuluscheque' },
            { id = 'j_nancy_decorativejoker' },
            { id = 'j_nancy_consolationprize' }
        },
        banned_tags = { { id = 'tag_nancy_shredder' } },
        banned_other = {
            { id = 'bl_nancy_desert', type = 'blind' },
            { id = 'bl_nancy_filter', type = 'blind' },
            { id = 'bl_nancy_purse', type = 'blind' }
        }
    },
    apply = function(self)
        G.E_MANAGER:add_event(Event({
            func = function()
                for _, card in ipairs(G.playing_cards) do
                    SMODS.debuff_card(card, true, 'nancy_stairway')
                end
                return true
            end
        }))
    end,
    calculate = function(self, context)
        if context.playing_card_added then
            for _, card in ipairs(context.cards) do
                if not (card.edition and card.edition.key == "e_negative") then
                    SMODS.debuff_card(card, true, 'nancy_stairway')
                end
            end
        end
        if context.setting_ability then
            if not (context.other_card.edition and context.other_card.edition.key == "e_negative") then
                SMODS.debuff_card(context.other_card, true, 'nancy_stairway')
            end
        end
    end
}

SMODS.Challenge {
    key = 'printing',
    button_colour = HEX('BF00BF'),
    jokers = { { id = 'j_nancy_laminator' }, { id = 'j_nancy_laminator' }, { id = 'j_nancy_laminator' } },
    rules = { custom = { { id = 'nancy_printing' } } },
    restrictions = {
        banned_cards = {
            { id = 'j_midas_mask' }, { id = 'c_familiar' }, { id = 'c_grim' },
            { id = 'c_incantation' }, { id = 'v_illusion' }
        },
        banned_other = { { id = 'bl_nancy_file', type = 'blind' } }
    },
    apply = function(self)
        local pool = SMODS.get_clean_pool('Enhanced')
        for _, enh in ipairs(pool) do G.GAME.banned_keys[enh] = true end
    end,
    calculate = function(self, context)
        if context.setting_ability and context.other_card.playing_card and context.new ~= 'c_base' then
            context.other_card:set_ability('c_base')
        end
    end
}

SMODS.Challenge {
    key = 'reroll',
    button_colour = HEX('BF00BF'),
    jokers = { { id = 'j_nancy_onthehouse' } },
    rules = { modifiers = { { id = 'reroll_cost', value = 50 } } }
}

SMODS.Challenge {
    key = 'vandalism',
    button_colour = HEX('BF00BF'),
    jokers = { { id = 'j_nancy_streetart', eternal = true } },
    restrictions = { banned_cards = {
        { id = 'j_runner' }, { id = 'j_blue_joker' }, { id = 'j_square' }, { id = 'j_stone' }, { id = 'j_bull' },
        { id = 'j_castle' }, { id = 'j_wee' }, { id = 'j_nancy_keepsakes' }, { id = 'j_nancy_postmodernjoker' },
        { id = 'j_nancy_deepocean' },
        { id = 'j_ceremonial' }, { id = 'j_abstract' }, { id = 'j_ride_the_bus' }, { id = 'j_green_joker' },
        { id = 'j_red_card' }, { id = 'j_erosion' }, { id = 'j_fortune_teller' }, { id = 'j_flash' }, { id = 'j_trousers' },
        { id = 'j_swashbuckler' }, { id = 'j_bootstraps' }, { id = 'j_nancy_frugaljoker' }, { id = 'j_nancy_slotmachine' },
        { id = 'j_nancy_packofbuffoons' }, { id = 'j_nancy_decorativejoker' },
        { id = 'j_stencil' }, { id = 'j_steel_joker' }, { id = 'j_constellation' }, { id = 'j_madness' },
        { id = 'j_vampire' }, { id = 'j_hologram' }, { id = 'j_obelisk' }, { id = 'j_lucky_cat' },
        { id = 'j_campfire' }, { id = 'j_throwback' }, { id = 'j_glass' }, { id = 'j_hit_the_road' },
        { id = 'j_nancy_countjokula' }, { id = 'j_caino' }, { id = 'j_yorick' }
    } }
}

SMODS.Challenge {
    key = 'lowp',
    button_colour = HEX('BF00BF'),
    rules = { custom = { { id = 'nancy_lowp_1' }, { id = 'nancy_lowp_2' } } },
    config = { extra = 0 },
    calculate = function(self, context)
        if context.first_hand_drawn and self.config.extra > 0 then
            G.GAME.blind.chips = math.floor(G.GAME.blind.chips + self.config.extra)
            G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
            NegaNancy.wiggle_blind()
            if G.deck and next(G.deck.cards) then
                G.deck.cards[1]:juice_up()
            else
                G.deck:juice_up()
            end
        end
        if context.end_of_round and context.main_eval then
            self.config.extra = G.GAME.chips - G.GAME.blind.chips
            if self.config.extra < 0 then self.config.extra = 0 end
            if G.deck and next(G.deck.cards) then
                SMODS.calculate_effect({message = '+'..tostring(self.config.extra), delay = 3}, G.deck.cards[1])
            else
                SMODS.calculate_effect({message = '+'..tostring(self.config.extra), delay = 3}, G.deck)
            end
        end
    end
}

SMODS.Challenge {
    key = 'high',
    button_colour = HEX('BF00BF'),
    jokers = { { id = 'j_splash', eternal = true }, { id = 'j_joker' }, },
    rules = { custom = { { id = 'nancy_high' } } },
    restrictions = { banned_other = {
        { id = 'bl_mouth', type = 'blind' },
        { id = 'bl_nancy_crowd', type = 'blind' }
    } },
    calculate = function(self, context)
        if context.debuff_hand and context.scoring_name ~= "High Card" then
            local deck
            if G.deck and next(G.deck.cards) then
                deck = G.deck.cards[1]
            else
                deck = G.deck
            end
            return {
                debuff = true,
                debuff_text = "Only High Card is allowed!",
                debuff_source = deck
            }
        end
    end
}

SMODS.Challenge {
    key = 'dance',
    button_colour = HEX('BF00BF'),
    jokers = { { id = 'j_joker' } },
    deck = { type = 'Challenge Deck', edition = 'negative' },
    rules = { custom = { { id = 'nancy_dance' } } },
    restrictions = { banned_other = {
        { id = 'bl_mouth', type = 'blind' },
        { id = 'bl_nancy_purse', type = 'blind' }
    } },
    config = { extra = "High Card" },
    apply = function(self)
        G.E_MANAGER:add_event(Event({
            func = function()
                local _poker_hands = {}
                for handname, _ in pairs(G.GAME.hands) do
                    if SMODS.is_poker_hand_visible(handname) then
                        _poker_hands[#_poker_hands + 1] = handname
                    end
                end
                self.config.extra = pseudorandom_element(_poker_hands, 'nancy_dance')
                return true
            end
        }))
    end,
    calculate = function(self, context)
        if context.debuff_hand and context.scoring_name ~= self.config.extra then
            local deck
            if G.deck and next(G.deck.cards) then
                deck = G.deck.cards[1]
            else
                deck = G.deck
            end
            return {
                debuff = true,
                debuff_text = "Only "..self.config.extra.." is allowed!",
                debuff_source = deck
            }
        end
        if context.starting_shop then
            local _poker_hands = {}
            for handname, _ in pairs(G.GAME.hands) do
                if SMODS.is_poker_hand_visible(handname) and handname ~= self.config.extra then
                    _poker_hands[#_poker_hands + 1] = handname
                end
            end
            self.config.extra = pseudorandom_element(_poker_hands, 'nancy_dance')
            if G.deck and next(G.deck.cards) then
                SMODS.calculate_effect({message = self.config.extra, delay = 3}, G.deck.cards[1])
            else
                SMODS.calculate_effect({message = self.config.extra, delay = 3}, G.deck)
            end
        end
        if context.setting_blind then
            if G.deck and next(G.deck.cards) then
                SMODS.calculate_effect({message = self.config.extra, delay = 3}, G.deck.cards[1])
            else
                SMODS.calculate_effect({message = self.config.extra, delay = 3}, G.deck)
            end
        end
    end
}

SMODS.Challenge {
    key = 'victory',
    button_colour = HEX('BF00BF'),
    jokers = { { id = 'j_nancy_exposuretherapy', eternal = true, edition = 'negative' } },
    consumeables = { { id = 'c_nancy_flood' }, { id = 'c_nancy_mastery' } },
    vouchers = { { id = 'v_nancy_scarf' }, { id = 'v_nancy_purse' } },
    rules = { custom = {
        { id = 'nancy_victory_1' },
        { id = 'nancy_victory_2' }
    } },
    apply = function(self)
        for k, v in pairs(G.P_BLINDS) do
            if not v.original_mod and string.sub(v.key, 1, 8) == "bl_final" then
                G.GAME.banned_keys[v.key] = true
            end
        end
        G.GAME.stake = G.P_STAKES.stake_nancy_emerald.order
        SMODS.setup_stake(G.P_STAKES.stake_nancy_emerald.order)
    end
}