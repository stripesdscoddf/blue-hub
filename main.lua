--[[
    redz Hub v3 — main.lua (Blox Fruits - Complete & Standalone Edition)
    Features: Full Auto Farm, Quest System, Air Hover, Fast Attack, Bring Mobs, Auto Stats, Teleports, & Fruit Store
--]]

--// Services
local Players         = game:GetService("Players")
local RunService      = game:GetService("RunService")
local UserInputService= game:GetService("UserInputService")
local TweenService    = game:GetService("TweenService")
local CoreGui         = game:GetService("CoreGui")
local HttpService     = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser     = game:GetService("VirtualUser")
local TeleportService = game:GetService("TeleportService")

local LocalPlayer = Players.LocalPlayer

--// ═══════════════════════════════════════════
--// BUILT-IN FARM & QUEST DATA
--// ═══════════════════════════════════════════
local LevelData = {
    { MinLvl = 1,   MaxLvl = 14,  Mob = "Bandit",               Quest = "BanditQuest1",   QuestLvl = 1, NPCPos = Vector3.new(1059, 16, 1549) },
    { MinLvl = 15,  MaxLvl = 29,  Mob = "Monkey",               Quest = "JungleQuest",    QuestLvl = 1, NPCPos = Vector3.new(-1600, 37, 153) },
    { MinLvl = 30,  MaxLvl = 59,  Mob = "Pirate",               Quest = "PirateQuest",    QuestLvl = 1, NPCPos = Vector3.new(-1140, 4, 3828) },
    { MinLvl = 60,  MaxLvl = 89,  Mob = "Desert Bandit",        Quest = "DesertQuest",    QuestLvl = 1, NPCPos = Vector3.new(894, 6, 4384) },
    { MinLvl = 90,  MaxLvl = 119, Mob = "Snow Bandit",          Quest = "SnowQuest",      QuestLvl = 1, NPCPos = Vector3.new(1385, 87, -1298) },
    { MinLvl = 120, MaxLvl = 149, Mob = "Chief Petty Officer", Quest = "MarineQuest2",    QuestLvl = 1, NPCPos = Vector3.new(-5035, 20, 4323) },
    { MinLvl = 150, MaxLvl = 189, Mob = "Sky Bandit",          Quest = "SkyQuest",       QuestLvl = 1, NPCPos = Vector3.new(-4840, 718, -2620) },
    { MinLvl = 190, MaxLvl = 249, Mob = "Prisoner",             Quest = "PrisonerQuest",  QuestLvl = 1, NPCPos = Vector3.new(530, 2, 482) },
    { MinLvl = 250, MaxLvl = 299, Mob = "Toga Warrior",         Quest = "ColosseumQuest", QuestLvl = 1, NPCPos = Vector3.new(-1580, 7, -2980) },
    { MinLvl = 300, MaxLvl = 374, Mob = "Military Soldier",     Quest = "MagmaQuest",     QuestLvl = 1, NPCPos = Vector3.new(-5315, 12, 8515) },
    { MinLvl = 375, MaxLvl = 449, Mob = "Fishman Warrior",      Quest = "FishmanQuest",   QuestLvl = 1, NPCPos = Vector3.new(61122, 18, 1569) },
    { MinLvl = 450, MaxLvl = 524, Mob = "God's Guard",          Quest = "SkyExp1Quest",   QuestLvl = 1, NPCPos = Vector3.new(-4720, 845, -1950) },
    { MinLvl = 525, MaxLvl = 624, Mob = "Shandopian Warrior",   Quest = "SkyExp2Quest",   QuestLvl = 1, NPCPos = Vector3.new(-7860, 5545, -380) },
    { MinLvl = 625, MaxLvl = 699, Mob = "Galley Pirate",        Quest = "FountainQuest",  QuestLvl = 1, NPCPos = Vector3.new(5258, 39, 4050) },
}

local function getTargetData(level)
    for _, data in ipairs(LevelData) do
        if level >= data.MinLvl and level <= data.MaxLvl then
            return data
        end
    end
    return LevelData[1]
end

--// ═══════════════════════════════════════════
--// CONFIGURATION
--// ═══════════════════════════════════════════
local Config = {
    FlightSpeed     = 250,
    HoverHeight     = 10,
    BringMobDistance= 40,
    SelectedWeapon  = "Melee", -- "Melee", "Blox Fruit", "Sword", "Gun"
    
    -- Auto Stats
    AutoStatMelee   = false,
    AutoStatDefense = false,
    AutoStatSword   = false,
    AutoStatFruit   = false,

    -- UI Colors Theme
    Colors = {
        Background   = Color3.fromRGB(12, 12, 14),
        Sidebar      = Color3.fromRGB(18, 18, 22),
        Element      = Color3.fromRGB(28, 28, 34),
        ElementHover = Color3.fromRGB(40, 40, 50),
        Accent       = Color3.fromRGB(235, 35, 50),
        AccentDark   = Color3.fromRGB(170, 20, 35),
        Text         = Color3.fromRGB(245, 245, 245),
        TextDim      = Color3.fromRGB(140, 140, 150),
        Border       = Color3.fromRGB(40, 40, 48),
        ToggleOff    = Color3.fromRGB(45, 45, 52),
        ToggleOn     = Color3.fromRGB(235, 35, 50),
    },
    Font       = Enum.Font.Gotham,
    FontMedium = Enum.Font.GothamMedium,
    FontBold   = Enum.Font.GothamBold,
}

--// ═══════════════════════════════════════════
--// STATE MANAGEMENT
--// ═══════════════════════════════════════════
local State = {
    AutoFarmON    = false,
    AutoQuestON   = true,
    FastAttackON  = true,
    BringMobsON   = true,
    AutoHakiON    = true,
    Running       = false,
    StopFlag      = false,
    CurrentTask   = "Idle",
    KilledCount   = 0,
    Level         = 1,
}

--// ═══════════════════════════════════════════
--// HELPER UTILITIES
--// ═══════════════════════════════════════════
local function getHRP() 
    local c = LocalPlayer.Character 
    return c and c:FindFirstChild("HumanoidRootPart") 
end

local function getHumanoid() 
    local c = LocalPlayer.Character 
    return c and c:FindFirstChildOfClass("Humanoid") 
end

local function getLevel()
    local ls = LocalPlayer:FindFirstChild("Data") or LocalPlayer:FindFirstChild("leaderstats")
    if not ls then return 1 end
    local lvl = ls:FindFirstChild("Level")
    return lvl and lvl.Value or 1
end

-- Anti-AFK Handler
LocalPlayer.Idled:Connect(function()
    VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    task.wait(1)
    VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
end)

-- Auto Equip Weapon
local function equipWeapon()
    local char = LocalPlayer.Character
    local backpack = LocalPlayer:FindFirstChild("Backpack")
    if not char or not backpack then return end

    local currentTool = char:FindFirstChildOfClass("Tool")
    if currentTool then return end

    for _, tool in ipairs(backpack:GetChildren()) do
        if tool:IsA("Tool") then
            if (Config.SelectedWeapon == "Melee" and tool.ToolTip == "Melee") or
               (Config.SelectedWeapon == "Blox Fruit" and (tool.ToolTip == "Blox Fruit" or tool.ToolTip == "Devil Fruit")) or
               (Config.SelectedWeapon == "Sword" and tool.ToolTip == "Sword") or
               (Config.SelectedWeapon == "Gun" and tool.ToolTip == "Gun") then
                getHumanoid():EquipTool(tool)
                break
            end
        end
    end
end

-- Auto Haki Activation
local function checkHaki()
    if not State.AutoHakiON then return end
    local char = LocalPlayer.Character
    if char and not char:FindFirstChild("HasBuso") then
        pcall(function()
            ReplicatedStorage.Remotes.CommF_:InvokeServer("HasBuso")
        end)
    end
end

-- Fast Movement Engine
local function flyTo(targetPos)
    local hrp = getHRP()
    if not hrp or not targetPos then return end

    local dist = (hrp.Position - targetPos).Magnitude
    if dist < 15 then 
        hrp.CFrame = CFrame.new(targetPos)
        return 
    end

    local duration = dist / Config.FlightSpeed
    local tween = TweenService:Create(
        hrp,
        TweenInfo.new(duration, Enum.EasingStyle.Linear),
        { CFrame = CFrame.new(targetPos) }
    )
    tween:Play()
    
    local elapsed = 0
    while tween.PlaybackState == Enum.PlaybackState.Playing and not State.StopFlag do
        task.wait(0.05)
        elapsed = elapsed + 0.05
        if elapsed > duration + 1 then tween:Cancel(); break end
    end
end

-- Ultra Fast Attack Thread
task.spawn(function()
    while true do
        task.wait(0.01)
        if State.AutoFarmON and State.FastAttackON then
            pcall(function()
                local char = LocalPlayer.Character
                local tool = char and char:FindFirstChildOfClass("Tool")
                if tool then
                    tool:Activate()
                    local net = ReplicatedStorage:FindFirstChild("Modules") and ReplicatedStorage.Modules:FindFirstChild("Net")
                    if net then
                        net:FindFirstChild("RE/RegisterAttack"):FireServer()
                    end
                end
            end)
        end
    end
end)

-- Bring Mobs Engine
local function bringNearestMobs(primaryEnemy)
    if not State.BringMobsON or not primaryEnemy then return end
    local primaryHrp = primaryEnemy:FindFirstChild("HumanoidRootPart")
    if not primaryHrp then return end

    local folder = workspace:FindFirstChild("Enemies") or workspace
    for _, mob in ipairs(folder:GetChildren()) do
        if mob:IsA("Model") and mob ~= primaryEnemy and mob.Name == primaryEnemy.Name then
            local h = mob:FindFirstChildOfClass("Humanoid")
            local mHrp = mob:FindFirstChild("HumanoidRootPart")
            if h and mHrp and h.Health > 0 then
                if (mHrp.Position - primaryHrp.Position).Magnitude <= Config.BringMobDistance then
                    mHrp.CFrame = primaryHrp.CFrame
                    mHrp.CanCollide = false
                    h:ChangeState(11)
                end
            end
        end
    end
end

-- Quest Engine
local function hasQuest()
    local gui = LocalPlayer:FindFirstChild("PlayerGui")
    local mainGui = gui and gui:FindFirstChild("Main")
    local questFrame = mainGui and mainGui:FindFirstChild("Quest")
    return questFrame and questFrame.Visible
end

local function acceptQuest(targetData)
    if hasQuest() then return end
    flyTo(targetData.NPCPos)
    task.wait(0.3)
    pcall(function()
        ReplicatedStorage.Remotes.CommF_:InvokeServer("StartQuest", targetData.Quest, targetData.QuestLvl)
    end)
    task.wait(0.3)
end

-- Find Active Target Mobs
local function findNearestTarget(mobName)
    local hrp = getHRP()
    if not hrp then return nil end
    local closest, closestDist = nil, math.huge
    local folder = workspace:FindFirstChild("Enemies") or workspace

    for _, obj in ipairs(folder:GetChildren()) do
        if obj:IsA("Model") and obj.Name:lower():find(mobName:lower(), 1, true) then
            local h = obj:FindFirstChildOfClass("Humanoid")
            local objHrp = obj:FindFirstChild("HumanoidRootPart")
            if h and objHrp and h.Health > 0 then
                local d = (hrp.Position - objHrp.Position).Magnitude
                if d < closestDist then closest, closestDist = obj, d end
            end
        end
    end
    return closest
end

-- Air Farm Execution
local function executeAttack(targetModel)
    local enemyHrp = targetModel:FindFirstChild("HumanoidRootPart")
    local enemyHum = targetModel:FindFirstChildOfClass("Humanoid")
    local hrp = getHRP()

    if not enemyHrp or not enemyHum or not hrp then return end

    -- Hover Stabilization Mechanics
    local bv = Instance.new("BodyVelocity")
    bv.MaxForce = Vector3.new(1e9, 1e9, 1e9)
    bv.Velocity = Vector3.zero
    bv.Parent = hrp

    local bg = Instance.new("BodyGyro")
    bg.MaxTorque = Vector3.new(1e9, 1e9, 1e9)
    bg.CFrame = hrp.CFrame
    bg.Parent = hrp

    local startTime = tick()
    while not State.StopFlag and State.AutoFarmON do
        if not enemyHum or enemyHum.Health <= 0 or not enemyHrp.Parent then break end

        -- Freeze/Float Character directly above target mob
        local hoverPos = enemyHrp.Position + Vector3.new(0, Config.HoverHeight, 0)
        hrp.CFrame = CFrame.new(hoverPos, enemyHrp.Position)

        equipWeapon()
        checkHaki()
        bringNearestMobs(targetModel)

        task.wait(0.05)
        if tick() - startTime > 15 then break end
    end

    bv:Destroy()
    bg:Destroy()
    if enemyHum and enemyHum.Health <= 0 then
        State.KilledCount = State.KilledCount + 1
    end
end

-- Auto Stat Distributor Thread
task.spawn(function()
    while task.wait(1) do
        if Config.AutoStatMelee then ReplicatedStorage.Remotes.CommF_:InvokeServer("AddPoint", "Melee", 1) end
        if Config.AutoStatDefense then ReplicatedStorage.Remotes.CommF_:InvokeServer("AddPoint", "Defense", 1) end
        if Config.AutoStatSword then ReplicatedStorage.Remotes.CommF_:InvokeServer("AddPoint", "Sword", 1) end
        if Config.AutoStatFruit then ReplicatedStorage.Remotes.CommF_:InvokeServer("AddPoint", "Demon Fruit", 1) end
    end
end)

--// ═══════════════════════════════════════════
--// MAIN AUTO FARM LOOP
--// ═══════════════════════════════════════════
local function autoFarmLoop()
    if State.Running then return end
    State.Running = true
    State.StopFlag = false

    while not State.StopFlag and State.AutoFarmON do
        local char = LocalPlayer.Character
        if not char or not getHRP() then task.wait(0.5); continue end

        State.Level = getLevel()
        local targetInfo = getTargetData(State.Level)

        -- Accept Quest
        if State.AutoQuestON then
            State.CurrentTask = "Quest: " .. targetInfo.Quest
            acceptQuest(targetInfo)
        end

        -- Find Target
        State.CurrentTask = "Hunting: " .. targetInfo.Mob
        local enemy = findNearestTarget(targetInfo.Mob)

        if enemy and enemy:FindFirstChild("HumanoidRootPart") then
            State.CurrentTask = "Attacking " .. enemy.Name
            executeAttack(enemy)
        else
            State.CurrentTask = "Waiting for " .. targetInfo.Mob .. " Spawns..."
            flyTo(targetInfo.NPCPos + Vector3.new(0, 20, 0))
            task.wait(1)
        end
    end

    State.Running = false
    State.CurrentTask = "Idle"
    State.StopFlag = false
end

--// ═══════════════════════════════════════════
--// USER INTERFACE GENERATOR
--// ═══════════════════════════════════════════
local function create(className, props)
    local inst = Instance.new(className)
    for k, v in pairs(props or {}) do
        if k ~= "Parent" then inst[k] = v end
    end
    if props and props.Parent then inst.Parent = props.Parent end
    return inst
end

local function corner(parent, radius)
    return create("UICorner", { CornerRadius = UDim.new(0, radius or 6), Parent = parent })
end

local function stroke(parent, color, thickness, transparency)
    return create("UIStroke", {
        Color = color or Config.Colors.Border,
        Thickness = thickness or 1,
        Transparency = transparency or 0.5,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        Parent = parent,
    })
end

local function tween(obj, time, props)
    local t = TweenService:Create(obj, TweenInfo.new(time or 0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), props)
    t:Play()
    return t
end

-- Root ScreenGui Setup
local parentGui = pcall(function() return CoreGui end) and CoreGui or LocalPlayer:WaitForChild("PlayerGui")
if parentGui:FindFirstChild("redzHubv3") then parentGui.redzHubv3:Destroy() end

local ScreenGui = create("ScreenGui", {
    Name = "redzHubv3",
    ResetOnSpawn = false,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    IgnoreGuiInset = true,
    Parent = parentGui,
})

local Main = create("Frame", {
    Name = "Main", Parent = ScreenGui, BackgroundColor3 = Config.Colors.Background,
    BackgroundTransparency = 0.05, BorderSizePixel = 0, Size = UDim2.new(0, 640, 0, 430),
    Position = UDim2.new(0.5, -320, 0.5, -215), Active = true, Draggable = true,
})
corner(Main, 10)
stroke(Main, Config.Colors.Border, 1, 0.3)

-- Topbar
local TopBar = create("Frame", { Name = "TopBar", Parent = Main, BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 42) })

create("TextLabel", {
    Parent = TopBar, BackgroundTransparency = 1, Position = UDim2.new(0, 16, 0, 6),
    Size = UDim2.new(0, 200, 0, 18), Font = Config.FontBold, Text = "redz Hub v3 — Blox Fruits",
    TextColor3 = Config.Colors.Accent, TextSize = 14, TextXAlignment = Enum.TextXAlignment.Left,
})

create("TextLabel", {
    Parent = TopBar, BackgroundTransparency = 1, Position = UDim2.new(0, 16, 0, 24),
    Size = UDim2.new(0, 200, 0, 12), Font = Config.Font, Text = "Standalone OP Edition | v3.0 (Fixed)",
    TextColor3 = Config.Colors.TextDim, TextSize = 10, TextXAlignment = Enum.TextXAlignment.Left,
})

-- Controls
local btnContainer = create("Frame", { Parent = TopBar, BackgroundTransparency = 1, Position = UDim2.new(1, -76, 0, 10), Size = UDim2.new(0, 66, 0, 22) })

local function makeWinBtn(text, xPos, hoverColor, callback)
    local btn = create("TextButton", {
        Parent = btnContainer, BackgroundColor3 = Config.Colors.Element, BorderSizePixel = 0,
        Position = UDim2.new(0, xPos, 0, 0), Size = UDim2.new(0, 20, 0, 20), Font = Config.FontBold,
        Text = text, TextColor3 = Config.Colors.Text, TextSize = 12, AutoButtonColor = false,
    })
    corner(btn, 5)
    btn.MouseEnter:Connect(function() tween(btn, 0.15, { BackgroundColor3 = hoverColor }) end)
    btn.MouseLeave:Connect(function() tween(btn, 0.15, { BackgroundColor3 = Config.Colors.Element }) end)
    btn.MouseButton1Click:Connect(callback)
    return btn
end

makeWinBtn("–", 0, Config.Colors.ElementHover, function()
    Main.Visible = false
    local reopen = create("TextButton", {
        Parent = ScreenGui, BackgroundColor3 = Config.Colors.Accent, BorderSizePixel = 0,
        Size = UDim2.new(0, 110, 0, 30), Position = UDim2.new(0, 20, 0, 60), Font = Config.FontBold,
        Text = "redz Hub v3", TextColor3 = Config.Colors.Text, TextSize = 12, AutoButtonColor = false,
    })
    corner(reopen, 6)
    reopen.MouseButton1Click:Connect(function() Main.Visible = true; reopen:Destroy() end)
end)

makeWinBtn("✕", 24, Color3.fromRGB(200, 35, 45), function()
    ScreenGui:Destroy()
    State.StopFlag = true
end)

-- Sidebar
local Sidebar = create("Frame", {
    Parent = Main, BackgroundColor3 = Config.Colors.Sidebar, BackgroundTransparency = 0.1,
    BorderSizePixel = 0, Position = UDim2.new(0, 0, 0, 42), Size = UDim2.new(0, 150, 1, -42),
})

local SideScroll = create("ScrollingFrame", {
    Parent = Sidebar, BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.new(0, 6, 0, 8),
    Size = UDim2.new(1, -12, 1, -16), CanvasSize = UDim2.new(0, 0, 0, 0), ScrollBarThickness = 2,
    ScrollBarImageColor3 = Config.Colors.Accent, AutomaticCanvasSize = Enum.AutomaticSize.Y,
})
create("UIListLayout", { Parent = SideScroll, Padding = UDim.new(0, 3), SortOrder = Enum.SortOrder.LayoutOrder })

local Content = create("Frame", {
    Parent = Main, BackgroundTransparency = 1, Position = UDim2.new(0, 150, 0, 42), Size = UDim2.new(1, -150, 1, -42),
})

-- UI Categories
local CATEGORIES = {
    "Main Farming", "Combat & OP Mods", "Auto Stats", 
    "Teleports & Seas", "Fruit & Raids", "Settings & Info"
}

local Pages = {}
local buttons = {}
local selected = nil

local function switchPage(name)
    for pageName, page in pairs(Pages) do
        page.Visible = (pageName == name)
    end
end

for _, catName in ipairs(CATEGORIES) do
    local btn = create("TextButton", {
        Parent = SideScroll, BackgroundColor3 = Config.Colors.Element, BackgroundTransparency = 1,
        BorderSizePixel = 0, Size = UDim2.new(1, 0, 0, 28), Font = Config.FontMedium,
        Text = "  " .. catName, TextColor3 = Config.Colors.TextDim, TextSize = 11,
        TextXAlignment = Enum.TextXAlignment.Left, AutoButtonColor = false, Name = catName,
    })
    corner(btn, 5)

    local indicator = create("Frame", {
        Parent = btn, BackgroundColor3 = Config.Colors.Accent, BorderSizePixel = 0,
        Size = UDim2.new(0, 3, 0.6, 0), Position = UDim2.new(0, 0, 0.2, 0), Visible = false, Name = "Indicator",
    })
    corner(indicator, 2)

    btn.MouseButton1Click:Connect(function()
        if selected == catName then return end
        selected = catName
        for _, other in ipairs(buttons) do
            other.BackgroundTransparency = 1
            other.TextColor3 = Config.Colors.TextDim
            other.Indicator.Visible = false
        end
        btn.BackgroundTransparency = 0.4
        btn.TextColor3 = Config.Colors.Text
        indicator.Visible = true
        switchPage(catName)
    end)

    table.insert(buttons, btn)

    local page = create("ScrollingFrame", {
        Parent = Content, BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.new(1, 0, 1, 0),
        CanvasSize = UDim2.new(0, 0, 0, 0), ScrollBarThickness = 2, ScrollBarImageColor3 = Config.Colors.Accent,
        AutomaticCanvasSize = Enum.AutomaticSize.Y, Visible = false, Name = catName,
    })
    create("UIPadding", { Parent = page, PaddingTop = UDim.new(0, 8), PaddingBottom = UDim.new(0, 12), PaddingLeft = UDim.new(0, 10), PaddingRight = UDim.new(0, 10) })
    create("UIListLayout", { Parent = page, Padding = UDim.new(0, 5), SortOrder = Enum.SortOrder.LayoutOrder })
    Pages[catName] = page
end

-- UI Controls Helpers
local function addSection(page, text)
    return create("TextLabel", {
        Parent = page, BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 18),
        Font = Config.FontBold, Text = text, TextColor3 = Config.Colors.Accent,
        TextSize = 11, TextXAlignment = Enum.TextXAlignment.Left,
    })
end

local function addToggle(page, name, default, callback)
    local state = default or false
    local btn = create("TextButton", {
        Parent = page, BackgroundColor3 = Config.Colors.Element, BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 30), Text = "", AutoButtonColor = false, Name = name,
    })
    corner(btn, 6)
    stroke(btn, Config.Colors.Border, 1, 0.6)

    create("TextLabel", {
        Parent = btn, BackgroundTransparency = 1, Position = UDim2.new(0, 10, 0, 0),
        Size = UDim2.new(1, -50, 1, 0), Font = Config.FontMedium, Text = name,
        TextColor3 = Config.Colors.Text, TextSize = 11, TextXAlignment = Enum.TextXAlignment.Left,
    })

    local sw = create("Frame", {
        Parent = btn, BackgroundColor3 = state and Config.Colors.ToggleOn or Config.Colors.ToggleOff,
        BorderSizePixel = 0, Position = UDim2.new(1, -42, 0.5, -8), Size = UDim2.new(0, 34, 0, 16),
    })
    corner(sw, 8)

    local knob = create("Frame", {
        Parent = sw, BackgroundColor3 = Color3.fromRGB(240, 240, 240), BorderSizePixel = 0,
        Position = state and UDim2.new(1, -16, 0, 2) or UDim2.new(0, 2, 0, 2), Size = UDim2.new(0, 12, 0, 12),
    })
    corner(knob, 6)

    local function update()
        tween(sw, 0.15, { BackgroundColor3 = state and Config.Colors.ToggleOn or Config.Colors.ToggleOff })
        tween(knob, 0.15, { Position = state and UDim2.new(1, -16, 0, 2) or UDim2.new(0, 2, 0, 2) })
    end

    btn.MouseButton1Click:Connect(function()
        state = not state
        update()
        if callback then task.spawn(callback, state) end
    end)

    return { Set = function(v) state = v; update(); if callback then callback(v) end end }
end

local function addSlider(page, name, minV, maxV, default, callback)
    local value = default or minV
    local container = create("Frame", {
        Parent = page, BackgroundColor3 = Config.Colors.Element, BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 34), Name = name,
    })
    corner(container, 6)
    stroke(container, Config.Colors.Border, 1, 0.6)

    create("TextLabel", {
        Parent = container, BackgroundTransparency = 1, Position = UDim2.new(0, 10, 0, 2),
        Size = UDim2.new(0.7, 0, 0, 14), Font = Config.FontMedium, Text = name,
        TextColor3 = Config.Colors.Text, TextSize = 10, TextXAlignment = Enum.TextXAlignment.Left,
    })

    local valLbl = create("TextLabel", {
        Parent = container, BackgroundTransparency = 1, Position = UDim2.new(0.7, 0, 0, 2),
        Size = UDim2.new(0.3, -10, 0, 14), Font = Config.FontBold, Text = tostring(value),
        TextColor3 = Config.Colors.Accent, TextSize = 10, TextXAlignment = Enum.TextXAlignment.Right,
    })

    local track = create("Frame", {
        Parent = container, BackgroundColor3 = Config.Colors.ToggleOff, BorderSizePixel = 0,
        Position = UDim2.new(0, 10, 1, -12), Size = UDim2.new(1, -20, 0, 4),
    })
    corner(track, 2)

    local fill = create("Frame", {
        Parent = track, BackgroundColor3 = Config.Colors.Accent, BorderSizePixel = 0,
        Size = UDim2.new((value - minV) / (maxV - minV), 0, 1, 0),
    })
    corner(fill, 2)

    local dragging = false
    local function updateFromX(x)
        local rel = math.clamp((x - track.AbsolutePosition.X) / track.AbsoluteSize.X, 0, 1)
        local v = math.floor(minV + (maxV - minV) * rel + 0.5)
        fill.Size = UDim2.new(rel, 0, 1, 0)
        valLbl.Text = tostring(v)
        if callback then callback(v) end
    end

    track.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            updateFromX(input.Position.X)
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            updateFromX(input.Position.X)
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
end

local function addButton(page, name, callback)
    local btn = create("TextButton", {
        Parent = page, BackgroundColor3 = Config.Colors.Accent, BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 28), Font = Config.FontBold, Text = name,
        TextColor3 = Config.Colors.Text, TextSize = 11, AutoButtonColor = false,
    })
    corner(btn, 6)
    btn.MouseEnter:Connect(function() tween(btn, 0.12, { BackgroundColor3 = Config.Colors.AccentDark }) end)
    btn.MouseLeave:Connect(function() tween(btn, 0.12, { BackgroundColor3 = Config.Colors.Accent }) end)
    btn.MouseButton1Click:Connect(function() if callback then task.spawn(callback) end end)
    return btn
end

local function addInfo(page, name)
    local lbl = create("TextLabel", {
        Parent = page, BackgroundColor3 = Config.Colors.Element, BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 24), Font = Config.Font, Text = "  " .. name,
        TextColor3 = Config.Colors.TextDim, TextSize = 10, TextXAlignment = Enum.TextXAlignment.Left, Name = name,
    })
    corner(lbl, 6)
    stroke(lbl, Config.Colors.Border, 1, 0.6)
    return lbl
end

--// ═══════════════════════════════════════════
--// TAB CONTENTS BINDING
--// ═══════════════════════════════════════════

-- Main Farming
do
    local page = Pages["Main Farming"]
    addSection(page, "AUTO FARM CONTROLS")
    addToggle(page, "Auto Farm Level", false, function(v)
        State.AutoFarmON = v
        if v then task.spawn(autoFarmLoop) else State.StopFlag = true end
    end)
    addToggle(page, "Auto Accept Quests", true, function(v) State.AutoQuestON = v end)

    addSection(page, "WEAPON SELECTION")
    local wBtn
    wBtn = addButton(page, "Weapon: " .. Config.SelectedWeapon, function()
        if Config.SelectedWeapon == "Melee" then Config.SelectedWeapon = "Blox Fruit"
        elseif Config.SelectedWeapon == "Blox Fruit" then Config.SelectedWeapon = "Sword"
        elseif Config.SelectedWeapon == "Sword" then Config.SelectedWeapon = "Gun"
        else Config.SelectedWeapon = "Melee" end
        wBtn.Text = "Weapon: " .. Config.SelectedWeapon
    end)

    addSection(page, "LIVE MONITOR")
    local statusLbl = addInfo(page, "Status: Idle")
    local killedLbl = addInfo(page, "Killed: 0")

    task.spawn(function()
        while ScreenGui.Parent do
            statusLbl.Text = "  Status: " .. State.CurrentTask
            killedLbl.Text = "  Killed: " .. State.KilledCount
            task.wait(0.5)
        end
    end)
end

-- Combat & OP Mods
do
    local page = Pages["Combat & OP Mods"]
    addSection(page, "COMBAT MODIFICATIONS")
    addToggle(page, "Ultra Fast Attack", true, function(v) State.FastAttackON = v end)
    addToggle(page, "Bring Nearby Mobs", true, function(v) State.BringMobsON = v end)
    addToggle(page, "Auto Armament Haki", true, function(v) State.AutoHakiON = v end)

    addSection(page, "TWEAKS & SLIDERS")
    addSlider(page, "Flight Speed", 100, 350, 250, function(v) Config.FlightSpeed = v end)
    addSlider(page, "Hover Altitude", 5, 25, 10, function(v) Config.HoverHeight = v end)
    addSlider(page, "Bring Radius", 10, 100, 40, function(v) Config.BringMobDistance = v end)
end

-- Auto Stats
do
    local page = Pages["Auto Stats"]
    addSection(page, "AUTOMATIC STAT DISTRIBUTOR")
    addToggle(page, "Auto Stat: Melee", false, function(v) Config.AutoStatMelee = v end)
    addToggle(page, "Auto Stat: Defense", false, function(v) Config.AutoStatDefense = v end)
    addToggle(page, "Auto Stat: Sword", false, function(v) Config.AutoStatSword = v end)
    addToggle(page, "Auto Stat: Demon Fruit", false, function(v) Config.AutoStatFruit = v end)
end

-- Teleports & Seas
do
    local page = Pages["Teleports & Seas"]
    addSection(page, "SEA TELEPORTS")
    addButton(page, "Teleport to Sea 1 (First Sea)", function()
        ReplicatedStorage.Remotes.CommF_:InvokeServer("TravelMain")
    end)
    addButton(page, "Teleport to Sea 2 (Second Sea)", function()
        ReplicatedStorage.Remotes.CommF_:InvokeServer("TravelDressrosa")
    end)
    addButton(page, "Teleport to Sea 3 (Third Sea)", function()
        ReplicatedStorage.Remotes.CommF_:InvokeServer("TravelZou")
    end)
end

-- Fruit & Raids
do
    local page = Pages["Fruit & Raids"]
    addSection(page, "FRUIT UTILITIES")
    addButton(page, "Buy Random Fruit", function()
        pcall(function()
            ReplicatedStorage.Remotes.CommF_:InvokeServer("Cousin", "Buy")
        end)
    end)
end

-- Settings & Info
do
    local page = Pages["Settings & Info"]
    addSection(page, "PLAYER & SERVER")
    addInfo(page, "User: " .. LocalPlayer.Name)
    local lvlInfo = addInfo(page, "Level: --")

    task.spawn(function()
        while ScreenGui.Parent do
            lvlInfo.Text = "  Level: " .. getLevel()
            task.wait(1)
        end
    end)

    addButton(page, "Rejoin Server", function()
        TeleportService:Teleport(game.PlaceId, LocalPlayer)
    end)
end

-- Default active tab
if buttons[1] then
    buttons[1].BackgroundTransparency = 0.4
    buttons[1].TextColor3 = Config.Colors.Text
    buttons[1].Indicator.Visible = true
    selected = "Main Farming"
    switchPage("Main Farming")
end

-- Notification
pcall(function()
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "redz Hub v3",
        Text = "Loaded full standalone script successfully!",
        Duration = 5,
    })
end)

print("[redz Hub v3] Full standalone script loaded successfully!")
