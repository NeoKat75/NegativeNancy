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
    discovered = true,
    config = { jokers = {'j_nancy_negativenancy'} },
    loc_vars = function(self, info_queue, back)
        return { vars = { localize{type = 'name_text', key = self.config.jokers[1], set = 'Joker'} } }
    end
}

-- Twister Deck
SMODS.Back {
    key = "twister",
    atlas = "nancy_decks",
    pos = { x = 1, y = 0 },
    discovered = true,
    config = { jokers = {'j_nancy_laminator'} },
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
                local edipool = get_current_pool('Edition')
                -- Remove invalid items from pool
                repeat
                    local restart = false
                    for i, item in ipairs(edipool) do
                        if item == 'UNAVAILABLE' then
                            table.remove(edipool, i)
                            restart = true
                            break
                        end
                    end
                until not restart
                for _, _card in ipairs(targets) do
                    local edi = pseudorandom_element(edipool, 'nancy_twisterdeck'..G.GAME.round_resets.ante)
                    _card:set_edition(edi, true, true)
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

-- Chaotic Deck
SMODS.Back {
    key = "chaotic",
    atlas = "nancy_decks",
    pos = { x = 2, y = 0 },
    discovered = true,
    config = { ante_scaling = 2 },
    loc_vars = function(self, info_queue, back)
        return { vars = { self.config.ante_scaling } }
    end,
    apply = function(self, back)
        G.E_MANAGER:add_event(Event({
            func = function()
                -- Shallow copies are copies of a table unlinked from the original table object
                -- This is used because get_current_pool() returns the same table object every time
                local enhpool = SMODS.shallow_copy(get_current_pool('Enhanced'))
                local edipool = SMODS.shallow_copy(get_current_pool('Edition'))
                local sealpool = SMODS.shallow_copy(get_current_pool('Seal'))
                -- Remove invalid items from each pool
                for _, pool in ipairs{enhpool, edipool, sealpool} do
                    repeat
                        local restart = false
                        for i, item in ipairs(pool) do
                            if item == 'UNAVAILABLE' then
                                table.remove(pool, i)
                                restart = true
                                break
                            end
                        end
                    until not restart
                end
                -- Determine chances of each modifier
                local enh_chance = pseudorandom('nancy_chaoticdeck', 2, 9)
                local edi_chance = pseudorandom('nancy_chaoticdeck', 2, 9)
                local seal_chance = pseudorandom('nancy_chaoticdeck', 2, 9)
                --print('Enh chance: 1 in '..enh_chance)
                --print('Edi chance: 1 in '..edi_chance)
                --print('Seal chance: 1 in '..seal_chance)
                -- Do the thing
                for _, _card in ipairs(G.playing_cards) do
                    if SMODS.pseudorandom_probability(back, 'nancy_chaoticdeck', 1, enh_chance) then
                        local enh = pseudorandom_element(enhpool, 'nancy_chaoticdeck')
                        _card:set_ability(enh)
                    end
                    if SMODS.pseudorandom_probability(back, 'nancy_chaoticdeck', 1, edi_chance) then
                        local edi = pseudorandom_element(edipool, 'nancy_chaoticdeck')
                        _card:set_edition(edi, true, true)
                    end
                    if SMODS.pseudorandom_probability(back, 'nancy_chaoticdeck', 1, seal_chance) then
                        local seal = pseudorandom_element(sealpool, 'nancy_chaoticdeck')
                        _card:set_seal(seal, true, true)
                    end
                end
                return true
            end
        }))
    end
}

-- Crumpled Deck
SMODS.Back {
    key = "crumpled",
    atlas = "nancy_decks",
    pos = { x = 3, y = 0 },
    discovered = true,
    config = { joker_slot = -4, extra = { hsize = -1 } },
    loc_vars = function(self, info_queue, back)
        return { vars = { self.config.extra.hsize } }
    end,
    calculate = function(self, back, context)
        if context.card_added and context.card.ability.set == "Joker" then
            G.jokers:change_size(1)
            G.hand:change_size(self.config.extra.hsize)
        end
        if (context.joker_type_destroyed or context.selling_card) and context.card.ability.set == "Joker" then
            G.jokers:change_size(-1)
            G.hand:change_size(-self.config.extra.hsize)
        end
        G.GAME.nancy_crumpledslots = G.GAME.starting_params.hand_size + G.hand.config.card_limits.mod
    end
}

-- Creative Deck
SMODS.Back {
    key = "creative",
    atlas = "nancy_decks",
    pos = { x = 4, y = 0 },
    discovered = true,
    loc_vars = function(self, info_queue, back)
        return { vars = { colours = { G.C.ETERNAL } } }
    end,
    apply = function(self, back)
        
    end
}