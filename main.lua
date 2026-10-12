-- [[ BLUE HUB: THE ALL-IN-ONE EDITION ]] --
-- [[ Features: Auto Farm 0-2800, Fruit, Raid, Boss, Stats ]] --
-- [[ Made by Blue Scripts ]] --

local RedzLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/REDZHUB/RedzLibV2/main/Source.lua"))()
local Window = RedzLib:MakeWindow({
    Title = "BLUE HUB 💙",
    SubTitle = "Blox Fruits | Made by Blue Scripts",
    SaveFolder = "BlueHubConfig.json"
})

-- [[ GLOBAL SETTINGS ]] --
_G.BlueSettings = {
    AutoFarm = false,
    Weapon = "Melee",
    FastAttack = true,
    BringMobs = true,
    AutoStats = false,
    AutoHaki = true,
    AutoFruit = {Bring = false, Store = true},
    Raid = {AutoRaid = false, Select = "Flame"}
}

-- [[ DATA TABLES ]] --
local SeaData = {
    -- [Sea 1: 0-700]
    [2753915549] = {
        {Level = 0, Name = "Bandit", NPC = "Bandit Recruiter", Quest = "BanditQuest1", NPC_Pos = CFrame.new(1059, 16, 1549), Enemy_Pos = CFrame.new(1145, 17, 1630)},
        {Level = 10, Name = "Monkey", NPC = "Monkey Trainer", Quest = "JungleQuest", NPC_Pos = CFrame.new(-1601, 37, 153), Enemy_Pos = CFrame.new(-1623, 37, 145)},
        {Level = 15, Name = "Gorilla", NPC = "Monkey Trainer", Quest = "JungleQuest", NPC_Pos = CFrame.new(-1601, 37, 153), Enemy_Pos = CFrame.new(-1237, 6, -486)},
        {Level = 30, Name = "Pirate", NPC = "Pirate Adventurer", Quest = "BuggyQuest1", NPC_Pos = CFrame.new(-1140, 4, 3828), Enemy_Pos = CFrame.new(-1215, 4, 3915)},
        {Level = 40, Name = "Brute", NPC = "Pirate Adventurer", Quest = "BuggyQuest1", NPC_Pos = CFrame.new(-1140, 4, 3828), Enemy_Pos = CFrame.new(-1145, 14, 4350)},
        {Level = 60, Name = "Desert Bandit", NPC = "Desert Quest Giver", Quest = "DesertQuest", NPC_Pos = CFrame.new(897, 6, 4388), Enemy_Pos = CFrame.new(932, 6, 4485)},
        {Level = 75, Name = "Desert Officer", NPC = "Desert Quest Giver", Quest = "DesertQuest", NPC_Pos = CFrame.new(897, 6, 4388), Enemy_Pos = CFrame.new(1572, 10, 4375)},
        {Level = 90, Name = "Snow Bandit", NPC = "Snow Quest Giver", Quest = "SnowQuest", NPC_Pos = CFrame.new(1385, 87, -1298), Enemy_Pos = CFrame.new(1285, 105, -1342)},
        {Level = 100, Name = "Snowman", NPC = "Snow Quest Giver", Quest = "SnowQuest", NPC_Pos = CFrame.new(1385, 87, -1298), Enemy_Pos = CFrame.new(1285, 105, -1500)},
        {Level = 120, Name = "Chief Petty Officer", NPC = "Marine Quest Giver", Quest = "MarineQuest2", NPC_Pos = CFrame.new(-5036, 28, 4324), Enemy_Pos = CFrame.new(-4800, 21, 4290)},
        {Level = 150, Name = "Sky Bandit", NPC = "Sky Quest Giver", Quest = "SkyQuest", NPC_Pos = CFrame.new(-4840, 717, -2620), Enemy_Pos = CFrame.new(-4975, 717, -2880)},
        {Level = 175, Name = "Dark Master", NPC = "Sky Quest Giver", Quest = "SkyQuest", NPC_Pos = CFrame.new(-4840, 717, -2620), Enemy_Pos = CFrame.new(-5220, 388, -2250)},
        {Level = 190, Name = "Prisoner", NPC = "Prison Quest Giver", Quest = "PrisonerQuest", NPC_Pos = CFrame.new(5308, 1, 475), Enemy_Pos = CFrame.new(5400, 1, 475)},
        {Level = 210, Name = "Dangerous Prisoner", NPC = "Prison Quest Giver", Quest = "PrisonerQuest", NPC_Pos = CFrame.new(5308, 1, 475), Enemy_Pos = CFrame.new(5550, 1, 650)},
        {Level = 250, Name = "Toga Warrior", NPC = "Colosseum Quest Giver", Quest = "ColosseumQuest", NPC_Pos = CFrame.new(-1580, 7, -2980), Enemy_Pos = CFrame.new(-1800, 50, -2750)},
        {Level = 275, Name = "Gladiator", NPC = "Colosseum Quest Giver", Quest = "ColosseumQuest", NPC_Pos = CFrame.new(-1580, 7, -2980), Enemy_Pos = CFrame.new(-1350, 50, -3300)},
        {Level = 300, Name = "Military Soldier", NPC = "Magma Quest Giver", Quest = "MagmaQuest", NPC_Pos = CFrame.new(-5315, 12, 8515), Enemy_Pos = CFrame.new(-5400, 60, 8500)},
        {Level = 325, Name = "Military Spy", NPC = "Magma Quest Giver", Quest = "MagmaQuest", NPC_Pos = CFrame.new(-5315, 12, 8515), Enemy_Pos = CFrame.new(-5800, 80, 8800)},
        {Level = 375, Name = "Fishman Warrior", NPC = "Fishman Quest Giver", Quest = "FishmanQuest", NPC_Pos = CFrame.new(61122, 18, 1569), Enemy_Pos = CFrame.new(61000, 18, 1200)},
        {Level = 400, Name = "Fishman Commando", NPC = "Fishman Quest Giver", Quest = "FishmanQuest", NPC_Pos = CFrame.new(61122, 18, 1569), Enemy_Pos = CFrame.new(61800, 18, 1500)},
        {Level = 450, Name = "God's Guard", NPC = "Sky2 Quest Giver", Quest = "Sky2Quest", NPC_Pos = CFrame.new(-7860, 5545, -380), Enemy_Pos = CFrame.new(-7700, 5560, -400)},
        {Level = 475, Name = "Shandora Warrior", NPC = "Sky2 Quest Giver", Quest = "Sky2Quest", NPC_Pos = CFrame.new(-7860, 5545, -380), Enemy_Pos = CFrame.new(-7650, 5560, -600)},
        {Level = 525, Name = "Royal Squad", NPC = "Sky2 Quest Giver 2", Quest = "Sky2Quest2", NPC_Pos = CFrame.new(-7900, 5635, -2250), Enemy_Pos = CFrame.new(-7600, 5600, -2300)},
        {Level = 550, Name = "Royal Guard", NPC = "Sky2 Quest Giver 2", Quest = "Sky2Quest2", NPC_Pos = CFrame.new(-7900, 5635, -2250), Enemy_Pos = CFrame.new(-7700, 5600, -2500)},
        {Level = 625, Name = "Galley Pirate", NPC = "Fountain Quest Giver", Quest = "FountainQuest", NPC_Pos = CFrame.new(5258, 38, 4050), Enemy_Pos = CFrame.new(5500, 38, 3900)},
        {Level = 650, Name = "Galley Captain", NPC = "Fountain Quest Giver", Quest = "FountainQuest", NPC_Pos = CFrame.new(5258, 38, 4050), Enemy_Pos = CFrame.new(5600, 38, 4900)}
    },
    -- [Sea 2: 700-1500]
    [4442272183] = {
        {Level = 700, Name = "Raider", NPC = "Area1QuestGiver", Quest = "Area1Quest", NPC_Pos = CFrame.new(-424, 73, 1837), Enemy_Pos = CFrame.new(-380, 75, 1890)},
        {Level = 725, Name = "Mercenary", NPC = "Area1QuestGiver", Quest = "Area1Quest", NPC_Pos = CFrame.new(-424, 73, 1837), Enemy_Pos = CFrame.new(-500, 75, 1600)},
        {Level = 775, Name = "Swan Pirate", NPC = "Area2QuestGiver", Quest = "Area2Quest", NPC_Pos = CFrame.new(638, 73, 918), Enemy_Pos = CFrame.new(850, 120, 1100)},
        {Level = 800, Name = "Factory Staff", NPC = "Area2QuestGiver", Quest = "Area2Quest", NPC_Pos = CFrame.new(638, 73, 918), Enemy_Pos = CFrame.new(200, 73, 700)},
        {Level = 875, Name = "Marine Officer", NPC = "MarineQuestGiver", Quest = "MarineQuest", NPC_Pos = CFrame.new(-2440, 73, -3220), Enemy_Pos = CFrame.new(-2800, 73, -3000)},
        {Level = 900, Name = "Marine Lieutenant", NPC = "MarineQuestGiver", Quest = "MarineQuest", NPC_Pos = CFrame.new(-2440, 73, -3220), Enemy_Pos = CFrame.new(-3000, 73, -3300)},
        {Level = 950, Name = "Zombie", NPC = "GraveyardQuestGiver", Quest = "GraveyardQuest", NPC_Pos = CFrame.new(-5490, 48, -795), Enemy_Pos = CFrame.new(-5600, 48, -900)},
        {Level = 975, Name = "Vampire", NPC = "GraveyardQuestGiver", Quest = "GraveyardQuest", NPC_Pos = CFrame.new(-5490, 48, -795), Enemy_Pos = CFrame.new(-6000, 6, -1300)},
        {Level = 1000, Name = "Snow Trooper", NPC = "SnowQuestGiver", Quest = "SnowQuest2", NPC_Pos = CFrame.new(607, 401, -5370), Enemy_Pos = CFrame.new(500, 401, -5500)},
        {Level = 1025, Name = "Winter Warrior", NPC = "SnowQuestGiver", Quest = "SnowQuest2", NPC_Pos = CFrame.new(607, 401, -5370), Enemy_Pos = CFrame.new(1100, 401, -5200)},
        {Level = 1100, Name = "Lab Subordinate", NPC = "IceSideQuestGiver", Quest = "IceSideQuest", NPC_Pos = CFrame.new(-6060, 15, -4980), Enemy_Pos = CFrame.new(-5800, 15, -4800)},
        {Level = 1125, Name = "Horned Warrior", NPC = "IceSideQuestGiver", Quest = "IceSideQuest", NPC_Pos = CFrame.new(-6060, 15, -4980), Enemy_Pos = CFrame.new(-6400, 15, -5800)},
        {Level = 1175, Name = "Magma Ninja", NPC = "FireSideQuestGiver", Quest = "FireSideQuest", NPC_Pos = CFrame.new(-5430, 15, -5290), Enemy_Pos = CFrame.new(-5400, 15, -5800)},
        {Level = 1200, Name = "Lava Pirate", NPC = "FireSideQuestGiver", Quest = "FireSideQuest", NPC_Pos = CFrame.new(-5430, 15, -5290), Enemy_Pos = CFrame.new(-5200, 15, -4800)},
        {Level = 1250, Name = "Ship Deckhand", NPC = "ShipQuestGiver", Quest = "ShipQuest1", NPC_Pos = CFrame.new(1038, 125, 32911), Enemy_Pos = CFrame.new(1200, 125, 32900)},
        {Level = 1275, Name = "Ship Engineer", NPC = "ShipQuestGiver", Quest = "ShipQuest1", NPC_Pos = CFrame.new(1038, 125, 32911), Enemy_Pos = CFrame.new(900, 125, 32800)},
        {Level = 1300, Name = "Ship Steward", NPC = "ShipQuestGiver2", Quest = "ShipQuest2", NPC_Pos = CFrame.new(968, 125, 33240), Enemy_Pos = CFrame.new(900, 125, 33400)},
        {Level = 1325, Name = "Ship Officer", NPC = "ShipQuestGiver2", Quest = "ShipQuest2", NPC_Pos = CFrame.new(968, 125, 33240), Enemy_Pos = CFrame.new(1000, 125, 33500)},
        {Level = 1350, Name = "Arctic Warrior", NPC = "FrostQuestGiver", Quest = "FrostQuest", NPC_Pos = CFrame.new(5667, 28, -6482), Enemy_Pos = CFrame.new(6000, 28, -6200)},
        {Level = 1375, Name = "Snow Lurker", NPC = "FrostQuestGiver", Quest = "FrostQuest", NPC_Pos = CFrame.new(5667, 28, -6482), Enemy_Pos = CFrame.new(5500, 28, -6800)},
        {Level = 1425, Name = "Sea Soldier", NPC = "ForgottenQuestGiver", Quest = "ForgottenQuest", NPC_Pos = CFrame.new(-3054, 235, -10145), Enemy_Pos = CFrame.new(-3000, 235, -9700)},
        {Level = 1450, Name = "Water Fighter", NPC = "ForgottenQuestGiver", Quest = "ForgottenQuest", NPC_Pos = CFrame.new(-3054, 235, -10145), Enemy_Pos = CFrame.new(-3400, 235, -9700)}
    },
    -- [Sea 3: 1500-2800]
    [7449925015] = {
        {Level = 1500, Name = "Pirate Millionaire", NPC = "PortQuestGiver", Quest = "PiratePortQuest", NPC_Pos = CFrame.new(-290, 44, 5580), Enemy_Pos = CFrame.new(-300, 44, 5300)},
        {Level = 1525, Name = "Pistol Billionaire", NPC = "PortQuestGiver", Quest = "PiratePortQuest", NPC_Pos = CFrame.new(-290, 44, 5580), Enemy_Pos = CFrame.new(-450, 44, 5800)},
        {Level = 1575, Name = "Dragon Crew Warrior", NPC = "AmazonQuestGiver", Quest = "AmazonQuest", NPC_Pos = CFrame.new(5832, 51, -1105), Enemy_Pos = CFrame.new(6100, 51, -1300)},
        {Level = 1600, Name = "Dragon Crew Archer", NPC = "AmazonQuestGiver", Quest = "AmazonQuest", NPC_Pos = CFrame.new(5832, 51, -1105), Enemy_Pos = CFrame.new(6600, 51, -900)},
        {Level = 1675, Name = "Female Islander", NPC = "AmazonQuestGiver2", Quest = "AmazonQuest2", NPC_Pos = CFrame.new(5446, 601, 750), Enemy_Pos = CFrame.new(5700, 601, 900)},
        {Level = 1700, Name = "Giant Islander", NPC = "AmazonQuestGiver2", Quest = "AmazonQuest2", NPC_Pos = CFrame.new(5446, 601, 750), Enemy_Pos = CFrame.new(5000, 601, 700)},
        {Level = 1775, Name = "Marine Commodore", NPC = "MarineTreeQuestGiver", Quest = "MarineTreeQuest", NPC_Pos = CFrame.new(2180, 29, -6740), Enemy_Pos = CFrame.new(2400, 29, -6800)},
        {Level = 1800, Name = "Marine Rear Admiral", NPC = "MarineTreeQuestGiver", Quest = "MarineTreeQuest", NPC_Pos = CFrame.new(2180, 29, -6740), Enemy_Pos = CFrame.new(3000, 29, -6700)},
        {Level = 1825, Name = "Fishman Raider", NPC = "DeepFloatingQuestGiver", Quest = "DeepFloatingQuest", NPC_Pos = CFrame.new(-10580, 332, -8910), Enemy_Pos = CFrame.new(-10400, 332, -8700)},
        {Level = 1850, Name = "Fishman Captain", NPC = "DeepFloatingQuestGiver", Quest = "DeepFloatingQuest", NPC_Pos = CFrame.new(-10580, 332, -8910), Enemy_Pos = CFrame.new(-11000, 332, -8900)},
        {Level = 1900, Name = "Forest Pirate", NPC = "DeepFloatingQuestGiver2", Quest = "DeepFloatingQuest2", NPC_Pos = CFrame.new(-13230, 332, -7625), Enemy_Pos = CFrame.new(-13400, 332, -7900)},
        {Level = 1925, Name = "Mythological Pirate", NPC = "DeepFloatingQuestGiver2", Quest = "DeepFloatingQuest2", NPC_Pos = CFrame.new(-13230, 332, -7625), Enemy_Pos = CFrame.new(-13500, 332, -7300)},
        {Level = 1975, Name = "Jungle Pirate", NPC = "PineappleQuestGiver", Quest = "PineappleQuest", NPC_Pos = CFrame.new(-13300, 332, -10470), Enemy_Pos = CFrame.new(-13500, 332, -10700)},
        {Level = 2000, Name = "Musketeer Pirate", NPC = "PineappleQuestGiver", Quest = "PineappleQuest", NPC_Pos = CFrame.new(-13300, 332, -10470), Enemy_Pos = CFrame.new(-13200, 332, -10000)},
        {Level = 2075, Name = "Reborn Skeleton", NPC = "HauntedQuestGiver", Quest = "HauntedQuest1", NPC_Pos = CFrame.new(-9515, 172, 6078), Enemy_Pos = CFrame.new(-8800, 172, 6000)},
        {Level = 2100, Name = "Living Zombie", NPC = "HauntedQuestGiver", Quest = "HauntedQuest1", NPC_Pos = CFrame.new(-9515, 172, 6078), Enemy_Pos = CFrame.new(-10100, 172, 5800)},
        {Level = 2125, Name = "Demonic Soul", NPC = "HauntedQuestGiver2", Quest = "HauntedQuest2", NPC_Pos = CFrame.new(-9515, 172, 6078), Enemy_Pos = CFrame.new(-9500, 172, 6400)},
        {Level = 2150, Name = "Posessed Mummy", NPC = "HauntedQuestGiver2", Quest = "HauntedQuest2", NPC_Pos = CFrame.new(-9515, 172, 6078), Enemy_Pos = CFrame.new(-9500, 14, 6100)},
        {Level = 2200, Name = "Peanut Scout", NPC = "NutsQuestGiver", Quest = "NutsQuest", NPC_Pos = CFrame.new(-2105, 38, -10190), Enemy_Pos = CFrame.new(-2000, 38, -10300)},
        {Level = 2225, Name = "Peanut President", NPC = "NutsQuestGiver", Quest = "NutsQuest", NPC_Pos = CFrame.new(-2105, 38, -10190), Enemy_Pos = CFrame.new(-2200, 38, -10500)},
        {Level = 2250, Name = "Ice Cream Chef", NPC = "IceCreamQuestGiver", Quest = "IceCreamQuest", NPC_Pos = CFrame.new(-820, 65, -10965), Enemy_Pos = CFrame.new(-600, 65, -11100)},
        {Level = 2275, Name = "Ice Cream Commander", NPC = "IceCreamQuestGiver", Quest = "IceCreamQuest", NPC_Pos = CFrame.new(-820, 65, -10965), Enemy_Pos = CFrame.new(-1000, 65, -11200)},
        {Level = 2300, Name = "Cookie Crafter", NPC = "CakeQuestGiver1", Quest = "CakeQuest1", NPC_Pos = CFrame.new(-2020, 38, -12025), Enemy_Pos = CFrame.new(-2300, 38, -12100)},
        {Level = 2325, Name = "Cake Guard", NPC = "CakeQuestGiver1", Quest = "CakeQuest1", NPC_Pos = CFrame.new(-2020, 38, -12025), Enemy_Pos = CFrame.new(-1600, 38, -12300)},
        {Level = 2350, Name = "Baking Staff", NPC = "CakeQuestGiver2", Quest = "CakeQuest2", NPC_Pos = CFrame.new(-1925, 38, -12850), Enemy_Pos = CFrame.new(-1800, 38, -13000)},
        {Level = 2375, Name = "Head Baker", NPC = "CakeQuestGiver2", Quest = "CakeQuest2", NPC_Pos = CFrame.new(-1925, 38, -12850), Enemy_Pos = CFrame.new(-2100, 38, -13100)},
        {Level = 2425, Name = "Chocolate Bar Battler", NPC = "ChocolateQuestGiver", Quest = "ChocolateQuest", NPC_Pos = CFrame.new(280, 25, -12500), Enemy_Pos = CFrame.new(200, 25, -12700)},
        {Level = 2450, Name = "Sweet Thief", NPC = "ChocolateQuestGiver", Quest = "ChocolateQuest", NPC_Pos = CFrame.new(280, 25, -12500), Enemy_Pos = CFrame.new(500, 25, -12400)},
        {Level = 2475, Name = "Candy Rebel", NPC = "CandyQuestGiver", Quest = "CandyQuest", NPC_Pos = CFrame.new(-1150, 15, -14300), Enemy_Pos = CFrame.new(-1300, 15, -14500)},
        {Level = 2525, Name = "Candy Pirate", NPC = "CandyQuestGiver", Quest = "CandyQuest", NPC_Pos = CFrame.new(-1150, 15, -14300), Enemy_Pos = CFrame.new(-1000, 15, -14100)},
        {Level = 2575, Name = "Island Boy", NPC = "TikiQuestGiver1", Quest = "TikiQuest1", NPC_Pos = CFrame.new(-16530, 55, -172, 1, 0, 0, 0, 1, 0, 0, 0, 1), Enemy_Pos = CFrame.new(-16800, 55, -300)},
        {Level = 2625, Name = "Sun-kissed Warrior", NPC = "TikiQuestGiver1", Quest = "TikiQuest1", NPC_Pos = CFrame.new(-16530, 55, -172, 1, 0, 0, 0, 1, 0, 0, 0, 1), Enemy_Pos = CFrame.new(-16300, 55, -500)},
        {Level = 2675, Name = "Isle Outlaw", NPC = "TikiQuestGiver2", Quest = "TikiQuest2", NPC_Pos = CFrame.new(-16530, 55, -172, 1, 0, 0, 0, 1, 0, 0, 0, 1), Enemy_Pos = CFrame.new(-17100, 55, 200)},
        {Level = 2725, Name = "Isle Champion", NPC = "TikiQuestGiver2", Quest = "TikiQuest2", NPC_Pos = CFrame.new(-16530, 55, -172, 1, 0, 0, 0, 1, 0, 0, 0, 1), Enemy_Pos = CFrame.new(-16000, 55, 400)}
    }
}

-- [[ SERVICES & LOCAL PLAYER ]] --
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TeleportService = game:GetService("TeleportService")
local VirtualUser = game:GetService("VirtualUser")

local LocalPlayer = Players.LocalPlayer

-- Anti-AFK Setup
LocalPlayer.Idled:Connect(function()
    VirtualUser:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
    task.wait(1)
    VirtualUser:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
end)

-- [[ CORE HELPER FUNCTIONS ]] --
local function GetCurrentData()
    local levelObj = LocalPlayer:FindFirstChild("Data") and LocalPlayer.Data:FindFirstChild("Level")
    local myLevel = levelObj and levelObj.Value or 1
    local data = SeaData[game.PlaceId]
    if not data then return nil end
    local best = nil
    for _, v in pairs(data) do
        if myLevel >= v.Level then best = v end
    end
    return best
end

local function BlueTween(TargetCFrame)
    local char = LocalPlayer.Character
    if not char then return end
    local HRP = char:FindFirstChild("HumanoidRootPart")
    if not HRP then return end
    
    local distance = (TargetCFrame.p - HRP.Position).Magnitude
    local tweenInfo = TweenInfo.new(distance / 350, Enum.EasingStyle.Linear)
    local tween = TweenService:Create(HRP, tweenInfo, {CFrame = TargetCFrame})
    tween:Play()
    return tween
end

local function EquipWeapon(weaponType)
    local char = LocalPlayer.Character
    local backpack = LocalPlayer:FindFirstChild("Backpack")
    if not char or not backpack then return end

    for _, item in pairs(backpack:GetChildren()) do
        if item:IsA("Tool") then
            local isMatch = false
            if weaponType == "Melee" and item.ToolTip == "Melee" then isMatch = true
            elseif weaponType == "Sword" and item.ToolTip == "Sword" then isMatch = true
            elseif weaponType == "Fruit" and item.ToolTip == "Blox Fruit" then isMatch = true
            end
            
            if isMatch then
                char.Humanoid:EquipTool(item)
                break
            end
        end
    end
end

local function AutoBusoHaki()
    local char = LocalPlayer.Character
    if char and not char:FindFirstChild("HasBuso") and _G.BlueSettings.AutoHaki then
        local rem = ReplicatedStorage:FindFirstChild("Remotes") and ReplicatedStorage.Remotes:FindFirstChild("CommF_")
        if rem then
            rem:InvokeServer("Buso")
        end
    end
end

-- [[ UI TABS ]] --
local MainTab = Window:MakeTab({"Main Farm", "home"})
local FruitTab = Window:MakeTab({"Fruits", "apple"})
local RaidTab = Window:MakeTab({"Raids", "zap"})
local MiscTab = Window:MakeTab({"Settings", "settings"})

-- [[ MAIN TAB CONTROLS ]] --
MainTab:AddToggle({
    Name = "Auto Farm Level (0-2800)",
    Default = false,
    Callback = function(Value)
        _G.BlueSettings.AutoFarm = Value
        spawn(function()
            while _G.BlueSettings.AutoFarm do
                task.wait(0.1)
                local data = GetCurrentData()
                if data then
                    AutoBusoHaki()
                    EquipWeapon(_G.BlueSettings.Weapon)
                    
                    -- Check if player has the quest active
                    local questTitle = LocalPlayer.PlayerGui:FindFirstChild("Main") 
                        and LocalPlayer.PlayerGui.Main:FindFirstChild("Quest") 
                        and LocalPlayer.PlayerGui.Main.Quest.Visible
                    
                    if not questTitle then
                        -- Tween to NPC and claim quest
                        BlueTween(data.NPC_Pos)
                        local dist = (LocalPlayer.Character.HumanoidRootPart.Position - data.NPC_Pos.p).Magnitude
                        if dist < 15 then
                            local rem = ReplicatedStorage:FindFirstChild("Remotes") and ReplicatedStorage.Remotes:FindFirstChild("CommF_")
                            if rem then
                                rem:InvokeServer("StartQuest", data.Quest, 1)
                            end
                        end
                    else
                        -- Quest active: find enemy and farm
                        local targetEnemy = nil
                        for _, enemy in pairs(workspace.Enemies:GetChildren()) do
                            if enemy.Name == data.Name and enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 and enemy:FindFirstChild("HumanoidRootPart") then
                                targetEnemy = enemy
                                break
                            end
                        end

                        if targetEnemy then
                            -- Hover slightly above enemy to avoid attacks
                            BlueTween(targetEnemy.HumanoidRootPart.CFrame * CFrame.new(0, 10, 0))
                            
                            -- Fast Attack trigger via VirtualUser click
                            if _G.BlueSettings.FastAttack then
                                VirtualUser:CaptureController()
                                VirtualUser:Button1Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
                            end
                        else
                            -- Move to enemy spawn area if no spawned targets found
                            BlueTween(data.Enemy_Pos)
                        end
                    end
                end
            end
        end)
    end
})

MainTab:AddDropdown({
    Name = "Select Weapon",
    Options = {"Melee", "Sword", "Fruit"},
    Default = "Melee",
    Callback = function(v) 
        _G.BlueSettings.Weapon = v 
    end
})

MainTab:AddToggle({
    Name = "Fast Attack",
    Default = true,
    Callback = function(v)
        _G.BlueSettings.FastAttack = v
    end
})

MainTab:AddToggle({
    Name = "Auto Haki",
    Default = true,
    Callback = function(v)
        _G.BlueSettings.AutoHaki = v
    end
})

-- [[ FRUIT TAB CONTROLS ]] --
FruitTab:AddToggle({
    Name = "Auto Store Fruits",
    Default = true,
    Callback = function(v) 
        _G.BlueSettings.AutoFruit.Store = v 
    end
})

spawn(function()
    while task.wait(2) do
        if _G.BlueSettings.AutoFruit.Store then
            local backpack = LocalPlayer:FindFirstChild("Backpack")
            local char = LocalPlayer.Character
            local rem = ReplicatedStorage:FindFirstChild("Remotes") and ReplicatedStorage.Remotes:FindFirstChild("CommF_")
            
            if rem and backpack then
                for _, item in pairs(backpack:GetChildren()) do
                    if item:IsA("Tool") and item.ToolTip == "Blox Fruit" then
                        rem:InvokeServer("StoreFruit", item.Name, item)
                    end
                end
            end
            if rem and char then
                for _, item in pairs(char:GetChildren()) do
                    if item:IsA("Tool") and item.ToolTip == "Blox Fruit" then
                        rem:InvokeServer("StoreFruit", item.Name, item)
                    end
                end
            end
        end
    end
end)

-- [[ RAID TAB CONTROLS ]] --
RaidTab:AddDropdown({
    Name = "Select Raid Chip",
    Options = {"Flame", "Ice", "Quake", "Light", "Dark", "Rumble", "Magma", "Human: Buddha", "Sand", "Bird: Phoenix"},
    Default = "Flame",
    Callback = function(v)
        _G.BlueSettings.Raid.Select = v
    end
})

RaidTab:AddButton({
    Name = "Buy Raid Microchip",
    Callback = function()
        local rem = ReplicatedStorage:FindFirstChild("Remotes") and ReplicatedStorage.Remotes:FindFirstChild("CommF_")
        if rem then
            rem:InvokeServer("RaidsNpc", "Select", _G.BlueSettings.Raid.Select)
        end
    end
})

-- [[ MISC / SETTINGS TAB CONTROLS ]] --
MiscTab:AddButton({
    Name = "Server Hop",
    Callback = function()
        local HttpService = game:GetService("HttpService")
        local placeId = game.PlaceId
        local serversUrl = "https://games.roblox.com/v1/games/" .. placeId .. "/servers/0?sortOrder=Asc&limit=100"
        
        local success, result = pcall(function()
            return HttpService:JSONDecode(game:HttpGet(serversUrl))
        end)
        
        if success and result and result.data then
            for _, server in pairs(result.data) do
                if server.playing < server.maxPlayers and server.id ~= game.JobId then
                    TeleportService:TeleportToPlaceInstance(placeId, server.id, LocalPlayer)
                    break
                end
            end
        end
    end
})

MiscTab:AddButton({
    Name = "Rejoin Game",
    Callback = function()
        TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
    end
})

-- [[ INITIALIZATION NOTIFICATION ]] --
RedzLib:Notify({
    Title = "BLUE HUB", 
    Content = "Made by Blue Scripts! All Systems Integrated.", 
    Duration = 5
})
