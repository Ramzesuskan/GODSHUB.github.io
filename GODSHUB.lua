--////////////////////////////////////////////////////////
--            Gods Hub (Optimized+Modded)
--////////////////////////////////////////////////////////

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local VirtualUser = game:GetService("VirtualUser")
local VirtualInputManager = game:GetService("VirtualInputManager")

local LocalPlayer = Players.LocalPlayer

-------------------------------------------------------------------------------
--    1. Создаем ScreenGui и основное окно (mainFrame)
-------------------------------------------------------------------------------
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "VenomHubScreenGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local mainFrame = Instance.new("Frame")
mainFrame.Name = "VenomHubMainFrame"
mainFrame.Size = UDim2.new(0, 320, 0, 650)  -- Увеличили высоту до 450
mainFrame.Position = UDim2.new(0.05, 0, 0.1, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(110, 0, 255)
mainFrame.BorderSizePixel = 2
mainFrame.Visible = true  -- по умолчанию скрыто, открывать клавишей [K]
mainFrame.Active = true
mainFrame.Selectable = true
mainFrame.Parent = screenGui

-- Заголовок
local titleBar = Instance.new("TextLabel")
titleBar.Name = "TitleBar"
titleBar.Size = UDim2.new(1, 0, 0, 30)
titleBar.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
titleBar.TextColor3 = Color3.fromRGB(255, 255, 255)
titleBar.Font = Enum.Font.SourceSansBold
titleBar.TextSize = 18
titleBar.Text = "HellYeah HUB(Modded)"
titleBar.Parent = mainFrame

-- Подпись внизу
local footerLabel = Instance.new("TextLabel")
footerLabel.Size = UDim2.new(1, 0, 0, 20)
footerLabel.Position = UDim2.new(0, 0, 1, -20)
footerLabel.BackgroundTransparency = 1
footerLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
footerLabel.Font = Enum.Font.SourceSansSemibold
footerLabel.TextSize = 16
footerLabel.Text = "By GOD (wzrrx)"
footerLabel.Parent = mainFrame

-- Прокручиваемая область для кнопок
local contentFrame = Instance.new("ScrollingFrame")
contentFrame.Name = "ContentFrame"
contentFrame.Size = UDim2.new(1, -10, 1, -60)  -- Занимает всю высоту, кроме заголовка и подписи
contentFrame.Position = UDim2.new(0, 5, 0, 35)
contentFrame.BackgroundTransparency = 1
contentFrame.BorderSizePixel = 0
contentFrame.ScrollingDirection = Enum.ScrollingDirection.Y
contentFrame.ScrollBarThickness = 4
contentFrame.Parent = mainFrame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Padding = UDim.new(0,5)
UIListLayout.Parent = contentFrame

-------------------------------------------------------------------------------
--    3. Клавиша [K] для показа/скрытия
-------------------------------------------------------------------------------
UserInputService.InputBegan:Connect(function(input, gp)
    if not gp and input.KeyCode == Enum.KeyCode.K then
        mainFrame.Visible = not mainFrame.Visible
    end
end)

-------------------------------------------------------------------------------
--    5. Добавляем новый функционал: Auto Key Press
-------------------------------------------------------------------------------
local AutoKeyPress_Enabled = false
local AutoKeyPress_Connection

local function AutoKeyPress_Enable()
    if AutoKeyPress_Enabled then return end
    AutoKeyPress_Enabled = true

    AutoKeyPress_Connection = task.spawn(function()
        task.wait(3) -- Ждем 3 секунды перед стартом

        while AutoKeyPress_Enabled do
            -- Нажатие и повторная отправка "b"
            VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.B, false, game)
            task.wait(0.1)
            VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.B, false, game)
            task.wait(45)
            VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.B, false, game)
            task.wait(0.1)
            VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.B, false, game)

            -- Нажатие и повторная отправка "n"
            VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.N, false, game)
            task.wait(0.1)
            VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.N, false, game)
            task.wait(45)
            VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.N, false, game)
            task.wait(0.1)
            VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.N, false, game)

            -- Нажатие и повторная отправка "m"
            VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.M, false, game)
            task.wait(0.1)
            VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.M, false, game)
            task.wait(45)
            VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.M, false, game)
            task.wait(0.1)
            VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.M, false, game)
        end
    end)
end

local function AutoKeyPress_Disable()
    if not AutoKeyPress_Enabled then return end
    AutoKeyPress_Enabled = false
    if AutoKeyPress_Connection then
        task.cancel(AutoKeyPress_Connection)
        AutoKeyPress_Connection = nil
    end
end

-------------------------------------------------------------------------------
--    6. Функция создания строки (createToggleRow) для кнопок
-------------------------------------------------------------------------------
local function createToggleRow(parent, scriptName, canToggle, isEnabledFn, onEnable, onDisable, getKeyBindFn, setKeyBindFn)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, 30)
    frame.BackgroundTransparency = 1
    frame.Parent = parent

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.4, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = scriptName
    label.TextColor3 = Color3.new(1, 1, 1)
    label.Font = Enum.Font.SourceSansSemibold
    label.TextSize = 16
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame

    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0.2, 0, 1, 0)
    button.Position = UDim2.new(0.4, 5, 0, 0)
    button.Font = Enum.Font.SourceSans
    button.TextSize = 16
    button.Parent = frame

    local bindButton = Instance.new("TextButton")
    bindButton.Size = UDim2.new(0.2, 0, 1, 0)
    bindButton.Position = UDim2.new(0.6, 10, 0, 0)
    bindButton.Font = Enum.Font.SourceSans
    bindButton.TextSize = 16
    bindButton.Text = "Bind"
    bindButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    bindButton.BackgroundColor3 = Color3.fromRGB(90, 90, 90)
    bindButton.Parent = frame

    local function updateToggleButton()
        if not canToggle then
            button.Text = "Run"
            button.BackgroundColor3 = Color3.fromRGB(150, 150, 150)
            return
        end
        if isEnabledFn() then
            button.Text = "ON"
            button.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
        else
            button.Text = "OFF"
            button.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
        end
    end
    updateToggleButton()

    button.MouseButton1Click:Connect(function()
        if not canToggle then
            onEnable()
            button.Text = "DONE"
            button.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
            button.Active = false
            bindButton.Active = false
            return
        end
        if isEnabledFn() then
            onDisable()
        else
            onEnable()
        end
        updateToggleButton()
    end)

    if getKeyBindFn and setKeyBindFn then
        local capturingKey = false

        local function updateBindButtonText()
            local kb = getKeyBindFn()
            if kb then
                bindButton.Text = "[".. kb.Name .."]"
            else
                bindButton.Text = "Bind"
            end
        end
        updateBindButtonText()

        bindButton.MouseButton1Click:Connect(function()
            if capturingKey then
                capturingKey = false
                bindButton.Text = "Bind"
            else
                capturingKey = true
                bindButton.Text = "Press Key..."
            end
        end)

        UserInputService.InputBegan:Connect(function(input, gp)
            if gp then return end
            if capturingKey then
                if input.KeyCode ~= Enum.KeyCode.Unknown then
                    setKeyBindFn(input.KeyCode)
                    capturingKey = false
                    updateBindButtonText()
                end
            else
                local kb = getKeyBindFn()
                if kb and input.KeyCode == kb then
                    if canToggle then
                        if isEnabledFn() then
                            onDisable()
                        else
                            onEnable()
                        end
                        updateToggleButton()
                    else
                        onEnable()
                        button.Text = "DONE"
                        button.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
                        button.Active = false
                        bindButton.Active = false
                    end
                end
            end
        end)
    else
        bindButton.Visible = false
    end

    return frame
end

-------------------------------------------------------------------------------
--    7. Остальной основной скрипт (без изменений)
-------------------------------------------------------------------------------
--========================== Admin Check ========================--
local AdminCheck_Enabled = false
local AdminCheck_Connection
local AdminCheck_Coroutine

local AdminList = {
    ["tabootvcat"] = true, ["Revenantic"] = true, ["Saabor"] = true, ["MoIitor"] = true,
    ["IAmUnderAMask"] = true, ["SheriffGorji"] = true, ["xXFireyScorpionXx"] = true,
    ["LoChips"] = true, ["DeliverCreations"] = true, ["TDXiswinning"] = true,
    ["TZZV"] = true, ["FelixVenue"] = true, ["SIEGFRlED"] = true, ["ARRYvvv"] = true,
    ["z_papermoon"] = true, ["Malpheasance"] = true, ["ModHandIer"] = true,
    ["valphex"] = true, ["J_anday"] = true, ["tvdisko"] = true, ["yIlehs"] = true,
    ["COLOSSUSBUILTOFSTEEL"] = true, ["SeizedHolder"] = true, ["r3shape"] = true,
    ["RVVZ"] = true, ["adurize"] = true, ["codedcosmetics"] = true,
    ["QuantumCaterpillar"] = true, ["FractalHarmonics"] = true, ["GalacticSculptor"] = true,
    ["oTheSilver"] = true, ["Kretacaous"] = true, ["icarus_xs1goliath"] = true,
    ["GlamorousDradon"] = true, ["rainjeremy"] = true, ["parachuter2000"] = true,
    ["faintermercury"] = true, ["harht"] = true, ["Sansek1252"] = true,
    ["Snorpuwu"] = true, ["BenAzoten"] = true, ["Cand1ebox"] = true, ["KeenlyAware"] = true,
    ["mrzued"] = true, ["BruhmanVIII"] = true, ["Nystesia"] = true, ["fausties"] = true,
    ["zateopp"] = true, ["Iordnabi"] = true, ["ReviveTheDevil"] = true, ["jake_jpeg"] = true,
    ["UncrossedMeat3888"] = true, ["realpenyy"] = true, ["karateeeh"] = true,
    ["JayyMlg"] = true, ["Lo_Chips"] = true, ["Avelosky"] = true, ["king_ab09"] = true,
    ["TigerLe123"] = true, ["Dalvanuis"] = true, ["iSonMillions"] = true,
    ["Cefasin"] = true, ["ulzig"] = true, ["DieYouOder"] = true, ["whosframed"] = true, ["Idont_HavePizza"] = true
}

local function CheckAdmins()
    local players = Players:GetPlayers()
    for i = 1, #players do
        if AdminList[players[i].Name] then
            LocalPlayer:Kick("Admin")
            wait(2)
            game:Shutdown()
            return
        end
    end
end

local function AdminCheck_Enable()
    if AdminCheck_Enabled then return end
    AdminCheck_Enabled = true

    CheckAdmins()

    AdminCheck_Connection = Players.PlayerAdded:Connect(function(plr)
        if AdminCheck_Enabled and AdminList[plr.Name] then
            LocalPlayer:Kick("Detected Nigger")
            wait(2)
            game:Shutdown()
        end
    end)

    AdminCheck_Coroutine = spawn(function()
        while AdminCheck_Enabled do
            CheckAdmins()
            wait(4)
        end
    end)
end

local function AdminCheck_Disable()
    if not AdminCheck_Enabled then return end
    AdminCheck_Enabled = false

    if AdminCheck_Connection then
        AdminCheck_Connection:Disconnect()
        AdminCheck_Connection = nil
    end
    if AdminCheck_Coroutine then
        cancel(AdminCheck_Coroutine)
        AdminCheck_Coroutine = nil
    end
end

--======================= Kill Button =========================--
-- Функция для полного отключения скрипта
local function killScript()
    -- Остановка всех активных процессов
    if Fly_Connection then Fly_Connection:Disconnect() end
    if AutoKeyPress_Connection then task.cancel(AutoKeyPress_Connection) end
    if AutoPressX_Connection then task.cancel(AutoPressX_Connection) end
    if AdminCheck_Connection then AdminCheck_Connection:Disconnect() end
    if AntiAFK_IdledConnection then AntiAFK_IdledConnection:Disconnect() end
    if MeleeAura_Connection then MeleeAura_Connection:Disconnect() end
    if TPFarm_SteppedConnection then TPFarm_SteppedConnection:Disconnect() end
    if TPFarm_RenderConnection then TPFarm_RenderConnection:Disconnect() end
    if TPFarm_CharConnection then TPFarm_CharConnection:Disconnect() end
    if SaveCube_Connection then SaveCube_Connection:Disconnect() end
    if SaveVibe_Connection then SaveVibe_Connection:Disconnect() end
    if SaveMount_Connection then SaveMount_Connection:Disconnect() end
    if NewSavePoint_Connection then NewSavePoint_Connection:Disconnect() end

    -- Удаление интерфейса
    if screenGui then
        screenGui:Destroy()
        screenGui = nil
    end

    -- Очистка переменных
    Fly_Enabled = false
    AutoKeyPress_Enabled = false
    AutoPressX_Enabled = false
    AdminCheck_Enabled = false
    AntiAFK_Enabled = false
    MeleeAura_Enabled = false
    TPFarm_Enabled = false
    SaveCube_Enabled = false
    SaveVibe_Enabled = false
    SaveMount_Enabled = false
    NewSavePoint_Enabled = false

    -- Сообщение в консоль
    print("Скрипт полностью отключен.")
end

-- Создание кнопки "Убить скрипт"
local killButtonFrame = Instance.new("Frame")
killButtonFrame.Size = UDim2.new(1, 0, 0, 30)
killButtonFrame.BackgroundTransparency = 1
killButtonFrame.Parent = contentFrame

local killButtonLabel = Instance.new("TextLabel")
killButtonLabel.Size = UDim2.new(0.4, 0, 1, 0)
killButtonLabel.BackgroundTransparency = 1
killButtonLabel.Text = "KILL BUTTON"
killButtonLabel.TextColor3 = Color3.new(1, 1, 1)
killButtonLabel.Font = Enum.Font.SourceSansSemibold
killButtonLabel.TextSize = 16
killButtonLabel.TextXAlignment = Enum.TextXAlignment.Left
killButtonLabel.Parent = killButtonFrame

local killButton = Instance.new("TextButton")
killButton.Size = UDim2.new(0.2, 0, 1, 0)
killButton.Position = UDim2.new(0.4, 5, 0, 0)
killButton.Font = Enum.Font.SourceSans
killButton.TextSize = 16
killButton.Text = "KILL"
killButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
killButton.TextColor3 = Color3.new(255, 255, 255)
killButton.Parent = killButtonFrame

-- Обработка нажатия на кнопку
killButton.MouseButton1Click:Connect(function()
    killScript() -- Функция вызывается только при нажатии на кнопку
    killButton.Text = "DONE"
    killButton.BackgroundColor3 = Color3.fromRGB(0, 170, 0) -- Зеленый цвет после выполнения
    killButton.Active = false -- Делаем кнопку неактивной после нажатия
end)

--========================== Auto Press X ===========================--
local AutoPressX_Enabled = false
local AutoPressX_Connection
local function AutoPressX_Enable()
    if AutoPressX_Enabled then return end
    AutoPressX_Enabled = true

    AutoPressX_Connection = task.spawn(function()
        while AutoPressX_Enabled do
            -- Нажатие клавиши "X"
            VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.X, false, game)
            task.wait(0.1)
            VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.X, false, game)
            task.wait(5)  -- Ждем 5 секунд перед следующим нажатием
        end
    end)
end

local function AutoPressX_Disable()
    if not AutoPressX_Enabled then return end
    AutoPressX_Enabled = false
    if AutoPressX_Connection then
        task.cancel(AutoPressX_Connection)
        AutoPressX_Connection = nil
    end
end

--========================== Fuck AntiCheat ===========================--
local AUTO_KICK_SETTINGS = {
    KICK_MESSAGE = "🔴 AntiCheat Save: {PLAYER} Leaved",
    CHECK_INTERVAL = 0.5,
    DEBUG_MODE = true
}

-- Состояние Auto-Kick System
local autoKickEnabled = false
local targetPlayersMap = {}
local autoKickConnection = nil
local targetNicknames = {"", "", "", ""} -- Пустые поля по умолчанию

-- Функция обновления списка игроков
local function updateTargetPlayers()
    targetPlayersMap = {}
    for _, name in ipairs(targetNicknames) do
        if name ~= "" then -- Игнорируем пустые поля
            targetPlayersMap[name] = true
        end
    end
    if AUTO_KICK_SETTINGS.DEBUG_MODE then
        print("")
        for name in pairs(targetPlayersMap) do
            print(""..name)
        end
    end
end

-- Функции управления Auto-Kick System
local function enableAutoKick()
    if autoKickEnabled then return end
    autoKickEnabled = true
    
    updateTargetPlayers() -- Обновляем список перед включением
    
    local function onPlayerRemoving(player)
        if targetPlayersMap[player.Name] then
            LocalPlayer:Kick(AUTO_KICK_SETTINGS.KICK_MESSAGE:gsub("{PLAYER}", player.Name))
            task.wait(0.1)
        end
    end
    
    autoKickConnection = Players.PlayerRemoving:Connect(onPlayerRemoving)
    
    -- Проверка уже вышедших игроков
    for _, player in ipairs(Players:GetPlayers()) do
        if targetPlayersMap[player.Name] and not player:IsDescendantOf(game) then
            LocalPlayer:Kick(AUTO_KICK_SETTINGS.KICK_MESSAGE:gsub("{PLAYER}", player.Name))
            break
        end
    end
    
    if AUTO_KICK_SETTINGS.DEBUG_MODE then
        print("")
    end
end

local function disableAutoKick()
    if not autoKickEnabled then return end
    autoKickEnabled = false
    
    if autoKickConnection then
        autoKickConnection:Disconnect()
        autoKickConnection = nil
    end
    
    if AUTO_KICK_SETTINGS.DEBUG_MODE then
        print("")
    end
end

--========================== Anti AFK ===========================--
local AntiAFK_Enabled = false
local AntiAFK_IdledConnection
local AntiAFK_Coroutine

local function AntiAFK_DoAction()
    pcall(function()
        VirtualUser:CaptureController()
        VirtualUser:SetKeyDown('0x20')  -- пробел
        task.wait(0.1)
        VirtualUser:SetKeyUp('0x20')
    end)
    pcall(function()
        local camera = workspace.CurrentCamera
        camera.CFrame = camera.CFrame * CFrame.Angles(math.rad(0.5), 0, 0)
        task.wait(0.1)
        camera.CFrame = camera.CFrame * CFrame.Angles(math.rad(-0.5), 0, 0)
    end)
end

local function AntiAFK_Enable()
    if AntiAFK_Enabled then return end
    AntiAFK_Enabled = true

    local player = LocalPlayer
    AntiAFK_IdledConnection = player.Idled:Connect(function()
        if AntiAFK_Enabled then
            AntiAFK_DoAction()
        end
    end)

    AntiAFK_Coroutine = coroutine.create(function()
        while AntiAFK_Enabled do
            AntiAFK_DoAction()
            task.wait(30)
        end
    end)
    coroutine.resume(AntiAFK_Coroutine)
end

local function AntiAFK_Disable()
    if not AntiAFK_Enabled then return end
    AntiAFK_Enabled = false

    if AntiAFK_IdledConnection then
        AntiAFK_IdledConnection:Disconnect()
        AntiAFK_IdledConnection = nil
    end
    AntiAFK_Coroutine = nil
end

--=================== Melee Aura 4 Alt MAX! =====================--
local MeleeAura_Enabled = false
local MeleeAura_Connection

local runAttackLoop do
    local plrs = game:GetService("Players")
    local me = plrs.LocalPlayer
    local run = game:GetService("RunService")

    local remote1 = game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("XMHH.2")
    local remote2 = game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("XMHH2.2")

    local maxdist = 20

    local function Attack(target)
        if not (target and target:FindFirstChild("Head")) then return end
        local arg1 = {
            [1] = "🍞",
            [2] = tick(),
            [3] = me.Character and me.Character:FindFirstChildOfClass("Tool"),
            [4] = "43TRFWX",
            [5] = "Normal",
            [6] = tick(),
            [7] = true
        }
        local result = remote1:InvokeServer(unpack(arg1))
        task.wait(0.5)

        local tool = me.Character and me.Character:FindFirstChildOfClass("Tool")
        if tool then
            local Handle = tool:FindFirstChild("WeaponHandle") or tool:FindFirstChild("Handle")
                          or me.Character:FindFirstChild("Right Arm")
            if Handle and target:FindFirstChild("Head") then
                local arg2 = {
                    [1] = "🍞",
                    [2] = tick(),
                    [3] = tool,
                    [4] = "2389ZFX34",
                    [5] = result,
                    [6] = false,
                    [7] = Handle,
                    [8] = target:FindFirstChild("Head"),
                    [9] = target,
                    [10] = me.Character:FindFirstChild("HumanoidRootPart").Position,
                    [11] = target:FindFirstChild("Head").Position
                }
                remote2:FireServer(unpack(arg2))
            end
        end
    end

    runAttackLoop = function()
        return run.RenderStepped:Connect(function()
            if not MeleeAura_Enabled then return end
            local char = me.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            if hrp then
                for _, plr in ipairs(plrs:GetPlayers()) do
                    if plr ~= me then
                        local c = plr.Character
                        local hrp2 = c and c:FindFirstChild("HumanoidRootPart")
                        local hum = c and c:FindFirstChildOfClass("Humanoid")
                        if hrp2 and hum then
                            local dist = (hrp.Position - hrp2.Position).Magnitude
                            if dist < maxdist and hum.Health > 15 and not c:FindFirstChildOfClass("ForceField") then
                                Attack(c)
                            end
                        end
                    end
                end
            end
        end)
    end
end

local function MeleeAura_Enable()
    if MeleeAura_Enabled then return end
    MeleeAura_Enabled = true
    MeleeAura_Connection = runAttackLoop()
end

local function MeleeAura_Disable()
    if not MeleeAura_Enabled then return end
    MeleeAura_Enabled = false

    if MeleeAura_Connection then
        MeleeAura_Connection:Disconnect()
        MeleeAura_Connection = nil
    end
end

--======================= Teleport Farm =========================--
local TPFarm_Enabled = false
local TPFarm_TargetName = ""

-- Локальные ссылки для оптимизации
local TPFarm_Connections = {}
local DeathRespawn_Event = game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("DeathRespawn")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local wait = task.wait
local disconnectConnection = function(conn)
    if conn then conn:Disconnect() end
end

-- Оптимизированная функция обработки добавления персонажа
local function TPFarm_OnCharacterAdded(char)
    -- Отключаем старые соединения
    disconnectConnection(TPFarm_Connections.Stepped)

    -- Ждем загрузки необходимых частей
    wait(0.4)
    
    local hrp = char:WaitForChild("HumanoidRootPart", 1)
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not (hrp and hum) then return end

    -- Кэшируем функцию для телепортации
    local function teleportToTarget()
        if not TPFarm_Enabled then return end
        local mainPlayer = Players:FindFirstChild(TPFarm_TargetName)
        if not mainPlayer then return end
        
        local mainChar = mainPlayer.Character
        if not mainChar then return end
        
        local mainHRP = mainChar:FindFirstChild("HumanoidRootPart")
        if mainHRP then
            -- Телепортация с сохранением ориентации
            hrp.CFrame = mainHRP.CFrame + (mainHRP.CFrame.LookVector * 3)
        end
    end

    -- Устанавливаем соединение для телепортации
    TPFarm_Connections.Stepped = RunService.Stepped:Connect(teleportToTarget)

    -- Обработчик здоровья (установка на 0)
    TPFarm_Connections.HealthChanged = hum:GetPropertyChangedSignal("Health"):Connect(function()
        if TPFarm_Enabled then
            hum.Health = 0
        end
    end)
end

-- Оптимизированная функция включения
local function TPFarm_Enable()
    if TPFarm_Enabled then return end
    TPFarm_Enabled = true

    local me = LocalPlayer

    -- Обработка текущего персонажа
    if me.Character then
        TPFarm_OnCharacterAdded(me.Character)
    end

    -- Обработка смены персонажа
    TPFarm_Connections.CharAdded = me.CharacterAdded:Connect(function(newChar)
        if not TPFarm_Enabled then return end
        
        TPFarm_OnCharacterAdded(newChar)
        
        -- Перенос оружия в руки
        local tool = me.Backpack:FindFirstChildOfClass("Tool")
        if tool and newChar then
            tool.Parent = newChar
        end
    end)

    -- Авто-возрождение
    TPFarm_Connections.RenderStepped = RunService.RenderStepped:Connect(function()
        if not TPFarm_Enabled then return end
        
        local char = me.Character
        if not char then return end
        
        local humanoid = char:FindFirstChildOfClass("Humanoid")
        if humanoid and humanoid.Health <= 0 then
            DeathRespawn_Event:InvokeServer("KMG4R904")
        end
    end)
end

-- Функция выключения
local function TPFarm_Disable()
    if not TPFarm_Enabled then return end
    TPFarm_Enabled = false

    -- Отключаем все соединения
    for _, conn in pairs(TPFarm_Connections) do
        disconnectConnection(conn)
    end
    TPFarm_Connections = {}
end

--================= 3 Save-кнопки (Cube/Vibecheck/Mountain) =======
local event = DeathRespawn_Event  -- Сократим название

-- 1) Save Cube
local SaveCube_Enabled = false
local SaveCube_Connection
local SaveCube_Position = Vector3.new(-5045, -259, 80)

local function SaveCube_Enable()
    if SaveCube_Enabled then return end
    SaveCube_Enabled = true

    SaveCube_Connection = RunService.RenderStepped:Connect(function()
        if not SaveCube_Enabled then return end
        local char = LocalPlayer.Character
        if char then
            local hrp = char:FindFirstChild("HumanoidRootPart")
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hrp then
                hrp.CFrame = CFrame.new(SaveCube_Position)
            end
            if hum and hum.Health <= 0 then
                event:InvokeServer("KMG4R904") -- авто возрождение
            end
        end
    end)
end

local function SaveCube_Disable()
    if not SaveCube_Enabled then return end
    SaveCube_Enabled = false
    if SaveCube_Connection then
        SaveCube_Connection:Disconnect()
        SaveCube_Connection = nil
    end
end

-- 2) Save Vibecheck
local SaveVibe_Enabled = false
local SaveVibe_Connection
local SaveVibe_Position = Vector3.new(-4065, -200, -306)

local function SaveVibe_Enable()
    if SaveVibe_Enabled then return end
    SaveVibe_Enabled = true

    SaveVibe_Connection = RunService.RenderStepped:Connect(function()
        if not SaveVibe_Enabled then return end
        local char = LocalPlayer.Character
        if char then
            local hrp = char:FindFirstChild("HumanoidRootPart")
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hrp then
                hrp.CFrame = CFrame.new(SaveVibe_Position)
            end
            if hum and hum.Health <= 0 then
                event:InvokeServer("KMG4R904")
            end
        end
    end)
end

local function SaveVibe_Disable()
    if not SaveVibe_Enabled then return end
    SaveVibe_Enabled = false
    if SaveVibe_Connection then
        SaveVibe_Connection:Disconnect()
        SaveVibe_Connection = nil
    end
end

-- 3) Save Mountain
local SaveMount_Enabled = false
local SaveMount_Connection
local SaveMount_Position = Vector3.new(-4118, 28, -493)

local function SaveMount_Enable()
    if SaveMount_Enabled then return end
    SaveMount_Enabled = true

    SaveMount_Connection = RunService.RenderStepped:Connect(function()
        if not SaveMount_Enabled then return end
        local char = LocalPlayer.Character
        if char then
            local hrp = char:FindFirstChild("HumanoidRootPart")
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hrp then
                hrp.CFrame = CFrame.new(SaveMount_Position)
            end
            if hum and hum.Health <= 0 then
                event:InvokeServer("KMG4R904")
            end
        end
    end)
end

local function SaveMount_Disable()
    if not SaveMount_Enabled then return end
    SaveMount_Enabled = false
    if SaveMount_Connection then
        SaveMount_Connection:Disconnect()
        SaveMount_Connection = nil
    end
end

-- 4) Save ATM
local NewSavePoint_Enabled = false
local NewSavePoint_Connection
local NewSavePoint_Position = Vector3.new(-4396, 4, 196)

-- Функция для включения телепортации к новой точке
local function NewSavePoint_Enable()
    if NewSavePoint_Enabled then return end
    NewSavePoint_Enabled = true

    NewSavePoint_Connection = RunService.RenderStepped:Connect(function()
        if not NewSavePoint_Enabled then return end
        local char = LocalPlayer.Character
        if char then
            local hrp = char:FindFirstChild("HumanoidRootPart")
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hrp then
                hrp.CFrame = CFrame.new(NewSavePoint_Position)
            end
            if hum and hum.Health <= 0 then
                event:InvokeServer("KMG4R904") -- авто возрождение
            end
        end
    end)
end

-- Функция для выключения телепортации к новой точке
local function NewSavePoint_Disable()
    if not NewSavePoint_Enabled then return end
    NewSavePoint_Enabled = false
    if NewSavePoint_Connection then
        NewSavePoint_Connection:Disconnect()
        NewSavePoint_Connection = nil
    end
end

-------------------------------------------------------------------------------
--    5. Функция создания строки (createToggleRow) для кнопок
-------------------------------------------------------------------------------
local function createToggleRow(parent, scriptName, canToggle, isEnabledFn, onEnable, onDisable, getKeyBindFn, setKeyBindFn)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, 30)
    frame.BackgroundTransparency = 1
    frame.Parent = parent

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.4, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = scriptName
    label.TextColor3 = Color3.new(1, 1, 1)
    label.Font = Enum.Font.SourceSansSemibold
    label.TextSize = 16
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame

    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0.2, 0, 1, 0)
    button.Position = UDim2.new(0.4, 5, 0, 0)
    button.Font = Enum.Font.SourceSans
    button.TextSize = 16
    button.Parent = frame

    local bindButton = Instance.new("TextButton")
    bindButton.Size = UDim2.new(0.2, 0, 1, 0)
    bindButton.Position = UDim2.new(0.6, 10, 0, 0)
    bindButton.Font = Enum.Font.SourceSans
    bindButton.TextSize = 16
    bindButton.Text = "Bind"
    bindButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    bindButton.BackgroundColor3 = Color3.fromRGB(90, 90, 90)
    bindButton.Parent = frame

    local function updateToggleButton()
        if not canToggle then
            button.Text = "Run"
            button.BackgroundColor3 = Color3.fromRGB(150, 150, 150)
            return
        end
        if isEnabledFn() then
            button.Text = "ON"
            button.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
        else
            button.Text = "OFF"
            button.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
        end
    end
    updateToggleButton()

    button.MouseButton1Click:Connect(function()
        if not canToggle then
            -- одноразовый запуск
            onEnable()
            button.Text = "DONE"
            button.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
            button.Active = false
            bindButton.Active = false
            return
        end
        if isEnabledFn() then
            onDisable()
        else
            onEnable()
        end
        updateToggleButton()
    end)

    if getKeyBindFn and setKeyBindFn then
        local capturingKey = false

        local function updateBindButtonText()
            local kb = getKeyBindFn()
            if kb then
                bindButton.Text = "[".. kb.Name .."]"
            else
                bindButton.Text = "Bind"
            end
        end
        updateBindButtonText()

        bindButton.MouseButton1Click:Connect(function()
            if capturingKey then
                capturingKey = false
                bindButton.Text = "Bind"
            else
                capturingKey = true
                bindButton.Text = "Press Key..."
            end
        end)

        UserInputService.InputBegan:Connect(function(input, gp)
            if gp then return end
            if capturingKey then
                if input.KeyCode ~= Enum.KeyCode.Unknown then
                    setKeyBindFn(input.KeyCode)
                    capturingKey = false
                    updateBindButtonText()
                end
            else
                local kb = getKeyBindFn()
                if kb and input.KeyCode == kb then
                    if canToggle then
                        if isEnabledFn() then
                            onDisable()
                        else
                            onEnable()
                        end
                        updateToggleButton()
                    else
                        -- одноразовый
                        if not DeletedMob_Ran then
                            onEnable()
                            button.Text = "DONE"
                            button.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
                            button.Active = false
                            bindButton.Active = false
                        end
                    end
                end
            end
        end)
    else
        bindButton.Visible = false
    end

    return frame
end

-- Дополнительная строка ввода для Teleport Farm
local function createTPFarmTargetRow(parent)
    local row = Instance.new("Frame")
    row.Size = UDim2.new(1, 0, 0, 30)
    row.BackgroundTransparency = 1
    row.Parent = parent

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.4, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = "TP Target:"
    label.TextColor3 = Color3.new(1,1,1)
    label.Font = Enum.Font.SourceSansSemibold
    label.TextSize = 16
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = row

    local input = Instance.new("TextBox")
    input.Size = UDim2.new(0.5, 0, 1, 0)
    input.Position = UDim2.new(0.4, 5, 0, 0)
    input.BackgroundColor3 = Color3.fromRGB(80,80,80)
    input.TextColor3 = Color3.new(1,1,1)
    input.Font = Enum.Font.SourceSans
    input.TextSize = 16
    input.Text = TPFarm_TargetName
    input.ClearTextOnFocus = false
    input.Parent = row

    input.FocusLost:Connect(function()
        TPFarm_TargetName = input.Text
    end)
end

-------------------------------------------------------------------------------
--   6. Создаём кнопки в нужном порядке
-------------------------------------------------------------------------------
-- 4) Fuck Anticheat
do
    local autoKickBind = nil
    createToggleRow(
        contentFrame,
        "Fuck AntiCheat",
        true,
        function() return autoKickEnabled end,
        enableAutoKick,
        disableAutoKick,
        function() return autoKickBind end,
        function(k) autoKickBind = k end
    )
end

-- Функция создания строки с полем ввода
local function createNicknameInput(parent, index)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, 30)
    frame.BackgroundTransparency = 1
    frame.Parent = parent

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.3, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = ""..index..":"
    label.TextColor3 = Color3.new(1, 1, 1)
    label.Font = Enum.Font.SourceSansSemibold
    label.TextSize = 16
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame

    local textBox = Instance.new("TextBox")
    textBox.Size = UDim2.new(0.7, -5, 0.8, 0)
    textBox.Position = UDim2.new(0.3, 5, 0.1, 0)
    textBox.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    textBox.TextColor3 = Color3.new(1, 1, 1)
    textBox.Font = Enum.Font.SourceSans
    textBox.TextSize = 16
    textBox.Text = targetNicknames[index] or ""
    textBox.PlaceholderText = ""
    textBox.ClearTextOnFocus = false
    textBox.Parent = frame

    textBox.FocusLost:Connect(function()
        targetNicknames[index] = textBox.Text
        if autoKickEnabled then
            updateTargetPlayers()
        end
    end)

    return textBox
end

-- Создаем 4 пустых поля для ввода никнеймов
for i = 1, 4 do
    createNicknameInput(contentFrame, i)
end

-- Клавиша [K] для показа/скрытия
UserInputService.InputBegan:Connect(function(input, gp)
    if not gp and input.KeyCode == Enum.KeyCode.K then
        mainFrame.Visible = not mainFrame.Visible
    end
end)

-- 1)
do
    local autoPressXBind = nil
    createToggleRow(
        contentFrame,
        "Auto Press X",
        true,
        function() return AutoPressX_Enabled end,
        AutoPressX_Enable,
        AutoPressX_Disable,
        function() return autoPressXBind end,
        function(k) autoPressXBind = k end
    )
end

-- 2)Auto B,N,M
do
    local autoKeyPressBind = nil
    createToggleRow(
        contentFrame,
        "Auto B,N,M",
        true,
        function() return AutoKeyPress_Enabled end,
        AutoKeyPress_Enable,
        AutoKeyPress_Disable,
        function() return autoKeyPressBind end,
        function(k) autoKeyPressBind = k end
    )
end

-- 5) Admin Check
do
    local adminCheckBind = nil
    createToggleRow(
        contentFrame,
        "Save Ass",
        true,
        function() return AdminCheck_Enabled end,
        AdminCheck_Enable,
        AdminCheck_Disable,
        function() return adminCheckBind end,
        function(k) adminCheckBind = k end
    )
end

-- 7) Anti AFK
do
    local antiAFKBind = nil
    createToggleRow(
        contentFrame,
        "Anti AFK",
        true,
        function() return AntiAFK_Enabled end,
        AntiAFK_Enable,
        AntiAFK_Disable,
        function() return antiAFKBind end,
        function(k) antiAFKBind = k end
    )
end

-- 8) Melee Aura 4 Alt MAX!
do
    local meleeBind = nil
    createToggleRow(
        contentFrame,
        "Melee Aura",
        true,
        function() return MeleeAura_Enabled end,
        MeleeAura_Enable,
        MeleeAura_Disable,
        function() return meleeBind end,
        function(k) meleeBind = k end
    )
end

-- 9) Teleport Farm
do
    local tpBind = nil
    createToggleRow(
        contentFrame,
        "Teleport Farm",
        true,
        function() return TPFarm_Enabled end,
        TPFarm_Enable,
        TPFarm_Disable,
        function() return tpBind end,
        function(k) tpBind = k end
    )
    createTPFarmTargetRow(contentFrame)
end

-- 10) Save Cube
do
    local scBind = nil
    createToggleRow(
        contentFrame,
        "Save Abyss",
        true,
        function() return SaveCube_Enabled end,
        SaveCube_Enable,
        SaveCube_Disable,
        function() return scBind end,
        function(k) scBind = k end
    )
end

-- 11) Save Vibecheck
do
    local svBind = nil
    createToggleRow(
        contentFrame,
        "Save Water",
        true,
        function() return SaveVibe_Enabled end,
        SaveVibe_Enable,
        SaveVibe_Disable,
        function() return svBind end,
        function(k) svBind = k end
    )
end

-- 12) Save Mountain
do
    local smBind = nil
    createToggleRow(
        contentFrame,
        "Save Hole",
        true,
        function() return SaveMount_Enabled end,
        SaveMount_Enable,
        SaveMount_Disable,
        function() return smBind end,
        function(k) smBind = k end
    )
end

-- 13) Save ATM
do
    local newSavePointBind = nil
    createToggleRow(
        contentFrame,
        "Save ATM",
        true,
        function() return NewSavePoint_Enabled end,
        NewSavePoint_Enable,
        NewSavePoint_Disable,
        function() return newSavePointBind end,
        function(k) newSavePointBind = k end
    )
end

--//////////////////////////////////////////////////// end
