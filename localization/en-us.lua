return {
    descriptions = {
        Back = {
            b_nancy_nancy = {
                name = "Nancy Deck",
                text = {
                    "Start run with",
                    "{C:attention,T:j_nancy_negativenancy}#1#{} and the",
                    "{C:dark_edition,T:v_nancy_scarf}#2#{} voucher"
                }
            },
            b_nancy_twister = {
                name = "Twister Deck",
                text = {
                    "{C:enhanced}Editions{} on playing",
                    "cards are {C:green}randomized",
                    "when entering shop",
                    "{s:0.85}Start run with {C:dark_edition,T:v_glow_up,s:0.85}#1#"
                }
            },
            b_nancy_chaotic = {
                name = "Chaotic Deck",
                text = {
                    "All {C:enhanced}Enhancements{},",
                    "{C:enhanced}Editions{} and {C:enhanced}Seals",
                    "in deck are {C:green}randomized",
                    "{C:red,s:0.85}X#1# {s:0.85}base Blind size"
                }
            },
            b_nancy_crumpled = {
                name = "Crumpled Deck",
                text = {
                    "{C:legendary,E:1}Unlimited{} Joker slots",
                    "{C:red}#1#{} hand size",
                    "per held Joker"
                }
            },
            b_nancy_hoarder = {
                name = "Hoarder Deck",
                text = {
                    "After defeating",
                    "each {C:attention}Boss Blind{}, a",
                    "random Joker becomes",
                    "{C:dark_edition}Negative{} & {V:1}Rental",
                    "{C:inactive,s:0.85}(Costs {C:money,s:0.85}$3{C:inactive,s:0.85} per round)"
                }
            }
        },
        Blind = {
            bl_nancy_desert = {
                name = "The Desert",
                text = {
                    "Editioned playing",
                    "cards are debuffed"
                }
            },
            bl_nancy_filter = {
                name = "The Filter",
                text = {
                    "Editioned cards are",
                    "drawn face down"
                }
            },
            bl_nancy_purse = {
                name = "The Purse",
                text = {
                    "Editioned cards",
                    "are shuffled to",
                    "bottom of deck"
                }
            },
            bl_nancy_dam = {
                name = "The Dam",
                text = {
                    "Score requirement",
                    "increases by 1%",
                    "per card drawn"
                }
            },
            bl_nancy_crowd = {
                name = "The Crowd",
                text = {
                    "Unscored cards are",
                    "returned to hand",
                    "after played"
                }
            },
            bl_nancy_wrench = {
                name = "The Wrench",
                text = {
                    "#1# in #2# chance for",
                    "each scored card",
                    "to be destroyed",
                    "after played"
                }
            },
            bl_nancy_file = {
                name = "The File",
                text = {
                    "All scored cards",
                    "lose enhancements",
                    "after played"
                }
            },
            bl_nancy_final_sun = {
                name = "Tourmaline Sun",
                text = {
                    "All cards not",
                    "in scoring hand",
                    "are debuffed",
                    "when hand is played"
                }
            }
        },
        Edition={},
        Enhanced={},
        Joker = {
            j_nancy_exposuretherapy = {
                name = "Exposure Therapy",
                text = {
                    "All {C:dark_edition}Negative{} cards in {C:attention}deck",
                    "are always {C:legendary,E:1}drawn first"
                }
            },
            j_nancy_streetart = {
                name = "Street Art",
                text = {
                    {
                        "This Joker gains Chips & Mult {C:red}lost",
                        "from {C:attention}poker hand{} downgrades",
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
                        "if played hand contains",
                        "{C:attention}any{} scoring {C:attention}7{}s",
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
                    "contains exactly {C:attention}one",
                    "{C:attention}unscored{} card"
                }
            },
            -- Can't really patch it to consider debuff sources so this'll do...
            j_matador = {
                name = "Matador",
                text = {
                    "Earn {C:money}$#1#{} if played",
                    "hand triggers the",
                    "{C:attention}Boss Blind{} ability",
                    "{s:0.85}or has a {C:attention,s:0.85}debuffed {s:0.85}card"
                },
                unlock = {
                    "Defeat a Boss Blind",
                    "in {E:1,C:attention}1 hand{} without",
                    "using any discards",
                }
            }
        },
        Other = {
            nancy_boostertags = {
                name = "Booster Tags",
                text = {
                    "{C:attention}Standard{} Tag",
                    "{C:tarot}Charm{} Tag",
                    "{C:planet}Meteor{} Tag",
                    "{C:spectral}Ethereal{} Tag",
                    "{C:attention}Buffoon{} Tag"
                }
            },
            nancy_raritytags = {
                name = "Rarity Tags",
                text = {
                    "{C:common}Top-up{} Tag",
                    "{C:uncommon}Uncommon{} Tag",
                    "{C:rare}Rare{} Tag",
                    "{C:legendary,E:1}?????"
                }
            },
            nancy_emerald_sticker = {
                name = "Emerald Sticker",
                text = {
                    "Used this Joker",
                    "to win on {C:attention}Emerald",
                    "{C:attention}Stake{} difficulty",
                }
            },
            nancy_binding = {
                name = "Binding",
                text = {
                    "{C:red}-1{} hand size"
                }
            }
        },
        Planet={},
        Spectral = {
            c_nancy_flood = {
                name = "Flood",
                text = {
                    {
                        "Apply {C:dark_edition}Negative{} {C:enhanced}Edition",
                        "to all {C:attention}unenhanced",
                        "cards in your hand"
                    },
                    {
                        "{C:red}#1#{} hand size"
                    }
                }
            },
            c_nancy_mastery = {
                name = "Mastery",
                text = {
                    "Apply a random",
                    "{C:enhanced}Enhancement{} to",
                    "each {C:attention}unenhanced",
                    "card in hand"
                }
            },
            c_nancy_sacrifice = {
                name = "Sacrifice",
                text = {
                    {
                        "Destroy {C:attention}#1#{} random",
                        "{C:dark_edition}Negative{} cards",
                        "held {C:attention}in hand"
                    },
                    {
                        "Creates a free",
                        "{C:dark_edition}Negative Tag"
                    }
                }
            }
        },
        Stake = {
            stake_nancy_emerald = {
                name = "Emerald Stake",
                text = {
                    "Shop can have {C:attention}Binding{} Jokers",
                    "{C:inactive,s:0.8}({C:red,s:0.8}-1 {C:inactive,s:0.8}hand size)",
                    "{s:0.8}Applies all previous Stakes",
                },
            }
        },
        Tag = {
            tag_nancy_secret = {
                name = "Secret Tag",
                text = {
                    "{C:legendary,E:1}Why would you do this?"
                }
            },
            tag_nancy_accolades = {
                name = "Accolades Tag",
                text = {
                    "Gives {C:money}$#1#{} per {C:enhanced}Editioned",
                    "card in your {C:attention}full deck",
                    "{C:inactive}(Will give {C:money}$#2#{C:inactive})"
                }
            },
            tag_nancy_priority = {
                name = "Priority Tag",
                text = {
                    "All {C:dark_edition}Negative{} cards in",
                    "{C:attention}deck{} are {C:legendary}drawn first",
                    "in the next round"
                }
            },
            tag_nancy_shredder = {
                name = "Shredder Tag",
                text = {
                    "Destroys all {C:attention}debuffed",
                    "cards {C:attention}in hand{} when",
                    "at least one is drawn"
                }
            }
        },
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
            },
            c_nancy_offering = {
                name = "The Offering",
                text = {
                    {
                        "Permanently {C:attention}debuff",
                        "{C:attention}#1#{} selected {C:enhanced}Editioned",
                        "card in your hand"
                    },
                    {
                        "Creates a random",
                        "free {C:attention}Booster Tag"
                    }
                }
            }
        },
        Voucher = {
            v_nancy_scarf = {
                name = "Dainty Scarf",
                text = {
                    "Every {C:attention}played{} {C:dark_edition}Negative",
                    "card counts in {C:attention}scoring"
                }
            },
            v_nancy_purse = {
                name = "Velvet Purse",
                text = {
                    "All {C:dark_edition}Negative{} cards held",
                    "{C:attention}in hand{} count in {C:attention}scoring"
                }
            }
        }
    },
    misc = {
        achievement_descriptions={},
        achievement_names={},
        blind_states={},
        challenge_names = {
            c_nancy_showcase = "Nancy's Showcase",
            c_nancy_groceries = "Jimbo Gets Groceries",
            c_nancy_vandalism = "Vandalism",
            c_nancy_stairway = "Stairway To Heaven",
            c_nancy_printing = "Printing Factory"
        },
        collabs={},
        dictionary = {
            nancy_notarget = "No Target!",
            nancy_exposed = "Exposed!",
            nancy_raritytag = "+1 Rarity Tag",
            nancy_downgrade = "Downgrade!",
            nancy_d6tag = "+1 D6 Tag",
            nancy_twisted = "Twisted!",
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
        labels = {
            nancy_binding = "Binding"
        },
        poker_hand_descriptions={},
        poker_hands={},
        quips={},
        ranks={},
        suits_plural={},
        suits_singular={},
        tutorial={},
        v_dictionary={},
        v_text = {
            ch_c_nancy_showcase_1 = { "Fight {C:attention}only{} the new {C:attention}Boss Blinds" },
            ch_c_nancy_showcase_2 = { "introduced in the {C:dark_edition}Negative Nancy{} mod!" },
            ch_c_nancy_groceries_1 = { "Help {C:attention}Jimbo{} shop at the supermarket!" },
            ch_c_nancy_groceries_2 = { "Only {C:attention}shopping{}-adjacent Jokers can spawn" },
            ch_c_nancy_stairway = { "Non-{C:dark_edition}Negative{} playing cards are {C:red}debuffed" },
            ch_c_nancy_printing = { "Cards cannot have {C:enhanced}Enhancements" },
        }
    }
}