-- Tag atlas
SMODS.Atlas {
    key = "tags",
    path = "tags.png",
    px = 34,
    py = 34
}

-- Secret Tag
SMODS.Tag {
    key = "secret",
    atlas = "tags",
    pos = { x = 0, y = 0 },
    no_collection = true,
    in_pool = function(self, args)
        return false
    end
}

-- Accolades Tag
SMODS.Tag {
    key = "accolades",
    atlas = "tags",
    pos = { x = 1, y = 0 },
    discovered = true,
    config = { money = 4 },
    loc_vars = function(self, info_queue, tag)
        local count = 0
        for _, _card in ipairs(G.playing_cards or {}) do
            if _card.edition then count = count + 1 end
        end
        return { vars = { tag.config.money, tag.config.money * count } }
    end,
    apply = function(self, tag, context)
        if context.type == 'immediate' then
            local count = 0
            for _, _card in ipairs(G.playing_cards or {}) do
                if _card.edition then count = count + 1 end
            end
            local lock = tag.ID
            G.CONTROLLER.locks[lock] = true
            tag:yep('+', G.C.MONEY, function()
                G.CONTROLLER.locks[lock] = nil
                return true
            end)
            ease_dollars(tag.config.money * count)
            tag.triggered = true
            return true
        end
    end,
    in_pool = function(self, args)
        for _, _card in ipairs(G.playing_cards or {}) do
            if _card.edition then
                return true
            end
        end
        return false
    end
}

-- Priority Tag
SMODS.Tag {
    key = "priority",
    atlas = "tags",
    pos = { x = 2, y = 0 },
    discovered = true,
    loc_vars = function(self, info_queue, tag)
        info_queue[#info_queue + 1] = { key = 'e_negative_playing_card', set = 'Edition', config = { extra = 1 } }
    end,
    apply = function(self, tag, context)
        if context.type == 'nancy_priority' then
            local targets = {}
            for _, _card in ipairs(G.deck.cards) do
                if _card.edition and _card.edition.key == "e_negative" and not _card.ability.nancy_exposed then
                    _card.ability.nancy_exposed = true
                    targets[#targets+1] = _card
                end
            end
            if next(targets) then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        for _, _card in ipairs(targets) do
                            draw_card(G.deck, G.hand, nil, nil, G.GAME.sort, _card)
                            _card.ability.nancy_exposed = nil
                        end
                        return true
                    end
                }))
            end
            tag:yep('+', G.C.RARITY[4], function()
                if next(targets) then
                    play_sound('gong', 0.94, 0.3)
                    play_sound('gong', 0.94*1.5, 0.3)
                end
                -- Trigger Shredder Tags if no Exposure Therapy to do it instead
                if G.GAME.tags and not next(SMODS.find_card("j_nancy_exposuretherapy")) then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            for _, _tag in ipairs(G.GAME.tags) do
                                if _tag:apply_to_run{type = 'nancy_shredder'} then break end
                            end
                            return true
                        end
                    }))
                end
                return true
            end)
            tag.triggered = true
            return true
        end
    end,
    in_pool = function(self, args)
        for _, _card in ipairs(G.playing_cards or {}) do
            if _card.edition and _card.edition.key == "e_negative" then
                return true
            end
        end
        return false
    end
}

-- Shredder Tag
SMODS.Tag {
    key = "shredder",
    atlas = "tags",
    pos = { x = 3, y = 0 },
    discovered = true,
    loc_vars = function(self, info_queue, tag)
        info_queue[#info_queue + 1] = { key = 'debuffed_playing_card', set = 'Other' }
    end,
    apply = function(self, tag, context)
        if context.type == 'nancy_shredder' and not G.CONTROLLER.locks.nancy_makenegatives then
            local targets = {}
            for _, _card in ipairs(G.hand.cards) do
                if _card.debuff then targets[#targets+1] = _card end
            end
            if next(targets) then
                tag:yep('+', G.C.RED, function()
                    SMODS.destroy_cards(targets)
                    return true
                end)
                tag.triggered = true
                return true
            end
        end
    end
}