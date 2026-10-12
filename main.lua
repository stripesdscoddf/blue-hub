-- Blue Hub (by bluescriptz) - Full Script with Interactive UI
-- Theme: Blue Accent / Dark Mode

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Clean up any pre-existing UI instance
if LocalPlayer.PlayerGui:FindFirstChild("BlueHubGUI") then
    LocalPlayer.PlayerGui.BlueHubGUI:Destroy()
end

-- Global States
_G.AutoFarm = false
_G.AutoMaterial = false
_G.SelectMaterial = "Angel Wings"
_G.SelectMonster = nil

-- UI Setup (Blue Hub Styling)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BlueHubGUI"
ScreenGui.Parent = LocalPlayer.PlayerGui
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 20, 35)
MainFrame.BorderColor3 = Color3.fromRGB(0, 120, 255)
MainFrame.BorderSizePixel = 2
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -175)
MainFrame.Size = UDim2.new(0, 400, 0, 350)
MainFrame.Active = true
MainFrame.Draggable = true

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Name = "TitleLabel"
TitleLabel.Parent = MainFrame
TitleLabel.BackgroundColor3 = Color3.fromRGB(0, 100, 220)
TitleLabel.BorderSizePixel = 0
TitleLabel.Size = UDim2.new(1, 0, 0, 35)
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.Text = "Blue Hub | Blox Fruits (by bluescriptz)"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 14

local Container = Instance.new("ScrollingFrame")
Container.Name = "Container"
Container.Parent = MainFrame
Container.BackgroundTransparency = 1
Container.Position = UDim2.new(0, 10, 0, 45)
Container.Size = UDim2.new(1, -20, 1, -55)
Container.CanvasSize = UDim2.new(0, 0, 0, 260)
Container.ScrollBarThickness = 6
Container.ScrollBarImageColor3 = Color3.fromRGB(0, 120, 255)

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Parent = Container
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 8)

-- Helper Function: Create Toggle Buttons
local function CreateToggle(name, defaultState, callback)
    local Button = Instance.new("TextButton")
    Button.Parent = Container
    Button.Size = UDim2.new(1, 0, 0, 40)
    Button.BackgroundColor3 = defaultState and Color3.fromRGB(0, 120, 255) or Color3.fromRGB(25, 35, 55)
    Button.BorderColor3 = Color3.fromRGB(0, 100, 200)
    Button.BorderSizePixel = 1
    Button.Font = Enum.Font.GothamSemibold
    Button.Text = name .. " : " .. (defaultState and "ON" or "OFF")
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.TextSize = 13

    local state = defaultState
    Button.MouseButton1Click:Connect(function()
        state = not state
        Button.BackgroundColor3 = state and Color3.fromRGB(0, 120, 255) or Color3.fromRGB(25, 35, 55)
        Button.Text = name .. " : " .. (state and "ON" or "OFF")
        callback(state)
    end)
end

-- Add Interactive Feature Toggles to UI
CreateToggle("Auto Farm Level", _G.AutoFarm, function(enabled)
    _G.AutoFarm = enabled
end)

CreateToggle("Auto Farm Material", _G.AutoMaterial, function(enabled)
    _G.AutoMaterial = enabled
end)

CreateToggle("Fast Attack", false, function(enabled)
    _G.FastAttack = enabled
end)

CreateToggle("Auto Accept Quest", true, function(enabled)
    _G.AutoQuest = enabled
end)

-- Bypass / Hooks
pcall(function()
    hookfunction(require(ReplicatedStorage.Effect.Container.Death), function()
        -- empty block
    end)
    hookfunction(require(ReplicatedStorage.Effect.Container.Respawn), function()
        -- empty block
    end)
end)

-- World Detection
if game.PlaceId == 2753915549 then
    World1 = true
elseif game.PlaceId == 4442272183 then
    World2 = true
elseif game.PlaceId == 7449423635 then
    World3 = true
end

function MaterialMon()
    if _G.SelectMaterial ~= "Radiactive Material" then
        if _G.SelectMaterial ~= "Leather + Scrap Metal" then
            if _G.SelectMaterial ~= "Magma Ore" then
                if _G.SelectMaterial ~= "Fish Tail" then
                    if _G.SelectMaterial == "Angel Wings" then
                        MMon = "Royal Soldier"
                        MPos = CFrame.new(-7759.45898, 5606.93652, -1862.70276, -0.866007447, 0, -0.500031412, 0, 1, 0, 0.500031412, 0, -0.866007447)
                        SP = "SkyArea2"
                    elseif _G.SelectMaterial == "Mystic Droplet" then
                        MMon = "Water Fighter"
                        MPos = CFrame.new(-3331.70459, 239.138336, -10553.3564, -0.29242146, 0, 0.95628953, 0, 1, 0, -0.95628953, 0, -0.29242146)
                        SP = "ForgottenIsland"
                    elseif _G.SelectMaterial == "Vampire Fang" then
                        MMon = "Vampire"
                        MPos = CFrame.new(-6132.39453, 9.00769424, -1466.16919, -0.927179813, 0, -0.374617696, 0, 1, 0, 0.374617696, 0, -0.927179813)
                        SP = "Graveyard"
                    elseif _G.SelectMaterial == "Gunpowder" then
                        MMon = "Pistol Billionaire"
                        MPos = CFrame.new(-185.693283, 84.7088699, 6103.62744, 0.90629667, 0, -0.422642082, 0, 1, 0, 0.422642082, 0, 0.90629667)
                        SP = "Mansion"
                    elseif _G.SelectMaterial ~= "Mini Tusk" then
                        if _G.SelectMaterial == "Conjured Cocoa" then
                            MMon = "Chocolate Bar Battler"
                            MPos = CFrame.new(582.828674, 25.5824986, -12550.7041, -0.766061664, 0, -0.642767608, 0, 1, 0, 0.642767608, 0, -0.766061664)
                            SP = "Chocolate"
                        end
                    else
                        MMon = "Mythological Pirate"
                        MPos = CFrame.new(-13456.0498, 469.433228, -7039.96436, 0, 0, 1, 0, 1, 0, -1, 0, 0)
                        SP = "BigMansion"
                    end
                elseif game.PlaceId == 2753915549 then
                    MMon = "Fishman Warrior"
                    MPos = CFrame.new(60943.9023, 17.9492188, 1744.11133, 0.826706648, 0, -0.562633216, 0, 1, 0, 0.562633216, 0, 0.826706648)
                    SP = "Underwater City"
                    MMon = "Fishman Commando"
                    MPos = CFrame.new(61760.8984, 18.0800781, 1460.11133, -0.632549644, 0, -0.774520278, 0, 1, 0, 0.774520278, 0, -0.632549644)
                    SP = "Underwater City"
                elseif game.PlaceId == 7449423635 then
                    MMon = "Fishman Captain"
                    MPos = CFrame.new(-10828.1064, 331.825989, -9049.14648, -0.0912091732, 0, 0.995831788, 0, 1, 0, -0.995831788, 0, -0.0912091732)
                    SP = "PineappleTown"
                end
            elseif game.PlaceId == 2753915549 then
                MMon = "Military Soldier"
                MPos = CFrame.new(-5565.60156, 9.10001755, 8327.56934, -0.838688731, 0, -0.544611216, 0, 1, 0, 0.544611216, 0, -0.838688731)
                SP = "Magma"
                MMon = "Military Spy"
                MPos = CFrame.new(-5806.70068, 78.5000458, 8904.46973, 0.707134247, 0, 0.707079291, 0, 1, 0, -0.707079291, 0, 0.707134247)
                SP = "Magma"
            elseif game.PlaceId == 4442272183 then
                MMon = "Lava Pirate"
                MPos = CFrame.new(-5158.77051, 14.4791956, -4654.2627, -0.848060489, 0, -0.529899538, 0, 1, 0, 0.529899538, 0, -0.848060489)
                SP = "CircleIslandFire"
            end
        elseif game.PlaceId == 2753915549 then
            MMon = "Pirate"
            MPos = CFrame.new(-967.433105, 13.5999937, 4034.24707, -0.258864403, 0, -0.965913713, 0, 1, 0, 0.965913713, 0, -0.258864403)
            SP = "Pirate"
            MMon = "Brute"
            MPos = CFrame.new(-1191.41235, 15.5999985, 4235.50928, 0.629286051, 0, -0.777173758, 0, 1, 0, 0.777173758, 0, 0.629286051)
            SP = "Pirate"
        elseif game.PlaceId ~= 4442272183 then
            if game.PlaceId == 7449423635 then
                MMon = "Pirate Millionaire"
                MPos = CFrame.new(-118.809372, 55.4874573, 5649.17041, -0.965929747, 0, 0.258804798, 0, 1, 0, -0.258804798, 0, -0.965929747)
                SP = "Default"
            end
        else
            MMon = "Mercenary"
            MPos = CFrame.new(-986.774475, 72.8755951, 1088.44653, -0.656062722, 0, 0.754706323, 0, 1, 0, -0.754706323, 0, -0.656062722)
            SP = "DressTown"
        end
    else
        MMon = "Factory Staff"
        MPos = CFrame.new(-105.889565, 72.8076935, -670.247986, -0.965929747, 0, -0.258804798, 0, 1, 0, 0.258804798, 0, -0.965929747)
        SP = "Bar"
    end
end

function CheckQuest()
    MyLevel = LocalPlayer.Data.Level.Value
    if World1 then
        if MyLevel >= 1 and MyLevel <= 9 or SelectMonster == "Bandit" then
            Mon = "Bandit"
            LevelQuest = 1
            NameQuest = "BanditQuest1"
            NameMon = "Bandit"
            CFrameQuest = CFrame.new(1059.37195, 15.4495068, 1550.4231, 0.939700544, -0, -0.341998369, -0, 1, -0, 0.341998369, -0, 0.939700544)
            CFrameMon = CFrame.new(1045.962646484375, 27.00250816345215, 1560.8203125)
        elseif (MyLevel < 10 or MyLevel > 14) and SelectMonster ~= "Monkey" then
            if (MyLevel < 15 or MyLevel > 29) and SelectMonster ~= "Gorilla" then
                if (MyLevel < 30 or MyLevel > 39) and SelectMonster ~= "Pirate" then
                    if (MyLevel < 40 or MyLevel > 59) and SelectMonster ~= "Brute" then
                        if MyLevel >= 60 and MyLevel <= 74 or SelectMonster == "Desert Bandit" then
                            Mon = "Desert Bandit"
                            LevelQuest = 1
                            NameQuest = "DesertQuest"
                            NameMon = "Desert Bandit"
                            CFrameQuest = CFrame.new(894.488647, 5.14000702, 4392.43359, 0.819155693, -0, -0.573571265, -0, 1, -0, 0.573571265, -0, 0.819155693)
                            CFrameMon = CFrame.new(924.7998046875, 6.44867467880249, 4481.5859375)
                        elseif (MyLevel < 75 or MyLevel > 89) and SelectMonster ~= "Desert Officer" then
                            if (MyLevel < 90 or MyLevel > 99) and SelectMonster ~= "Snow Bandit" then
                                if MyLevel >= 100 and MyLevel <= 119 or SelectMonster == "Snowman" then
                                    Mon = "Snowman"
                                    LevelQuest = 2
                                    NameQuest = "SnowQuest"
                                    NameMon = "Snowman"
                                    CFrameQuest = CFrame.new(1389.74451, 88.1519318, -1298.90796, -0.342042685, -0, 0.939684391, -0, 1, -0, -0.939684391, -0, -0.342042685)
                                    CFrameMon = CFrame.new(1201.6412353515625, 144.57958984375, -1550.0670166015625)
                                elseif (MyLevel < 120 or MyLevel > 149) and SelectMonster ~= "Chief Petty Officer" then
                                    if (MyLevel < 150 or MyLevel > 174) and SelectMonster ~= "Sky Bandit" then
                                        if (MyLevel < 175 or MyLevel > 189) and SelectMonster ~= "Dark Master" then
                                            if MyLevel >= 190 and MyLevel <= 209 or SelectMonster == "Prisoner" then
                                                Mon = "Prisoner"
                                                LevelQuest = 1
                                                NameQuest = "PrisonerQuest"
                                                NameMon = "Prisoner"
                                                CFrameQuest = CFrame.new(5308.93115, 1.65517521, 475.120514, -0.0894274712, -5.00292918E-9, -0.995993316, 1.60817859E-9, 1, -5.16744869E-9, 0.995993316, -2.06384709E-9, -0.0894274712)
                                                CFrameMon = CFrame.new(5098.9736328125, -0.3204058110713959, 474.2373352050781)
                                            elseif (MyLevel < 210 or MyLevel > 249) and SelectMonster ~= "Dangerous Prisoner" then
                                                if MyLevel >= 250 and MyLevel <= 274 or SelectMonster == "Toga Warrior" then
                                                    Mon = "Toga Warrior"
                                                    LevelQuest = 1
                                                    NameQuest = "ColosseumQuest"
                                                    NameMon = "Toga Warrior"
                                                    CFrameQuest = CFrame.new(-1580.04663, 6.35000277, -2986.47534, -0.515037298, -0, -0.857167721, -0, 1, -0, 0.857167721, -0, -0.515037298)
                                                    CFrameMon = CFrame.new(-1820.21484375, 51.68385696411133, -2740.6650390625)
                                                elseif (MyLevel < 275 or MyLevel > 299) and SelectMonster ~= "Gladiator" then
                                                    if (MyLevel < 300 or MyLevel > 324) and SelectMonster ~= "Military Soldier" then
                                                        if (MyLevel < 325 or MyLevel > 374) and SelectMonster ~= "Military Spy" then
                                                            if (MyLevel < 375 or MyLevel > 399) and SelectMonster ~= "Fishman Warrior" then
                                                                if (MyLevel < 400 or MyLevel > 449) and SelectMonster ~= "Fishman Commando" then
                                                                    if MyLevel >= 450 and MyLevel <= 474 or SelectMonster == "God's Guard" then
                                                                        Mon = "God's Guard"
                                                                        LevelQuest = 1
                                                                        NameQuest = "SkyExp1Quest"
                                                                        NameMon = "God's Guard"
                                                                        CFrameQuest = CFrame.new(-4721.88867, 843.874695, -1949.96643, 0.996191859, -0, -0.0871884301, -0, 1, -0, 0.0871884301, -0, 0.996191859)
                                                                        CFrameMon = CFrame.new(-4710.04296875, 845.2769775390625, -1927.3079833984375)
                                                                        if _G.AutoFarm and (CFrameQuest.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 10000 then
                                                                            ReplicatedStorage.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(-4607.82275, 872.54248, -1667.55688))
                                                                        end
                                                                    elseif MyLevel >= 475 and MyLevel <= 524 or SelectMonster == "Shanda" then
                                                                        Mon = "Shanda"
                                                                        LevelQuest = 2
                                                                        NameQuest = "SkyExp1Quest"
                                                                        NameMon = "Shanda"
                                                                        CFrameQuest = CFrame.new(-7859.09814, 5544.19043, -381.476196, -0.422592998, -0, 0.906319618, -0, 1, -0, -0.906319618, -0, -0.422592998)
                                                                        CFrameMon = CFrame.new(-7678.48974609375, 5566.40380859375, -497.2156066894531)
                                                                        if _G.AutoFarm and (CFrameQuest.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 10000 then
                                                                            ReplicatedStorage.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(-7894.6176757813, 5547.1416015625, -380.29119873047))
                                                                        end
                                                                    elseif MyLevel >= 525 and MyLevel <= 549 or SelectMonster == "Royal Squad" then
                                                                        Mon = "Royal Squad"
                                                                        LevelQuest = 1
                                                                        NameQuest = "SkyExp2Quest"
                                                                        NameMon = "Royal Squad"
                                                                        CFrameQuest = CFrame.new(-7906.81592, 5634.6626, -1411.99194, -0, -0, -1, -0, 1, -0, 1, -0, -0)
                                                                        CFrameMon = CFrame.new(-7624.25244140625, 5658.13330078125, -1467.354248046875)
                                                                    elseif (MyLevel < 550 or MyLevel > 624) and SelectMonster ~= "Royal Soldier" then
                                                                        if MyLevel >= 625 and MyLevel <= 649 or SelectMonster == "Galley Pirate" then
                                                                            Mon = "Galley Pirate"
                                                                            LevelQuest = 1
                                                                            NameQuest = "FountainQuest"
                                                                            NameMon = "Galley Pirate"
                                                                            CFrameQuest = CFrame.new(5259.81982, 37.3500175, 4050.0293, 0.087131381, -0, 0.996196866, -0, 1, -0, -0.996196866, -0, 0.087131381)
                                                                            CFrameMon = CFrame.new(5551.02197265625, 78.90135192871094, 3930.412841796875)
                                                                        elseif MyLevel >= 650 or SelectMonster == "Galley Captain" then
                                                                            Mon = "Galley Captain"
                                                                            LevelQuest = 2
                                                                            NameQuest = "FountainQuest"
                                                                            NameMon = "Galley Captain"
                                                                            CFrameQuest = CFrame.new(5259.81982, 37.3500175, 4050.0293, 0.087131381, -0, 0.996196866, -0, 1, -0, -0.996196866, -0, 0.087131381)
                                                                            CFrameMon = CFrame.new(5441.95166015625, 42.50205993652344, 4950.09375)
                                                                        end
                                                                    else
                                                                        Mon = "Royal Soldier"
                                                                        LevelQuest = 2
                                                                        NameQuest = "SkyExp2Quest"
                                                                        NameMon = "Royal Soldier"
                                                                        CFrameQuest = CFrame.new(-7906.81592, 5634.6626, -1411.99194, -0, -0, -1, -0, 1, -0, 1, -0, -0)
                                                                        CFrameMon = CFrame.new(-7836.75341796875, 5645.6640625, -1790.6236572265625)
                                                                    end
                                                                else
                                                                    Mon = "Fishman Commando"
                                                                    LevelQuest = 2
                                                                    NameQuest = "FishmanQuest"
                                                                    NameMon = "Fishman Commando"
                                                                    CFrameQuest = CFrame.new(61122.65234375, 18.497442245483, 1569.3997802734)
                                                                    CFrameMon = CFrame.new(61922.6328125, 18.482830047607422, 1493.934326171875)
                                                                    if _G.AutoFarm and (CFrameQuest.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 10000 then
                                                                        ReplicatedStorage.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(61163.8515625, 11.6796875, 1819.7841796875))
                                                                    end
                                                                end
                                                            else
                                                                Mon = "Fishman Warrior"
                                                                LevelQuest = 1
                                                                NameQuest = "FishmanQuest"
                                                                NameMon = "Fishman Warrior"
                                                                CFrameQuest = CFrame.new(61122.65234375, 18.497442245483, 1569.3997802734)
                                                                CFrameMon = CFrame.new(60878.30078125, 18.482830047607422, 1543.7574462890625)
                                                                if _G.AutoFarm and (CFrameQuest.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 10000 then
                                                                    ReplicatedStorage.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(61163.8515625, 11.6796875, 1819.7841796875))
                                                                end
                                                            end
                                                        else
                                                            Mon = "Military Spy"
                                                            LevelQuest = 2
                                                            NameQuest = "MagmaQuest"
                                                            NameMon = "Military Spy"
                                                            CFrameQuest = CFrame.new(-5313.37012, 10.9500084, 8515.29395, -0.499959469, -0, 0.866048813, -0, 1, -0, -0.866048813, -0, -0.499959469)
                                                            CFrameMon = CFrame.new(-5802.8681640625, 86.26241302490234, 8828.859375)
                                                        end
                                                    else
                                                        Mon = "Military Soldier"
                                                        LevelQuest = 1
                                                        NameQuest = "MagmaQuest"
                                                        NameMon = "Military Soldier"
                                                        CFrameQuest = CFrame.new(-5313.37012, 10.9500084, 8515.29395, -0.499959469, -0, 0.866048813, -0, 1, -0, -0.866048813, -0, -0.499959469)
                                                        CFrameMon = CFrame.new(-5411.16455078125, 11.081554412841797, 8454.29296875)
                                                    end
                                                else
                                                    Mon = "Gladiator"
                                                    LevelQuest = 2
                                                    NameQuest = "ColosseumQuest"
                                                    NameMon = "Gladiator"
                                                    CFrameQuest = CFrame.new(-1580.04663, 6.35000277, -2986.47534, -0.515037298, -0, -0.857167721, -0, 1, -0, 0.857167721, -0, -0.515037298)
                                                    CFrameMon = CFrame.new(-1292.838134765625, 56.380882263183594, -3339.031494140625)
                                                end
                                            else
                                                Mon = "Dangerous Prisoner"
                                                LevelQuest = 2
                                                NameQuest = "PrisonerQuest"
                                                NameMon = "Dangerous Prisoner"
                                                CFrameQuest = CFrame.new(5308.93115, 1.65517521, 475.120514, -0.0894274712, -5.00292918E-9, -0.995993316, 1.60817859E-9, 1, -5.16744869E-9, 0.995993316, -2.06384709E-9, -0.0894274712)
                                                CFrameMon = CFrame.new(5654.5634765625, 15.633401870727539, 866.2991943359375)
                                            end
                                        else
                                            Mon = "Dark Master"
                                            LevelQuest = 2
                                            NameQuest = "SkyQuest"
                                            NameMon = "Dark Master"
                                            CFrameQuest = CFrame.new(-4839.53027, 716.368591, -2619.44165, 0.866007268, -0, 0.500031412, -0, 1, -0, -0.500031412, -0, 0.866007268)
                                            CFrameMon = CFrame.new(-5259.8447265625, 391.3976745605469, -2229.035400390625)
                                        end
                                    else
                                        Mon = "Sky Bandit"
                                        LevelQuest = 1
                                        NameQuest = "SkyQuest"
                                        NameMon = "Sky Bandit"
                                        CFrameQuest = CFrame.new(-4839.53027, 716.368591, -2619.44165, 0.866007268, -0, 0.500031412, -0, 1, -0, -0.500031412, -0, 0.866007268)
                                        CFrameMon = CFrame.new(-4953.20703125, 295.74420166015625, -2899.22900390625)
                                    end
                                else
                                    Mon = "Chief Petty Officer"
                                    LevelQuest = 1
                                    NameQuest = "MarineQuest2"
                                    NameMon = "Chief Petty Officer"
                                    CFrameQuest = CFrame.new(-5039.58643, 27.3500385, 4324.68018, -0, -0, -1, -0, 1, -0, 1, -0, -0)
                                    CFrameMon = CFrame.new(-4881.23095703125, 22.65204429626465, 4273.75244140625)
                                end
                            else
                                Mon = "Snow Bandit"
                                LevelQuest = 1
                                NameQuest = "SnowQuest"
                                NameMon = "Snow Bandit"
                                CFrameQuest = CFrame.new(1389.74451, 88.1519318, -1298.90796, -0.342042685, -0, 0.939684391, -0, 1, -0, -0.939684391, -0, -0.342042685)
                                CFrameMon = CFrame.new(1354.347900390625, 87.27277374267578, -1393.946533203125)
                            end
                        else
                            Mon = "Desert Officer"
                            LevelQuest = 2
                            NameQuest = "DesertQuest"
                            NameMon = "Desert Officer"
                            CFrameQuest = CFrame.new(894.488647, 5.14000702, 4392.43359, 0.819155693, -0, -0.573571265, -0, 1, -0, 0.573571265, -0, 0.819155693)
                            CFrameMon = CFrame.new(1608.2822265625, 8.614224433898926, 4371.00732421875)
                        end
                    else
                        Mon = "Brute"
                        LevelQuest = 2
                        NameQuest = "BuggyQuest1"
                        NameMon = "Brute"
                        CFrameQuest = CFrame.new(-1141.07483, 4.10001802, 3831.5498, 0.965929627, -0, -0.258804798, -0, 1, -0, 0.258804798, -0, 0.965929627)
                        CFrameMon = CFrame.new(-1140.083740234375, 14.809885025024414, 4322.92138671875)
                    end
                else
                    Mon = "Pirate"
                    LevelQuest = 1
                    NameQuest = "BuggyQuest1"
                    NameMon = "Pirate"
                    CFrameQuest = CFrame.new(-1141.07483, 4.10001802, 3831.5498, 0.965929627, -0, -0.258804798, -0, 1, -0, 0.258804798, -0, 0.965929627)
                    CFrameMon = CFrame.new(-1103.513427734375, 13.752052307128906, 3896.091064453125)
                end
            else
                Mon = "Gorilla"
                LevelQuest = 2
                NameQuest = "JungleQuest"
                NameMon = "Gorilla"
                CFrameQuest = CFrame.new(-1598.08911, 35.5501175, 153.377838, -0, -0, 1, -0, 1, -0, -1, -0, -0)
                CFrameMon = CFrame.new(-1129.8836669921875, 40.46354675292969, -525.4237060546875)
            end
        else
            Mon = "Monkey"
            LevelQuest = 1
            NameQuest = "JungleQuest"
            NameMon = "Monkey"
            CFrameQuest = CFrame.new(-1598.08911, 35.5501175, 153.377838, -0, -0, 1, -0, 1, -0, -1, -0, -0)
            CFrameMon = CFrame.new(-1448.51806640625, 67.85301208496094, 11.46579647064209)
        end
    elseif not World2 then
        if World3 then
            if MyLevel >= 1500 and MyLevel <= 1524 or SelectMonster == "Pirate Millionaire" then
                Mon = "Pirate Millionaire"
                LevelQuest = 1
                NameQuest = "PiratePortQuest"
                NameMon = "Pirate Millionaire"
                CFrameQuest = CFrame.new(-450.104645, 107.681458, 5950.72607, 0.957107544, -0, -0.289732844, -0, 1, -0, 0.289732844, -0, 0.957107544)
                CFrameMon = CFrame.new(-245.9963836669922, 47.30615234375, 5584.1005859375)
            elseif (MyLevel < 1525 or MyLevel > 1574) and SelectMonster ~= "Pistol Billionaire" then
                if MyLevel >= 1575 and MyLevel <= 1599 or SelectMonster == "Dragon Crew Warrior" then
                    Mon = "Dragon Crew Warrior"
                    LevelQuest = 1
                    NameQuest = "DragonCrewQuest"
                    NameMon = "Dragon Crew Warrior"
                    CFrameQuest = CFrame.new(6750.4931640625, 127.44916534423828, -711.0308837890625)
                    CFrameMon = CFrame.new(6709.76367, 52.3442993, -1139.02966, -0.763515472, -0, 0.645789504, -0, 1, -0, -0.645789504, -0, -0.763515472)
                elseif MyLevel >= 1600 and MyLevel <= 1624 or SelectMonster == "Dragon Crew Archer" then
                    Mon = "Dragon Crew Archer"
                    NameQuest = "DragonCrewQuest"
                    LevelQuest = 2
                    NameMon = "Dragon Crew Archer"
                    CFrameQuest = CFrame.new(6750.4931640625, 127.44916534423828, -711.0308837890625)
                    CFrameMon = CFrame.new(6668.76172, 481.376923, 329.12207, -0.121787429, -0, -0.992556155, -0, 1, -0, 0.992556155, -0, -0.121787429)
                elseif (MyLevel < 1625 or MyLevel > 1649) and SelectMonster ~= "Hydra Enforcer" then
                    if (MyLevel < 1650 or MyLevel > 1699) and SelectMonster ~= "Venomous Assailant" then
                        if (MyLevel < 1700 or MyLevel > 1724) and SelectMonster ~= "Marine Commodore" then
                            if (MyLevel < 1725 or MyLevel > 1774) and SelectMonster ~= "Marine Rear Admiral" then
                                if (MyLevel < 1775 or MyLevel > 1799) and SelectMonster ~= "Fishman Raider" then
                                    if MyLevel >= 1800 and MyLevel <= 1824 or SelectMonster == "Fishman Captain" then
                                        Mon = "Fishman Captain"
                                        LevelQuest = 2
                                        NameQuest = "DeepForestIsland3"
                                        NameMon = "Fishman Captain"
                                        CFrameQuest = CFrame.new(-10581.6563, 330.872955, -8761.18652, -0.882952213, -0, 0.469463557, -0, 1, -0, -0.469463557, -0, -0.882952213)
                                        CFrameMon = CFrame.new(-10994.701171875, 352.38140869140625, -9002.1103515625)
                                    elseif (MyLevel < 1825 or MyLevel > 1849) and SelectMonster ~= "Forest Pirate" then
                                        if (MyLevel < 1850 or MyLevel > 1899) and SelectMonster ~= "Mythological Pirate" then
                                            if MyLevel >= 1900 and MyLevel <= 1924 or SelectMonster == "Jungle Pirate" then
                                                Mon = "Jungle Pirate"
                                                LevelQuest = 1
                                                NameQuest = "DeepForestIsland2"
                                                NameMon = "Jungle Pirate"
                                                CFrameQuest = CFrame.new(-12680.3818, 389.971039, -9902.01953, -0.0871315002, -0, 0.996196866, -0, 1, -0, -0.996196866, -0, -0.0871315002)
                                                CFrameMon = CFrame.new(-12256.16015625, 331.73828125, -10485.8369140625)
                                            elseif MyLevel >= 1925 and MyLevel <= 1974 or SelectMonster == "Musketeer Pirate" then
                                                Mon = "Musketeer Pirate"
                                                LevelQuest = 2
                                                NameQuest = "DeepForestIsland2"
                                                NameMon = "Musketeer Pirate"
                                                CFrameQuest = CFrame.new(-12680.3818, 389.971039, -9902.01953, -0.0871315002, -0, 0.996196866, -0, 1, -0, -0.996196866, -0, -0.0871315002)
                                                CFrameMon = CFrame.new(-13457.904296875, 391.545654296875, -9859.177734375)
                                            elseif MyLevel >= 1975 and MyLevel <= 1999 or SelectMonster == "Reborn Skeleton" then
                                                Mon = "Reborn Skeleton"
                                                LevelQuest = 1
                                                NameQuest = "HauntedQuest1"
                                                NameMon = "Reborn Skeleton"
                                                CFrameQuest = CFrame.new(-9479.2168, 141.215088, 5566.09277, -0, -0, 1, -0, 1, -0, -1, -0, -0)
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

-- Background Automation Loop Thread
task.spawn(function()
    while task.wait(1) do
        if _G.AutoFarm then
            pcall(function()
                CheckQuest()
            end)
        end
        if _G.AutoMaterial then
            pcall(function()
                MaterialMon()
            end)
        end
    end
end)
