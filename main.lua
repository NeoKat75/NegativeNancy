NegaNancy = SMODS.current_mod

NegaNancy.optional_features = {
	cardareas = { deck = true , discard = true }
}

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

assert(SMODS.load_file("src/jokers.lua"))()