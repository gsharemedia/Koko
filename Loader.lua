repeat task.wait() until game.GameId ~= 0
if Koko and Koko.Loaded then
    Koko.Utilities.UI:Notification({
        Title = "Koko Hub",
        Description = "Script already executed!",
        Duration = 5
    }) return
end

local PlayerService = game:GetService("Players")
repeat task.wait() until PlayerService.LocalPlayer
local LocalPlayer = PlayerService.LocalPlayer

local function GetSupportedGame() local Game
    for Id,Info in pairs(Koko.Games) do
        if tostring(game.GameId) == Id then
            Game = Info break
        end
    end if not Game then
        Game = Koko.Games.Universal
    end return Game
end

local function GetScript(Script)
    return Koko.Debug and readfile("Koko/" .. Script .. ".lua")
    or game:HttpGetAsync("https://raw.githubusercontent.com/gsharemedia/Koko/main/" .. Script .. ".lua")
end

local function LoadScript(Script)
    return loadstring(Koko.Debug and readfile("Koko/" .. Script .. ".lua")
    or game:HttpGetAsync("https://raw.githubusercontent.com/gsharemedia/Koko/main/" .. Script .. ".lua"))()
end

getgenv().Koko = {
    Loaded = false,
    Debug = false,
    Utilities = {},
    Games = {
        ["Universal"] = {
            Name = "Universal",
            Script = "Universal"
        },
        ["1054526971"] = {
            Name = "Blackhawk Rescue Mission 5",
            Script = "Games/BRM5"
        },
        ["580765040"] = {
            Name = "RAGDOLL UNIVERSE",
            Script = "Games/RU"
        },
        ["1168263273"] = {
            Name = "Bad Business",
            Script = "Games/BB"
        },
        ["807930589"] = {
            Name = "The Wild West",
            Script = "Games/TWW"
        },
        ["187796008"] = {
            Name = "Those Who Remain",
            Script = "Games/TWR"
        },
        ["1586272220"] = {
            Name = "Steel Titans",
            Script = "Games/ST"
        },
        ["358276974"] = {
            Name = "Apocalypse Rising 2",
            Script = "Games/AR2"
        }
    }
}

Koko.Utilities.Misc = LoadScript("Utilities/Misc")
Koko.Utilities.UI = LoadScript("Utilities/UI")
Koko.Utilities.Drawing = LoadScript("Utilities/Drawing")

LocalPlayer.OnTeleport:Connect(function(State)
    if State == Enum.TeleportState.Started then
        local QueueOnTeleport = (syn and syn.queue_on_teleport) or queue_on_teleport
        QueueOnTeleport(GetScript("Loader"))
    end
end)

local SupportedGame = GetSupportedGame()
if SupportedGame then
    Koko.Game = SupportedGame.Name
    LoadScript(SupportedGame.Script)
    Koko.Utilities.UI:Notification({
        Title = "Koko Hub",
        Description = Koko.Game .. " loaded!",
        Duration = 5
    }) Koko.Loaded = true
end
