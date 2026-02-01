---@diagnostic disable: duplicate-set-field

---- Allow negative cards in standard packs and from Illusion
-- save the orig function (no executing)
local polledition = poll_edition
-- overwrite the orig function
function poll_edition(_key, _mod, _no_neg, _guaranteed)
    -- before the orig function
    if _key == 'standard_edition'..G.GAME.round_resets.ante or 'illusion' then _no_neg = false end
    -- execute and save the orig function's return
    local ret = polledition(_key, _mod, _no_neg, _guaranteed)
    -- after the orig function
    ---- do nothing!
    -- actually return the orig function's return
    return ret
end



---- Add joker to jokerlist if it's unique when it's added (mostly taken from Vanilla Remade)
-- save the orig function (no executing)
local card_add_to_deck_ref = Card.add_to_deck
function Card:add_to_deck(from_debuff)
    -- before the orig function
    ---- do nothing!
    -- execute and save the orig function's return
    local ret = card_add_to_deck_ref(self, from_debuff)
    -- after the orig function
    G.GAME.nancy_jokerlist = G.GAME.nancy_jokerlist or {}
    if not from_debuff -- If the card wasn't added by being undebuffed
        and self.ability.set == "Joker" -- and the card (`self` in this case) is a Joker
        and not G.GAME.nancy_jokerlist[self.config.center.key] -- and it's not already in the jokerlist
    then
        G.GAME.nancy_jokerlist[self.config.center.key] = true
    end
    -- actually return the orig function's return
    return ret
end



---- Baneful sticker functionality (obtaining or undebuffing Joker)
-- save the orig function (no executing)
local card_add_to_deck_ref = Card.add_to_deck
function Card:add_to_deck(from_debuff)
    -- before the orig function
    ---- do nothing!
    -- execute and save the orig function's return
    local ret = card_add_to_deck_ref(self, from_debuff)
    -- after the orig function
    if self.ability.set == "Joker" and self.ability.nancy_baneful and G.hand then G.hand:change_size(-1) end
    -- actually return the orig function's return
    return ret
end

---- Baneful sticker functionality (removing or debuffing Joker)
-- save the orig function (no executing)
local card_remove_from_deck_ref = Card.remove_from_deck
function Card:remove_from_deck(from_debuff)
    -- before the orig function
    ---- do nothing!
    -- execute and save the orig function's return
    local ret = card_remove_from_deck_ref(self, from_debuff)
    -- after the orig function
    if self.ability.set == "Joker" and self.ability.nancy_baneful and G.hand then G.hand:change_size(1) end
    -- actually return the orig function's return
    return ret
end



---- Disable play button during makenegatives()
-- save the orig function (no executing)
local canplay = G.FUNCS.can_play
-- overwrite the orig function
function G.FUNCS.can_play(e)
    -- before the orig function
    ---- do nothing!
    -- execute and save the orig function's return
    local ret = canplay(e)
    -- after the orig function
    if G.CONTROLLER.locks.nancy_makenegatives then
        e.config.colour = G.C.UI.BACKGROUND_INACTIVE
        e.config.button = nil
    end
    -- actually return the orig function's return
    return ret
end

---- Disable discard button during makenegatives()
-- save the orig function (no executing)
local candiscard = G.FUNCS.can_discard
-- overwrite the orig function
function G.FUNCS.can_discard(e)
    -- before the orig function
    ---- do nothing!
    -- execute and save the orig function's return
    local ret = candiscard(e)
    -- after the orig function
    if G.CONTROLLER.locks.nancy_makenegatives then
        e.config.colour = G.C.UI.BACKGROUND_INACTIVE
        e.config.button = nil
    end
    -- actually return the orig function's return
    return ret
end