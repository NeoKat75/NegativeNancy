---@diagnostic disable: duplicate-set-field

NegaNancy = SMODS.current_mod

function NegaNancy.calculate(self, context)
    -- Prevent Edition Tags from triggering if there are Booster Tags left
    if context.prevent_tag_trigger and context.prevent_tag_trigger.config.type == 'store_joker_modify' then
        for _, tag in ipairs(G.GAME.tags) do
            if tag.config.type == 'new_blind_choice' then return { prevent_trigger = true } end
        end
    end
    -- Use Booster Tags when entering shop
    if context.starting_shop and G.GAME.tags then
        for _, tag in ipairs(G.GAME.tags) do
            if tag:apply_to_run{type = 'new_blind_choice'} then break end
        end
    end
    -- Use Edition Tags when exiting a booster pack
    if context.ending_booster and G.GAME.tags and G.shop_jokers and G.shop_jokers.cards then
        for k, card in ipairs(G.shop_jokers.cards) do
            for kk, tag in ipairs(G.GAME.tags) do
                if tag:apply_to_run{type = 'store_joker_modify', card = card} then break end
            end
        end
    end
    -- Shredder Tag (only triggered if no Exposure Therapy & no potential Priority Tags)
    -- If those are present, they trigger Shredder Tags themselves after doing their thing
    if (context.hand_drawn or context.other_drawn) and G.GAME.tags then
        local priority = false
        for _, tag in ipairs(G.GAME.tags) do
            if tag.key == 'tag_nancy_priority' then priority = true; break end
        end
        if not next(SMODS.find_card("j_nancy_exposuretherapy")) and (not priority or not context.first_hand_drawn) then
            for _, tag in ipairs(G.GAME.tags) do
                if tag:apply_to_run{type = 'nancy_shredder'} then break end
            end
        end
    end
    -- Priority Tag
    if context.first_hand_drawn and G.GAME.tags then
        for _, tag in ipairs(G.GAME.tags) do
            if tag:apply_to_run{type = 'nancy_priority'} then break end
        end
    end
end

-- FUNCTIONS --

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
    if next(stones) then
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
    if G.GAME.blind.in_blind then
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
    else
        for _, _card in ipairs(targets) do
            _card:juice_up()
            _card:set_edition("e_negative", true, true)
        end
        play_sound('negative', 1.5, 0.4)
    end
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
    G.GAME.nancy_jokerlist = G.GAME.nancy_jokerlist or {}
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

-- PULL THE LEVER, KRONK! --

assert(SMODS.load_file("src/jokers.lua"))()
assert(SMODS.load_file("src/consumables.lua"))()
assert(SMODS.load_file("src/vouchers.lua"))()
assert(SMODS.load_file("src/tags.lua"))()