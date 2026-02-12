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
    key = 'lowerreq',
    bypass_all_unlocked = true,
    -- reset_on_startup = true,
    unlock_condition = function(self, args)
        if args.type == "nancy_lowerreq" then return true end
        return false
    end
}