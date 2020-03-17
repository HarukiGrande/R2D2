local _, AddOn = ...

AddOn.defaults = {
    profile = {
        logThreshold = AddOn.Libs.Logging.Level.Debug,
    }
}


function AddOn:GetDefaultCustomItems()
    --[[

    See LibGearPoints-1.2

    keys are item ids and values are tuple where index is
        1. rarity, int, 4 = epic
        2. ilvl, int
        3. inventory slot, string (supports special keywords such as CUSTOM_SCALE and CUSTOM_GP)
        4. faction (Horde/Alliance), string

    --]]
    return {
        -- Classic P2
        [18422] = { 4, 74, "INVTYPE_NECK", "Horde" },       -- Head of Onyxia
        [18423] = { 4, 74, "INVTYPE_NECK", "Alliance" },    -- Head of Onyxia
        [18646] = { 4, 75, "INVTYPE_2HWEAPON" },            -- The Eye of Divinity
        [18703] = { 4, 75, "INVTYPE_RANGED" },              -- Ancient Petrified Leaf

        -- Classic P3
        [19002] = { 4, 83, "INVTYPE_NECK", "Horde" },      -- Head of Nefarian
        [19003] = { 4, 83, "INVTYPE_NECK", "Alliance" },   -- Head of Nefarian

        -- Classic P5
        [20928] = { 4, 78, "INVTYPE_SHOULDER" },    -- T2.5 shoulder, feet (Qiraji Bindings of Command)
        [20932] = { 4, 78, "INVTYPE_SHOULDER" },    -- T2.5 shoulder, feet (Qiraji Bindings of Dominance)
        [20930] = { 4, 81, "INVTYPE_HEAD" },        -- T2.5 head (Vek'lor's Diadem)
        [20926] = { 4, 81, "INVTYPE_HEAD" },        -- T2.5 head (Vek'nilash's Circlet)
        [20927] = { 4, 81, "INVTYPE_LEGS" },        -- T2.5 legs (Ouro's Intact Hide)
        [20931] = { 4, 81, "INVTYPE_LEGS" },        -- T2.5 legs (Skin of the Great Sandworm)
        [20929] = { 4, 81, "INVTYPE_CHEST" },       -- T2.5 chest (Carapace of the Old God)
        [20933] = { 4, 81, "INVTYPE_CHEST" },       -- T2.5 chest (Husk of the Old God
        [21221] = { 4, 88, "INVTYPE_NECK" },        -- Neck, Back, Finger (Eye of C'Thun)
        [21232] = { 4, 79, "INVTYPE_WEAPON" },      -- Weapon, Shield (Imperial Qiraji Armaments)
        [21237] = { 4, 79, "INVTYPE_2HWEAPON" },    -- 2H Weapon (Imperial Qiraji Regalia)

        -- Classic P6
        [22349] = { 4, 88, "INVTYPE_CHEST" },       -- Desecrated Breastplate
        [22350] = { 4, 88, "INVTYPE_CHEST" },       -- Desecrated Tunic
        [22351] = { 4, 88, "INVTYPE_CHEST" },       -- Desecrated Robe
        [22352] = { 4, 88, "INVTYPE_LEGS" },        -- Desecrated Legplates
        [22359] = { 4, 88, "INVTYPE_LEGS" },        -- Desecrated Legguards
        [22366] = { 4, 88, "INVTYPE_LEGS" },        -- Desecrated Leggings
        [22353] = { 4, 88, "INVTYPE_HEAD" },        -- Desecrated Helmet
        [22360] = { 4, 88, "INVTYPE_HEAD" },        -- Desecrated Headpiece
        [22367] = { 4, 88, "INVTYPE_HEAD" },        -- Desecrated Circlet
        [22354] = { 4, 88, "INVTYPE_SHOULDER" },    -- Desecrated Pauldrons
        [22361] = { 4, 88, "INVTYPE_SHOULDER" },    -- Desecrated Spaulders
        [22368] = { 4, 88, "INVTYPE_SHOULDER" },    -- Desecrated Shoulderpads
        [22355] = { 4, 88, "INVTYPE_WRIST" },       -- Desecrated Bracers
        [22362] = { 4, 88, "INVTYPE_WRIST" },       -- Desecrated Wristguards
        [22369] = { 4, 88, "INVTYPE_WRIST" },       -- Desecrated Bindings
        [22356] = { 4, 88, "INVTYPE_WAIST" },       -- Desecrated Waistguard
        [22363] = { 4, 88, "INVTYPE_WAIST" },       -- Desecrated Girdle
        [22370] = { 4, 88, "INVTYPE_WAIST" },       -- Desecrated Belt
        [22357] = { 4, 88, "INVTYPE_HAND" },        -- Desecrated Gauntlets
        [22364] = { 4, 88, "INVTYPE_HAND" },        -- Desecrated Handguards
        [22371] = { 4, 88, "INVTYPE_HAND" },        -- Desecrated Gloves
        [22358] = { 4, 88, "INVTYPE_FEET" },        -- Desecrated Sabatons
        [22365] = { 4, 88, "INVTYPE_FEET" },        -- Desecrated Boots
        [22372] = { 4, 88, "INVTYPE_FEET" },        -- Desecrated Sandals
        [22520] = { 4, 90, "INVTYPE_TRINKET" },     -- The Phylactery of Kel'Thuzad
        [22726] = { 5, 90, "INVTYPE_2HWEAPON" },    -- Splinter of Atiesh
    }
end

function AddOn:GetTestItems()
    return {
        16800, 18878, 16938, 17063, 18816, 19372, 19348,
        17076, 12590, 14555, 11684, 22691, 871, -- Weapons
        12640, 14551, 14153, 12757, -- Armor
        18821, 19140, 19148, 1980, 942, 18813, 13143 -- Rings
    }
end