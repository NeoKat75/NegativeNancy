SMODS.Challenge {
    key = 'showcase',
    button_colour = HEX('A000A0'),
    jokers = { { id = 'j_nancy_negativenancy' } },
    rules = { custom = {
        { id = 'nancy_showcase_1' },
        { id = 'nancy_showcase_2' }
    } },
    apply = function(self)
        for k, v in pairs(G.P_BLINDS) do
            if not v.original_mod and v.key ~= 'bl_small' and v.key ~= 'bl_big' then
                G.GAME.banned_keys[v.key] = true
            end
        end
    end
}