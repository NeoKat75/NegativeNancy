-- The Desert
SMODS.Blind {
    key = "desert",
    discovered = true,
    boss = { min = 1 },
    boss_colour = HEX("900090"),
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.debuff_card and context.debuff_card.area ~= G.jokers and context.debuff_card.edition then
                return { debuff = true }
            end
        end
    end
}