---@diagnostic disable: duplicate-set-field

NegaNancy = SMODS.current_mod

NegaNancy.optional_features = {
	cardareas = { deck = true , discard = true }
}

-- Function to make cards negative

---@param targets table table of cards
-- Makes cards in hand negative
function NegaNancy.makenegatives(targets)
	G.CONTROLLER.locks.nancy_makenegatives = true
    local currentcard = 1
    local handsize = G.hand.config.card_limit
    -- Highlight affected cards
    G.hand:unhighlight_all()
    local highlightlimit = G.hand.config.highlighted_limit
    G.hand.config.highlighted_limit = 99999
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
                targets[currentcard]:set_edition("e_negative", true)
                targets[currentcard]:juice_up(0.3, 0.5)
                G.hand:remove_from_highlighted(targets[currentcard])
                currentcard = currentcard + 1
                handsize = G.hand.config.card_limit
                checkevent()
                return true
            end
        }))
    end
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

-- Hooks to disable play/discard during makenegatives()

-- save the orig function (no executing)
local canplay = G.FUNCS.can_play
-- overwrite the orig function
function G.FUNCS.can_play(e)
    -- before the orig function
    -- do nothing!
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

-- save the orig function (no executing)
local candiscard = G.FUNCS.can_discard
-- overwrite the orig function
function G.FUNCS.can_discard(e)
    -- before the orig function
    -- do nothing!
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

assert(SMODS.load_file("src/jokers.lua"))()