NegaNancy = SMODS.current_mod

function NegaNancy.calculate(self, context)
    -- Use Booster Tags when entering shop
    if context.starting_shop and next(G.GAME.tags) then
        for _, tag in ipairs(G.GAME.tags) do
            if tag:apply_to_run{type = 'new_blind_choice'} then break end
        end
    end
    -- Use Edition Tags when exiting a booster pack
    if context.ending_booster and next(G.GAME.tags) and G.shop_jokers and G.shop_jokers.cards then
        for k, card in ipairs(G.shop_jokers.cards) do
            for kk, tag in ipairs(G.GAME.tags) do
                if tag:apply_to_run{type = 'store_joker_modify', card = card} then break end
            end
        end
    end
    -- Prevent Edition Tags from triggering if there are Booster Tags left
    if context.prevent_tag_trigger and context.prevent_tag_trigger.config.type == 'store_joker_modify' then
        for _, tag in ipairs(G.GAME.tags) do
            if tag.config.type == 'new_blind_choice' then return { prevent_trigger = true } end
        end
    end
    -- Shredder Tag
    if (context.hand_drawn or context.other_drawn) and next(G.GAME.tags) then
        for _, tag in ipairs(G.GAME.tags) do
            if tag:apply_to_run{type = 'nancy_shredder'} then break end
        end
    end
end

loc_colour()
G.ARGS.LOC_COLOURS.nancy_emerald = HEX('068b54')

assert(SMODS.load_file("src/utils/functions.lua"))()
assert(SMODS.load_file("src/utils/hooks.lua"))()

assert(SMODS.load_file("src/jokers.lua"))()
assert(SMODS.load_file("src/consumables.lua"))()
assert(SMODS.load_file("src/vouchers.lua"))()
assert(SMODS.load_file("src/tags.lua"))()
assert(SMODS.load_file("src/decks.lua"))()
assert(SMODS.load_file("src/stakes.lua"))()
assert(SMODS.load_file("src/blinds.lua"))()

assert(SMODS.load_file("src/challenges.lua"))()
assert(SMODS.load_file("src/achievements.lua"))()