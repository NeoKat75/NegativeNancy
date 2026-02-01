NegaNancy = SMODS.current_mod

SMODS.Atlas {
    key = "icon",
    path = "icon.png",
    px = 32,
    py = 32
}

function NegaNancy.calculate(self, context)
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
    -- Prevent Edition Tags from triggering if there are Booster Tags left
    if context.prevent_tag_trigger and context.prevent_tag_trigger.config.type == 'store_joker_modify' then
        for _, tag in ipairs(G.GAME.tags) do
            if tag.config.type == 'new_blind_choice' then return { prevent_trigger = true } end
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

assert(SMODS.load_file("src/utils/functions.lua"))()
assert(SMODS.load_file("src/utils/hooks.lua"))()

assert(SMODS.load_file("src/jokers.lua"))()
assert(SMODS.load_file("src/consumables.lua"))()
assert(SMODS.load_file("src/vouchers.lua"))()
assert(SMODS.load_file("src/tags.lua"))()
assert(SMODS.load_file("src/decks.lua"))()
assert(SMODS.load_file("src/stakes.lua"))()
assert(SMODS.load_file("src/stickers.lua"))()