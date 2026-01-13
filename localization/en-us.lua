return {
    descriptions = {
        Back={},
        Blind={},
        Edition={},
        Enhanced={},
        Joker = {
            j_nancy_exposuretherapy = {
                name = "Exposure Therapy",
                text = {
                    "All {C:dark_edition}Negative{} cards in {C:attention}deck",
                    "are {C:legendary,E:1}drawn to hand",
                    "when a hand is drawn"
                }
            },
            j_nancy_streetgraffiti = {
                name = "Street Graffiti",
                text = {
                    {
                        "This Joker gains Chips and Mult",
                        "{C:red}lost{} from {C:attention}poker hand{} downgrades",
                        "{C:inactive}(Currently {C:chips}+#1# {C:inactive}Chips & {C:mult}+#2# {C:inactive}Mult)"
                    },
                    {
                        "{C:red}Downgrades{} played {C:attention}poker hands"
                    }
                }
            },
            j_nancy_cutoffcard = {
                name = "Cutoff Card",
                text = {
                    "Once per round,",
                    "sell a {C:attention}consumable",
                    "to destroy a random",
                    "card held {C:attention}in hand"
                }
            },
            j_nancy_qualityoflife = {
                name = "Quality of Life",
                text = {
                    "When drawing a hand of cards",
                    "inside a {C:red}Booster Pack{},",
                    "upgrade the {C:attention}highest{} ranking",
                    "{C:attention}poker hand{} present"
                }
            },
            j_nancy_returnpolicy = {
                name = "Return Policy",
                text = {
                    {
                        "Sell {C:attention}#1#{} Jokers to create a",
                        "free {C:attention}Rarity Tag{} based on",
                        "{C:attention}last sold{} Joker's rarity",
                        "{C:inactive}(Currently {C:attention}#2#{C:inactive}/#1#)"
                    },
                    {
                        "Requirement increases",
                        "by {C:attention}#3#{} after each use"
                    }
                }
            },
            j_nancy_expiredcoupon = {
                name = "Expired Coupon",
                text = {
                    "While in a round, sell this Joker",
                    "to immediately {C:attention}spend{} up to {C:money}$#1#",
                    "and {C:attention}reduce{} the blind threshold",
                    "by {C:money}#2#%{} per dollar spent"
                }
            },
            j_nancy_packofbuffoons = {
                name = "Pack of Buffoons",
                text = {
                    "{C:mult}+#1#{} Mult per {C:attention}unique{} Joker",
                    "obtained during this run",
                    "{C:inactive}(Currently {C:mult}+#2# {C:inactive}Mult)"
                }
            },
            j_nancy_consolationprize = {
                name = "Consolation Prize",
                text = {
                    "Create a random {C:tarot}Tarot",
                    "card if {C:attention}poker hand",
                    "contains a {C:attention}debuffed{} card",
                    "{C:inactive}(Must have room)"
                }
            },
            j_nancy_exorcist = {
                name = "Exorcist",
                text = {
                    "{X:mult,C:white}X#1#{} Mult if a {C:dark_edition}Negative",
                    "playing card has been",
                    "{C:attention}destroyed{} this Ante",
                    "{C:inactive}#2#"
                }
            },
            j_nancy_pumpdump = {
                name = "Pump & Dump",
                text = {
                    "At end of round, earn {C:money}$#1#",
                    "per {C:dark_edition}Negative{} playing card",
                    "{C:attention}destroyed{} this Ante",
                    "{C:inactive}(Currently {C:money}$#2#{C:inactive})"
                }
            },
            j_nancy_deepocean = {
                name = "Deep Ocean",
                text = {
                    "This Joker gains {C:chips}+#1#{} Chips",
                    "per {C:attention}consecutive{} hand played",
                    "with a scoring {C:dark_edition}Negative{} card",
                    "{C:inactive}(Currently {C:chips}+#2# {C:inactive}Chips)"
                }
            },
            j_nancy_doubletake = {
                name = "Double Take",
                text = {
                    "{C:green}#1# in #2#{} chance to",
                    "retrigger each",
                    "{C:dark_edition}Negative{} {C:attention}playing card"
                }
            },
            j_nancy_lackofthedraw = {
                name = "#2# of the Draw",
                text = {
                    "If {C:red}discard{} contains {C:attention}#1#",
                    "{C:dark_edition}Negative{} cards, create a",
                    "random {C:spectral}Spectral{} card",
                    "{C:inactive}(Must have room)"
                }
            },
            j_nancy_initiation = {
                name = "Initiation",
                text = {
                    "{C:legendary}Permanently{} gain {C:attention}+#1#{} hand size",
                    "after hand is played if all",
                    "cards held {C:attention}in hand{} are {C:dark_edition}Negative",
                    "{C:red,E:2}self-destructs"
                }
            },
            j_nancy_decorativejoker = {
                name = "Decorative Joker",
                text = {
                    "{C:mult}+#1#{} Mult for each {C:attention}debuffed",
                    "card in your {C:attention}full deck",
                    "{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult)"
                }
            },
            j_nancy_stimuluscheque = {
                name = "Stimulus Cheque",
                text = {
                    "This Joker gives {C:money}$#1#{} per",
                    "{C:attention}debuffed{} card {C:attention}in hand",
                    "when hand is played"
                }
            },
            j_nancy_slotmachine = {
                name = "Slot Machine",
                text = {
                    {
                        "This Joker gains {C:mult}+#1#{} Mult",
                        "if played {C:attention}hand{} contains",
                        "any scoring {C:attention}7{}s",
                        "{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult)"
                    },
                    {
                        "Permanently {C:attention}debuffs",
                        "scored {C:attention}7{}s after played"
                    }
                }
            },
            j_nancy_frugaljoker = {
                name = "Frugal Joker",
                text = {
                    "This Joker gains {C:mult}+#1#{} Mult when",
                    "a {C:dark_edition}Negative{} card is {C:attention}discarded",
                    "{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult)"
                }
            },
            j_nancy_collector = {
                name = "Collector",
                text = {
                    "{C:chips}+#1#{} Chips for each {C:attention}unique{} card",
                    "in your {C:attention}full deck{}, including",
                    "{C:enhanced}Enhancements{}, {C:enhanced}Editions{} and {C:enhanced}Seals",
                    "{C:inactive}(Currently {C:chips}+#2#{C:inactive} Chips)"
                }
            },
            j_nancy_postmodernjoker = {
                name = "Post-Modern Joker",
                text = {
                    "{C:chips}+#1#{} Chips for each remaining",
                    "{C:dark_edition}Negative{} card in {C:attention}deck",
                    "{C:inactive}(Currently {C:chips}+#2#{C:inactive} Chips)"
                }
            },
            j_nancy_laminator = {
                name = "Laminator",
                text = {
                    "When round begins,",
                    "apply a random {C:enhanced}Edition{} to",
                    "a random card {C:attention}in hand"
                }
            },
            j_nancy_goldenfingers = {
                name = "Golden Fingers",
                text = {
                    "Earn {C:money}$#1#{} per held {C:attention}consumable",
                    "when hand is played"
                }
            },
            j_nancy_stairwell = {
                name = "Stairwell",
                text = {
                    {
                        "Sell this Joker to",
                        "apply {C:dark_edition}Negative{} {C:enhanced}Edition",
                        "to {C:attention}#1#{} random cards",
                        "held {C:attention}in hand"
                    },
                    {
                        "Amount increases",
                        "by {C:attention}#2#{} each round"
                    }
                }
            },
            j_nancy_negativenancy = {
                name = "Negative Nancy",
                text = {
                    "Sell this Joker to",
                    "apply {C:dark_edition}Negative{} {C:enhanced}Edition",
                    "to all cards held {C:attention}in hand"
                }
            },
            j_nancy_usefuljoker = {
                name = "Useful Joker",
                text = {
                    "This Joker gains {X:chips,C:white}X0.5{} Chips",
                    "when {C:attention}pigs fly",
                    "{C:inactive}(Currently {X:chips,C:white}X1{C:inactive} Chips)"
                }
            },
            j_nancy_countjokula = {
                name = "Count Jokula",
                text = {
                    "Gains {X:mult,C:white}X#2#{} Mult per card {C:attention}drawn",
                    "Loses {X:mult,C:white}X#3#{} Mult per card {C:attention}scored",
                    "{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult)"
                }
            },
            j_nancy_snacktray = {
                name = "Snack Tray",
                text = {
                    {
                        "{C:attention}+#1#{} consumable slots"
                    },
                    {
                        "{C:green}#2# in #3#{} chance this",
                        "gets eaten when",
                        "entering {C:attention}shop"
                    }
                }
            },
            j_nancy_onthehouse = {
                name = "On the House",
                text = {
                    "Create a free {C:attention}D6 Tag{} if",
                    "{C:attention}final{} played hand of round",
                    "contains a {C:attention}Full House"
                }
            },
            j_nancy_windowshopping = {
                name = "Window Shopping",
                text = {
                    "Adds {C:attention}double{} your current",
                    "{C:attention}hand size{} to Mult"
                }
            },
            j_nancy_junkiejoker = {
                name = "Junkie Joker",
                text = {
                    "Earn {C:money}$#1#{} if played hand",
                    "contains exactly {C:attention}#2#",
                    "{C:attention}unscored{} card"
                }
            }
        },
        Other={},
        Planet={},
        Spectral={},
        Stake={},
        Tag={},
        Tarot = {
            c_nancy_downpour = {
                name = "The Downpour",
                text = {
                    {
                        "Create a {C:dark_edition}Negative{}",
                        "copy of {C:attention}#1#{} selected",
                        "card in your hand"
                    },
                    {
                        "Permanently {C:attention}debuffs",
                        "the selected card"
                    }
                }
            },
            c_nancy_trainee = {
                name = "The Trainee",
                text = {
                    {
                        "Select {C:attention}#1#{} cards, give the {C:attention}left{} card",
                        "the {C:attention}right{} card's {C:enhanced}Enhancement{}, {C:enhanced}Edition",
                        "and/or {C:enhanced}Seal{} where it's {C:attention}applicable"
                    },
                    {
                        "Permanently {C:attention}debuffs{} the {C:attention}right{} card"
                    }
                }
            }
        },
        Voucher={},
    },
    misc = {
        achievement_descriptions={},
        achievement_names={},
        blind_states={},
        challenge_names={},
        collabs={},
        dictionary = {
            nancy_exposed = "Exposed!",
            nancy_raritytag = "+1 Rarity Tag",
            nancy_downgrade = "Downgrade!",
            nancy_d6tag = "+1 D6 Tag",
            nancy_usefuljoker_clone = "My clone???",
            -- When scoring
            nancy_usefuljoker_1 = "I'm helping!",
            nancy_usefuljoker_2 = "Yum!",
            nancy_usefuljoker_3 = "Keep me...!",
            nancy_usefuljoker_4 = "Am I doing it?",
            nancy_usefuljoker_5 = "Yippee!",
            nancy_usefuljoker_6 = "Yippee?",
            nancy_usefuljoker_7 = "X4 Chips!!!",
            nancy_usefuljoker_8 = "+naneinf",
            nancy_usefuljoker_9 = "Ship it!",
            nancy_usefuljoker_10 = "Pokerissimo!",
            -- When obtained
            nancy_usefuljoker_11 = "Hewwo!",
            nancy_usefuljoker_12 = "Win time!",
            nancy_usefuljoker_13 = "I'm useful!",
            nancy_usefuljoker_14 = "Count me in!",
            nancy_usefuljoker_15 = "Go XChips!!!",
            -- When boss triggers
            nancy_usefuljoker_16 = "Ouch!!",
            nancy_usefuljoker_17 = "Careful!",
            nancy_usefuljoker_18 = "Stinky...",
            nancy_usefuljoker_19 = "Unfair!!",
            nancy_usefuljoker_20 = "Bummer!",
            -- When starting blind
            nancy_usefuljoker_21 = "You got this!",
            nancy_usefuljoker_22 = "Let's go!!",
            nancy_usefuljoker_23 = "Breathe...",
            nancy_usefuljoker_24 = "Go time!",
            nancy_usefuljoker_25 = "I'll help!",
            -- When winning blind
            nancy_usefuljoker_26 = "Go Bulls!!",
            nancy_usefuljoker_27 = "Take that!",
            nancy_usefuljoker_28 = "We did it!",
            nancy_usefuljoker_29 = "I did it!!",
            nancy_usefuljoker_30 = "Calculated!",
            -- When entering shop
            nancy_usefuljoker_31 = "Whatcha got?",
            nancy_usefuljoker_32 = "Let's see...",
            nancy_usefuljoker_33 = "Gamba time!!",
            nancy_usefuljoker_34 = "My brethren...",
            nancy_usefuljoker_35 = "Take that one!",
            -- When leaving shop
            nancy_usefuljoker_36 = "Go next!",
            nancy_usefuljoker_37 = "Moving on!",
            nancy_usefuljoker_38 = "My groceries...",
            nancy_usefuljoker_39 = "I wanted more...",
            nancy_usefuljoker_40 = "Savings!",
            -- When getting sold :(
            nancy_usefuljoker_41 = "Whyyy...",
            nancy_usefuljoker_42 = "Was I bad?",
            nancy_usefuljoker_43 = "Betrayer...",
            nancy_usefuljoker_44 = "I'm upset.",
            nancy_usefuljoker_45 = "I'm the fool..."
        },
        high_scores={},
        labels={},
        poker_hand_descriptions={},
        poker_hands={},
        quips={},
        ranks={},
        suits_plural={},
        suits_singular={},
        tutorial={},
        v_dictionary={},
        v_text={},
    },
}