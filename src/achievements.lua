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

SMODS.Achievement {
    key = 'scoredeck',
    bypass_all_unlocked = true,
    -- reset_on_startup = true,
    unlock_condition = function(self, args)
        if args.type == "nancy_scoredeck" then return true end
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
    key = 'inabind',
    bypass_all_unlocked = true,
    -- reset_on_startup = true,
    unlock_condition = function(self, args)
        if args.type == "nancy_inabind" then return true end
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
    key = 'sacrifice',
    bypass_all_unlocked = true,
    -- reset_on_startup = true,
    unlock_condition = function(self, args)
        if args.type == "nancy_sacrifice" then return true end
        return false
    end
}