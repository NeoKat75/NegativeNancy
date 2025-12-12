NegaNancy = SMODS.current_mod

NegaNancy.optional_features = {
	cardareas = { deck = true , discard = true }
}

-- Makes cards in hand negative (targets is a table of cards to affect, card is the card doing it)
function NegaNancy.makenegatives(targets, card)
	G.CONTROLLER.locks.nancy_makenegatives = true
    local currentcard = 1
    local handsize = G.hand.config.card_limit
	-- Event that makes negative cards one at a time
    local function mainevent()
        -- Subevent to wait for the next card to be drawn
        local function checkevent()
            G.E_MANAGER:add_event(Event({
                func = function()
                    if targets[currentcard] == nil then G.CONTROLLER.locks.nancy_makenegatives = nil; return true
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
				card:juice_up(0.3, 0.5)
				play_sound('tarot1')
                currentcard = currentcard + 1
                handsize = G.hand.config.card_limit
                checkevent()
                return true
            end
        }))
    end
	mainevent()
end

assert(SMODS.load_file("src/jokers.lua"))()