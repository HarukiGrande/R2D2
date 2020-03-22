local name, AddOn = ...

AddOn.Constants = {
    name    =   name,
    chat    =   "chat",
    group   =   "group",
    guild   =   "guild",
    player  =   "player",
    party   =   "party",

    Channels = {
        None        =   "NONE",
        Guild       =   "GUILD",
        Instance    =   "INSTANCE_CHAT",
        Officer     =   "OFFICER",
        Party       =   "PARTY",
        Raid        =   "RAID",
        RaidWarning =   "RAID_WARNING",
        Whisper     =   "WHISPER",
    },

    Commands = {
        Candidates              =   "Candidates",
        CandidatesRequest       =   "CandidatesRequest",
        LootTable               =   "LootTable",
        LootTableAdd            =   "LootTableAdd",
        MasterLooterDb          =   "MasterLooterDb",
        MasterLooterDbRequest   =   "MasterLooterDbRequest",
        MasterLooterDbCheck     =   "MasterLooterDbCheck",
        OfflineCheck            =   "OfflineCheck",
        PlayerInfo              =   "PlayerInfo",
        PlayerInfoRequest       =   "PlayerInfoRequest",
        Reconnect               =   "Reconnect",
        Response                =   "Response",
        Roll                    =   "Roll",
    },

    Messages = {
        MasterLooterAddItem =   name .. "_MasterLooterAddItem",
        MasterLooterBuildDb =   name .. "_MasterLooterBuildDb"
    },

    Responses = {
        Disabled    =   "Disabled",
        NotInRaid   =   "NotInRaid",
    }

}