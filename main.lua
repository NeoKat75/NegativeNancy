---@diagnostic disable: duplicate-set-field

NegaNancy = SMODS.current_mod

NegaNancy.optional_features = {
	cardareas = { deck = true , discard = true }
}

-- FUNCTIONS --

---- [SMODS function] Initiate Pack of Buffoons' joker list when a run starts
function NegaNancy.reset_game_globals(run_start)
    if run_start then G.GAME.nancy_jokerlist = {} end
end

---@param table table target table
---@return number
---- Utility function for getting the amount of items in a table (from the internet)
function NegaNancy.tablelength(table)
    local count = 0
    for _ in pairs(table) do count = count + 1 end
    return count
end

---@param cardarea CardArea a cardarea with playing cards
---@return number
---- Counts unique cards in specified cardarea, returns amount of cards
function NegaNancy.uniquecards(cardarea)
    local cards = {}
    local stones = {}
    -- Put playing cards into 'cards' and stone cards into 'stones'
    for _, _card in ipairs(cardarea) do
        if _card.config.center.key == "m_stone" then
            stones[#stones+1] = _card
        else
            cards[#cards+1] = _card
        end
    end
    -- Remove duplicate cards from 'cards'
    repeat
        local restart = false
        for index1, card1 in ipairs(cards) do
            for index2, card2 in ipairs(cards) do
                if index1 < index2
                    and card1.base.value == card2.base.value
                    and card1.base.suit == card2.base.suit
                    and card1.config.center.key == card2.config.center.key
                    and (card1.edition and card1.edition.key) == (card2.edition and card2.edition.key)
                    and card1.seal == card2.seal
                then
                    table.remove(cards, index2)
                    restart = true
                    break
                end
            end
            if restart then break end
        end
    until not restart
    -- If there are stones, remove duplicate stones from 'stones'
    if next(stones) ~= nil then
        repeat
            local restart = false
            for index1, card1 in ipairs(stones) do
                for index2, card2 in ipairs(stones) do
                    if index1 < index2
                        and (card1.edition and card1.edition.key) == (card2.edition and card2.edition.key)
                        and card1.seal == card2.seal
                    then
                        table.remove(stones, index2)
                        restart = true
                        break
                    end
                end
                if restart then break end
            end
        until not restart
    end
    -- Return amount of unique cards
    return (#cards + #stones)
end

---@param targets table table of cards
---- Makes cards in hand negative
function NegaNancy.makenegatives(targets)
	G.CONTROLLER.locks.nancy_makenegatives = true
    local currentcard = 1
    local handsize = G.hand.config.card_limit
    -- Highlight affected cards
    G.hand:unhighlight_all()
    local highlightlimit = G.hand.config.highlighted_limit
    G.hand.config.highlighted_limit = 9999
    for _, _card in ipairs(targets) do G.hand:add_to_highlighted(_card, true) end
    play_sound('cardSlide1')
	-- Event that makes negative cards one at a time
    local function mainevent()
        -- Subevent to wait for the next card to be drawn
        local function checkevent()
            G.E_MANAGER:add_event(Event({
                func = function()
                    if targets[currentcard] == nil then
                        G.CONTROLLER.locks.nancy_makenegatives = nil
                        G.hand.config.highlighted_limit = highlightlimit
                        return true
                    elseif handsize < G.hand.config.card_limit then mainevent(); return true
                    else return false end
                end
            }))
        end
        -- Actual main event
        G.E_MANAGER:add_event(Event({
            func = function()
                handsize = G.hand.config.card_limit
                targets[currentcard]:set_edition("e_negative", true)
                targets[currentcard]:juice_up()
                G.hand:remove_from_highlighted(targets[currentcard])
                currentcard = currentcard + 1
                checkevent()
                return true
            end
        }))
    end
    -- Do the thing with a delay first for the joker to finish selling
    G.E_MANAGER:add_event(Event({
        blocking = false,
        trigger = 'after',
        delay = 0.7,
        func = function()
            mainevent()
            return true
        end
    }))
end

-- HOOKS --

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
    if not from_debuff -- If the card wasn't added by being undebuffed
        and self.ability.set == "Joker" -- and the card (`self` in this case) is a Joker
        and G.GAME.nancy_jokerlist[self.config.center.key] == nil -- and it's not already in the jokerlist
    then
        G.GAME.nancy_jokerlist[self.config.center.key] = true
    end
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

-- OWNERSHIP --

---- Prevent DNA from copying negative
SMODS.Joker:take_ownership('dna', -- object key (class prefix not required)
    { -- table of properties to change from the existing object
	loc_vars = function(self, info_queue, card)
        -- Append warning to description if needed
        local main_end = {}
        for _, _card in ipairs(G.playing_cards or {}) do
            if _card.edition and _card.edition.key == "e_negative" then
                localize{type = 'other', key = 'remove_negative', nodes = main_end, vars = {}}
            end
        end
        return { vars = { card.ability.extra }, main_end = main_end[1] }
    end,
    -- From Vanilla Remade
    calculate = function(self, card, context)
        if context.first_hand_drawn and not context.blueprint then
            local eval = function() return G.GAME.current_round.hands_played == 0 and not G.RESET_JIGGLES end
            juice_card_until(card, eval, true)
        end
        if context.before and G.GAME.current_round.hands_played == 0 and #context.full_hand == 1 then
            G.playing_card = (G.playing_card and G.playing_card + 1) or 1
            local card_copied = copy_card(context.full_hand[1], nil, nil, G.playing_card)
            -- Remove negative from copy
            if card_copied.edition and card_copied.edition.key == "e_negative" then
                card_copied:set_edition(nil, true, true)
            end
            -- --
            card_copied:add_to_deck()
            G.deck.config.card_limit = G.deck.config.card_limit + 1
            table.insert(G.playing_cards, card_copied)
            G.hand:emplace(card_copied)
            card_copied.states.visible = nil
            G.E_MANAGER:add_event(Event({
                func = function()
                    card_copied:start_materialize()
                    return true
                end
            }))
            return {
                message = localize('k_copied_ex'),
                colour = G.C.CHIPS,
                func = function() -- This is for timing purposes, it runs after the message
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            SMODS.calculate_context({ playing_card_added = true, cards = { card_copied } })
                            return true
                        end
                    }))
                end
            }
        end
    end
    },
    true -- silent | suppresses mod badge
)

---- Prevent Death from copying negative
SMODS.Consumable:take_ownership('death', -- object key (class prefix not required)
    { -- table of properties to change from the existing object
	loc_vars = function(self, info_queue, card)
        -- Append warning to description if needed
        local main_end = {}
        for _, _card in ipairs(G.playing_cards or {}) do
            if _card.edition and _card.edition.key == "e_negative" then
                localize{type = 'other', key = 'remove_negative', nodes = main_end, vars = {}}
            end
        end
        return { vars = { card.ability.min_highlighted }, main_end = main_end[1] }
    end,
    -- From Vanilla Remade
    use = function(self, card, area, copier)
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
        local rightmost = G.hand.highlighted[1]
        for i = 1, #G.hand.highlighted do
            if G.hand.highlighted[i].T.x > rightmost.T.x then
                rightmost = G.hand.highlighted[i]
            end
        end
        for i = 1, #G.hand.highlighted do
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.1,
                func = function()
                    if G.hand.highlighted[i] ~= rightmost then
                        copy_card(rightmost, G.hand.highlighted[i])
                        -- Remove negative from copy
                        if G.hand.highlighted[i].edition and G.hand.highlighted[i].edition.key == "e_negative" then
                            G.hand.highlighted[i]:set_edition(nil, true, true)
                        end
                        -- --
                    end
                    return true
                end
            }))
        end
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
    },
    true -- silent | suppresses mod badge
)

---- Prevent Cryptid from copying negative
SMODS.Consumable:take_ownership('cryptid', -- object key (class prefix not required)
    { -- table of properties to change from the existing object
	loc_vars = function(self, info_queue, card)
        -- Append warning to description if needed
        local main_end = {}
        for _, _card in ipairs(G.playing_cards or {}) do
            if _card.edition and _card.edition.key == "e_negative" then
                localize{type = 'other', key = 'remove_negative', nodes = main_end, vars = {}}
            end
        end
        return { vars = { card.ability.extra }, main_end = main_end[1] }
    end,
    -- From Vanilla Remade
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            func = function()
                local _first_dissolve = nil
                local new_cards = {}
                for i = 1, card.ability.extra do
                    G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                    local _card = copy_card(G.hand.highlighted[1], nil, nil, G.playing_card)
                    -- Remove negative from copy
                    if _card.edition and _card.edition.key == "e_negative" then
                        _card:set_edition(nil, true, true)
                    end
                    -- --
                    _card:add_to_deck()
                    G.deck.config.card_limit = G.deck.config.card_limit + 1
                    table.insert(G.playing_cards, _card)
                    G.hand:emplace(_card)
                    _card:start_materialize(nil, _first_dissolve)
                    _first_dissolve = true
                    new_cards[#new_cards + 1] = _card
                end
                SMODS.calculate_context({ playing_card_added = true, cards = new_cards })
                return true
            end
        }))
    end
    },
    true -- silent | suppresses mod badge
)

-- PULL THE LEVER, KRONK! --

assert(SMODS.load_file("src/jokers.lua"))()
assert(SMODS.load_file("src/consumables.lua"))()