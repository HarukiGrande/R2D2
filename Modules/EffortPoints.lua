local _, AddOn = ...
local EP        = AddOn:NewModule("EffortPoints", "AceHook-3.0", "AceEvent-3.0")
local Encounter = AddOn.Libs.Encounter
local L         = AddOn.components.Locale
local Logging   = AddOn.components.Logging
local Util      = AddOn.Libs.Util
local Tables    = Util.Tables
local Objects   = Util.Objects
local Strings   = Util.Strings
local COpts     = AddOn.components.UI.ConfigOptions

EP.defaults = {
    profile = {
        enabled = true,
        raid = {
            -- should EP be auto-awarded for kills
            auto_award_victory = false,
            -- should EP be auto-awarded for wipes
            auto_award_defeat = false,
            -- the percent of kil EP to award on defeat
            auto_award_defeat_pct = 0.25,
            -- EP values by creature
            -- These are represented as strings instead of numbers in order to facilitate
            -- easy access by path when reading/writing values
            creatures = {
                -- Lucifron
                ['12118'] = 10,
                -- Magmadar
                ['11982'] = 10,
                -- Gehennas
                ['12259'] = 10,
                -- Garr
                ['12057'] = 10,
                -- Geddon
                ['12056'] = 10,
                -- Shazzrah
                ['12264'] = 10,
                -- Sulfuron
                ['12098'] = 10,
                -- Golemagg
                ['11988'] = 10,
                -- Domo
                ['12018'] = 12,
                -- Ragnaros
                ['11502'] = 14,
                -- Onyxia
                ['10184'] = 12,
                -- Razorgore
                ['12435'] = 14,
                -- Vaelastrasz
                ['13020'] = 14,
                -- Broodlord
                ['12017'] = 14,
                -- Firemaw,
                ['11983'] = 14,
                -- Ebonroc
                ['14601'] = 14,
                -- Flamegor
                ['11981'] = 14,
                -- Chromaggus
                ['14020'] = 17,
                -- Nefarian
                ['11583'] = 20,
            }
        },
        -- todo : add option for verifying whether standby members are still online
        standby = {
            enabled = false,
            standby_pct = 0.80,
        }
    }
}

EP.options = {
    name = L['ep'],
    desc = L['ep_desc'],
    args = {
        raid = {
            type = 'group',
            name = L['raids'],
            desc = L['raids_desc'],
            childGroups = "tab",
            args = {
                auto_award_settings = {
                    type = 'group',
                    name = L['auto_award'],
                    inline = true,
                    args = {
                        -- function COpts.Range(name, order, min, max, step, extra)
                        ['raid.auto_award_victory'] = COpts.Toggle(L['auto_award_victory'], 0, L['auto_award_victory_desc']),
                        ['raid.auto_award_defeat'] = COpts.Toggle(L['auto_award_defeat'], 1, L['auto_award_defeat_desc']),
                        ['raid.auto_award_defeat_pct'] = COpts.Range(L['auto_award_defeat_pct'], 2, 0, 1, 0.01, {isPercent=true, desc= L['auto_award_defeat_ptc_desc']}),
                    }
                }
            }
        },
        standby = {
            type = 'group',
            name = L['standby'],
            desc = L['standby_desc'],
            args = {
                sb_enabled = {
                    type = 'group',
                    name = L['standby_toggle'],
                    inline = true,
                    order = 1,
                    args = {
                        ['standby.enabled'] = COpts.Toggle(L['enable'], 0, L['standby_toggle_desc']),
                    }
                },
                sb_settings = {
                    type = 'group',
                    name = L['settings'],
                    inline = true,
                    order = 2,
                    args = {
                        ['standby.standby_pct']  = COpts.Range(L['standby_pct'], 1, 0, 1, 0.01, { isPercent = true, desc = L['standby_pct_desc']})
                    }
                },
            }
        },
    }
}

do
    local defaults = EP.defaults.profile.raid
    -- table for storing processed defaults which needed added as arguments
    -- Creatures indexed by map name
    local creature_ep = Tables.New()

    -- iterate all the creatures and group by map (instance)
    for _, id in Objects.Each(Tables.Keys(defaults.creatures)) do
        -- if you don't convert to number, library calls will fail
        id = tonumber(id)
        local creature, map = Encounter:GetCreatureDetail(id)
        local creatures = creature_ep[map] or Util.Tables.New()
        Tables.Push(creatures, {
            creature_id = id,
            creature_name = creature,
        })
        creature_ep[map] = creatures
    end


    local creature_ep_args = EP.options.args.raid.args
    for _, key in Objects.Each(Tables.Sort(Tables.Keys(creature_ep))) do
        -- arguments that map to the map name (under which creatures will be attached)
        local map_args = Tables.New()
        -- iterate through all the creatrues in the map
        for _, c in Objects.Each(creature_ep[key]) do
            local creature_args = Tables.New()
            -- the key is of format 'creature.id', which will then be used for
            -- reading/writing values from the "db"
            creature_args['raid.creatures.'..tostring(c.creature_id)] = COpts.Range(L['ep'], 1, 1, 100, 1)

            map_args[Strings.ToCamelCase(c.creature_name, ' ')] = {
                type = 'group',
                name = c.creature_name,
                args = creature_args,
            }
        end

        creature_ep_args[Strings.ToCamelCase(key, ' ')] = {
            type = 'group',
            name = key,
            args = map_args
        }
    end
end

function EP:OnInitialize()
    Logging:Debug("OnInitialize(%s)", self:GetName())
    self.db = AddOn.db:RegisterNamespace(self:GetName(), EP.defaults)
end

function EP:OnEnable()
    Logging:Debug("OnEnable(%s)", self:GetName())
end