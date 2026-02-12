SMODS.Achievement {
    key = 'secrettag',
    bypass_all_unlocked = true,
    unlock_condition = function(self, args)
        if args.type == "nancy_secrettag" then return true end
        return false
    end
}