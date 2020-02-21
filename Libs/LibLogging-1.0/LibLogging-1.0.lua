local MAJOR_VERSION = "LibLogging-1.0"
local MINOR_VERSION = tonumber(("$Revision: 1023 $"):match("%d+")) or 0

local lib, _ = LibStub:NewLibrary(MAJOR_VERSION, MINOR_VERSION)
if not lib then return end

-- are we in test mode
local _TEST = _G.LibLogging_Testing

-- Basic constants for use with library, with a mapping to hierarchy key
lib.Level = {
    Disabled = "Disabled",
    Trace = "Trace",
    Debug = "Debug",
    Info = "Info",
    Warn = "Warn",
    Error = "Error",
    Fatal = "Fatal"
}
-- local reference for ease of use
local Level = lib.Level

-- Establish hierarchy of levels
local LevelHierarchy = {"Disabled", "Trace", "Debug", "Info", "Warn", "Error", "Fatal"}
local MaxLevels = #LevelHierarchy
for i=1,MaxLevels do
    LevelHierarchy[LevelHierarchy[i]] = i
end

-- validates specified level is of correct type and within valid range
-- returns passed level if valid
local function AssertLevel(value)
    assert(type(value) == 'number', format("undefined level `%s'", tostring(level)))
    assert(value, format("undefined level '%s'", tostring(level)))
    assert(value >= LevelHierarchy[LevelHierarchy[1]] and value <= LevelHierarchy[LevelHierarchy[#LevelHierarchy]],
            format("undefined level `%s'", tostring(value)))
    return value
end

-- returns mapping from level to numeric value
-- supports strings or numbers as input
local function GetThreshold(level)
    local value

    if type(level) == "string" then
        value = LevelHierarchy[level]
    elseif type(level) == "number" then
        value = math.floor(tonumber(level))
    end

    return AssertLevel(value)
end

-- expose some internal functionality for purposes of tests
if _TEST then
    function lib:GetThreshold(level)
        return GetThreshold(level)
    end

    function lib:GetMinThreshold()
        return LevelHierarchy[LevelHierarchy[1]]
    end

    function lib:GetMaxThreshold()
        return LevelHierarchy[LevelHierarchy[#LevelHierarchy]]
    end
end

-- a numeric value mapping on to level
local RootThreshold = GetThreshold(Level.Disabled)

function lib:GetRootThreshold()
    return RootThreshold
end

function lib:SetRootThreshold(level)
    RootThreshold = GetThreshold(level)
end

function lib:Enable()
    self:SetRootThreshold(Level.Debug)
end

function lib:Disable()
    self:SetRootThreshold(Level.Disabled)
end

local Writer

function lib:SetWriter(writer)
    Writer = writer
end

function lib:ResetWriter()
    Writer = function(msg) print(msg) end
end

-- set it default to start
lib:ResetWriter()

local function GetDateTime()
    return date("%m/%d/%y %H:%M:%S", time())
end

local function GetCaller()
    local trace = debugstack(4, 1, 0)
    return trace:match("([^\\/]-): in [function|method]") or trace
end

local function Log(writer, level, fmt, ...)
    -- don't log if specified level is above our threshold
    if GetThreshold(level) > RootThreshold then return end
    writer(string.format("%s [%s] (%s): "..fmt, string.upper(level), GetDateTime(), GetCaller(), ...))
end

function lib:Log(level, fmt, ...)
    Log(Writer, level, fmt, ...)
end

function lib:Trace(fmt, ...)
    Log(Writer, Level.Trace, fmt, ...)
end

function lib:Debug(fmt, ...)
    Log(Writer, Level.Debug, fmt, ...)
end

function lib:Warn(fmt, ...)
    Log(Writer, Level.Warn, fmt, ...)
end

function lib:Error(fmt, ...)
    Log(Writer, Level.Error, fmt, ...)
end



