SMODS.JimboQuip {
    key = 'quips',
    extra = {
        center = 'j_nancy_negativenancy',
        particle_colours = {
            G.ARGS.LOC_COLOURS.tarot,
            G.ARGS.LOC_COLOURS.planet,
            G.ARGS.LOC_COLOURS.nancy_emerald
        },
        materialize_colours = {
            G.ARGS.LOC_COLOURS.tarot,
            G.ARGS.LOC_COLOURS.planet,
            G.ARGS.LOC_COLOURS.nancy_emerald
        },
        times = 7,
        pitch = 1.7,
        delay = 0.17
    },
    filter = function(self, type)
        if (G.GAME and G.GAME.challenge and string.sub(G.GAME.challenge, 1, 7) == "c_nancy")
            or (G.GAME and G.GAME.selected_back and string.sub(G.GAME.selected_back.effect.config.key, 1, 7) == "b_nancy")
        then
            if type == 'win' then
                self.extra.text_key = self.key..'_win_'..math.random(1,5)
                return true, { weight = 999999 }
            elseif type == 'loss' then
                self.extra.text_key = self.key..'_loss_'..math.random(1,5)
                return true, { weight = 999999 }
            end
        end
        return false
    end
}