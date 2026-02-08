---@diagnostic disable: need-check-nil

---- SMODS.juice_up_blind() if it was good (has sounds now)
function NegaNancy.wiggle_blind()
    local ui_elem = G.HUD_blind:get_UIE_by_ID('HUD_blind_debuff')
    for _, v in ipairs(ui_elem.children) do
        v.children[1]:juice_up(0.3, 0)
    end
    G.GAME.blind:wiggle()
end

---@param table table table to check against
---@param item table|Card item to check for
---@return boolean
---- Utility function for checking if a table contains an item
function NegaNancy.isintable(table, item)
    for _, _item in pairs(table) do
        if _item == item then return true end
    end
    return false
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
                    SMODS.recalc_debuff(targets[currentcard])
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