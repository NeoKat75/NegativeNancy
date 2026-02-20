---@diagnostic disable: duplicate-set-field

-- Allow negative cards in standard packs and from Illusion
-- save the orig function (no executing)
local polledition = poll_edition
-- overwrite the orig function
function poll_edition(_key, _mod, _no_neg, _guaranteed)
    -- before the orig function
    if _key == 'standard_edition'..G.GAME.round_resets.ante or _key == 'illusion' then _no_neg = false end
    -- execute and save the orig function's return
    local ret = polledition(_key, _mod, _no_neg, _guaranteed)
    -- after the orig function
    ---- do nothing!
    -- actually return the orig function's return
    return ret
end



-- Stairway to Heaven challenge functionality
local setedition = Card.set_edition
function Card:set_edition(edition, immediate, silent)
    local ret = setedition(self, edition, immediate, silent)
    if G.GAME.challenge and G.GAME.challenge == 'c_nancy_stairway' and self.playing_card then
        if self.edition and self.edition.key == 'e_negative' then
            SMODS.debuff_card(self, false, 'nancy_stairway')
        else
            SMODS.debuff_card(self, true, 'nancy_stairway')
        end
    end
    return ret
end



-- The Purse functionality
local shuffle = CardArea.shuffle
function CardArea:shuffle(_seed)
    local ret = shuffle(self, _seed)
    if self == G.deck and _seed == 'nr'..G.GAME.round_resets.ante
        and G.GAME.blind and G.GAME.blind.config.blind.key == 'bl_nancy_purse'
        and not G.GAME.blind.disabled and not next(SMODS.find_card('j_chicot'))
        -- blind.disabled check is reduntant for vanilla-only content, but just incase
    then
        -- I took this from All in Jest's Headstone.
        -- I don't understand why my code was crashing and failing to index 'card',
        -- but this doesn't crash when it's basically the exact same thing...
        -- UPDATE: maybe it's because I was using ipairs() and the i wasn't the same as the i in this code???
        local targets = {}
        for i = #self.cards, 1, -1 do
            local card = self.cards[i]
            if card.edition then
                table.insert(targets, card)
                table.remove(self.cards, i)
            end
        end
        for _, card in ipairs(targets) do
            table.insert(self.cards, 1, card)
        end
    end
    return ret
end

-- Velvet Purse and Priority Tag
local shuffle = CardArea.shuffle
function CardArea:shuffle(_seed)
    local ret = shuffle(self, _seed)
    if self == G.deck and _seed == 'nr'..G.GAME.round_resets.ante then
        SMODS.calculate_context{nancy_velvetpurse = true}
        if next(G.GAME.tags) then
            for _, tag in ipairs(G.GAME.tags) do
                if tag:apply_to_run{type = 'nancy_priority'} then break end
            end
        end
    end
    return ret
end



-- Add joker to jokerlist if it's unique when it's added (mostly taken from Vanilla Remade)
local card_add_to_deck_ref = Card.add_to_deck
function Card:add_to_deck(from_debuff)
    local ret = card_add_to_deck_ref(self, from_debuff)
    G.GAME.nancy_jokerlist = G.GAME.nancy_jokerlist or {}
    if not from_debuff -- If the card wasn't added by being undebuffed
        and self.ability.set == "Joker" -- and the card (`self` in this case) is a Joker
        and not G.GAME.nancy_jokerlist[self.config.center.key] -- and it's not already in the jokerlist
    then
        G.GAME.nancy_jokerlist[self.config.center.key] = true
    end
    return ret
end



-- Binding sticker functionality (obtaining or undebuffing Joker)
local card_add_to_deck_ref = Card.add_to_deck
function Card:add_to_deck(from_debuff)
    if not self.added_to_deck and self.ability.nancy_binding and G.hand then G.hand:change_size(-1) end
    local ret = card_add_to_deck_ref(self, from_debuff)
    return ret
end

-- Binding sticker functionality (removing or debuffing Joker)
local card_remove_from_deck_ref = Card.remove_from_deck
function Card:remove_from_deck(from_debuff)
    if self.added_to_deck and self.ability.nancy_binding and G.hand then G.hand:change_size(1) end
    local ret = card_remove_from_deck_ref(self, from_debuff)
    return ret
end



-- Disable play button during makenegatives()
local canplay = G.FUNCS.can_play
function G.FUNCS.can_play(e)
    local ret = canplay(e)
    if G.CONTROLLER.locks.nancy_makenegatives then
        e.config.colour = G.C.UI.BACKGROUND_INACTIVE
        e.config.button = nil
    end
    return ret
end

-- Disable discard button during makenegatives()
local candiscard = G.FUNCS.can_discard
function G.FUNCS.can_discard(e)
    local ret = candiscard(e)
    if G.CONTROLLER.locks.nancy_makenegatives then
        e.config.colour = G.C.UI.BACKGROUND_INACTIVE
        e.config.button = nil
    end
    return ret
end