-- =============================================
-- EIC HUB | BLOX FRUITS (v3.0 OP EDITION)
-- UNIVERSAL MOBILE & DESKTOP EXECUTION
-- =============================================
local SCRIPT_VERSION = "3.0"
local LOGO_ASSET_ID = "rbxassetid://73393542095412"

-- Prevent duplicated UI instances
if game:GetService("CoreGui"):FindFirstChild("EicHubUI") then
    game:GetService("CoreGui"):FindFirstChild("EicHubUI"):Destroy()
end

-- ======================
-- [SERVICES & INITIALIZATION]
-- ======================
local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")
local VU = game:GetService("VirtualUser")
local UIS = game:GetService("UserInputService")
local RunS = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local LogService = game:GetService("LogService")

-- Anti-Log / Basic Detection Bypass
pcall(function()
    LogService.MessageOut:Connect(function() end)
end)

local plr = Players.LocalPlayer
repeat task.wait() until plr and plr.Character
repeat task.wait() until plr:FindFirstChild("PlayerGui")
repeat task.wait() until plr.Character:FindFirstChild("HumanoidRootPart")

local function getC() return plr.Character or plr.CharacterAdded:Wait() end
local function getR() local c = getC(); return c:FindFirstChild("HumanoidRootPart") or c:WaitForChild("HumanoidRootPart") end
local function getH() local c = getC(); return c:FindFirstChild("Humanoid") or c:WaitForChild("Humanoid") end
local function getLv() return (plr:FindFirstChild("Data") and plr.Data:FindFirstChild("Level") and plr.Data.Level.Value) or 1 end

local Remotes = RS:WaitForChild("Remotes", 5)
local CF = Remotes and Remotes:WaitForChild("CommF_", 5)
local CE = Remotes and Remotes:WaitForChild("CommE_", 5)

-- Anti-AFK Kick Protection
plr.Idled:Connect(function()
    VU:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
    task.wait(1)
    VU:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
end)

-- ======================
-- [LOCATIONS & BOSS DATA]
-- ======================
local ISLANDS = {
    {"Jungle", Vector3.new(-3863.5, 461.2, -2392.9)},
    {"Pirate Village", Vector3.new(-1122.7, 4.5, 3855.6)},
    {"Desert", Vector3.new(984.4, 4.5, 4101.8)},
    {"Frozen Village", Vector3.new(1121.3, 5.4, 1111.1)},
    {"Marine Fortress", Vector3.new(-5051.7, 80.2, 4335.1)},
    {"Skylands", Vector3.new(-4859.5, 734.5, -5234.7)},
    {"Magma Village", Vector3.new(-5402.9, 43.6, 8442.1)},
    {"Underwater City", Vector3.new(3562.3, 118.1, -5924.2)},
    {"Kingdom of Rose", Vector3.new(-2621.6, 32.3, -7895.4)},
    {"Green Zone", Vector3.new(2020.4, 88.6, -9052.5)},
    {"Floating Turtle", Vector3.new(-697.3, 145.5, 13970.8)}
}
local ISLAND_NAMES = {}
for _, v in ipairs(ISLANDS) do ISLAND_NAMES[v[1]] = v[2] end

local BOSSES = {
    {"Gorilla King", Vector3.new(-1122.7, 4.5, 3855.6)},
    {"Vice Admiral", Vector3.new(-4859.5, 734.5, -5234.7)},
    {"Don Swan", Vector3.new(-2284.7, 21.8, 8759.8)},
    {"Order", Vector3.new(-6242.8, 20.8, -5018.4)},
    {"RIP Indra", Vector3.new(-5314.6, 32.4, 8848.3)},
    {"Dough King", Vector3.new(-2218.7, 73.8, 5328.6)},
    {"Cake Prince", Vector3.new(-2117.6, 38.8, -12028.8)},
    {"Cyborg", Vector3.new(6243.8, 20.8, -4958.6)},
    {"Stone", Vector3.new(1392.3, 98.8, -1029.6)},
    {"Island Empress", Vector3.new(5646.7, 20.8, -648.6)}
}

local QUESTS = {
    {min=1, max=9, npc="BanditQuestGiver", mob="Bandit", quest="BanditQuest1", lq=1, island="Jungle"},
    {min=10, max=14, npc="MonkeyQuestGiver", mob="Monkey", quest="JungleQuest", lq=1, island="Jungle"},
    {min=15, max=29, npc="GorillaQuestGiver", mob="Gorilla", quest="JungleQuest", lq=2, island="Jungle"},
    {min=30, max=39, npc="PirateQuestGiver", mob="Pirate", quest="PirateQuest", lq=1, island="Pirate Village"},
    {min=40, max=54, npc="BruteQuestGiver", mob="Brute", quest="PirateQuest", lq=2, island="Pirate Village"},
    {min=60, max=74, npc="DesertBanditQuestGiver", mob="Desert Bandit", quest="DesertQuest", lq=1, island="Desert"},
    {min=75, max=89, npc="DesertOfficerQuestGiver", mob="Desert Officer", quest="DesertQuest", lq=2, island="Desert"},
    {min=90, max=99, npc="SnowBanditQuestGiver", mob="Snow Bandit", quest="SnowQuest", lq=1, island="Frozen Village"},
    {min=100, max=119, npc="SnowmanQuestGiver", mob="Snowman", quest="SnowQuest", lq=2, island="Frozen Village"},
    {min=120, max=134, npc="ChiefPettyQuestGiver", mob="Chief Petty Officer", quest="MarineQuest", lq=1, island="Marine Fortress"},
    {min=135, max=149, npc="ViceAdmiralQuestGiver", mob="Vice Admiral", quest="MarineQuest", lq=2, island="Marine Fortress"},
    {min=150, max=174, npc="SkyBanditQuestGiver", mob="Sky Bandit", quest="SkyQuest", lq=1, island="Skylands"},
    {min=175, max=189, npc="DarkMasterQuestGiver", mob="Dark Master", quest="SkyQuest", lq=2, island="Skylands"},
    {min=190, max=224, npc="TogaWarriorQuestGiver", mob="Toga Warrior", quest="ColosseumQuest", lq=1, island="Colosseum"},
    {min=225, max=249, npc="GladiatorQuestGiver", mob="Gladiator", quest="ColosseumQuest", lq=2, island="Colosseum"},
    {min=250, max=299, npc="MilitarySoldierQuestGiver", mob="Military Soldier", quest="MagmaQuest", lq=1, island="Magma Village"},
    {min=300, max=324, npc="MilitarySpyQuestGiver", mob="Military Spy", quest="MagmaQuest", lq=2, island="Magma Village"},
    {min=325, max=374, npc="FishmanWarriorQuestGiver", mob="Fishman Warrior", quest="FishmanQuest", lq=1, island="Underwater City"},
    {min=375, max=399, npc="FishmanCommandoQuestGiver", mob="Fishman Commando", quest="FishmanQuest", lq=2, island="Underwater City"},
    {min=400, max=449, npc="GodGuardQuestGiver", mob="God's Guard", quest="SkyExpQuest", lq=1, island="Upper Skylands"},
    {min=450, max=474, npc="ShandaQuestGiver", mob="Shanda", quest="SkyExpQuest", lq=2, island="Upper Skylands"},
    {min=475, max=624, npc="GalleyPirateQuestGiver", mob="Galley Pirate", quest="FountainQuest", lq=1, island="Fountain City"},
    {min=625, max=699, npc="GalleyCaptainQuestGiver", mob="Galley Captain", quest="FountainQuest", lq=2, island="Fountain City"},
    {min=700, max=724, npc="RaiderQuestGiver", mob="Raider", quest="PiratePortQuest", lq=1, island="Kingdom of Rose"},
    {min=725, max=874, npc="MercenaryQuestGiver", mob="Mercenary", quest="PiratePortQuest", lq=2, island="Kingdom of Rose"},
    {min=875, max=899, npc="MarineQuestGiver", mob="Marine", quest="MarineTreeQuest", lq=1, island="Green Zone"},
    {min=900, max=949, npc="MarineCaptainQuestGiver", mob="Marine Captain", quest="MarineTreeQuest", lq=2, island="Green Zone"},
    {min=950, max=974, npc="ZombieQuestGiver", mob="Zombie", quest="GraveyardQuest", lq=1, island="Graveyard"},
    {min=975, max=999, npc="VampireQuestGiver", mob="Vampire", quest="GraveyardQuest", lq=2, island="Graveyard"}
}

-- ======================
-- [STATE CONFIGURATION]
-- ======================
local C = {
    bg = Color3.fromRGB(15, 15, 25),
    card = Color3.fromRGB(25, 25, 40),
    primary = Color3.fromRGB(140, 0, 255),
    accent = Color3.fromRGB(0, 210, 255),
    text = Color3.fromRGB(240, 240, 255),
    textMuted = Color3.fromRGB(140, 140, 170),
    on = Color3.fromRGB(0, 230, 120),
    off = Color3.fromRGB(45, 45, 70),
    danger = Color3.fromRGB(255, 60, 60),
    warning = Color3.fromRGB(255, 180, 0),
    fruit = Color3.fromRGB(255, 110, 0)
}

local T = {
    autoFarm = false, autoLevel = false, autoMastery = false, autoStats = false,
    autoQuest = false, autoChest = false, killAura = false, autoPvP = false,
    godMode = false, fastAttack = false, noCooldown = false, autoBoss = false,
    autoAllBosses = false, autoSeaBeast = false, autoTerrorshark = false,
    autoLeviathan = false, autoCollectFruit = false, autoStoreFruit = false,
    autoRandomFruit = false, fruitESP = false, chestESP = false, enemyESP = false,
    fly = false, infiniteJump = false, noClip = false, walkOnWater = false,
    speed = false, fpsBoost = false, autoBounty = false, autoRaid = false
}

for _, b in ipairs(BOSSES) do 
    T["boss_" .. b[1]:gsub("%s+", "")] = false 
end

-- ======================
-- [CORE UTILITIES]
-- ======================
local function cmd(...) 
    if CF then
        return pcall(CF.InvokeServer, CF, ...) 
    end
    return false
end

local function tweenTo(pos, speed)
    speed = speed or 350
    local r = getR()
    local h = getH()
    if r and h then
        if (r.Position - pos).Magnitude > 500 then
            r.CFrame = CFrame.new(pos + Vector3.new(0, 50, 0))
        else
            h:MoveTo(pos)
        end
        task.wait(0.2)
    end
end

local function findEnemy(options)
    options = options or {}
    local enemiesFolder = workspace:FindFirstChild("Enemies") or workspace:FindFirstChild("NPCs")
    if not enemiesFolder then return nil end

    local bestTarget, bestScore = nil, -math.huge
    for _, e in pairs(enemiesFolder:GetChildren()) do
        if e:FindFirstChild("Humanoid") and e.Humanoid.Health > 0 and e:FindFirstChild("HumanoidRootPart") then
            if options.name and not e.Name:find(options.name) then continue end
            local score = (e:FindFirstChild("Level") and e.Level.Value or 0) * 10
            if options.prioritizeClose then
                local r = getR()
                if r then score = score + (10000 - (r.Position - e.HumanoidRootPart.Position).Magnitude) end
            end
            if score > bestScore then 
                bestScore, bestTarget = score, e 
            end
        end
    end
    return bestTarget
end

local function attackTarget(target)
    local r = getR()
    if not r or not target then return end
    local tp = target:FindFirstChild("HumanoidRootPart") or target
    r.CFrame = tp.CFrame * CFrame.new(0, 0, 10)
    
    local tool = char:FindFirstChildOfClass("Tool") or plr.Backpack:FindFirstChildOfClass("Tool")
    if tool then
        if tool.Parent ~= char then tool.Parent = char end
        tool:Activate()
    end
    VU:ClickButton1(Vector2.new(), workspace.CurrentCamera.CFrame)
end

-- ESP System
local espObjs = {}
local function addESP(obj, color, text)
    if espObjs[obj] or not obj then return end
    local b = Instance.new("BillboardGui")
    b.Name = "EIC_ESP_" .. math.random(1000, 9999)
    b.Size = UDim2.new(0, 120, 0, 30)
    b.Adornee = obj
    b.AlwaysOnTop = true
    b.StudsOffset = Vector3.new(0, 3, 0)
    
    local l = Instance.new("TextLabel", b)
    l.Size = UDim2.new(1, 0, 1, 0)
    l.BackgroundTransparency = 1
    l.Text = text
    l.TextColor3 = color
    l.TextStrokeColor3 = Color3.new(0, 0, 0)
    l.TextStrokeTransparency = 0
    l.TextSize = 13
    l.Font = Enum.Font.GothamBold
    b.Parent = plr:WaitForChild("PlayerGui")
    espObjs[obj] = b
end

local function clearESP()
    for obj, b in pairs(espObjs) do
        if b and b.Parent then b:Destroy() end
    end
    espObjs = {}
end

-- ======================
-- [QUEST LOGIC]
-- ======================
local currentQuest = nil
local function takeQuest()
    local lv = getLv()
    for _, q in ipairs(QUESTS) do
        if lv >= q.min and lv <= q.max then
            cmd("AbandonQuest")
            local pos = ISLAND_NAMES[q.island]
            if pos then tweenTo(pos) end
            cmd("StartQuest", q.npc, q.quest)
            currentQuest = q
            break
        end
    end
end

local function farmCurrent()
    if not currentQuest then
        takeQuest()
        return
    end
    local mob = currentQuest.mob
    local enemy = findEnemy({name = mob, prioritizeClose = true})
    if enemy then
        attackTarget(enemy)
    else
        local pos = ISLAND_NAMES[currentQuest.island]
        if pos then tweenTo(pos) end
    end
end

-- ======================
-- [BACKGROUND LOOPS]
-- ======================
-- Farming Loop
spawn(function()
    while task.wait(0.15) do
        pcall(function()
            if T.autoFarm or T.autoLevel then farmCurrent() end
            if T.autoStats then
                local pts = plr.Data.Points.Value or 0
                if pts > 0 then
                    cmd("AddPoint", "Melee", pts)
                end
            end
            if T.autoChest then
                for _, obj in pairs(workspace:GetChildren()) do
                    if obj.Name:find("Chest") and obj:IsA("Model") and obj:FindFirstChild("Handle") then
                        local r = getR()
                        if r then r.CFrame = obj.Handle.CFrame end
                        task.wait(0.1)
                    end
                end
            end
        end)
    end
end)

-- Combat / KillAura Loop
spawn(function()
    while task.wait(0.1) do
        pcall(function()
            if T.killAura or T.fastAttack then
                local enemiesFolder = workspace:FindFirstChild("Enemies")
                if enemiesFolder then
                    for _, e in pairs(enemiesFolder:GetChildren()) do
                        if e:FindFirstChild("Humanoid") and e:FindFirstChild("HumanoidRootPart") and e.Humanoid.Health > 0 then
                            local r = getR()
                            if r and (r.Position - e.HumanoidRootPart.Position).Magnitude < 50 then
                                attackTarget(e)
                            end
                        end
                    end
                end
            end
            if T.autoAllBosses then
                for _, bname in ipairs(BOSSES) do
                    local e = findEnemy({name = bname[1]})
                    if e then attackTarget(e); break end
                end
            end
        end)
    end
end)

-- ESP & Item Loop
spawn(function()
    while task.wait(0.5) do
        pcall(function()
            clearESP()
            if T.autoCollectFruit then
                for _, obj in pairs(workspace:GetChildren()) do
                    if (obj:IsA("Tool") or obj.Name:find("Fruit")) and obj:FindFirstChild("Handle") then
                        local r = getR()
                        if r then r.CFrame = obj.Handle.CFrame end
                    end
                end
            end
            if T.autoStoreFruit then
                for _, obj in pairs(plr.Backpack:GetChildren()) do
                    if obj:IsA("Tool") and obj.Name:find("Fruit") then 
                        cmd("StoreFruit", obj.Name) 
                    end
                end
            end
            if T.fruitESP then
                for _, o in pairs(workspace:GetChildren()) do
                    if (o:IsA("Tool") or o.Name:find("Fruit")) and o:FindFirstChild("Handle") then
                        addESP(o.Handle, C.fruit, "🍎 " .. o.Name)
                    end
                end
            end
            if T.enemyESP then
                local enemiesFolder = workspace:FindFirstChild("Enemies")
                if enemiesFolder then
                    for _, e in pairs(enemiesFolder:GetChildren()) do
                        if e:FindFirstChild("HumanoidRootPart") and e:FindFirstChild("Humanoid") and e.Humanoid.Health > 0 then
                            addESP(e.HumanoidRootPart, C.danger, "☠️ " .. e.Name)
                        end
                    end
                end
            end
        end)
    end
end)

-- Movement & Flight Loop
local flying, bg, bv = false, nil, nil
spawn(function()
    while task.wait(0.03) do
        pcall(function()
            local r = getR()
            if not r then return end
            if T.fly then
                if not flying then
                    flying = true
                    bg = Instance.new("BodyGyro", r)
                    bg.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
                    bg.P = 10000
                    bv = Instance.new("BodyVelocity", r)
                    bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
                end
                bg.CFrame = workspace.CurrentCamera.CFrame
                bv.Velocity = workspace.CurrentCamera.CFrame.LookVector * (T.speed and 200 or 100)
            elseif flying then
                flying = false
                if bg then bg:Destroy() end
                if bv then bv:Destroy() end
            end
            if T.infiniteJump and UIS:IsKeyDown(Enum.KeyCode.Space) then
                r.Velocity = Vector3.new(r.Velocity.X, 60, r.Velocity.Z)
            end
            if T.noClip then
                for _, p in pairs(getC():GetDescendants()) do
                    if p:IsA("BasePart") then p.CanCollide = false end
                end
            end
        end)
    end
end)

-- ======================
-- [UI CONSTRUCT]
-- ======================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "EicHubUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game:GetService("CoreGui")

-- Floating Logo Toggle Button
local Logo = Instance.new("ImageButton")
Logo.Name = "EicLogo"
Logo.Parent = ScreenGui
Logo.Size = UDim2.new(0, 65, 0, 65)
Logo.Position = UDim2.new(0.03, 0, 0.4, 0)
Logo.BackgroundColor3 = C.bg
Logo.Image = LOGO_ASSET_ID
Logo.Active = true

local LogoCorner = Instance.new("UICorner", Logo)
LogoCorner.CornerRadius = UDim.new(1, 0)

local LogoStroke = Instance.new("UIStroke", Logo)
LogoStroke.Color = C.primary
LogoStroke.Thickness = 2.5

-- Fallback Text if Asset modern loader fails
local FallbackText = Instance.new("TextLabel", Logo)
FallbackText.Size = UDim2.new(1, 0, 1, 0)
FallbackText.BackgroundTransparency = 1
FallbackText.Text = "EIC"
FallbackText.TextColor3 = C.text
FallbackText.TextSize = 18
FallbackText.Font = Enum.Font.GothamBold
FallbackText.Visible = false

task.spawn(function()
    task.wait(2)
    if Logo.ImageContentId == "" or Logo.ImageContentId == "rbxassetid://0" then
        FallbackText.Visible = true
    end
end)

-- Main Menu Window
local Menu = Instance.new("Frame")
Menu.Name = "EicMenu"
Menu.Parent = ScreenGui
Menu.Size = UDim2.new(0, 0, 0, 0)
Menu.Position = UDim2.new(0.5, -310, 0.5, -200)
Menu.BackgroundColor3 = C.bg
Menu.Visible = false
Menu.Active = true
Menu.ClipsDescendants = true

local MenuCorner = Instance.new("UICorner", Menu)
MenuCorner.CornerRadius = UDim.new(0, 10)

local MenuStroke = Instance.new("UIStroke", Menu)
MenuStroke.Color = C.primary
MenuStroke.Thickness = 1.5

-- Header Title
local Header = Instance.new("Frame", Menu)
Header.Size = UDim2.new(1, 0, 0, 40)
Header.BackgroundColor3 = C.card

local HeaderTitle = Instance.new("TextLabel", Header)
HeaderTitle.Size = UDim2.new(1, -20, 1, 0)
HeaderTitle.Position = UDim2.new(0, 15, 0, 0)
HeaderTitle.BackgroundTransparency = 1
HeaderTitle.Text = "⚡ EIC HUB v3.0 | BLOX FRUITS OP"
HeaderTitle.TextColor3 = C.text
HeaderTitle.TextSize = 15
HeaderTitle.Font = Enum.Font.GothamBold
HeaderTitle.TextXAlignment = Enum.TextXAlignment.Left

-- Toggle Menu Visibility
Logo.MouseButton1Click:Connect(function()
    if Menu.Visible then
        local closeTween = TweenService:Create(Menu, TweenInfo.new(0.2), {Size = UDim2.new(0, 0, 0, 0)})
        closeTween:Play()
        closeTween.Completed:Wait()
        Menu.Visible = false
    else
        Menu.Size = UDim2.new(0, 0, 0, 0)
        Menu.Visible = true
        TweenService:Create(Menu, TweenInfo.new(0.25, Enum.EasingStyle.Quart), {Size = UDim2.new(0, 620, 0, 400)}):Play()
    end
end)

-- Touch & Mouse Dragging for Logo Button
local dragging, dragStart, startPos = false, nil, nil
Logo.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = Logo.Position
    end
end)

UIS.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        Logo.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

-- Scroll Container
local ContentScroll = Instance.new("ScrollingFrame", Menu)
ContentScroll.Size = UDim2.new(1, -20, 1, -55)
ContentScroll.Position = UDim2.new(0, 10, 0, 45)
ContentScroll.BackgroundTransparency = 1
ContentScroll.ScrollBarThickness = 4
ContentScroll.ScrollBarImageColor3 = C.primary

local ContentLayout = Instance.new("UIListLayout", ContentScroll)
ContentLayout.Padding = UDim.new(0, 8)
ContentLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    ContentScroll.CanvasSize = UDim2.new(0, 0, 0, ContentLayout.AbsoluteContentSize.Y + 20)
end)

-- Categories Structure
local CATEGORIES = {
    {name = "🔥 AUTOMATION & FARM", color = C.on, toggles = {"autoFarm", "autoLevel", "autoMastery", "autoStats", "autoChest"}},
    {name = "⚔️ OP COMBAT & PVP", color = C.danger, toggles = {"killAura", "fastAttack", "godMode", "autoPvP", "autoBounty"}},
    {name = "👹 BOSS & RAID FARM", color = C.warning, toggles = {"autoAllBosses", "autoRaid"}},
    {name = "🍎 FRUITS & ITEMS", color = C.fruit, toggles = {"autoCollectFruit", "autoStoreFruit", "autoRandomFruit", "fruitESP"}},
    {name = "👁️ ESP & VISUALS", color = C.accent, toggles = {"chestESP", "enemyESP"}},
    {name = "🛩️ MOVEMENT & TELEPORT", color = C.primary, toggles = {"fly", "infiniteJump", "noClip", "speed"}}
}

for _, cat in ipairs(CATEGORIES) do
    local CategoryFrame = Instance.new("Frame", ContentScroll)
    CategoryFrame.Size = UDim2.new(1, 0, 0, 30)
    CategoryFrame.BackgroundColor3 = C.card
    
    local CatCorner = Instance.new("UICorner", CategoryFrame)
    CatCorner.CornerRadius = UDim.new(0, 6)
    
    local CatStroke = Instance.new("UIStroke", CategoryFrame)
    CatStroke.Color = cat.color
    CatStroke.Thickness = 1
    
    local CatTitle = Instance.new("TextLabel", CategoryFrame)
    CatTitle.Size = UDim2.new(1, -10, 0, 28)
    CatTitle.Position = UDim2.new(0, 10, 0, 0)
    CatTitle.BackgroundTransparency = 1
    CatTitle.Text = cat.name
    CatTitle.TextColor3 = cat.color
    CatTitle.TextSize = 13
    CatTitle.Font = Enum.Font.GothamBold
    CatTitle.TextXAlignment = Enum.TextXAlignment.Left

    local Container = Instance.new("Frame", ContentScroll)
    Container.Size = UDim2.new(1, 0, 0, 0)
    Container.BackgroundTransparency = 1
    
    local Grid = Instance.new("UIGridLayout", Container)
    Grid.CellSize = UDim2.new(0.48, 0, 0, 32)
    Grid.CellPadding = UDim2.new(0.03, 0, 0, 6)
    
    for _, tKey in ipairs(cat.toggles) do
        local Btn = Instance.new("TextButton", Container)
        Btn.BackgroundColor3 = T[tKey] and C.on or C.off
        Btn.Text = "  " .. tKey .. " [" .. (T[tKey] and "ON" or "OFF") .. "]"
        Btn.TextColor3 = C.text
        Btn.TextSize = 11
        Btn.Font = Enum.Font.Gotham
        Btn.TextXAlignment = Enum.TextXAlignment.Left

        local BtnCorner = Instance.new("UICorner", Btn)
        BtnCorner.CornerRadius = UDim.new(0, 4)

        Btn.MouseButton1Click:Connect(function()
            T[tKey] = not T[tKey]
            Btn.BackgroundColor3 = T[tKey] and C.on or C.off
            Btn.Text = "  " .. tKey .. " [" .. (T[tKey] and "ON" or "OFF") .. "]"
        end)
    end
    
    Grid:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        Container.Size = UDim2.new(1, 0, 0, Grid.AbsoluteContentSize.Y)
    end)
end
