SMODS.Achievement {
    key = 'nancywin',
    bypass_all_unlocked = true,
    -- reset_on_startup = true,
    unlock_condition = function(self, args)
        if args.type == 'win_deck' and get_deck_win_stake('b_nancy_nancy') > 0 then return true end
        return false
    end
}

SMODS.Achievement {
    key = 'emeraldwin',
    bypass_all_unlocked = true,
    -- reset_on_startup = true,
    unlock_condition = function(self, args)
        if args.type == 'win_stake' and get_deck_win_stake() >= G.P_STAKES.stake_nancy_emerald.order then return true end
        return false
    end
}

SMODS.Achievement {
    key = 'challengewin',
    bypass_all_unlocked = true,
    -- reset_on_startup = true,
    nancy_challengeachievement = true,
    unlock_condition = function(self, args)
        if args.type == 'win_challenge' then
            if string.sub(G.GAME.challenge, 1, 7) == "c_nancy" then return true end
        end
        return false
    end
}

SMODS.Achievement {
    key = 'handsize',
    bypass_all_unlocked = true,
    -- reset_on_startup = true,
    unlock_condition = function(self, args)
        if args.type == "nancy_handsize" and G.hand and G.hand.config.card_limit >= 22 then return true end
        return false
    end
}

SMODS.Achievement {
    key = 'secrettag',
    bypass_all_unlocked = true,
    -- reset_on_startup = true,
    unlock_condition = function(self, args)
        if args.type == "nancy_secrettag" then return true end
        return false
    end
}

SMODS.Achievement {
    key = 'initiation',
    bypass_all_unlocked = true,
    -- reset_on_startup = true,
    unlock_condition = function(self, args)
        if args.type == "nancy_initiation" then return true end
        return false
    end
}

SMODS.Achievement {
    key = 'alldeckswin',
    bypass_all_unlocked = true,
    -- reset_on_startup = true,
    unlock_condition = function(self, args)
        if args.type == 'win_deck' then
            for _, deck in
                pairs{'b_nancy_nancy', 'b_nancy_twister', 'b_nancy_hoarder', 'b_nancy_chaotic', 'b_nancy_crumpled'}
            do
                if get_deck_win_stake(deck) == 0 then return false end
            end
            return true
        end
        return false
    end
}

SMODS.Achievement {
    key = 'inabind',
    bypass_all_unlocked = true,
    -- reset_on_startup = true,
    unlock_condition = function(self, args)
        if args.type == "nancy_inabind" then return true end
        return false
    end
}

SMODS.Achievement {
    key = 'allchallengeswin',
    bypass_all_unlocked = true,
    -- reset_on_startup = true,
    nancy_challengeachievement = true,
    unlock_condition = function(self, args)
        if args.type == 'win_challenge' then
            for _, ch in pairs(G.CHALLENGES) do
                if ch.original_mod and ch.original_mod.id == 'nancy'
                    and not G.PROFILES[G.SETTINGS.profile].challenge_progress.completed[ch.id]
                then return false end
            end
            return true
        end
        return false
    end
}

SMODS.Achievement {
    key = 'qolstrush',
    bypass_all_unlocked = true,
    -- reset_on_startup = true,
    unlock_condition = function(self, args)
        if args.type == "nancy_qolstrush" then return true end
        return false
    end
}

SMODS.Achievement {
    key = 'lowerreq',
    bypass_all_unlocked = true,
    -- reset_on_startup = true,
    unlock_condition = function(self, args)
        if args.type == "nancy_lowerreq" then return true end
        return false
    end
}

SMODS.Achievement {
    key = 'scoredeck',
    bypass_all_unlocked = true,
    -- reset_on_startup = true,
    unlock_condition = function(self, args)
        if args.type == "nancy_scoredeck" then return true end
        return false
    end
}