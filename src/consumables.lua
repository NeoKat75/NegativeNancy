-- Consumable atlas
SMODS.Atlas {
    key = "nancy_consumables",
    path = "consumables.png",
    px = 71,
    py = 95
}

-- The Downpour
SMODS.Consumable {
    key = 'downpour',
    set = 'Tarot',
    discovered = true,
    atlas = "nancy_consumables",
    pos = { x = 0, y = 0 },
    config = { max_highlighted = 1 },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = 'e_negative_playing_card', set = 'Edition', config = { extra = 1 } }
        info_queue[#info_queue + 1] = { key = 'debuffed_playing_card', set = 'Other' }
        return { vars = { card.ability.max_highlighted } }
    end,
    -- Mostly from Vanilla Remade's Cryptid
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            func = function()
                G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                local _card = copy_card(G.hand.highlighted[1], nil, nil, G.playing_card)
                -- Make new card negative
                _card:set_edition('e_negative')
                _card:add_to_deck()
                G.deck.config.card_limit = G.deck.config.card_limit + 1
                table.insert(G.playing_cards, _card)
                G.hand:emplace(_card)
                _card:start_materialize()
                -- Debuff original card and play sound wombo-combo
                SMODS.debuff_card(G.hand.highlighted[1], true, "nancy")
                G.hand.highlighted[1]:juice_up()
                card:juice_up(0.3, 0.5)
                play_sound('tarot2', 1, 0.4)
                G.E_MANAGER:add_event(Event({
                    blocking = false,
                    blockable = false,
                    trigger = 'after',
                    delay = 0.06*G.SETTINGS.GAMESPEED,
                    func = function()
                        play_sound('tarot2', 0.76, 0.4)
                        return true
                    end
                }))
                G.hand:unhighlight_all()
                SMODS.calculate_context({ playing_card_added = true, cards = {_card} })
                return true
            end
        }))
        delay(0.5)
    end
    -- The config field already handles the functionality so it doesn't need to be implemented
    -- The following is how the implementation would be
    --[[
    can_use = function(self, card)
        return G.hand and #G.hand.highlighted <= card.config.max_highlighted and #G.hand.highlighted > 0
    end
    --]]
}

-- The Trainee
SMODS.Consumable {
    key = 'trainee',
    set = 'Tarot',
    discovered = true,
    atlas = "nancy_consumables",
    pos = { x = 1, y = 0 },
    config = { max_highlighted = 2, min_highlighted = 2 },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = 'debuffed_playing_card', set = 'Other' }
        return { vars = { card.ability.max_highlighted } }
    end,
    -- Mostly from Vanilla Remade's Death
    use = function(self, card, area, copier)
        -- Flip cards
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        for i = 1, #G.hand.highlighted do
            local percent = 1.15 - (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.hand.highlighted[i]:flip()
                    play_sound('card1', percent)
                    G.hand.highlighted[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        delay(0.2)
        -- Do the thing
        -- Figure out rightmost card based on screen position
        local rightmost = G.hand.highlighted[1]
        for i = 1, #G.hand.highlighted do
            if G.hand.highlighted[i].T.x > rightmost.T.x then
                rightmost = G.hand.highlighted[i]
            end
        end
        -- Figure out leftmost card if it's not rightmost card
        local leftmost
        for i = 1, #G.hand.highlighted do
            if G.hand.highlighted[i] ~= rightmost then
                leftmost = G.hand.highlighted[i]
            end
        end
        -- Do the thing fr
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.1,
            func = function()
                if leftmost.config.center.key == "c_base" and rightmost.config.center.key ~= "c_base" then
                    leftmost:set_ability(rightmost.config.center.key)
                end
                if not leftmost.edition and rightmost.edition then
                    leftmost:set_edition(rightmost.edition.key, true, true)
                end
                if not leftmost.seal and rightmost.seal then
                    leftmost:set_seal(rightmost.seal, true, true)
                end
                SMODS.debuff_card(rightmost, true, "nancy")
                return true
            end
        }))
        -- Unflip cards
        for i = 1, #G.hand.highlighted do
            local percent = 0.85 + (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.hand.highlighted[i]:flip()
                    play_sound('tarot2', percent, 0.6)
                    G.hand.highlighted[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                G.hand:unhighlight_all()
                return true
            end
        }))
        delay(0.5)
    end
    -- The config field already handles the functionality so it doesn't need to be implemented
    -- The following is how the implementation would be
    --[[
    can_use = function(self, card)
        return G.hand and #G.hand.highlighted >= card.ability.extra.min_highlighted and
            #G.hand.highlighted <= card.ability.max_highlighted
    end
    --]]
}

-- The Offering
SMODS.Consumable {
    key = 'offering',
    set = 'Tarot',
    discovered = true,
    atlas = "nancy_consumables",
    pos = { x = 2, y = 0 },
    config = { extra = { max_highlighted = 1 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = 'tag_charm', set = 'Tag' }
        info_queue[#info_queue + 1] = { key = 'tag_ethereal', set = 'Tag' }
        info_queue[#info_queue + 1] = { key = 'tag_meteor', set = 'Tag' }
        info_queue[#info_queue + 1] = { key = 'tag_standard', set = 'Tag' }
        info_queue[#info_queue + 1] = { key = 'debuffed_playing_card', set = 'Other' }
        info_queue[#info_queue + 1] = { key = 'tag_buffoon', set = 'Tag' }
        return { vars = { card.ability.extra.max_highlighted } }
    end,
    use = function(self, card, area, copier)
        -- Debuff card
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.1,
            func = function()
                SMODS.debuff_card(G.hand.highlighted[1], true, "nancy")
                G.hand.highlighted[1]:juice_up()
                card:juice_up(0.3, 0.5)
                play_sound('tarot2', 1, 0.4)
                G.E_MANAGER:add_event(Event({
                    blocking = false,
                    blockable = false,
                    trigger = 'after',
                    delay = 0.06*G.SETTINGS.GAMESPEED,
                    func = function()
                        play_sound('tarot2', 0.76, 0.4)
                        return true
                    end
                }))
                return true
            end
        }))
        delay(0.5)
        -- Give random tag
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.1,
            func = function()
                local tag = pseudorandom_element({"tag_charm", "tag_ethereal", "tag_meteor", "tag_standard", "tag_buffoon"}, "nancy_offering")
                card:juice_up(0.3, 0.5)
                add_tag(Tag(tag))
                play_sound('generic1')
                play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
                return true
            end
        }))
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                G.hand:unhighlight_all()
                return true
            end
        }))
        delay(0.5)
    end,
    -- Usable if the 1 selected card has an edition and isn't debuffed
    can_use = function(self, card)
        return G.hand and #G.hand.highlighted <= card.ability.extra.max_highlighted and #G.hand.highlighted > 0
            and G.hand.highlighted[1].edition and not G.hand.highlighted[1].debuff
    end
}