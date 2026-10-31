-- ═════════════════════════════════════════════════════════════
-- HAMA UNIVERSAL HUB V4.0 
-- ═════════════════════════════════════════════════════════════

local Services = {
    Players = game:GetService("Players"),
    RunService = game:GetService("RunService"),
    Workspace = game:GetService("Workspace"),
    ReplicatedStorage = game:GetService("ReplicatedStorage"),
    UserInputService = game:GetService("UserInputService"),
    TeleportService = game:GetService("TeleportService"),
    TweenService = game:GetService("TweenService"),
    HttpService = game:GetService("HttpService"),
}
local Player = Services.Players.LocalPlayer
local RunService = Services.RunService
local UIS = game:GetService("UserInputService")
local TweenService = Services.TweenService
local HttpService = Services.HttpService
local Workspace = Services.Workspace
local RepStorage = Services.ReplicatedStorage
local Players = Services.Players

-- ═══ SISTEM WHITELIST BARU (DEV & PREMIUM) ═══
local _DEV_URL = "https://raw.githubusercontent.com/dafaremixeruhuy-ctr/hama-hub/refs/heads/main/dev.txt"
local _PREM_URL = "https://raw.githubusercontent.com/dafaremixeruhuy-ctr/hama-hub/refs/heads/main/premium.txt"

local function FetchWhitelist(url)
    local body
    pcall(function()
        body = game:HttpGet(url)
    end)
    if not body then
        pcall(function()
            if syn and syn.request then
                body = syn.request({Url = url, Method = "GET"}).Body
            elseif request then
                body = request({Url = url, Method = "GET"}).Body
            end
        end)
    end
    return body
end

local function IsNameInList(body, playerName)
    if not body or body == "" then return false end
    for line in body:gmatch("[^\r\n]+") do
        local name = line:match("^%s*(.-)%s*$")
        if name == playerName then
            return true
        end
    end
    return false
end

local function CheckAccess()
    local playerName = game.Players.LocalPlayer.Name
    
    -- Owner bypass
    if playerName == "dpnvhr" or playerName == "fire6uns" then
        return true, "OWNER"
    end

    local devBody = FetchWhitelist(_DEV_URL)
    if IsNameInList(devBody, playerName) then
        return true, "DEV"
    end

    local premBody = FetchWhitelist(_PREM_URL)
    if IsNameInList(premBody, playerName) then
        return true, "PREMIUM"
    end

    return false, "Nama kamu ("..playerName..") tidak ada di Whitelist DEV maupun PREMIUM!"
end

-- Eksekusi pengecekan
local isAllowed, role = CheckAccess()

if not isAllowed then
    -- Tampilkan GUI Ditolak
    local pg = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
    local gui = Instance.new("ScreenGui")
    gui.Name = "HAMA_DENIED"
    gui.ResetOnSpawn = false
    gui.Parent = pg

    local main = Instance.new("Frame", gui)
    main.Size = UDim2.new(0, 320, 0, 160)
    main.Position = UDim2.new(0.5, 0, 0.5, 0)
    main.AnchorPoint = Vector2.new(0.5, 0.5)
    main.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
    Instance.new("UICorner", main).CornerRadius = UDim.new(0, 10)
    
    local stroke = Instance.new("UIStroke", main)
    stroke.Color = Color3.fromRGB(200, 50, 50)
    stroke.Thickness = 2

    local title = Instance.new("TextLabel", main)
    title.Size = UDim2.new(1, -20, 0, 40)
    title.Position = UDim2.new(0, 10, 0, 10)
    title.BackgroundTransparency = 1
    title.Text = "❌ ACCESS DENIED"
    title.TextColor3 = Color3.fromRGB(255, 60, 60)
    title.Font = Enum.Font.GothamBold
    title.TextSize = 20

    local desc = Instance.new("TextLabel", main)
    desc.Size = UDim2.new(1, -20, 0, 50)
    desc.Position = UDim2.new(0, 10, 0, 50)
    desc.BackgroundTransparency = 1
    desc.Text = role
    desc.TextColor3 = Color3.fromRGB(200, 200, 200)
    desc.Font = Enum.Font.GothamMedium
    desc.TextSize = 11
    desc.TextWrapped = true

    local close = Instance.new("TextButton", main)
    close.Size = UDim2.new(1, -20, 0, 30)
    close.Position = UDim2.new(0, 10, 1, -40)
    close.BackgroundColor3 = Color3.fromRGB(50, 20, 20)
    close.Text = "Tutup (Close)"
    close.TextColor3 = Color3.fromRGB(255, 255, 255)
    close.Font = Enum.Font.GothamBold
    close.TextSize = 12
    Instance.new("UICorner", close).CornerRadius = UDim.new(0, 6)
    
    close.MouseButton1Click:Connect(function()
        gui:Destroy()
    end)

    return -- Hentikan script di sini
end
-- ═══ END WHITELIST ═══

local State = {
    OwnerName = "dpnvhr", IsWhitelisted = true,
    PianoSpamming = false, SelectedRemote = nil, SelectedPiano = nil, FoundPianos = {},
    Level = 10, Threads = 10, KeyMult = 1, Mode = "nuke", FireCount = 0, RemoteFormat = "positional",
    FlyEnabled = false, FlySpeed = 50, FlyKeybind = Enum.KeyCode.F,
    NoclipEnabled = false, InvisibleEnabled = false, SpeedEnabled = false, WalkSpeed = 16,
    TargetPlayer = nil, TrollMode = "NONE", TrollActive = false, TrollConn = nil,
    SpectateStop = nil, PhysicStop = nil, HijackStop = nil, WalkFlingStop = nil,
    ShieldStop = nil, VoidStop = nil, PlayerExtraStop = nil, ServerStop = nil,
    HookAmplifier = 20, SimHack = true, PhaseDriver = true,
}

if not getgenv then getgenv = function() return _G end end
JD_Get = JD_Get or function() return nil end
JD_Set = JD_Set or function() end
if not firetouchinterest then firetouchinterest = function() end end
if not sethiddenproperty then sethiddenproperty = function() end end
if not setreadonly then setreadonly = function() end end
if not make_writeable then make_writeable = function() end end
if not hookmetamethod then hookmetamethod = function() end end
if not getrawmetatable then getrawmetatable = function() return {} end end

-- ═══ HOOK AMPLIFIER ═══
local _HM_INSTALLED, _HM_RESTORE_NC, _HM_ACTIVE_REMOTES = false, nil, {}
local function _HM_SetRW(mt, w)
    if typeof(setreadonly) == "function" then pcall(setreadonly, mt, not w)
    elseif typeof(make_writeable) == "function" and w then pcall(make_writeable, mt) end
end
local function _HM_Install()
    if _HM_INSTALLED then return end
    if typeof(hookmetamethod) ~= "function" or typeof(getrawmetatable) ~= "function" then return end
    local mt = getrawmetatable(game)
    _HM_RESTORE_NC = mt.__namecall
    local origNC = _HM_RESTORE_NC
    _HM_SetRW(mt, true)
    mt.__namecall = newcclosure(function(self, ...)
        local m = getnamecallmethod()
        if m ~= "FireServer" and m ~= "InvokeServer" then return origNC(self, ...) end
        if _HM_ACTIVE_REMOTES[self] then
            local a = {...}; local n = State.HookAmplifier
            if m == "FireServer" then
                for _ = 1, n do origNC(self, table.unpack(a)) end
            else
                for _ = 1, n do task.spawn(origNC, self, table.unpack(a)) end
            end
        end
        return origNC(self, ...)
    end)
    _HM_SetRW(mt, false)
    _HM_INSTALLED = true
end
local function _HM_Uninstall()
    if not _HM_INSTALLED or typeof(getrawmetatable) ~= "function" then return end
    local mt = getrawmetatable(game)
    _HM_SetRW(mt, true)
    if _HM_RESTORE_NC then mt.__namecall = _HM_RESTORE_NC; _HM_RESTORE_NC = nil end
    _HM_SetRW(mt, false)
    _HM_INSTALLED = false; _HM_ACTIVE_REMOTES = {}
end
local function _HM_SetActiveRemotes(r)
    _HM_ACTIVE_REMOTES = {}
    for _, x in ipairs(r) do if x and x.Parent then _HM_ACTIVE_REMOTES[x] = true end end
end

local function ExpandSimulation()
    if not State.SimHack then return end
    pcall(function()
        sethiddenproperty(Player, "SimulationRadius", 1e15)
        sethiddenproperty(Player, "MaxSimulationRadius", 1e15)
        settings().Physics.AllowSleep = false
        settings().Physics.ThrottleAdjustTime = 0
    end)
end
local function RestoreSimulation()
    pcall(function()
        sethiddenproperty(Player, "SimulationRadius", 1024)
        sethiddenproperty(Player, "MaxSimulationRadius", 1024)
        settings().Physics.AllowSleep = true
    end)
end

-- ═══ PIANO HELPERS ═══
local PIANO_KEYWORDS = {"piano","keyboard","keys","organ","synthesizer","grand","upright","key","music","sound","instrument","note","play"}
local function ContainsPianoKeyword(s)
    if not s then return false end
    s = s:lower()
    for _, kw in ipairs(PIANO_KEYWORDS) do if s:find(kw) then return true end end
    return false
end
local function ScanPianos()
    local found, seen = {}, {}
    for _, obj in ipairs(Workspace:GetDescendants()) do
        if (obj:IsA("Seat") or obj:IsA("VehicleSeat")) and not seen[obj] then
            local nm = ContainsPianoKeyword(obj.Name)
            local pm = obj.Parent and ContainsPianoKeyword(obj.Parent.Name)
            local gm = obj.Parent and obj.Parent.Parent and ContainsPianoKeyword(obj.Parent.Parent.Name)
            local hp = false
            if obj.Parent and obj.Parent:IsA("BasePart") then
                for _, c in ipairs(obj.Parent:GetChildren()) do
                    if c:IsA("ProximityPrompt") and (ContainsPianoKeyword(c.ActionText) or ContainsPianoKeyword(c.ObjectText)) then hp = true end
                end
            end
            if nm or pm or gm or hp then
                seen[obj] = true
                local pname = obj.Name
                local pmodel = obj.Parent
                for _ = 1, 3 do
                    if pmodel and pmodel ~= Workspace and pmodel:IsA("Model") then pname = pmodel.Name; break end
                    if pmodel then pmodel = pmodel.Parent end
                end
                table.insert(found, {
                    seat = obj, pos = obj.Position, name = pname,
                    label = string.format("[%d] %s [%d, %d, %d]", #found + 1, pname, math.floor(obj.Position.X), math.floor(obj.Position.Y), math.floor(obj.Position.Z))
                })
            end
        end
    end
    return found
end
local function FindAllPianoRemotes()
    local remotes = {}
    for _, obj in ipairs(RepStorage:GetDescendants()) do
        if obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction") then
            local n = obj.Name:lower()
            if n:find("piano") or n:find("note") or n:find("play") or n:find("music") or n:find("sound") then table.insert(remotes, obj) end
        end
    end
    if #remotes == 0 then
        local gpc = Workspace:FindFirstChild("GlobalPianoConnector")
        if gpc and (gpc:IsA("RemoteEvent") or gpc:IsA("RemoteFunction")) then table.insert(remotes, gpc) end
    end
    return remotes
end

-- ═══ PLAYER HELPERS ═══
local flyBV, flyBG, flyConn
local function ToggleFly(state)
    State.FlyEnabled = state
    local char = Player.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if state and hrp and hum then
        hum.PlatformStand = true
        flyBV = Instance.new("BodyVelocity", hrp); flyBV.MaxForce = Vector3.new(1e5,1e5,1e5); flyBV.Velocity = Vector3.zero
        flyBG = Instance.new("BodyGyro", hrp); flyBG.MaxTorque = Vector3.new(1e5,1e5,1e5); flyBG.P = 1000
        flyConn = RunService.RenderStepped:Connect(function()
            if not State.FlyEnabled then return end
            local cam = Workspace.CurrentCamera
            local mv = Vector3.zero
            if UIS:IsKeyDown(Enum.KeyCode.W) then mv += cam.CFrame.LookVector end
            if UIS:IsKeyDown(Enum.KeyCode.S) then mv -= cam.CFrame.LookVector end
            if UIS:IsKeyDown(Enum.KeyCode.A) then mv -= cam.CFrame.RightVector end
            if UIS:IsKeyDown(Enum.KeyCode.D) then mv += cam.CFrame.RightVector end
            if UIS:IsKeyDown(Enum.KeyCode.Space) then mv += Vector3.new(0,1,0) end
            if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then mv -= Vector3.new(0,1,0) end
            flyBV.Velocity = mv.Magnitude > 0 and mv.Unit * State.FlySpeed or Vector3.zero
            flyBG.CFrame = cam.CFrame
        end)
    else
        if flyConn then flyConn:Disconnect(); flyConn = nil end
        if flyBV then flyBV:Destroy(); flyBV = nil end
        if flyBG then flyBG:Destroy(); flyBG = nil end
        if hum then hum.PlatformStand = false end
    end
end
local function ApplySpeed()
    local hum = Player.Character and Player.Character:FindFirstChildOfClass("Humanoid")
    if hum then hum.WalkSpeed = State.SpeedEnabled and State.WalkSpeed or 16 end
end
local noclipConn
local function ToggleNoclip(state)
    State.NoclipEnabled = state
    if noclipConn then noclipConn:Disconnect(); noclipConn = nil end
    if state then
        noclipConn = RunService.Stepped:Connect(function()
            if not State.NoclipEnabled then return end
            local c = Player.Character; if not c then return end
            for _, p in ipairs(c:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide = false end end
        end)
    end
end
if UIS then
    UIS.InputBegan:Connect(function(input, gp)
        if gp then return end
        if input.KeyCode == State.FlyKeybind then ToggleFly(not State.FlyEnabled) end
    end)
end

-- ═══ LEVEL CONFIG ═══
local LEVEL_CFG = {}
local _base = {
    {c=14,b=0.00060,s=0.0016,l="WARM-UP"},{c=20,b=0.00050,s=0.0019,l="RISING"},
    {c=27,b=0.00040,s=0.0022,l="HEATING"},{c=34,b=0.00033,s=0.0024,l="AGGRESSIVE"},
    {c=42,b=0.00027,s=0.0026,l="STORM"},{c=54,b=0.00021,s=0.0028,l="OVERLOAD"},
    {c=68,b=0.00017,s=0.0030,l="BRUTAL"},{c=88,b=0.00013,s=0.0030,l="SAVAGE"},
    {c=114,b=0.00010,s=0.0030,l="CATASTROPHIC"},{c=150,b=0.00008,s=0.0030,l="EXTINCTION"},
}
for i = 1, 10 do LEVEL_CFG[i] = {conns=_base[i].c, budget=_base[i].b, sigBudget=_base[i].s, label="Lv."..i.." ".._base[i].l} end
local _ext = {"MASSACRE","CARNAGE","RAMPAGE","DEVASTATION","ANNIHILATION","OBLITERATION","ERADICATION","EXTERMINATION","TERMINATION","ARMAGEDDON","HELLFIRE","INFERNO","NAPALM","FIRESTORM","NUCLEAR","MELTDOWN","FALLOUT","SUPERNOVA","SINGULARITY","VOID COLLAPSE","ENTROPY","CHAOS THEORY","DARK MATTER","NEUTRON FLUX","GRAVITON","EVENT HORIZON","WARP CORE","ANTIMATTER","PLASMA SURGE","QUANTUM RIFT","ZERO-POINT","TEMPORAL FLUX","GAMMA BURST","X-RAY PULSE","NEUTRON STAR","PULSAR WAVE","BLACK HOLE","DARK ENERGY","TACHYON FLOOD","COSMIC RAY","ION STORM","PHOTON LANCE","NEUTRINO BLAST","MUON SURGE","QUARK STORM","SUBATOMIC","ZERO-KELVIN","ULTRAVIOLET","HYPERWAVE","DEATHWAVE","OMNISLASH","GODMODE","JUDGMENT","RECKONING","NO ESCAPE","FINAL FORM","ULTRA KILL","MEGADEATH","ABSOLUTE ZERO","GENOCIDE","ENDGAME","TERMINUS","OMEGA","SIGMA","APOCALYPSE NOW","CATACLYSM","RAPTURE","DOOMSDAY","HEAT DEATH","UNIVERSE END","SILENT KILLER","PHANTOM NUKE","GHOST PROTOCOL","DARK OPERATION","SHADOW COLLAPSE","MAXIMUM CARNAGE","REIGN OF CHAOS","ETERNAL STORM","IMMORTAL RAGE","SERVER DEATH","PURE CHAOS","RAW POWER","BRUTAL FORCE","NO MERCY","SYSTEM FAILURE"}
for i = 11, 100 do
    local t = (i - 10) / 90
    local conns = math.floor(150 + (2200 - 150) * (t ^ 0.7))
    local budget = 0.00008 * math.exp(-t * 6.4)
    LEVEL_CFG[i] = {conns=conns, budget=budget, sigBudget=0.0020, label="Lv."..i.." "..(_ext[i - 10] or "TIER "..i)}
end

-- ═══ MONOCHROME UI THEME ═══
local function RT(t) return tostring(t):gsub("(%d+)", '<font color="#00ff64">%1</font>') end
local function Apply3D(btn)
    local sh = Instance.new("Frame", btn); sh.Size = UDim2.new(1,0,1,0)
    sh.Position = UDim2.new(0,3,0,3); sh.BackgroundColor3 = Color3.fromRGB(0,0,0)
    sh.BackgroundTransparency = 0.4; sh.BorderSizePixel = 0; sh.ZIndex = btn.ZIndex - 1
    Instance.new("UICorner", sh).CornerRadius = UDim.new(0, 4)
    local hl = Instance.new("Frame", btn)
    hl.Size = UDim2.new(1,-4,0,3); hl.Position = UDim2.new(0,2,0,1)
    hl.BackgroundColor3 = Color3.fromRGB(255,255,255); hl.BackgroundTransparency = 0.7
    hl.BorderSizePixel = 0; hl.ZIndex = btn.ZIndex + 1
    Instance.new("UICorner", hl).CornerRadius = UDim.new(0, 2)
    local oS, oP = btn.Size, btn.Position
    btn.MouseButton1Down:Connect(function() btn.Size = UDim2.new(oS.X.Scale, oS.X.Offset-2, oS.Y.Scale, oS.Y.Offset-2); btn.Position = oP + UDim2.new(0,1,0,1) end)
    btn.MouseButton1Up:Connect(function() btn.Size = oS; btn.Position = oP end)
    btn.MouseLeave:Connect(function() btn.Size = oS; btn.Position = oP end)
end

local function MakeBtn(parent, text, pos, size, color)
    local b = Instance.new("TextButton", parent)
    b.Size = size or UDim2.new(1,0,0,32); b.Position = pos
    b.BackgroundColor3 = color or Color3.fromRGB(20,20,24)
    b.Text = text; b.TextColor3 = Color3.fromRGB(255,255,255)
    b.Font = Enum.Font.GothamBold; b.TextSize = 11; b.ZIndex = 7
    Instance.new("UICorner", b).CornerRadius = UDim.new(0,6)
    local s = Instance.new("UIStroke", b)
    s.Color = Color3.fromRGB(60,60,65); s.Thickness = 1
    Apply3D(b); return b
end
local function MakeLbl(parent, text, pos, size, color)
    local l = Instance.new("TextLabel", parent)
    l.Size = size or UDim2.new(1,0,0,18); l.Position = pos
    l.BackgroundTransparency = 1; l.RichText = true; l.Text = RT(text)
    l.TextColor3 = color or Color3.fromRGB(220,220,225)
    l.Font = Enum.Font.GothamMedium; l.TextSize = 11
    l.TextXAlignment = Enum.TextXAlignment.Left; l.ZIndex = 7
    return l
end
local function UHL(l, t) if l then l.Text = RT(t) end end

local function MakeSlider(parent, label, pos, mn, mx, def, cb)
    local l = Instance.new("TextLabel", parent)
    l.Size = UDim2.new(1,0,0,16); l.Position = pos; l.BackgroundTransparency = 1
    l.RichText = true; l.Text = RT(label..": "..def)
    l.TextColor3 = Color3.fromRGB(180,180,185); l.Font = Enum.Font.GothamMedium
    l.TextSize = 10; l.TextXAlignment = Enum.TextXAlignment.Left; l.ZIndex = 7
    local bar = Instance.new("Frame", parent)
    bar.Size = UDim2.new(1,0,0,14); bar.Position = pos + UDim2.new(0,0,0,18)
    bar.BackgroundColor3 = Color3.fromRGB(30,30,35); bar.ZIndex = 6
    Instance.new("UICorner", bar).CornerRadius = UDim.new(1,0)
    local bs = Instance.new("UIStroke", bar); bs.Color = Color3.fromRGB(60,60,65); bs.Thickness = 1; bs.Transparency = 0.5
    local fill = Instance.new("Frame", bar)
    fill.Size = UDim2.new((def-mn)/(mx-mn),0,1,0)
    fill.BackgroundColor3 = Color3.fromRGB(255,255,255); fill.BorderSizePixel = 0; fill.ZIndex = 7
    Instance.new("UICorner", fill).CornerRadius = UDim.new(1,0)
    local drag = false
    local function upd(i)
        local rel = math.clamp((i.Position.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
        local v = math.floor(mn + rel * (mx - mn))
        fill.Size = UDim2.new(rel,0,1,0); UHL(l, label..": "..v); cb(v)
    end
    bar.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then drag = true; upd(i) end end)
    UIS.InputChanged:Connect(function(i) if drag and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then upd(i) end end)
    UIS.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then drag = false end end)
end

local function MakeScrollPage(parent, name, vis)
    local sf = Instance.new("ScrollingFrame", parent)
    sf.Name = name; sf.Size = UDim2.new(1,0,1,0)
    sf.BackgroundTransparency = 1; sf.BorderSizePixel = 0
    sf.ScrollBarThickness = 3; sf.ScrollBarImageColor3 = Color3.fromRGB(100,100,105)
    sf.CanvasSize = UDim2.new(0,0,0,0); sf.Visible = vis or false
    sf.AutomaticCanvasSize = Enum.AutomaticSize.Y; sf.ZIndex = 7
    return sf
end

local function MakeDropdown(parent, label, options, default, callback, posY)
    local state = { value = default or options[1], open = false }
    local lbl = Instance.new("TextLabel", parent)
    lbl.Size = UDim2.new(1, 0, 0, 14); lbl.Position = UDim2.new(0, 0, 0, posY or 0)
    lbl.BackgroundTransparency = 1; lbl.Text = label
    lbl.TextColor3 = Color3.fromRGB(150, 150, 155); lbl.Font = Enum.Font.GothamMedium
    lbl.TextSize = 9; lbl.TextXAlignment = Enum.TextXAlignment.Left; lbl.ZIndex = 7
    local btn = Instance.new("TextButton", parent)
    btn.Size = UDim2.new(1, 0, 0, 28); btn.Position = UDim2.new(0, 0, 0, (posY or 0) + 16)
    btn.BackgroundColor3 = Color3.fromRGB(20, 20, 24)
    btn.Text = "  " .. tostring(state.value) .. " ▼"
    btn.TextColor3 = Color3.fromRGB(255, 255, 255); btn.Font = Enum.Font.GothamBold
    btn.TextSize = 11; btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.AutoButtonColor = false; btn.ZIndex = 7
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    local bs = Instance.new("UIStroke", btn); bs.Color = Color3.fromRGB(60, 60, 65); bs.Thickness = 1; bs.Transparency = 0.4
    local list = Instance.new("Frame", parent)
    list.Size = UDim2.new(1, 0, 0, 0); list.Position = UDim2.new(0, 0, 0, (posY or 0) + 48)
    list.BackgroundColor3 = Color3.fromRGB(15, 15, 18); list.BorderSizePixel = 0
    list.Visible = false; list.ClipsDescendants = true; list.ZIndex = 100
    Instance.new("UICorner", list).CornerRadius = UDim.new(0, 6)
    local ls = Instance.new("UIStroke", list); ls.Color = Color3.fromRGB(60, 60, 65); ls.Thickness = 1; ls.Transparency = 0.3
    local layout = Instance.new("UIListLayout", list)
    layout.Padding = UDim.new(0, 1); layout.SortOrder = Enum.SortOrder.LayoutOrder
    local ITEM_H = 24
    local function CloseList()
        state.open = false
        btn.Text = "  " .. tostring(state.value) .. " ▼"
        TweenService:Create(list, TweenInfo.new(0.15), {Size = UDim2.new(1, 0, 0, 0)}):Play()
        task.delay(0.16, function() if not state.open then list.Visible = false end end)
    end
    local function OpenList()
        state.open = true
        btn.Text = "  " .. tostring(state.value) .. " ▲"
        list.Visible = true
        TweenService:Create(list, TweenInfo.new(0.18), {Size = UDim2.new(1, 0, 0, #options * ITEM_H + 4)}):Play()
    end
    for i, opt in ipairs(options) do
        local it = Instance.new("TextButton", list)
        it.Size = UDim2.new(1, 0, 0, ITEM_H); it.Position = UDim2.new(0, 0, 0, (i - 1) * ITEM_H + 2)
        it.BackgroundColor3 = (opt == state.value) and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(25, 25, 30)
        it.Text = "  " .. tostring(opt)
        it.TextColor3 = (opt == state.value) and Color3.fromRGB(0, 0, 0) or Color3.fromRGB(220, 220, 220)
        it.Font = Enum.Font.GothamMedium; it.TextSize = 10
        it.TextXAlignment = Enum.TextXAlignment.Left; it.AutoButtonColor = false
        it.ZIndex = 101; it.LayoutOrder = i
        it.MouseEnter:Connect(function() if opt ~= state.value then it.BackgroundColor3 = Color3.fromRGB(40, 40, 45) end end)
        it.MouseLeave:Connect(function() it.BackgroundColor3 = (opt == state.value) and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(25, 25, 30) end)
        it.MouseButton1Click:Connect(function()
            state.value = opt
            for _, c in ipairs(list:GetChildren()) do
                if c:IsA("TextButton") then
                    local sel = (c.Text:gsub("^%s+", "") == tostring(opt))
                    c.BackgroundColor3 = sel and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(25, 25, 30)
                    c.TextColor3 = sel and Color3.fromRGB(0, 0, 0) or Color3.fromRGB(220, 220, 220)
                end
            end
            CloseList()
            if callback then pcall(callback, opt) end
        end)
    end
    btn.MouseButton1Click:Connect(function()
        if state.open then CloseList() else OpenList() end
    end)
    return { GetValue = function() return state.value end, Close = CloseList }
end
-- ═══ CREATEUI ═══
local function CreateUI()
    local pg = Player:WaitForChild("PlayerGui")
    local old = pg:FindFirstChild("HamaUniversalV3")
    if old then old:Destroy() end

    local gui = Instance.new("ScreenGui")
    gui.Name = "HamaUniversalV3"; gui.ResetOnSpawn = false
    gui.IgnoreGuiInset = false; gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    gui.DisplayOrder = 999; gui.Enabled = true; gui.Parent = pg
    _G.HamaGUI = gui

    local main = Instance.new("Frame", gui)
    main.Name = "Main"; main.AnchorPoint = Vector2.new(0.5, 0.5)
    main.Position = UDim2.new(0.5, 0, 0.5, 0); main.Size = UDim2.new(0, 560, 0, 380)
    main.BackgroundColor3 = Color3.fromRGB(8, 8, 10); main.BorderSizePixel = 0
    main.Active = true; main.ClipsDescendants = false; main.ZIndex = 5
    Instance.new("UICorner", main).CornerRadius = UDim.new(0, 10)

    -- ═══ AUTO SCALE UNTUK HP ═══
    local uiScale = Instance.new("UIScale", main)
    local function UpdateScale()
        if UIS.TouchEnabled and not UIS.KeyboardEnabled then
            -- Kalau di HP, maksa scale jadi 0.6 (biar muat)
            uiScale.Scale = 0.6
        else
            -- Kalau di PC, biarin normal (1.0)
            uiScale.Scale = 1
        end
    end
    UpdateScale()
    -- ═══ END AUTO SCALE ═══

    local sizeC = Instance.new("UISizeConstraint", main)
    sizeC.MaxSize = Vector2.new(640, 460); sizeC.MinSize = Vector2.new(420, 280)

    local glow = Instance.new("UIStroke", main)
    glow.Thickness = 1.5; glow.Color = Color3.fromRGB(60, 60, 65)
    glow.Transparency = 0.3; glow.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

    -- HEADER
    local header = Instance.new("Frame", main)
    header.Size = UDim2.new(1,0,0,40); header.BackgroundColor3 = Color3.fromRGB(5,5,8)
    header.BorderSizePixel = 0; header.Active = true; header.ZIndex = 6
    Instance.new("UICorner", header).CornerRadius = UDim.new(0,10)
    
    local title = Instance.new("TextLabel", header)
    title.Size = UDim2.new(1,-100,1,0); title.Position = UDim2.new(0,14,0,0)
    title.BackgroundTransparency = 1; title.Text = "HAMA UNIVERSAL V4.0"
    title.TextColor3 = Color3.fromRGB(255,255,255); title.Font = Enum.Font.GothamBold
    title.TextSize = 15; title.TextXAlignment = Enum.TextXAlignment.Left; title.ZIndex = 7
    
    local minBtn = Instance.new("TextButton", header)
    minBtn.Size = UDim2.new(0,28,0,28); minBtn.Position = UDim2.new(1,-64,0,6)
    minBtn.BackgroundColor3 = Color3.fromRGB(25,25,30); minBtn.Text = "—"
    minBtn.TextColor3 = Color3.fromRGB(255,255,255); minBtn.Font = Enum.Font.GothamBold; minBtn.TextSize = 16; minBtn.ZIndex = 7
    Instance.new("UICorner", minBtn).CornerRadius = UDim.new(0,6); Apply3D(minBtn)
    
    local closeBtn = Instance.new("TextButton", header)
    closeBtn.Size = UDim2.new(0,28,0,28); closeBtn.Position = UDim2.new(1,-32,0,6)
    closeBtn.BackgroundColor3 = Color3.fromRGB(200,50,50); closeBtn.Text = "X"
    closeBtn.TextColor3 = Color3.fromRGB(255,255,255); closeBtn.Font = Enum.Font.GothamBold; closeBtn.TextSize = 14; closeBtn.ZIndex = 7
    Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0,6); Apply3D(closeBtn)

       -- ═══ DRAG SYSTEM (PC & HP) ═══
       local dragging, dragStart, startPos = false, nil, nil
    
       header.InputBegan:Connect(function(i)
           if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
               -- Jangan drag kalau yang dipencet tombol Close (X) atau Minimize (—)
               if i.Position.X > header.AbsolutePosition.X + header.AbsoluteSize.X - 70 then return end
               dragging = true
               dragStart = i.Position
               startPos = main.Position
           end
       end)
   
       UIS.InputChanged:Connect(function(i)
           if dragging and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
               local delta = i.Position - dragStart
               main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
           end
       end)
   
       UIS.InputEnded:Connect(function(i) 
           if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then 
               dragging = false 
           end 
       end)
       -- ═══ END DRAG SYSTEM ═══

    -- SIDEBAR & CONTENT
    local sidebar = Instance.new("Frame", main)
    sidebar.Size = UDim2.new(0,100,1,-55); sidebar.Position = UDim2.new(0,8,0,48)
    sidebar.BackgroundTransparency = 1; sidebar.ZIndex = 6
    local sL = Instance.new("UIListLayout", sidebar); sL.Padding = UDim.new(0,4); sL.SortOrder = Enum.SortOrder.LayoutOrder

    local content = Instance.new("Frame", main)
    content.Size = UDim2.new(1,-120,1,-55); content.Position = UDim2.new(0,112,0,48)
    content.BackgroundTransparency = 1; content.ClipsDescendants = true; content.ZIndex = 6

    -- ═══ FIX LOGIC MINIMIZE (Tombol Terpisah) ═══
       -- ═══ FIX LOGIC MINIMIZE (Tombol Terpisah) ═══
       local miniGui = Instance.new("ScreenGui")
       miniGui.Name = "HamaMiniGui"
       miniGui.ResetOnSpawn = false
       miniGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
       miniGui.DisplayOrder = 1000 -- Biar di atas UI utama
       miniGui.Parent = pg
   
       local miniIcon = Instance.new("TextButton", miniGui) -- <-- Ganti parent jadi miniGui
    miniIcon.Name = "MiniIcon"
    miniIcon.Size = UDim2.new(0, 50, 0, 50)
    miniIcon.Position = UDim2.new(0, 50, 0, 50) -- Posisi awal
    miniIcon.BackgroundColor3 = Color3.fromRGB(8, 8, 10)
    miniIcon.Text = "H"
    miniIcon.TextColor3 = Color3.fromRGB(255, 255, 255)
    miniIcon.Font = Enum.Font.GothamBlack
    miniIcon.TextSize = 24
    miniIcon.ZIndex = 10
    miniIcon.Visible = false
        -- Bikin mini icon punya scale sendiri (biar gak gede di HP)
        local miniScale = Instance.new("UIScale", miniIcon)
        miniScale.Scale = uiScale.Scale -- Ngikutin scale UI utama
    Instance.new("UICorner", miniIcon).CornerRadius = UDim.new(1, 0)
    local miniStroke = Instance.new("UIStroke", miniIcon)
   miniStroke.Color = Color3.fromRGB(255, 255, 255); miniStroke.Thickness = 0

    local isMiniDragging = false
    local miniDragStart, miniStartPos = nil, nil

            -- Tombol Minimize (—) diklik
    minBtn.MouseButton1Click:Connect(function()
        gui.Enabled = false -- Matiin UI utama (tapi miniGui aman)
        miniIcon.Position = UDim2.new(0.5, 0, 0.5, 0) -- Munculin di tengah
        miniIcon.Visible = true
    end)

      -- Fitur Drag untuk Mini Icon
      miniIcon.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
            isMiniDragging = true
            miniDragStart = i.Position
            miniStartPos = miniIcon.Position
        end
    end)

    UIS.InputChanged:Connect(function(i)
        if isMiniDragging and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
            local d = i.Position - miniDragStart
            miniIcon.Position = UDim2.new(miniStartPos.X.Scale, miniStartPos.X.Offset + d.X, miniStartPos.Y.Scale, miniStartPos.Y.Offset + d.Y)
        end
    end)

    UIS.InputEnded:Connect(function(i)
        if isMiniDragging and (i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch) then
            isMiniDragging = false
            -- Kalau cuma diklik (bukan digeser)
            if (i.Position - miniDragStart).Magnitude < 5 then
                miniIcon.Visible = false
                gui.Enabled = true -- Nyalain lagi UI utama
                main.Position = UDim2.new(0.5, 0, 0.5, 0) -- Balikin ke tengah
            end
        end
    end)
    local tabs = {"PIANO","PLAYER","VOID","PHYSIC","FOREST","SERVER","SHIELD","ABOUT"}
    local tabBtns, pages = {}, {}
    for i, name in ipairs(tabs) do
        local b = Instance.new("TextButton", sidebar)
        b.Size = UDim2.new(1,0,0,26); b.BackgroundColor3 = Color3.fromRGB(20,20,25)
        b.Text = name; b.TextColor3 = Color3.fromRGB(220,220,225)
        b.Font = Enum.Font.GothamBold; b.TextSize = 10; b.LayoutOrder = i; b.ZIndex = 7
        Instance.new("UICorner", b).CornerRadius = UDim.new(0,6)
        local s = Instance.new("UIStroke", b); s.Color = Color3.fromRGB(50,50,55); s.Thickness = 1
        Apply3D(b); tabBtns[name] = b
    end
    
    local switchTab
    switchTab = function(name)
        for n, b in pairs(tabBtns) do
            b.BackgroundColor3 = n == name and Color3.fromRGB(255,255,255) or Color3.fromRGB(20,20,25)
            b.TextColor3 = n == name and Color3.fromRGB(0,0,0) or Color3.fromRGB(220,220,225)
        end
        for n, p in pairs(pages) do p.Visible = (n == name) end
    end
    for _, name in ipairs(tabs) do
        tabBtns[name].MouseButton1Click:Connect(function() switchTab(name) end)
    end

    -- ═══ TAB PIANO ═══
    local pagePiano = MakeScrollPage(content, "PIANO", true)
    pages["PIANO"] = pagePiano
    do
        local Spam = {Running=false, Gen=0, FireCount=0, Connections={}, RateCount=0, RateWin=os.clock(), SelectedRemotes={}, KeyPool={}, Format="positional"}
        local counterLbl
        
        _StopSpam = function()
            Spam.Running = false; Spam.Gen = Spam.Gen + 1
            for _, c in ipairs(Spam.Connections) do pcall(function() c:Disconnect() end) end
            Spam.Connections = {}
            _HM_Uninstall(); RestoreSimulation()
            if counterLbl then UHL(counterLbl, "Fires: " .. Spam.FireCount) end
        end
        
        local function BuildKeyPool()
            local pool = {}; local mult = math.max(1, math.floor(State.KeyMult))
            for i = 1, 61 do for _ = 1, mult do table.insert(pool, i) end end
            return pool
        end
        
        local function BuildFireUnit(remotes, fmt)
            local ve, vf = {}, {}
            for _, r in ipairs(remotes) do
                if r and r.Parent then
                    if r:IsA("RemoteEvent") then ve[#ve+1] = r
                    elseif r:IsA("RemoteFunction") then vf[#vf+1] = r end
                end
            end
            local nE, nF = #ve, #vf
            if nE == 0 and nF == 0 then return function() return 0 end end
            if fmt == "positional" then
                return function(k)
                    local f = 0
                    for i = 1, nE do local e = ve[i]; if e.Parent then e:FireServer("play", k); f = f + 1 end end
                    for i = 1, nF do local fn = vf[i]; if fn.Parent then task.spawn(fn.InvokeServer, fn, "play", k); f = f + 1 end end
                    return f
                end
            else
                return function(k)
                    local p = {play=true, action="play", key=k, note=k, index=k, value=k}
                    local f = 0
                    for i = 1, nE do local e = ve[i]; if e.Parent then e:FireServer(p); f = f + 1 end end
                    for i = 1, nF do local fn = vf[i]; if fn.Parent then task.spawn(fn.InvokeServer, fn, p); f = f + 1 end end
                    return f
                end
            end
        end
        
        local StartSpam
StartSpam = function()
    local myName = Player.Name
    
    local isMeDev = (getgenv().PRIORITY and getgenv().PRIORITY.DevUsers[myName]) or (_WL_DEV_SET and _WL_DEV_SET[myName])
    local isMePrem = (getgenv().PRIORITY and getgenv().PRIORITY.PremiumUsers[myName]) or (_WL_PREM_SET and _WL_PREM_SET[myName])

    local hasDev = false
    local hasPrem = false
    local premName = ""

    for _, pl in ipairs(Players:GetPlayers()) do
        if pl ~= Player then
            local oD = (getgenv().PRIORITY and getgenv().PRIORITY.DevUsers[pl.Name]) or (_WL_DEV_SET and _WL_DEV_SET[pl.Name])
            local oP = (getgenv().PRIORITY and getgenv().PRIORITY.PremiumUsers[pl.Name]) or (_WL_PREM_SET and _WL_PREM_SET[pl.Name])
            if oD then hasDev = true end
            if oP then hasPrem = true; premName = pl.Name end
        end
    end

    -- ═══ LOGIKA: KALAU PREMIUM NGE-LAG PAS ADA DEV, YANG REJOIN PREMIUM-NYA ═══
    if isMePrem and not isMeDev then
        if hasDev then
            warn("[SATPAM] Kamu Premium, ada DEV di server! Auto-Rejoin...")
            -- Paksa Client Premium ini buat Rejoin
            pcall(function()
                if getgenv().HAMA_DoRejoin then getgenv().HAMA_DoRejoin("Dev in server")
                else game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, Player) end
            end)
            return -- Hentikan script, jangan lanjut spam
        end
        
        if hasPrem then
            -- Notifikasi UI kalau ada sesama PREM
            local pg = Player:FindFirstChild("PlayerGui")
            local n = Instance.new("ScreenGui", pg)
            n.Name = "HAMA_Notif"; n.ResetOnSpawn = false
            local f = Instance.new("Frame", n)
            f.Size = UDim2.new(0, 250, 0, 60); f.Position = UDim2.new(0.5, -125, 0.1, 0)
            f.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
            Instance.new("UICorner", f).CornerRadius = UDim.new(0, 8)
            Instance.new("UIStroke", f).Color = Color3.fromRGB(255, 60, 60)
            local t = Instance.new("TextLabel", f)
            t.Size = UDim2.new(1, -10, 1, -10); t.Position = UDim2.new(0, 5, 0, 5)
            t.BackgroundTransparency = 1; t.Text = "❌ Tidak bisa spam!\nAda temanmu ("..premName..") di server ini."
            t.TextColor3 = Color3.fromRGB(255, 255, 255); t.Font = Enum.Font.GothamBold; t.TextSize = 11; t.TextWrapped = true
            task.delay(3, function() n:Destroy() end)
            return
        end
    end

    -- Lanjut ke kode spam asli lu...
    if not State.IsWhitelisted and Player.Name ~= State.OwnerName then return end
    -- (biarin sisa kode StartSpam lu yang lama di bawahnya)
            if getgenv().PRIORITY and getgenv().PRIORITY.Enabled then
                local P = getgenv().PRIORITY
                local isDev = getgenv().HAMA_IsLocalDev and getgenv().HAMA_IsLocalDev() or false
                local isPrem = getgenv().HAMA_IsLocalPremium and getgenv().HAMA_IsLocalPremium() or false
                local hasDev = getgenv().HAMA_IsDevInServer and getgenv().HAMA_IsDevInServer(true) or false
                local hasPrem = getgenv().HAMA_IsPremiumInServer and getgenv().HAMA_IsPremiumInServer(true) or false
                if not isDev then
                    if hasDev then warn("[HAMA] DEV in server. Spam blocked."); return end
                    if hasPrem and not isPrem then warn("[HAMA] PREMIUM in server. Spam blocked."); return end
                end
            end
            local valid = {}
            for _, r in ipairs(Spam.SelectedRemotes) do if r and r.Parent then valid[#valid+1] = r end end
            if #valid == 0 then warn("[HAMA] Pilih remote dulu!"); return end
            local hum = Player.Character and Player.Character:FindFirstChildOfClass("Humanoid")
            if not hum or not hum.Sit then warn("[HAMA] Duduk dulu di piano!"); return end
            _StopSpam()
            _HM_SetActiveRemotes(valid); _HM_Install(); ExpandSimulation()
            Spam.Running = true; Spam.FireCount = 0; Spam.Gen = Spam.Gen + 1
            Spam.RateCount = 0; Spam.RateWin = os.clock()
            local gen = Spam.Gen
            local cap = math.max(1, math.min(100, State.Level))
            local cfg = LEVEL_CFG[cap]
            local phaseBudget = math.min((cfg.conns / 4) * cfg.budget, cfg.sigBudget)
            local rateCap = tonumber(getgenv().HAMA_RATE_CAP) or 150000
            Spam.KeyPool = BuildKeyPool()
            local fireUnit = BuildFireUnit(valid, Spam.Format)
            local keyPool = Spam.KeyPool; local nK = #keyPool
            local phases = {RunService.Heartbeat, RunService.Stepped, RunService.PreSimulation, RunService.PostSimulation}
            local function firePhase()
                if not Spam.Running or Spam.Gen ~= gen or Spam.RateCount >= rateCap then return end
                local dl = os.clock() + phaseBudget
                local f = 0
                repeat
                    for ki = 1, nK do f = f + fireUnit(keyPool[ki]) end
                    if os.clock() >= dl then break end
                until Spam.RateCount + f >= rateCap
                Spam.FireCount = Spam.FireCount + f
                Spam.RateCount = Spam.RateCount + f
            end
            for _, s in ipairs(phases) do
                local ok, c = pcall(function() return s:Connect(firePhase) end)
                if ok and c then table.insert(Spam.Connections, c) end
            end
            local last = 0
            local c = RunService.Heartbeat:Connect(function()
                local now = os.clock()
                if now - Spam.RateWin >= 1 then Spam.RateWin = now; Spam.RateCount = 0 end
                if now - last >= 0.2 then
                    last = now
                    if counterLbl and counterLbl.Parent then UHL(counterLbl, "Fires: " .. Spam.FireCount) end
                end
            end)
            table.insert(Spam.Connections, c)
            print("[HAMA] Spam ACTIVE: " .. cfg.label)
        end

        local scanBtn = MakeBtn(pagePiano, "SCAN REMOTES", UDim2.new(0,0,0,0), UDim2.new(0.48,-2,0,32), Color3.fromRGB(25,25,30))
        local scanPianoBtn = MakeBtn(pagePiano, "SCAN PIANO", UDim2.new(0.52,2,0,0), UDim2.new(0.48,-2,0,32), Color3.fromRGB(25,25,30))
        local remoteListLbl = MakeLbl(pagePiano, "Remote List (klik max 2):", UDim2.new(0,0,0,36), UDim2.new(1,0,0,16), Color3.fromRGB(200,200,205))
        remoteListLbl.TextSize = 10
        local remoteList = Instance.new("ScrollingFrame", pagePiano)
        remoteList.Size = UDim2.new(1,0,0,70); remoteList.Position = UDim2.new(0,0,0,54)
        remoteList.BackgroundColor3 = Color3.fromRGB(10,10,12); remoteList.BorderSizePixel = 0
        remoteList.ScrollBarThickness = 2; remoteList.ZIndex = 7
        Instance.new("UICorner", remoteList).CornerRadius = UDim.new(0,6)
        Instance.new("UIListLayout", remoteList).Padding = UDim.new(0,2)
        
        local pianoListLbl = MakeLbl(pagePiano, "Piano Found:", UDim2.new(0,0,0,128), UDim2.new(1,0,0,16), Color3.fromRGB(200,200,205))
        pianoListLbl.TextSize = 10
        local pianoList = Instance.new("ScrollingFrame", pagePiano)
        pianoList.Size = UDim2.new(1,0,0,50); pianoList.Position = UDim2.new(0,0,0,146)
        pianoList.BackgroundColor3 = Color3.fromRGB(10,10,12); pianoList.BorderSizePixel = 0
        pianoList.ScrollBarThickness = 2; pianoList.ZIndex = 7
        Instance.new("UICorner", pianoList).CornerRadius = UDim.new(0,6)
        Instance.new("UIListLayout", pianoList).Padding = UDim.new(0,2)

        MakeSlider(pagePiano, "Level (1-100)", UDim2.new(0,0,0,204), 1, 100, 10, function(v) State.Level = v end)
        MakeSlider(pagePiano, "Threads (1-8000)", UDim2.new(0,0,0,244), 1, 8000, 10, function(v) State.Threads = v end)
        MakeSlider(pagePiano, "Key Mult (1-100)", UDim2.new(0,0,0,284), 1, 100, 1, function(v) State.KeyMult = v end)
        MakeSlider(pagePiano, "Hook Amp (1-50x)", UDim2.new(0,0,0,324), 1, 50, 20, function(v) State.HookAmplifier = v end)
        
        local modeDropdown = MakeDropdown(pagePiano, "Attack Mode", 
            {"Random", "Sequential", "Chromatic", "Burst Chord", "NUKE", "White Flood", "Black Flood", "Chaos", "Thunderclap"},
            "NUKE", 
            function(val)
                local map = {
                    ["Random"] = "random", ["Sequential"] = "sequential", ["Chromatic"] = "chromatic",
                    ["Burst Chord"] = "chord", ["NUKE"] = "nuke", ["White Flood"] = "whiteflood",
                    ["Black Flood"] = "blackflood", ["Chaos"] = "chaos", ["Thunderclap"] = "thunderclap"
                }
                State.Mode = map[val] or "random"
            end, 
            364
        )
        
        counterLbl = MakeLbl(pagePiano, "Fires: 0", UDim2.new(0.52,2,0,364), UDim2.new(0.48,-2,0,32), Color3.fromRGB(255,255,255))
        counterLbl.BackgroundColor3 = Color3.fromRGB(15,15,18); counterLbl.BackgroundTransparency = 0
        counterLbl.TextXAlignment = Enum.TextXAlignment.Center
        Instance.new("UICorner", counterLbl).CornerRadius = UDim.new(0,6)
        
        local startBtn = MakeBtn(pagePiano, "🔥 START SPAM", UDim2.new(0,0,0,406), UDim2.new(0.48,-2,0,34), Color3.fromRGB(25,25,30))
        local stopBtn = MakeBtn(pagePiano, "■ STOP", UDim2.new(0.52,2,0,406), UDim2.new(0.48,-2,0,34), Color3.fromRGB(25,25,30))
        
        local fmtDropdown = MakeDropdown(pagePiano, "Remote Format", 
            {"Positional (\"play\", key)", "Table {play=true, key}"},
            "Positional (\"play\", key)", 
            function(val)
                Spam.Format = val:find("Table") and "table" or "positional"
            end, 
            448
        )
        
        local rejoinBtn = MakeBtn(pagePiano, "🔄 REJOIN", UDim2.new(0,0,0,486), UDim2.new(1,0,0,32), Color3.fromRGB(25,25,30))
        rejoinBtn.MouseButton1Click:Connect(function()
            _StopSpam()
            task.delay(0.4, function()
                pcall(function()
                    local jid = game.JobId
                    if jid and jid ~= "" then
                        Services.TeleportService:TeleportToPlaceInstance(game.PlaceId, jid, Player)
                    else
                        Services.TeleportService:Teleport(game.PlaceId, Player)
                    end
                end)
            end)
        end)

        scanBtn.MouseButton1Click:Connect(function()
            pcall(function()
                local remotes = FindAllPianoRemotes()
                for _, c in ipairs(remoteList:GetChildren()) do if c:IsA("TextButton") then c:Destroy() end end
                if #remotes == 0 then UHL(remoteListLbl, "❌ No remote"); return end
                UHL(remoteListLbl, "Remote List (" .. #remotes .. " found):")
                Spam.SelectedRemotes = {remotes[1]}
                for i, r in ipairs(remotes) do
                    local b = Instance.new("TextButton", remoteList)
                    b.Size = UDim2.new(1,-4,0,26); b.Position = UDim2.new(0,2,0,(i-1)*28)
                    b.BackgroundColor3 = (i==1) and Color3.fromRGB(255,255,255) or Color3.fromRGB(20,20,25)
                    b.Text = "  [" .. r.ClassName .. "] " .. r:GetFullName()
                    b.TextColor3 = (i==1) and Color3.fromRGB(0,0,0) or Color3.fromRGB(220,220,225); b.Font = Enum.Font.GothamMedium
                    b.TextSize = 9; b.TextXAlignment = Enum.TextXAlignment.Left; b.ZIndex = 8
                    Instance.new("UICorner", b).CornerRadius = UDim.new(0,4)
                    b.MouseButton1Click:Connect(function()
                        local ex = nil
                        for si, x in ipairs(Spam.SelectedRemotes) do if x == r then ex = si; break end end
                        if ex then table.remove(Spam.SelectedRemotes, ex)
                        else
                            if #Spam.SelectedRemotes < 2 then table.insert(Spam.SelectedRemotes, r)
                            else Spam.SelectedRemotes[2] = r end
                        end
                        for _, c in ipairs(remoteList:GetChildren()) do if c:IsA("TextButton") then c.BackgroundColor3 = Color3.fromRGB(20,20,25) end end
                        for si, x in ipairs(Spam.SelectedRemotes) do
                            for _, c in ipairs(remoteList:GetChildren()) do
                                if c:IsA("TextButton") and c.Text:find(x.Name, 1, true) then
                                    c.BackgroundColor3 = Color3.fromRGB(255,255,255); c.TextColor3 = Color3.fromRGB(0,0,0)
                                end
                            end
                        end
                        _HM_SetActiveRemotes(Spam.SelectedRemotes)
                    end)
                end
                remoteList.CanvasSize = UDim2.new(0,0,0,#remotes*28+4)
                _HM_SetActiveRemotes(Spam.SelectedRemotes)
            end)
        end)
        
        scanPianoBtn.MouseButton1Click:Connect(function()
            pcall(function()
                State.FoundPianos = ScanPianos()
                for _, c in ipairs(pianoList:GetChildren()) do if c:IsA("TextButton") then c:Destroy() end end
                if #State.FoundPianos == 0 then UHL(pianoListLbl, "❌ No piano"); return end
                UHL(pianoListLbl, "Piano Found (" .. #State.FoundPianos .. "):")
                for i, p in ipairs(State.FoundPianos) do
                    local b = Instance.new("TextButton", pianoList)
                    b.Size = UDim2.new(1,-4,0,24); b.Position = UDim2.new(0,2,0,(i-1)*26)
                    b.BackgroundColor3 = Color3.fromRGB(20,20,25); b.Text = "  " .. p.label
                    b.TextColor3 = Color3.fromRGB(220,220,225); b.Font = Enum.Font.GothamMedium
                    b.TextSize = 9; b.TextXAlignment = Enum.TextXAlignment.Left; b.ZIndex = 8
                    Instance.new("UICorner", b).CornerRadius = UDim.new(0,4)
                    b.MouseButton1Click:Connect(function()
                        State.SelectedPiano = p
                        for _, c in ipairs(pianoList:GetChildren()) do if c:IsA("TextButton") then c.BackgroundColor3 = Color3.fromRGB(20,20,25) end end
                        b.BackgroundColor3 = Color3.fromRGB(255,255,255); b.TextColor3 = Color3.fromRGB(0,0,0)
                        local hrp = Player.Character and Player.Character:FindFirstChild("HumanoidRootPart")
                        if hrp and p.seat then
                            hrp.CFrame = CFrame.new(p.pos + Vector3.new(0,4,0))
                            task.wait(0.25)
                            local hum = Player.Character:FindFirstChildOfClass("Humanoid")
                            if hum and p.seat:IsA("Seat") then pcall(function() p.seat:Sit(hum) end) end
                        end
                    end)
                end
                pianoList.CanvasSize = UDim2.new(0,0,0,#State.FoundPianos*26+4)
            end)
        end)
        
        startBtn.MouseButton1Click:Connect(StartSpam)
        stopBtn.MouseButton1Click:Connect(_StopSpam)
        getgenv()._HAMA_StopSpam = _StopSpam
    end

    -- ═══ TAB PLAYER ═══
    local pagePlayer = MakeScrollPage(content, "PLAYER", false)
    pages["PLAYER"] = pagePlayer
    do
        local speedBtn = MakeBtn(pagePlayer, "SPEED: OFF", UDim2.new(0,0,0,0), UDim2.new(1,0,0,32), Color3.fromRGB(25,25,30))
        local sTog = false
        speedBtn.MouseButton1Click:Connect(function()
            sTog = not sTog; State.SpeedEnabled = sTog
            speedBtn.Text = "SPEED: " .. (sTog and "ON" or "OFF")
            speedBtn.BackgroundColor3 = sTog and Color3.fromRGB(255,255,255) or Color3.fromRGB(25,25,30)
            speedBtn.TextColor3 = sTog and Color3.fromRGB(0,0,0) or Color3.fromRGB(255,255,255)
            ApplySpeed()
        end)
        MakeSlider(pagePlayer, "WalkSpeed", UDim2.new(0,0,0,44), 16, 500, 16, function(v) State.WalkSpeed = v; if State.SpeedEnabled then ApplySpeed() end end)
        
        local flyBtn = MakeBtn(pagePlayer, "FLY: OFF", UDim2.new(0,0,0,84), UDim2.new(0.48,-2,0,32), Color3.fromRGB(25,25,30))
        flyBtn.MouseButton1Click:Connect(function()
            ToggleFly(not State.FlyEnabled)
            flyBtn.Text = "FLY: " .. (State.FlyEnabled and "ON" or "OFF")
            flyBtn.BackgroundColor3 = State.FlyEnabled and Color3.fromRGB(255,255,255) or Color3.fromRGB(25,25,30)
            flyBtn.TextColor3 = State.FlyEnabled and Color3.fromRGB(0,0,0) or Color3.fromRGB(255,255,255)
        end)
        
        local kbBtn = MakeBtn(pagePlayer, "Keybind: F", UDim2.new(0.52,2,0,84), UDim2.new(0.48,-2,0,32), Color3.fromRGB(40,40,45))
        kbBtn.MouseButton1Click:Connect(function()
            kbBtn.Text = "Press key..."
            local conn
            conn = UIS.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.Keyboard then
                    State.FlyKeybind = input.KeyCode
                    kbBtn.Text = "Keybind: " .. input.KeyCode.Name
                    conn:Disconnect()
                end
            end)
        end)
        
        MakeSlider(pagePlayer, "Fly Speed", UDim2.new(0,0,0,124), 10, 200, 50, function(v) State.FlySpeed = v end)
        
        local noclipBtn = MakeBtn(pagePlayer, "NOCLIP: OFF", UDim2.new(0,0,0,164), UDim2.new(0.48,-2,0,32), Color3.fromRGB(25,25,30))
        noclipBtn.MouseButton1Click:Connect(function()
            ToggleNoclip(not State.NoclipEnabled)
            noclipBtn.Text = "NOCLIP: " .. (State.NoclipEnabled and "ON" or "OFF")
            noclipBtn.BackgroundColor3 = State.NoclipEnabled and Color3.fromRGB(255,255,255) or Color3.fromRGB(25,25,30)
            noclipBtn.TextColor3 = State.NoclipEnabled and Color3.fromRGB(0,0,0) or Color3.fromRGB(255,255,255)
        end)
        
        local invisBtn = MakeBtn(pagePlayer, "INVISIBLE → VOID TAB", UDim2.new(0.52,2,0,164), UDim2.new(0.48,-2,0,32), Color3.fromRGB(40,40,45))
        invisBtn.MouseButton1Click:Connect(function() switchTab("VOID") end)
    end
         -- ═══ TAB VOID ═══
     local pageVoid = MakeScrollPage(content, "VOID", false)
     pages["VOID"] = pageVoid
     do
         local VOID = {VoidDropEnabled=false, VoidDropConn=nil, VoidDropOrigCF=nil,
             VXZ=2^26*30000000, VY=2^26*30000000,
             VoidTrapActive=false, VTPNoclip=nil, VTPDesc=nil, VTPOrigCF=nil, VTPGodSt=nil, VTPDied=nil, VTPHit=nil,
             VT_SPEED=20, VT_NOCLIP={HumanoidRootPart=true,Torso=true,UpperTorso=true,LowerTorso=true,Head=true},
             Markers={}}
         local voidTitle = MakeLbl(pageVoid, "🕳️ VOID DROP", UDim2.new(0,0,0,0), UDim2.new(1,0,0,20), Color3.fromRGB(255,255,255))
         voidTitle.TextSize = 14
         local voidSub = MakeLbl(pageVoid, "Void Drop • Void Trap • Stealth Invisible", UDim2.new(0,0,0,22), UDim2.new(1,0,0,16), Color3.fromRGB(150,150,155))
         voidSub.TextSize = 10
         
         local function StartVD()
             local c = Player.Character; local r = c and c:FindFirstChild("HumanoidRootPart")
             if not r then return false end
             VOID.VoidDropOrigCF = r.CFrame
             local vCF = CFrame.new(VOID.VXZ, VOID.VY, VOID.VXZ) * (VOID.VoidDropOrigCF - VOID.VoidDropOrigCF.Position)
             task.spawn(function() r.CFrame = vCF end)
             VOID.VoidDropConn = RunService.Heartbeat:Connect(function()
                 pcall(function()
                     local cc = Player.Character; local rr = cc and cc:FindFirstChild("HumanoidRootPart")
                     if not rr then return end
                     rr.CFrame = vCF; rr.AssemblyLinearVelocity = Vector3.zero; rr.AssemblyAngularVelocity = Vector3.zero
                 end)
             end)
             local m = Instance.new("Part"); m.Name = "VoidMarker"; m.Size = Vector3.new(4,1,4)
             m.Anchored = true; m.CanCollide = false; m.Transparency = 0.5
             m.Color = Color3.fromRGB(255,255,255); m.Material = Enum.Material.Neon
             m.CFrame = vCF; m.Parent = Workspace; VOID.Markers.VD = m
             return true
         end
         local function StopVD()
             if VOID.VoidDropConn then VOID.VoidDropConn:Disconnect(); VOID.VoidDropConn = nil end
             local c = Player.Character; local r = c and c:FindFirstChild("HumanoidRootPart")
             local riders = {}; local mp = r and r.Position
             if mp then
                 for _, pl in ipairs(Players:GetPlayers()) do
                     if pl ~= Player and pl.Character then
                         local pr = pl.Character:FindFirstChild("HumanoidRootPart")
                         if pr and (pr.Position - mp).Magnitude < 20 then table.insert(riders, pr) end
                     end
                 end
             end
             if r and VOID.VoidDropOrigCF then
                 task.spawn(function() r.CFrame = VOID.VoidDropOrigCF end)
                 if #riders > 0 then
                     local pin = CFrame.new(VOID.VXZ, VOID.VY, VOID.VXZ)
                     task.spawn(function()
                         for _ = 1, 5 do task.wait(); for _, rr in ipairs(riders) do pcall(function() rr.CFrame = pin end) end end
                     end)
                 end
             end
             if VOID.Markers.VD then pcall(function() VOID.Markers.VD:Destroy() end); VOID.Markers.VD = nil end
         end
         
         local function VT_NoclipStart()
             if VOID.VTPNoclip then return end
             VOID.VTPNoclip = RunService.Stepped:Connect(function()
                 if not VOID.VoidTrapActive then return end
                 local ch = Player.Character; if not ch then return end
                 for _, v in ipairs(ch:GetDescendants()) do
                     if v:IsA("BasePart") and VOID.VT_NOCLIP[v.Name] then v.CanCollide = false end
                 end
             end)
         end
         local function VT_NoclipStop()
             if VOID.VTPNoclip then VOID.VTPNoclip:Disconnect(); VOID.VTPNoclip = nil end
             local ch = Player.Character
             if ch then for _, v in ipairs(ch:GetDescendants()) do
                 if v:IsA("BasePart") and VOID.VT_NOCLIP[v.Name] then v.CanCollide = true end
             end end
         end
         local function VT_DescStart()
             if VOID.VTPDesc then return end
             VOID.VTPDesc = RunService.Heartbeat:Connect(function()
                 if not VOID.VoidTrapActive then return end
                 local c = Player.Character; local r = c and c:FindFirstChild("HumanoidRootPart")
                 if not r then return end
                 r.CFrame = r.CFrame * CFrame.new(0, -VOID.VT_SPEED, 0)
             end)
         end
         local function VT_DescStop() if VOID.VTPDesc then VOID.VTPDesc:Disconnect(); VOID.VTPDesc = nil end end
         local function VT_HitStart()
             if VOID.VTPHit then return end
             VOID.VTPHit = RunService.Stepped:Connect(function()
                 if not VOID.VoidTrapActive then return end
                 local c = Player.Character; if not c then return end
                 for _, v in ipairs(c:GetDescendants()) do
                     if v:IsA("BasePart") then
                         if v.CanCollide then v.CanCollide = false end
                         if v.CanTouch then v.CanTouch = false end
                     end
                 end
             end)
         end
         local function VT_HitStop()
             if VOID.VTPHit then VOID.VTPHit:Disconnect(); VOID.VTPHit = nil end
             local c = Player.Character
             if c then for _, v in ipairs(c:GetDescendants()) do
                 if v:IsA("BasePart") then pcall(function() v.CanCollide = true; v.CanTouch = true end) end
             end end
         end
         local function VT_GodApply(h)
             if not h then return end
             pcall(function()
                 h.MaxHealth = 1e308; h.Health = 1e308
                 h:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
                 h:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
                 h:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
                 h.BreakJointsOnDeath = false
             end)
             if VOID.VTPGodSt then pcall(function() VOID.VTPGodSt:Disconnect() end) end
             VOID.VTPGodSt = h.StateChanged:Connect(function(_, ns)
                 if not VOID.VoidTrapActive then return end
                 if ns == Enum.HumanoidStateType.Dead or ns == Enum.HumanoidStateType.Ragdoll or ns == Enum.HumanoidStateType.FallingDown then
                     pcall(function() h:SetStateEnabled(ns, false); h:ChangeState(Enum.HumanoidStateType.GettingUp) end)
                 end
             end)
         end
         local function VT_GodRemove(h)
             if VOID.VTPGodSt then pcall(function() VOID.VTPGodSt:Disconnect() end); VOID.VTPGodSt = nil end
             if not h then return end
             pcall(function()
                 h.MaxHealth = 100; h.Health = 100
                 h:SetStateEnabled(Enum.HumanoidStateType.Dead, true)
                 h:SetStateEnabled(Enum.HumanoidStateType.FallingDown, true)
                 h:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, true)
                 h.BreakJointsOnDeath = true
             end)
         end
         local function VT_FullStop(tp)
             VOID.VoidTrapActive = false
             if VOID.VTPDied then pcall(function() VOID.VTPDied:Disconnect() end); VOID.VTPDied = nil end
             VT_DescStop(); VT_NoclipStop(); VT_HitStop()
             local c = Player.Character; local h = c and c:FindFirstChildOfClass("Humanoid")
             local r = c and c:FindFirstChild("HumanoidRootPart")
             VT_GodRemove(h)
             if tp and r and VOID.VTPOrigCF then task.spawn(function() r.CFrame = VOID.VTPOrigCF end) end
             VOID.VTPOrigCF = nil
         end
         
         local vdBtn = MakeBtn(pageVoid, "VOID DROP: OFF", UDim2.new(0,0,0,58), UDim2.new(1,0,0,32), Color3.fromRGB(25,25,30))
         vdBtn.MouseButton1Click:Connect(function()
             VOID.VoidDropEnabled = not VOID.VoidDropEnabled
             if VOID.VoidDropEnabled then
                 if StartVD() then
                     vdBtn.Text = "VOID DROP: ON"; vdBtn.BackgroundColor3 = Color3.fromRGB(255,255,255); vdBtn.TextColor3 = Color3.fromRGB(0,0,0)
                 else VOID.VoidDropEnabled = false end
             else
                 StopVD(); vdBtn.Text = "VOID DROP: OFF"; vdBtn.BackgroundColor3 = Color3.fromRGB(25,25,30); vdBtn.TextColor3 = Color3.fromRGB(255,255,255)
             end
         end)
         
         local vtBtn = MakeBtn(pageVoid, "VOID TRAP: OFF", UDim2.new(0,0,0,116), UDim2.new(1,0,0,32), Color3.fromRGB(25,25,30))
         vtBtn.MouseButton1Click:Connect(function()
             VOID.VoidTrapActive = not VOID.VoidTrapActive
             local c = Player.Character; local h = c and c:FindFirstChildOfClass("Humanoid")
             local r = c and c:FindFirstChild("HumanoidRootPart")
             if VOID.VoidTrapActive then
                 if not r then VOID.VoidTrapActive = false; return end
                 VOID.VTPOrigCF = r.CFrame
                 VT_NoclipStart(); VT_DescStart(); VT_HitStart(); VT_GodApply(h)
                 if h then
                     if VOID.VTPDied then pcall(function() VOID.VTPDied:Disconnect() end) end
                     VOID.VTPDied = h.Died:Connect(function()
                         VT_FullStop(false); vtBtn.Text = "VOID TRAP: OFF"; vtBtn.BackgroundColor3 = Color3.fromRGB(25,25,30); vtBtn.TextColor3 = Color3.fromRGB(255,255,255)
                     end)
                 end
                 vtBtn.Text = "VOID TRAP: ON"; vtBtn.BackgroundColor3 = Color3.fromRGB(255,255,255); vtBtn.TextColor3 = Color3.fromRGB(0,0,0)
             else
                 VT_FullStop(true); vtBtn.Text = "VOID TRAP: OFF"; vtBtn.BackgroundColor3 = Color3.fromRGB(25,25,30); vtBtn.TextColor3 = Color3.fromRGB(255,255,255)
             end
         end)
         
         local stealthBtn = MakeBtn(pageVoid, "INVISIBLE (FE): OFF", UDim2.new(0,0,0,174), UDim2.new(1,0,0,32), Color3.fromRGB(25,25,30))
         local STL = {Enabled=false, Parts={}, Conn=nil}
         local function StartStealth()
             local c = Player.Character; local h = c and c:FindFirstChildOfClass("Humanoid")
             local r = c and c:FindFirstChild("HumanoidRootPart")
             if not c or not r then return false end
             STL.Parts = {}
             for _, v in ipairs(c:GetDescendants()) do
                 if v:IsA("BasePart") and v.Name ~= "HumanoidRootPart" and v.Transparency < 1 then
                     table.insert(STL.Parts, v)
                 end
             end
             if STL.Conn then STL.Conn:Disconnect(); STL.Conn = nil end
             for _, v in ipairs(STL.Parts) do v.Transparency = 0.5 end
             STL.Conn = RunService.Heartbeat:Connect(function()
                 if not STL.Enabled then return end
                 local cc = Player.Character; local hh = cc and cc:FindFirstChildOfClass("Humanoid")
                 local rr = cc and cc:FindFirstChild("HumanoidRootPart")
                 if not cc or not hh or not rr then return end
                 local ocf = rr.CFrame; local oof = hh.CameraOffset
                 local hideCF = ocf * CFrame.new(0, -25, 0)
                 rr.CFrame = hideCF
                 hh.CameraOffset = hideCF:ToObjectSpace(CFrame.new(ocf.Position)).Position
                 RunService.RenderStepped:Wait()
                 rr.CFrame = ocf; hh.CameraOffset = oof
             end)
             return true
         end
         local function StopStealth()
             for _, v in ipairs(STL.Parts) do if v and v.Parent then v.Transparency = 0 end end
             local c = Player.Character; local h = c and c:FindFirstChildOfClass("Humanoid")
             if h then h.CameraOffset = Vector3.new(0,0,0) end
             if STL.Conn then STL.Conn:Disconnect(); STL.Conn = nil end
             STL.Parts = {}
         end
         stealthBtn.MouseButton1Click:Connect(function()
             STL.Enabled = not STL.Enabled
             if STL.Enabled then
                 if StartStealth() then stealthBtn.Text = "INVISIBLE (FE): ON"; stealthBtn.BackgroundColor3 = Color3.fromRGB(255,255,255); stealthBtn.TextColor3 = Color3.fromRGB(0,0,0)
                 else STL.Enabled = false end
             else
                 StopStealth(); stealthBtn.Text = "INVISIBLE (FE): OFF"; stealthBtn.BackgroundColor3 = Color3.fromRGB(25,25,30); stealthBtn.TextColor3 = Color3.fromRGB(255,255,255)
             end
         end)
         State.VoidStop = function()
             if VOID.VoidDropEnabled then StopVD() end
             if VOID.VoidTrapActive then VT_FullStop(false) end
             StopStealth()
         end
     end
 
     -- ═══ TAB PHYSIC ═══
     local pagePhysic = MakeScrollPage(content, "PHYSIC", false)
     pages["PHYSIC"] = pagePhysic
     do
         local phyTitle = MakeLbl(pagePhysic, "PHYSIC MANIPULATOR", UDim2.new(0,0,0,0), UDim2.new(1,0,0,20), Color3.fromRGB(255,255,255))
         phyTitle.TextSize = 14
         local phyStatus = MakeLbl(pagePhysic, "Status: Idle", UDim2.new(0,0,0,22), UDim2.new(1,0,0,18), Color3.fromRGB(150,150,155))
         local phyModes = {"STACK","ORBIT","BLACKHOLE","TORNADO","VORTEX","WAVE","CAGE","SPIRAL","SATURN"}
         local phyMode = "STACK"
         local phyModeBtn = MakeBtn(pagePhysic, "Mode: " .. phyMode, UDim2.new(0,0,0,45), UDim2.new(0.48,-2,0,32), Color3.fromRGB(25,25,30))
         phyModeBtn.MouseButton1Click:Connect(function()
             local ix = 1
             for i, v in ipairs(phyModes) do if v == phyMode then ix = i; break end end
             ix = ix % #phyModes + 1; phyMode = phyModes[ix]; phyModeBtn.Text = "Mode: " .. phyMode
         end)
         local phyRad = 2500
         local phyRadBtn = MakeBtn(pagePhysic, "Radius: " .. phyRad, UDim2.new(0.52,2,0,45), UDim2.new(0.48,-2,0,32), Color3.fromRGB(25,25,30))
         phyRadBtn.MouseButton1Click:Connect(function()
             phyRad = phyRad + 500
             if phyRad > 5000 then phyRad = 500 end
             phyRadBtn.Text = "Radius: " .. phyRad
         end)
         local phyActive, phyConn, managed, phyTime = false, nil, {}, 0
         local function IsPartValid(p)
             if not p:IsA("BasePart") or p.Anchored then return false end
             if Player.Character and p:IsDescendantOf(Player.Character) then return false end
             if p.Parent and p.Parent:FindFirstChildOfClass("Humanoid") then return false end
             if p.Name == "Baseplate" or p.Name == "Terrain" then return false end
             return true
         end
         local function SetupAlign(p)
             if managed[p] then return end
             pcall(function()
                 local h = Player.Character and Player.Character:FindFirstChild("Head")
                 if not h then return end
                 local hAtt = h:FindFirstChild("An9xTA")
                 if not hAtt then
                     hAtt = Instance.new("Attachment"); hAtt.Name = "An9xTA"
                     hAtt.Parent = h; hAtt.Position = Vector3.new(0, 3, 0)
                 end
                 local pAtt = Instance.new("Attachment"); pAtt.Name = "An9xPA"; pAtt.Parent = p
                 local al = Instance.new("AlignPosition"); al.Name = "An9xA"
                 al.Attachment0 = pAtt; al.Attachment1 = hAtt
                 al.MaxForce = 9e18; al.Responsiveness = 200; al.RigidityEnabled = true
                 al.ApplyAtCenterOfMass = true; al.Parent = p
                 p.CanCollide = false; p.Velocity = Vector3.new(0, 5, 0)
                 managed[p] = {Att = pAtt, Align = al, Seed = math.random()*math.pi*2,
                     HOff = math.random(-8,8), RJ = 0.7 + math.random()*0.6}
             end)
         end
         local function CleanupPart(p)
             local c = managed[p]
             if c then
                 pcall(function() if c.Att then c.Att:Destroy() end; if c.Align then c.Align:Destroy() end end)
                 managed[p] = nil
             end
         end
         local function GetTargetPos(mode, pos, data, i, n, t)
             local seed = data.Seed; local h = data.HOff
             if mode == "STACK" then return pos + Vector3.new(0, 10, 0)
             elseif mode == "ORBIT" then
                 local a = t * 1.5 + seed + (n > 0 and (i/n)*math.pi*2 or 0)
                 local r = 30 * data.RJ
                 return pos + Vector3.new(math.cos(a)*r, 10 + h, math.sin(a)*r)
             elseif mode == "BLACKHOLE" then
                 local a = t * 3 + seed; local r = 6 * (0.3 + 0.7 * math.abs(math.sin(t*0.5 + seed)))
                 return pos + Vector3.new(math.cos(a)*r, 10 + h*0.5, math.sin(a)*r)
             elseif mode == "TORNADO" then
                 local s = t * 2.25; local a = s + seed
                 local w = (math.sin(t*0.8 + seed) + 1) / 2
                 local r = 25 * (1 - w*0.5) * data.RJ
                 return pos + Vector3.new(math.cos(a)*r, w*60, math.sin(a)*r)
             elseif mode == "VORTEX" then
                 local cy = (math.sin(t*1.2 + seed) + 1) / 2
                 local r = 5 + cy*60*data.RJ; local a = t * 3 + seed
                 return pos + Vector3.new(math.cos(a)*r, 10 + (cy-0.5)*30, math.sin(a)*r)
             elseif mode == "WAVE" then
                 local a = t*0.75 + seed; local r = 40 * data.RJ
                 local hh = 10 + math.sin(t*2 + seed)*20
                 return pos + Vector3.new(math.cos(a)*r, hh, math.sin(a)*r)
             elseif mode == "CAGE" then
                 local phi = math.acos(1 - 2*(i+0.5)/math.max(n,1))
                 local th = math.pi * (1 + 5^0.5) * i; local r = 15 * data.RJ
                 return pos + Vector3.new(math.cos(th)*math.sin(phi)*r, math.cos(phi)*r + 10, math.sin(th)*math.sin(phi)*r)
             elseif mode == "SPIRAL" then
                 local ph = (i/math.max(n,1)) + t*0.3
                 local a = ph*math.pi*2*3 + seed
                 local hh = (ph%1)*80
                 local r = 30*data.RJ*(0.6 + 0.4*math.sin(ph*math.pi))
                 return pos + Vector3.new(math.cos(a)*r, hh, math.sin(a)*r)
             elseif mode == "SATURN" then
                 local a = t*1.5 + seed + (n > 0 and (i/n)*math.pi*2 or 0)
                 local r = 45 * data.RJ; local tilt = math.rad(25)
                 local x = math.cos(a)*r; local z = math.sin(a)*r; local y = h*0.3
                 local y2 = y*math.cos(tilt) - z*math.sin(tilt)
                 local z2 = y*math.sin(tilt) + z*math.cos(tilt)
                 return pos + Vector3.new(x, y2 + 10, z2)
             end
             return pos + Vector3.new(0, 10, 0)
         end
                        -- ═══ FIX BUG PHYSIC: phyToggle dideklarasikan duluan ═══
        local phyToggle

        local function StopPhy()
            phyActive = false
            if phyConn then phyConn:Disconnect(); phyConn = nil end
            for p in pairs(managed) do CleanupPart(p) end
            managed = {}
            UHL(phyStatus, "Status: Idle")
            if phyToggle then
                phyToggle.Text = "START PHYSIC"
                phyToggle.BackgroundColor3 = Color3.fromRGB(25,25,30)
                phyToggle.TextColor3 = Color3.fromRGB(255,255,255)
            end
        end
        
        local function StartPhy()
            phyActive = true; managed = {}; phyTime = 0
            if phyToggle then
                phyToggle.Text = "STOP PHYSIC"
                phyToggle.BackgroundColor3 = Color3.fromRGB(255,255,255)
                phyToggle.TextColor3 = Color3.fromRGB(0,0,0)
            end
            phyConn = RunService.Heartbeat:Connect(function(dt)
                if not phyActive then return end
                ExpandSimulation(); phyTime = phyTime + dt
                local mc = Player.Character; local hr = mc and mc:FindFirstChild("HumanoidRootPart")
                local hd = mc and mc:FindFirstChild("Head")
                if not hr or not hd then StopPhy(); return end
                local hp = hd.Position + Vector3.new(0, 3, 0)
                for _, p in pairs(Workspace:GetDescendants()) do
                    if IsPartValid(p) then
                        if (p.Position - hp).Magnitude < phyRad then SetupAlign(p) end
                    end
                end
                local total = 0
                for _ in pairs(managed) do total = total + 1 end
                local active, idx = 0, 0
                for p, d in pairs(managed) do
                    if p.Parent and IsPartValid(p) then
                        idx = idx + 1; active = active + 1
                        local tp = GetTargetPos(phyMode, hp, d, idx, total, phyTime)
                        if phyMode == "STACK" then
                            d.Att.WorldPosition = tp; p.Velocity = Vector3.new(0, 0.5, 0)
                        else
                            d.Att.WorldPosition = tp; p.Velocity = Vector3.zero
                            p.RotVelocity = Vector3.new(math.random()*5, math.random()*5, math.random()*5)
                        end
                    else CleanupPart(p) end
                end
                UHL(phyStatus, "Active: " .. active)
            end)
        end
        
        phyToggle = MakeBtn(pagePhysic, "START PHYSIC", UDim2.new(0,0,0,87), UDim2.new(1,0,0,36), Color3.fromRGB(25,25,30))
        phyToggle.MouseButton1Click:Connect(function()
            if phyActive then StopPhy() else StartPhy() end
        end)
        State.PhysicStop = StopPhy

        -- ═══ TAB FOREST ═══
    local pageForest = MakeScrollPage(content, "FOREST", false)
    pages["FOREST"] = pageForest
    do
        local VEHICLE_PAT = {'wheel.*barrow','barrow','^carriage$','carriage','gerobak','^cart$','handcart','pushcart','vehicle','flingcart','pushvehicle'}
        local WF_NOCLIP_NAMES = {HumanoidRootPart=true,Torso=true,UpperTorso=true,LowerTorso=true,Head=true}
        
        local function IsVehModel(m)
            if not m or not m:IsA("Model") then return false end
            local n = m.Name:lower()
            for _, p in ipairs(VEHICLE_PAT) do if n:match(p) then return true end end
            return false
        end
        local function AllWBs()
            local l = {}
            for _, o in ipairs(Workspace:GetDescendants()) do
                if o:IsA("Model") and IsVehModel(o) then l[#l+1] = o end
            end
            return l
        end
        local function FreeSeat(m)
            if not m then return nil end
            for _, p in ipairs(m:GetDescendants()) do
                if (p:IsA("VehicleSeat") or p:IsA("Seat")) and p.Occupant == nil then return p end
            end
            return nil
        end
        local function MassCh(c)
            if not c then return 0 end
            local t = 0
            for _, p in ipairs(c:GetDescendants()) do if p:IsA("BasePart") then t = t + p.AssemblyMass end end
            return t
        end
        local function ClaimOwner(m)
            if not m then return end
            for _, p in ipairs(m:GetDescendants()) do
                if p:IsA("BasePart") then
                    pcall(function() p:SetNetworkOwner(Player) end)
                    pcall(function() sethiddenproperty(p, "NetworkOwnershipRule", Enum.NetworkOwnershipRule.Manual) end)
                end
            end
        end

        local forestSubBar = Instance.new("Frame", pageForest)
        forestSubBar.Size = UDim2.new(1,0,0,26); forestSubBar.Position = UDim2.new(0,0,0,0)
        forestSubBar.BackgroundColor3 = Color3.fromRGB(20,20,25); forestSubBar.ZIndex = 6
        Instance.new("UICorner", forestSubBar).CornerRadius = UDim.new(0,6)
        Instance.new("UIStroke", forestSubBar).Color = Color3.fromRGB(60,60,65)
        local fsubDefs = {{key="wb",label="WB"},{key="canopy",label="CANOPY"},{key="rock",label="ROCK"}}
        local fsubPages, fsubBtns = {}, {}
        local curFSub = "wb"
        for i, def in ipairs(fsubDefs) do
            local b = Instance.new("TextButton", forestSubBar)
            b.Size = UDim2.new((1/#fsubDefs),-4,0,18); b.Position = UDim2.new((i-1)/#fsubDefs,2,0,4)
            b.BackgroundColor3 = (def.key==curFSub) and Color3.fromRGB(255,255,255) or Color3.fromRGB(30,30,35)
            b.Text = def.label; b.TextColor3 = (def.key==curFSub) and Color3.fromRGB(0,0,0) or Color3.fromRGB(200,200,205)
            b.Font = Enum.Font.GothamBold; b.TextSize = 10; b.ZIndex = 7
            Instance.new("UICorner", b).CornerRadius = UDim.new(0,4)
            fsubBtns[def.key] = b
            b.MouseButton1Click:Connect(function()
                curFSub = def.key
                for k, btn in pairs(fsubBtns) do
                    btn.BackgroundColor3 = (k==curFSub) and Color3.fromRGB(255,255,255) or Color3.fromRGB(30,30,35)
                    btn.TextColor3 = (k==curFSub) and Color3.fromRGB(0,0,0) or Color3.fromRGB(200,200,205)
                end
                for k, p in pairs(fsubPages) do p.Visible = (k == curFSub) end
            end)
            local sf = Instance.new("ScrollingFrame", pageForest)
            sf.Size = UDim2.new(1,0,1,-34); sf.Position = UDim2.new(0,0,0,34)
            sf.BackgroundTransparency = 1; sf.BorderSizePixel = 0
            sf.ScrollBarThickness = 3; sf.ScrollBarImageColor3 = Color3.fromRGB(100,100,105)
            sf.CanvasSize = UDim2.new(0,0,0,0); sf.AutomaticCanvasSize = Enum.AutomaticSize.Y
            sf.Visible = (def.key == curFSub); sf.ZIndex = 7
            fsubPages[def.key] = sf
        end

        -- WB sub (JEYHUB Walkfling Tanpa Box)
        local wbPage = fsubPages["wb"]
        local WB = {AutoSit=false, AutoGetUp=false, SkipHeavy=false, FlyEnabled=false, FlySpeed=60,
            WalkFling=false, WFGen=0, PriorityMode=false, ExcludedPlayers={}, FriendCache={},
            HModel=nil, HSeat=nil, HWelds={}, HAnch={}, AutoSitConn=nil, FlyConn=nil, FlyModel=nil, FlySeat=nil, FlyBase=nil, FlyWelds={}, FlyAnch={},
            CharConn=nil, CooldownUntil=0, AutoExcludeFriends=false}

        local function HasWheelbarrowTool(pl)
            local ok, result = pcall(function()
                local char = pl.Character
                if char then
                    local eq = char:FindFirstChildOfClass("Tool")
                    if eq and eq.Name:lower():sub(1, 11) == "wheelbarrow" then return true end
                end
                local bp = pl:FindFirstChild("Backpack")
                if bp then
                    for _, t in ipairs(bp:GetChildren()) do
                        if t:IsA("Tool") and t.Name:lower():sub(1, 11) == "wheelbarrow" then return true end
                    end
                end
                return false
            end)
            return ok and result or false
        end

        local function StartAutoSit()
            if WB.AutoSitConn then return end
            WB.AutoSitConn = RunService.Heartbeat:Connect(function()
                if not WB.AutoSit then return end
                local c = Player.Character; local r = c and c:FindFirstChild("HumanoidRootPart")
                local h = c and c:FindFirstChildOfClass("Humanoid")
                if not r or not h then return end
                if tick() < WB.CooldownUntil then return end
                if h.Sit then
                    local s = h.SeatPart
                    if s and not IsVehModel(s:FindFirstAncestorOfClass("Model")) then return end
                end
                if h.Sit and WB.AutoGetUp and WB.HSeat then
                    task.delay(1, function()
                        h.Sit = false; h.Jump = true
                        WB.HSeat = nil; WB.CooldownUntil = tick() + 2
                    end)
                    return
                end
                if h.Sit then return end
                local myMass = MassCh(c)
                local best, bestD = nil, 120
                for _, wb in ipairs(AllWBs()) do
                    local seat = FreeSeat(wb)
                    if seat then
                        local d = (seat.Position - r.Position).Magnitude
                        if d < bestD then
                            local skip = false
                            if WB.SkipHeavy then
                                local pusher = nil
                                for _, pl in ipairs(Players:GetPlayers()) do
                                    if pl ~= Player and pl.Character then
                                        for _, w in ipairs(pl.Character:GetDescendants()) do
                                            if w:IsA("Weld") and ((w.Part0 and w.Part0:IsDescendantOf(wb)) or (w.Part1 and w.Part1:IsDescendantOf(wb))) then
                                                pusher = pl.Character; break
                                            end
                                        end
                                        if pusher then break end
                                    end
                                end
                                if pusher and MassCh(pusher) > myMass then skip = true end
                            end
                            if not skip then bestD = d; best = wb end
                        end
                    end
                end
                if best then
                    local seat = FreeSeat(best)
                    if seat then
                        ClaimOwner(best)
                        local base = best:FindFirstChild("NoTool") or best:FindFirstChild("Base") or seat
                        if base then
                            for _, w in ipairs(WB.HWelds) do pcall(function() w:Destroy() end) end
                            WB.HWelds = {}; WB.HAnch = {}
                            WB.HAnch[base] = base.Anchored; pcall(function() base.Anchored = false end)
                            for _, p in ipairs(best:GetDescendants()) do
                                if p:IsA("BasePart") and p ~= base then
                                    WB.HAnch[p] = p.Anchored; pcall(function() p.Anchored = false end)
                                    local wc = Instance.new("WeldConstraint")
                                    wc.Part0 = base; wc.Part1 = p; wc.Parent = base
                                    table.insert(WB.HWelds, wc)
                                end
                            end
                            WB.HModel = best; WB.HSeat = seat
                            task.wait(0.1); pcall(function() seat:Sit(h) end)
                        end
                    end
                end
            end)
        end
        
        local autoSitBtn = MakeBtn(wbPage, "AUTO SIT: OFF", UDim2.new(0,0,0,0), UDim2.new(0.48,-2,0,30), Color3.fromRGB(25,25,30))
        autoSitBtn.MouseButton1Click:Connect(function()
            WB.AutoSit = not WB.AutoSit
            autoSitBtn.Text = "AUTO SIT: " .. (WB.AutoSit and "ON" or "OFF")
            autoSitBtn.BackgroundColor3 = WB.AutoSit and Color3.fromRGB(255,255,255) or Color3.fromRGB(25,25,30)
            autoSitBtn.TextColor3 = WB.AutoSit and Color3.fromRGB(0,0,0) or Color3.fromRGB(255,255,255)
            if WB.AutoSit then StartAutoSit()
            else
                if WB.AutoSitConn then WB.AutoSitConn:Disconnect(); WB.AutoSitConn = nil end
            end
        end)
        
        local autoGetUpBtn = MakeBtn(wbPage, "AUTO GET UP: OFF", UDim2.new(0.52,2,0,0), UDim2.new(0.48,-2,0,30), Color3.fromRGB(25,25,30))
        autoGetUpBtn.MouseButton1Click:Connect(function()
            WB.AutoGetUp = not WB.AutoGetUp
            autoGetUpBtn.Text = "AUTO GET UP: " .. (WB.AutoGetUp and "ON" or "OFF")
            autoGetUpBtn.BackgroundColor3 = WB.AutoGetUp and Color3.fromRGB(255,255,255) or Color3.fromRGB(25,25,30)
            autoGetUpBtn.TextColor3 = WB.AutoGetUp and Color3.fromRGB(0,0,0) or Color3.fromRGB(255,255,255)
        end)
        
        local wbFlyBtn = MakeBtn(wbPage, "WB FLY: OFF", UDim2.new(0,0,0,72), UDim2.new(0.48,-2,0,30), Color3.fromRGB(25,25,30))
        local function StartWBFly()
            local c = Player.Character; local r = c and c:FindFirstChild("HumanoidRootPart")
            local h = c and c:FindFirstChildOfClass("Humanoid")
            if not r or not h then return false end
            local best, bestD = nil, 30
            for _, wb in ipairs(AllWBs()) do
                local seat = wb:FindFirstChildWhichIsA("Seat") or wb:FindFirstChildWhichIsA("VehicleSeat")
                if seat then
                    local d = (seat.Position - r.Position).Magnitude
                    if d < bestD then bestD = d; best = wb end
                end
            end
            if not best then return false end
            ClaimOwner(best)
            local seat = best:FindFirstChildWhichIsA("Seat") or best:FindFirstChildWhichIsA("VehicleSeat")
            local base = best:FindFirstChild("NoTool") or best:FindFirstChild("Base") or seat
            if not base then return false end
            WB.FlyModel = best; WB.FlySeat = seat; WB.FlyBase = base
            WB.FlyWelds = {}; WB.FlyAnch = {}
            for _, p in ipairs(best:GetDescendants()) do
                if p:IsA("BasePart") then
                    WB.FlyAnch[p] = p.Anchored; pcall(function() p.Anchored = false end)
                    if p ~= base then
                        local wc = Instance.new("WeldConstraint"); wc.Part0 = base; wc.Part1 = p; wc.Parent = base
                        table.insert(WB.FlyWelds, wc)
                    end
                end
            end
            WB.FlyConn = RunService.Heartbeat:Connect(function()
                if not WB.FlyEnabled then return end
                local cc = Player.Character; local rr = cc and cc:FindFirstChild("HumanoidRootPart")
                local hh = cc and cc:FindFirstChildOfClass("Humanoid")
                if not rr or not hh then return end
                local cam = Workspace.CurrentCamera; if not cam then return end
                local mv = Vector3.zero
                if UIS:IsKeyDown(Enum.KeyCode.W) then mv += cam.CFrame.LookVector end
                if UIS:IsKeyDown(Enum.KeyCode.S) then mv -= cam.CFrame.LookVector end
                if UIS:IsKeyDown(Enum.KeyCode.A) then mv -= cam.CFrame.RightVector end
                if UIS:IsKeyDown(Enum.KeyCode.D) then mv += cam.CFrame.RightVector end
                if UIS:IsKeyDown(Enum.KeyCode.Space) then mv += Vector3.new(0,1,0) end
                if UIS:IsKeyDown(Enum.KeyCode.LeftShift) then mv -= Vector3.new(0,1,0) end
                local vel = mv.Magnitude > 0 and mv.Unit * WB.FlySpeed or Vector3.zero
                pcall(function()
                    WB.FlyBase.AssemblyLinearVelocity = vel; WB.FlyBase.AssemblyAngularVelocity = Vector3.zero
                    rr.AssemblyLinearVelocity = vel; rr.AssemblyAngularVelocity = Vector3.zero
                end)
                if WB.FlySeat and hh.SeatPart ~= WB.FlySeat then pcall(function() WB.FlySeat:Sit(hh) end) end
                hh.PlatformStand = true
            end)
            return true
        end
        wbFlyBtn.MouseButton1Click:Connect(function()
            WB.FlyEnabled = not WB.FlyEnabled
            wbFlyBtn.Text = "WB FLY: " .. (WB.FlyEnabled and "ON" or "OFF")
            wbFlyBtn.BackgroundColor3 = WB.FlyEnabled and Color3.fromRGB(255,255,255) or Color3.fromRGB(25,25,30)
            wbFlyBtn.TextColor3 = WB.FlyEnabled and Color3.fromRGB(0,0,0) or Color3.fromRGB(255,255,255)
            if WB.FlyEnabled then StartWBFly()
            else
                if WB.FlyConn then WB.FlyConn:Disconnect(); WB.FlyConn = nil end
                for _, w in ipairs(WB.FlyWelds) do pcall(function() w:Destroy() end) end
                WB.FlyWelds = {}
                for p in pairs(WB.FlyAnch) do pcall(function() p.Anchored = false end) end
                WB.FlyAnch = {}; WB.FlyModel = nil; WB.FlySeat = nil; WB.FlyBase = nil
            end
        end)

        local wfBtn = MakeBtn(wbPage, "WALKFLING: OFF", UDim2.new(0,0,0,110), UDim2.new(1,0,0,30), Color3.fromRGB(25,25,30))
        local wfStatusLbl = MakeLbl(wbPage, "Status: OFF", UDim2.new(0,0,0,144), UDim2.new(1,0,0,14), Color3.fromRGB(150,150,155))
        wfStatusLbl.TextSize = 9
        
        local wfPriorityBtn = MakeBtn(wbPage, "PRIORITY MODE: OFF", UDim2.new(0,0,0,168), UDim2.new(0.48,-2,0,30), Color3.fromRGB(25,25,30))
        wfPriorityBtn.MouseButton1Click:Connect(function()
            WB.PriorityMode = not WB.PriorityMode
            wfPriorityBtn.Text = "PRIORITY MODE: " .. (WB.PriorityMode and "ON" or "OFF")
            wfPriorityBtn.BackgroundColor3 = WB.PriorityMode and Color3.fromRGB(255,255,255) or Color3.fromRGB(25,25,30)
            wfPriorityBtn.TextColor3 = WB.PriorityMode and Color3.fromRGB(0,0,0) or Color3.fromRGB(255,255,255)
            if WB.PriorityMode then wfPriorityBtn.Text = "PRIORITY: PICK IN EXCL" end
        end)
        
        local wfExclBtn = MakeBtn(wbPage, "EXCL FRIENDS: OFF", UDim2.new(0.52,2,0,168), UDim2.new(0.48,-2,0,30), Color3.fromRGB(25,25,30))
        wfExclBtn.MouseButton1Click:Connect(function()
            WB.AutoExcludeFriends = not (WB.AutoExcludeFriends or false)
            wfExclBtn.Text = "EXCL FRIENDS: " .. (WB.AutoExcludeFriends and "ON" or "OFF")
            wfExclBtn.BackgroundColor3 = WB.AutoExcludeFriends and Color3.fromRGB(255,255,255) or Color3.fromRGB(25,25,30)
            wfExclBtn.TextColor3 = WB.AutoExcludeFriends and Color3.fromRGB(0,0,0) or Color3.fromRGB(255,255,255)
            WB.FriendCache = {}
        end)

        local exclListLabel = MakeLbl(wbPage, "Player List (Klik = Target/Exclude):", UDim2.new(0,0,0,206), UDim2.new(1,0,0,16), Color3.fromRGB(200,200,205))
        exclListLabel.TextSize = 9
        
        local exclList = Instance.new("ScrollingFrame", wbPage)
        exclList.Size = UDim2.new(1,0,0,120); exclList.Position = UDim2.new(0,0,0,224)
        exclList.BackgroundColor3 = Color3.fromRGB(10,10,12); exclList.BorderSizePixel = 0
        exclList.ScrollBarThickness = 2; exclList.ZIndex = 7
        Instance.new("UICorner", exclList).CornerRadius = UDim.new(0,6)
        Instance.new("UIListLayout", exclList).Padding = UDim.new(0,2)

        local function RefreshExclList()
            for _, c in ipairs(exclList:GetChildren()) do
                if c:IsA("TextButton") then c:Destroy() end
            end
            local idx = 0
            for _, pl in ipairs(Players:GetPlayers()) do
                if pl ~= Player then
                    idx = idx + 1
                    local isExcl = WB.ExcludedPlayers[pl.Name]
                    local hasWB = HasWheelbarrowTool(pl)
                    
                    local b = Instance.new("TextButton", exclList)
                    b.Size = UDim2.new(1,-4,0,24); b.Position = UDim2.new(0,2,0,(idx-1)*26)
                    
                    if WB.PriorityMode then
                        b.BackgroundColor3 = isExcl and Color3.fromRGB(255,255,255) or Color3.fromRGB(20,20,25)
                        b.TextColor3 = isExcl and Color3.fromRGB(0,0,0) or (hasWB and Color3.fromRGB(255,255,255) or Color3.fromRGB(150,150,155))
                    else
                        b.BackgroundColor3 = isExcl and Color3.fromRGB(255,255,255) or Color3.fromRGB(20,20,25)
                        b.TextColor3 = isExcl and Color3.fromRGB(0,0,0) or (hasWB and Color3.fromRGB(255,255,255) or Color3.fromRGB(150,150,155))
                    end
                    
                    b.Text = "  " .. pl.Name .. (hasWB and " [WB]" or "")
                    b.Font = Enum.Font.GothamMedium; b.TextSize = 10
                    b.TextXAlignment = Enum.TextXAlignment.Left; b.ZIndex = 8
                    Instance.new("UICorner", b).CornerRadius = UDim.new(0,4)
                    
                    b.MouseButton1Click:Connect(function()
                        WB.ExcludedPlayers[pl.Name] = not WB.ExcludedPlayers[pl.Name] or nil
                        RefreshExclList()
                    end)
                end
            end
            exclList.CanvasSize = UDim2.new(0,0,0, idx * 26 + 4)
        end
        RefreshExclList()
        Players.PlayerAdded:Connect(function() task.wait(1); RefreshExclList() end)
        Players.PlayerRemoving:Connect(function() task.wait(1); RefreshExclList() end)
        wfPriorityBtn.MouseButton1Click:Connect(function() task.wait(0.1); RefreshExclList() end)

        -- WALKFLING JEYHUB LOGIC (TANPA BOX)
        local function WFLoop(gen)
            local flingMag = 2^30 * 99999999
            local movel = 0.1
            while WB.WalkFling and WB.WFGen == gen do
                RunService.Heartbeat:Wait()
                local ch = Player.Character
                local root = ch and ch:FindFirstChild("HumanoidRootPart")
                local hum = ch and ch:FindFirstChildOfClass("Humanoid")
                
                while WB.WalkFling and WB.WFGen == gen and not (ch and ch.Parent and root and root.Parent and hum and hum.Health > 0) do
                    RunService.Heartbeat:Wait()
                    ch = Player.Character
                    root = ch and ch:FindFirstChild("HumanoidRootPart")
                    hum = ch and ch:FindFirstChildOfClass("Humanoid")
                end
                if not (WB.WalkFling and WB.WFGen == gen) then break end
                
                pcall(function() root:SetNetworkOwner(Player) end)
                pcall(function() sethiddenproperty(root, "NetworkOwnershipRule", Enum.NetworkOwnershipRule.Manual) end)
                
                local vel = root.AssemblyLinearVelocity
                root.AssemblyLinearVelocity = Vector3.new(flingMag, flingMag, flingMag)
                
                -- Nembak sentuhan ke SEMUA orang yang bawa Wheelbarrow (sesuai filter Priority/Exclude)
                pcall(function()
                    for _, pl in ipairs(Players:GetPlayers()) do
                        if pl ~= Player and pl.Character and HasWheelbarrowTool(pl) then
                            local allowed
                            if WB.PriorityMode then
                                allowed = WB.ExcludedPlayers[pl.Name] == true
                            else
                                allowed = not WB.ExcludedPlayers[pl.Name]
                            end
                            
                            if allowed and WB.AutoExcludeFriends then
                                if WB.FriendCache[pl.Name] then
                                    allowed = false
                                else
                                    local ok, fr = pcall(function() return Player:IsFriendsWith(pl.UserId) end)
                                    if ok and fr then
                                        WB.FriendCache[pl.Name] = true
                                        allowed = false
                                    end
                                end
                            end

                            if allowed then
                                for _, part in ipairs(pl.Character:GetDescendants()) do
                                    if part:IsA("BasePart") then
                                        pcall(firetouchinterest, root, part, 0)
                                        pcall(firetouchinterest, root, part, 1)
                                    end
                                end
                            end
                        end
                    end
                end)
                
                RunService.RenderStepped:Wait()
                if root and root.Parent then
                    root.AssemblyLinearVelocity = vel
                end
                RunService.Stepped:Wait()
                if root and root.Parent then
                    root.AssemblyLinearVelocity = vel + Vector3.new(0, movel, 0)
                    movel = -movel
                end
            end
        end

        wfBtn.MouseButton1Click:Connect(function()
            if WB.WalkFling then
                WB.WalkFling = false; WB.WFGen = WB.WFGen + 1
                if WB.CharConn then pcall(function() WB.CharConn:Disconnect() end); WB.CharConn = nil end
                local c = Player.Character
                local r = c and c:FindFirstChild("HumanoidRootPart")
                if r then r.AssemblyLinearVelocity = Vector3.zero; r.AssemblyAngularVelocity = Vector3.zero end
                wfBtn.Text = "WALKFLING: OFF"; wfBtn.BackgroundColor3 = Color3.fromRGB(25,25,30); wfBtn.TextColor3 = Color3.fromRGB(255,255,255)
                UHL(wfStatusLbl, "Status: OFF")
            else
                WB.WalkFling = true; WB.WFGen = WB.WFGen + 1; WB.FriendCache = {}
                
                if not WB.CharConn then
                    WB.CharConn = Player.CharacterAdded:Connect(function()
                        if not WB.WalkFling then return end
                        WB.WFGen = WB.WFGen + 1
                        task.spawn(WFLoop, WB.WFGen)
                    end)
                end
                
                task.spawn(WFLoop, WB.WFGen)
                wfBtn.Text = "WALKFLING: ON"; wfBtn.BackgroundColor3 = Color3.fromRGB(255,255,255); wfBtn.TextColor3 = Color3.fromRGB(0,0,0)
                UHL(wfStatusLbl, "Status: ON (Hitting All WB)")
            end
        end)

        -- CANOPY sub
        local cyPage = fsubPages["canopy"]
        local CY = {Lifts={}, Selected="Lift1", AutoSit=false, FlyEnabled=false, FlySpeed=60, Conn=nil,
            TPPusher=false, AntiDisappear=false, TPConn=nil, StabilityConn=nil, LockY=0}
        
        local function ScanLifts()
            local cr = Workspace:FindFirstChild("Canopy Ride")
            if not cr then return {"Lift1","Lift2","Lift4","Lift5","Lift6"} end
            local n = {}
            for _, c in ipairs(cr:GetChildren()) do
                if c:IsA("Model") and c.Name:match("^Lift%d+$") then n[#n+1] = c.Name end
            end
            table.sort(n, function(a, b) return tonumber(a:match("%d+")) < tonumber(b:match("%d+")) end)
            return #n > 0 and n or {"Lift1","Lift2","Lift4","Lift5","Lift6"}
        end
        local function GetLift(name)
            local cr = Workspace:FindFirstChild("Canopy Ride")
            return cr and cr:FindFirstChild(name)
        end
        local function GetLiftSeat(l)
            if not l then return nil end
            for _, v in ipairs(l:GetDescendants()) do
                if v:IsA("Seat") or v:IsA("VehicleSeat") then return v end
            end
            return nil
        end
        
        local function FindNearbyPusher(refPos, maxDist)
            local wbPatterns = {'wheel.*barrow', 'barrow', 'gerobak', 'cart'}
            local best, bestD = nil, maxDist or 120
            for _, obj in ipairs(Workspace:GetDescendants()) do
                if obj:IsA("Model") then
                    local n = obj.Name:lower()
                    local isWB = false
                    for _, pat in ipairs(wbPatterns) do if n:match(pat) then isWB = true; break end end
                    if isWB then
                        local pivot; pcall(function() pivot = obj:GetPivot() end)
                        if pivot then
                            local d = (pivot.Position - refPos).Magnitude
                            if d < bestD then bestD = d; best = obj end
                        end
                    end
                end
            end
            return best
        end
        local function FindWBPusher(wbModel)
            if not wbModel then return nil end
            local refPart
            for _, p in ipairs(wbModel:GetDescendants()) do
                if p:IsA("BasePart") and p.Name:lower() == "handles" then refPart = p; break end
            end
            if not refPart then
                for _, p in ipairs(wbModel:GetDescendants()) do
                    if p:IsA("BasePart") then refPart = p; break end
                end
            end
            if not refPart then return nil end
            local function charFromPart(part)
                if not part then return nil end
                for _, pl in ipairs(Players:GetPlayers()) do
                    if pl ~= Player then
                        local ch = pl.Character
                        if ch and part:IsDescendantOf(ch) then return ch end
                    end
                end
                return nil
            end
            for _, w in ipairs(wbModel:GetDescendants()) do
                if w:IsA("Weld") or w:IsA("WeldConstraint") then
                    local pusher = charFromPart(w.Part0) or charFromPart(w.Part1)
                    if pusher then return pusher end
                end
            end
            local nearestDist = 10
            local pusherChar = nil
            for _, pl in ipairs(Players:GetPlayers()) do
                if pl ~= Player then
                    local ch = pl.Character
                    local root = ch and ch:FindFirstChild("HumanoidRootPart")
                    if root then
                        local d = (root.Position - refPart.Position).Magnitude
                        if d < nearestDist then nearestDist = d; pusherChar = ch end
                    end
                end
            end
            return pusherChar
        end

        local function StartCanopyTPPusher()
            if CY.TPConn then CY.TPConn:Disconnect(); CY.TPConn = nil end
            local accum = 0
            CY.TPConn = RunService.Heartbeat:Connect(function(dt)
                if not CY.TPPusher then
                    if CY.TPConn then CY.TPConn:Disconnect(); CY.TPConn = nil end
                    return
                end
                local lift = GetLift(CY.Selected)
                if not lift or not lift.PrimaryPart then return end
                accum = accum + dt
                if accum < 0.15 then return end
                accum = 0
                local wb = FindNearbyPusher(lift.PrimaryPart.Position, 120)
                if not wb then return end
                local pusherChar = FindWBPusher(wb)
                local pusherRoot = pusherChar and pusherChar:FindFirstChild("HumanoidRootPart")
                if not pusherRoot then return end
                local base = lift.PrimaryPart
                local newPos = Vector3.new(pusherRoot.Position.X, CY.LockY, pusherRoot.Position.Z)
                pcall(function()
                    base.CFrame = CFrame.new(newPos) * (base.CFrame - base.CFrame.Position)
                    base.AssemblyLinearVelocity = Vector3.zero
                    base.AssemblyAngularVelocity = Vector3.zero
                end)
            end)
        end

        local function StartCanopyStability()
            if CY.StabilityConn then CY.StabilityConn:Disconnect(); CY.StabilityConn = nil end
            local t = 0
            CY.StabilityConn = RunService.Heartbeat:Connect(function(dt)
                if not CY.AntiDisappear then
                    if CY.StabilityConn then CY.StabilityConn:Disconnect(); CY.StabilityConn = nil end
                    return
                end
                t = t + dt
                if t < 1.5 then return end
                t = 0
                local lift = GetLift(CY.Selected)
                if not lift then return end
                ClaimOwner(lift)
                pcall(function()
                    for _, s in ipairs(lift:GetDescendants()) do
                        if s:IsA("Script") or s:IsA("LocalScript") then
                            local sn = s.Name:lower()
                            if sn:find("weld") or sn:find("seat") then s.Disabled = true end
                        end
                    end
                end)
            end)
        end

        CY.Lifts = ScanLifts(); CY.Selected = CY.Lifts[1] or "Lift1"
        local cyTitle = MakeLbl(cyPage, "🎡 CANOPY RIDE", UDim2.new(0,0,0,0), UDim2.new(1,0,0,20), Color3.fromRGB(255,255,255))
        cyTitle.TextSize = 13
        local liftList = Instance.new("ScrollingFrame", cyPage)
        liftList.Size = UDim2.new(1,0,0,80); liftList.Position = UDim2.new(0,0,0,24)
        liftList.BackgroundColor3 = Color3.fromRGB(10,10,12); liftList.BorderSizePixel = 0
        liftList.ScrollBarThickness = 2; liftList.ZIndex = 7
        Instance.new("UICorner", liftList).CornerRadius = UDim.new(0,6)
        Instance.new("UIListLayout", liftList).Padding = UDim.new(0,2)
        local function BuildLifts()
            for _, c in ipairs(liftList:GetChildren()) do if c:IsA("TextButton") then c:Destroy() end end
            for i, n in ipairs(CY.Lifts) do
                local b = Instance.new("TextButton", liftList)
                b.Size = UDim2.new(1,-4,0,24); b.Position = UDim2.new(0,2,0,(i-1)*26)
                b.BackgroundColor3 = (n == CY.Selected) and Color3.fromRGB(255,255,255) or Color3.fromRGB(20,20,25)
                b.Text = "  " .. n; b.TextColor3 = (n == CY.Selected) and Color3.fromRGB(0,0,0) or Color3.fromRGB(220,220,225)
                b.Font = Enum.Font.GothamMedium; b.TextSize = 9
                b.TextXAlignment = Enum.TextXAlignment.Left; b.ZIndex = 8
                Instance.new("UICorner", b).CornerRadius = UDim.new(0,4)
                b.MouseButton1Click:Connect(function()
                    CY.Selected = n
                    for _, c in ipairs(liftList:GetChildren()) do
                        if c:IsA("TextButton") then c.BackgroundColor3 = Color3.fromRGB(20,20,25); c.TextColor3 = Color3.fromRGB(220,220,225) end
                    end
                    b.BackgroundColor3 = Color3.fromRGB(255,255,255); b.TextColor3 = Color3.fromRGB(0,0,0)
                end)
            end
            liftList.CanvasSize = UDim2.new(0,0,0,#CY.Lifts*26+4)
        end
        BuildLifts()
        
        local rescanBtn = MakeBtn(cyPage, "🔄 RESCAN LIFTS", UDim2.new(0,0,0,110), UDim2.new(1,0,0,30), Color3.fromRGB(25,25,30))
        rescanBtn.MouseButton1Click:Connect(function()
            CY.Lifts = ScanLifts(); CY.Selected = CY.Lifts[1]; BuildLifts()
        end)
        
        local tpSitBtn = MakeBtn(cyPage, "TP & SIT", UDim2.new(0,0,0,144), UDim2.new(0.48,-2,0,32), Color3.fromRGB(25,25,30))
        tpSitBtn.MouseButton1Click:Connect(function()
            local l = GetLift(CY.Selected); if not l then return end
            local seat = GetLiftSeat(l); if not seat then return end
            local c = Player.Character; local r = c and c:FindFirstChild("HumanoidRootPart")
            local h = c and c:FindFirstChildOfClass("Humanoid")
            if not r or not h then return end
            ClaimOwner(l)
            r.CFrame = CFrame.new(seat.Position + Vector3.new(0,3,0))
            task.wait(0.25); pcall(function() seat:Sit(h) end)
        end)
        
        local cyAutoBtn = MakeBtn(cyPage, "AUTO SIT: OFF", UDim2.new(0.52,2,0,144), UDim2.new(0.48,-2,0,32), Color3.fromRGB(25,25,30))
        cyAutoBtn.MouseButton1Click:Connect(function()
            CY.AutoSit = not CY.AutoSit
            cyAutoBtn.Text = "AUTO SIT: " .. (CY.AutoSit and "ON" or "OFF")
            cyAutoBtn.BackgroundColor3 = CY.AutoSit and Color3.fromRGB(255,255,255) or Color3.fromRGB(25,25,30)
            cyAutoBtn.TextColor3 = CY.AutoSit and Color3.fromRGB(0,0,0) or Color3.fromRGB(255,255,255)
        end)
        
        local cyFlyBtn = MakeBtn(cyPage, "CANOPY FLY: OFF", UDim2.new(0,0,0,184), UDim2.new(1,0,0,32), Color3.fromRGB(25,25,30))
        cyFlyBtn.MouseButton1Click:Connect(function()
            CY.FlyEnabled = not CY.FlyEnabled
            cyFlyBtn.Text = "CANOPY FLY: " .. (CY.FlyEnabled and "ON" or "OFF")
            cyFlyBtn.BackgroundColor3 = CY.FlyEnabled and Color3.fromRGB(255,255,255) or Color3.fromRGB(25,25,30)
            cyFlyBtn.TextColor3 = CY.FlyEnabled and Color3.fromRGB(0,0,0) or Color3.fromRGB(255,255,255)
            if CY.FlyEnabled then
                local l = GetLift(CY.Selected); if not l then CY.FlyEnabled = false; return end
                ClaimOwner(l)
                local seat = GetLiftSeat(l)
                local base = l:FindFirstChild("NoTool") or l:FindFirstChild("Base") or seat
                if not base then CY.FlyEnabled = false; return end
                CY.Conn = RunService.Heartbeat:Connect(function()
                    if not CY.FlyEnabled then return end
                    local cam = Workspace.CurrentCamera; if not cam then return end
                    local mv = Vector3.zero
                    if UIS:IsKeyDown(Enum.KeyCode.W) then mv += cam.CFrame.LookVector end
                    if UIS:IsKeyDown(Enum.KeyCode.S) then mv -= cam.CFrame.LookVector end
                    if UIS:IsKeyDown(Enum.KeyCode.A) then mv -= cam.CFrame.RightVector end
                    if UIS:IsKeyDown(Enum.KeyCode.D) then mv += cam.CFrame.RightVector end
                    if UIS:IsKeyDown(Enum.KeyCode.Space) then mv += Vector3.new(0,1,0) end
                    if UIS:IsKeyDown(Enum.KeyCode.LeftShift) then mv -= Vector3.new(0,1,0) end
                    local vel = mv.Magnitude > 0 and mv.Unit * CY.FlySpeed or Vector3.zero
                    pcall(function()
                        base.AssemblyLinearVelocity = vel; base.AssemblyAngularVelocity = Vector3.zero
                    end)
                end)
            else
                if CY.Conn then CY.Conn:Disconnect(); CY.Conn = nil end
            end
        end)
        
        local tpPusherBtn = MakeBtn(cyPage, "TP TO PUSHER: OFF", UDim2.new(0,0,0,224), UDim2.new(1,0,0,32), Color3.fromRGB(25,25,30))
        tpPusherBtn.MouseButton1Click:Connect(function()
            CY.TPPusher = not CY.TPPusher
            tpPusherBtn.Text = "TP TO PUSHER: " .. (CY.TPPusher and "ON" or "OFF")
            tpPusherBtn.BackgroundColor3 = CY.TPPusher and Color3.fromRGB(255,255,255) or Color3.fromRGB(25,25,30)
            tpPusherBtn.TextColor3 = CY.TPPusher and Color3.fromRGB(0,0,0) or Color3.fromRGB(255,255,255)
            if CY.TPPusher then
                local lift = GetLift(CY.Selected)
                CY.LockY = lift and lift.PrimaryPart and lift.PrimaryPart.Position.Y or 0
                StartCanopyTPPusher()
            end
        end)
        
        local stabilityBtn = MakeBtn(cyPage, "ANTI-DISAPPEAR: OFF", UDim2.new(0,0,0,264), UDim2.new(1,0,0,32), Color3.fromRGB(25,25,30))
        stabilityBtn.MouseButton1Click:Connect(function()
            CY.AntiDisappear = not CY.AntiDisappear
            stabilityBtn.Text = "ANTI-DISAPPEAR: " .. (CY.AntiDisappear and "ON" or "OFF")
            stabilityBtn.BackgroundColor3 = CY.AntiDisappear and Color3.fromRGB(255,255,255) or Color3.fromRGB(25,25,30)
            stabilityBtn.TextColor3 = CY.AntiDisappear and Color3.fromRGB(0,0,0) or Color3.fromRGB(255,255,255)
            if CY.AntiDisappear then StartCanopyStability() end
        end)

        -- ═══ ROCK sub (JEYHUB LOGIC) ═══
        local rkPage = fsubPages["rock"]
        local RK = {TargetPlayer=nil, PartName="HumanoidRootPart", AutoFling=false, Gen=0,
            PART_MAP={HumanoidRootPart={"HumanoidRootPart"},Head={"Head"},Torso={"Torso","UpperTorso"},
                ["Left Arm"]={"Left Arm","LeftHand","LeftLowerArm","LeftUpperArm"},
                ["Right Arm"]={"Right Arm","RightHand","RightLowerArm","RightUpperArm"},
                ["Left Leg"]={"Left Leg","LeftFoot","LeftLowerLeg","LeftUpperLeg"},
                ["Right Leg"]={"Right Leg","RightFoot","RightLowerLeg","RightUpperLeg"}}}
        local rkTitle = MakeLbl(rkPage, "🪨 ROCK FLING", UDim2.new(0,0,0,0), UDim2.new(1,0,0,20), Color3.fromRGB(255,255,255))
        rkTitle.TextSize = 13
        local rkTgtLbl = MakeLbl(rkPage, "Target: none", UDim2.new(0,0,0,22), UDim2.new(1,0,0,14), Color3.fromRGB(200,200,205))
        rkTgtLbl.TextSize = 9
        local rkList = Instance.new("ScrollingFrame", rkPage)
        rkList.Size = UDim2.new(1,0,0,80); rkList.Position = UDim2.new(0,0,0,40)
        rkList.BackgroundColor3 = Color3.fromRGB(10,10,12); rkList.BorderSizePixel = 0
        rkList.ScrollBarThickness = 2; rkList.ZIndex = 7
        Instance.new("UICorner", rkList).CornerRadius = UDim.new(0,6)
        Instance.new("UIListLayout", rkList).Padding = UDim.new(0,2)
        local function RefreshRK()
            for _, c in ipairs(rkList:GetChildren()) do if c:IsA("TextButton") then c:Destroy() end end
            local idx = 0
            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= Player then
                    local b = Instance.new("TextButton", rkList)
                    b.Size = UDim2.new(1,-4,0,22); b.Position = UDim2.new(0,2,0,idx*24)
                    b.BackgroundColor3 = (p == RK.TargetPlayer) and Color3.fromRGB(255,255,255) or Color3.fromRGB(20,20,25)
                    b.Text = "  " .. p.Name; b.TextColor3 = (p == RK.TargetPlayer) and Color3.fromRGB(0,0,0) or Color3.fromRGB(220,220,225)
                    b.Font = Enum.Font.GothamMedium; b.TextSize = 9
                    b.TextXAlignment = Enum.TextXAlignment.Left; b.ZIndex = 8
                    Instance.new("UICorner", b).CornerRadius = UDim.new(0,4)
                    b.MouseButton1Click:Connect(function()
                        RK.TargetPlayer = p
                        UHL(rkTgtLbl, "Target: " .. p.Name)
                        for _, c in ipairs(rkList:GetChildren()) do
                            if c:IsA("TextButton") then c.BackgroundColor3 = Color3.fromRGB(20,20,25); c.TextColor3 = Color3.fromRGB(220,220,225) end
                        end
                        b.BackgroundColor3 = Color3.fromRGB(255,255,255); b.TextColor3 = Color3.fromRGB(0,0,0)
                        State.TargetPlayer = p
                    end)
                    idx = idx + 1
                end
            end
            rkList.CanvasSize = UDim2.new(0,0,0,idx*24+4)
        end
        RefreshRK()
        Players.PlayerAdded:Connect(function() task.wait(1); RefreshRK() end)
        Players.PlayerRemoving:Connect(function() task.wait(1); RefreshRK() end)
        
        local function GetRKPart()
            local p = RK.TargetPlayer; if not p or not p.Character then return nil end
            for _, n in ipairs(RK.PART_MAP[RK.PartName] or {"HumanoidRootPart"}) do
                local x = p.Character:FindFirstChild(n)
                if x and x:IsA("BasePart") then return x end
            end
            return p.Character:FindFirstChild("HumanoidRootPart")
        end
        local function GetRKParts()
            local p = RK.TargetPlayer; if not p or not p.Character then return nil end
            local parts = {}
            for _, x in ipairs(p.Character:GetDescendants()) do
                if x:IsA("BasePart") then parts[#parts + 1] = x end
            end
            return parts
        end
        
        -- JEYHUB ROCK FLING LOGIC EXACT COPY
        local function RKLoop(gen)
            local flingMag = 2^30 * 99999999
            local movel = 0.1
            local frame = 0
            while RK.AutoFling and RK.Gen == gen do
                RunService.Heartbeat:Wait()
                local ch = Player.Character
                local root = ch and ch:FindFirstChild("HumanoidRootPart")
                local hum = ch and ch:FindFirstChildOfClass("Humanoid")
                while RK.AutoFling and RK.Gen == gen and not (ch and ch.Parent and root and root.Parent and hum and hum.Health > 0) do
                    RunService.Heartbeat:Wait()
                    ch = Player.Character
                    root = ch and ch:FindFirstChild("HumanoidRootPart")
                    hum = ch and ch:FindFirstChildOfClass("Humanoid")
                end
                if not (RK.AutoFling and RK.Gen == gen) then break end
                local tPart = GetRKPart()
                local parts = GetRKParts()
                if tPart and parts then
                    root.CFrame = tPart.CFrame
                    pcall(function() root:SetNetworkOwner(Player) end)
                    pcall(function() sethiddenproperty(root, "NetworkOwnershipRule", Enum.NetworkOwnershipRule.Manual) end)
                    
                    local vel = root.AssemblyLinearVelocity
                    root.AssemblyLinearVelocity = Vector3.new(flingMag, flingMag, flingMag)
                    
                    for _, p in ipairs(parts) do
                        pcall(firetouchinterest, root, p, 0)
                        pcall(firetouchinterest, root, p, 1)
                    end
                    
                    RunService.RenderStepped:Wait()
                    if root and root.Parent then
                        root.AssemblyLinearVelocity = vel
                    end
                    RunService.Stepped:Wait()
                    if root and root.Parent then
                        root.AssemblyLinearVelocity = vel + Vector3.new(0, movel, 0)
                        movel = -movel
                    end
                end
            end
        end

                -- ═══ FITUR SPAM TOOLS (JEYHUB STYLE) ═══
                local rkCycleOn = false
                local rkCycleConn = nil
        
                local function GetRockTool()
                    local char = Player.Character
                    local bp = Player:FindFirstChild("Backpack")
                    if char then
                        for _, t in ipairs(char:GetChildren()) do
                            if t:IsA("Tool") and (t.Name == "Box" or t.Name == "box") then return t end
                        end
                    end
                    if bp then
                        for _, t in ipairs(bp:GetChildren()) do
                            if t:IsA("Tool") and (t.Name == "Box" or t.Name == "box") then return t end
                        end
                    end
                    return nil
                end
        
                local rkEquipBtn = MakeBtn(rkPage, "EQUIP ROCK BOX", UDim2.new(0,0,0,80), UDim2.new(0.48,-2,0,26), Color3.fromRGB(25,25,30))
                rkEquipBtn.MouseButton1Click:Connect(function()
                    local tool = GetRockTool()
                    local hum = Player.Character and Player.Character:FindFirstChildOfClass("Humanoid")
                    if tool and hum and tool.Parent ~= Player.Character then
                        hum:EquipTool(tool)
                    end
                end)
        
                local rkUnequipBtn = MakeBtn(rkPage, "UNEQUIP BOX", UDim2.new(0.52,2,0,80), UDim2.new(0.48,-2,0,26), Color3.fromRGB(25,25,30))
                rkUnequipBtn.MouseButton1Click:Connect(function()
                    local hum = Player.Character and Player.Character:FindFirstChildOfClass("Humanoid")
                    if hum then pcall(function() hum:UnequipTools() end) end
                end)
        
                local rkSpamToolsBtn = MakeBtn(rkPage, "SPAM TOOLS: OFF", UDim2.new(0,0,0,110), UDim2.new(1,0,0,26), Color3.fromRGB(25,25,30))
                rkSpamToolsBtn.MouseButton1Click:Connect(function()
                    rkCycleOn = not rkCycleOn
                    rkSpamToolsBtn.Text = "SPAM TOOLS: " .. (rkCycleOn and "ON" or "OFF")
                    rkSpamToolsBtn.BackgroundColor3 = rkCycleOn and Color3.fromRGB(255,255,255) or Color3.fromRGB(25,25,30)
                    rkSpamToolsBtn.TextColor3 = rkCycleOn and Color3.fromRGB(0,0,0) or Color3.fromRGB(255,255,255)
        
                    if rkCycleOn then
                        if not rkCycleConn then
                            rkCycleConn = RunService.Heartbeat:Connect(function()
                                if not rkCycleOn then return end
                                local tool = GetRockTool()
                                local char = Player.Character
                                local hum = char and char:FindFirstChildOfClass("Humanoid")
                                
                                if tool and hum then
                                    if tool.Parent == char then
                                        pcall(function() hum:UnequipTools() end)
                                    else
                                        pcall(function() hum:EquipTool(tool) end)
                                    end
                                end
                            end)
                        end
                    else
                        if rkCycleConn then rkCycleConn:Disconnect(); rkCycleConn = nil end
                        local hum = Player.Character and Player.Character:FindFirstChildOfClass("Humanoid")
                        if hum then pcall(function() hum:UnequipTools() end) end
                    end
                end)
                -- ═══ END FITUR SPAM TOOLS ═══
        
        local rkAutoBtn = MakeBtn(rkPage, "AUTO FLING: OFF", UDim2.new(0,0,0,128), UDim2.new(1,0,0,32), Color3.fromRGB(25,25,30))
        rkAutoBtn.MouseButton1Click:Connect(function()
            if RK.AutoFling then
                RK.AutoFling = false; RK.Gen = RK.Gen + 1
                local c = Player.Character; local h = c and c:FindFirstChildOfClass("Humanoid")
                if h then pcall(function() h:UnequipTools() end) end
                rkAutoBtn.Text = "AUTO FLING: OFF"; rkAutoBtn.BackgroundColor3 = Color3.fromRGB(25,25,30); rkAutoBtn.TextColor3 = Color3.fromRGB(255,255,255)
            else
                if not RK.TargetPlayer then warn("[HAMA] Pilih target"); return end
                RK.AutoFling = true; RK.Gen = RK.Gen + 1
                task.spawn(RKLoop, RK.Gen)
                rkAutoBtn.Text = "AUTO FLING: ON"; rkAutoBtn.BackgroundColor3 = Color3.fromRGB(255,255,255); rkAutoBtn.TextColor3 = Color3.fromRGB(0,0,0)
            end
        end)
    end

    -- ═══ TAB SERVER ═══
    local pageServer = MakeScrollPage(content, "SERVER", false)
    pages["SERVER"] = pageServer
    do
        local SF = {Busy=false, Scanning=false, Servers={}, HideFull=true, HideEmpty=false, Sort="Asc"}
        local function GetJobId() return game.JobId and game.JobId ~= "" and game.JobId or nil end
        local function FetchServers(sort)
            local url = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=" .. sort .. "&limit=100"
            local body
            local ok, res = pcall(function() return game:HttpGet(url) end)
            if ok and type(res) == "string" then body = res
            elseif typeof(request) == "function" then
                local ok2, r = pcall(request, {Url=url, Method="GET"})
                if ok2 and r and r.Body then body = r.Body end
            end
            if not body then return nil end
            local okD, d = pcall(function() return HttpService:JSONDecode(body) end)
            if okD and d and d.data then return d.data end
            return nil
        end
        local function TeleportSrv(sid)
            pcall(function() Services.TeleportService:TeleportToPlaceInstance(game.PlaceId, sid, Player) end)
        end
        local REGIONS = {
            {max=35,code="SG",color=Color3.fromRGB(70,70,70)},{max=65,code="ID",color=Color3.fromRGB(60,60,60)},
            {max=95,code="JP",color=Color3.fromRGB(30,30,30)},{max=130,code="AU",color=Color3.fromRGB(50,50,50)},
            {max=180,code="US",color=Color3.fromRGB(45,45,45)},{max=260,code="EU",color=Color3.fromRGB(40,40,40)},
            {max=350,code="BR",color=Color3.fromRGB(36,36,36)},{max=999,code="??",color=Color3.fromRGB(32,32,32)},
        }
        local function ResolveReg(ping)
            local p = tonumber(ping) or 999
            for _, r in ipairs(REGIONS) do if p <= r.max then return r.code, r.color end end
            return "??", Color3.fromRGB(32,32,32)
        end
        
        local srvTitle = MakeLbl(pageServer, "🌐 SERVER TOOLS", UDim2.new(0,0,0,0), UDim2.new(1,0,0,20), Color3.fromRGB(255,255,255))
        srvTitle.TextSize = 14
        local hopRow = Instance.new("Frame", pageServer)
        hopRow.Size = UDim2.new(1,0,0,32); hopRow.Position = UDim2.new(0,0,0,24)
        hopRow.BackgroundTransparency = 1; hopRow.ZIndex = 6
        Instance.new("UIListLayout", hopRow).FillDirection = Enum.FillDirection.Horizontal
        Instance.new("UIListLayout", hopRow).Padding = UDim.new(0,4)
        
        local function MkHopBtn(lbl, order, cb)
            local b = Instance.new("TextButton", hopRow)
            b.Size = UDim2.new(0.33,-3,1,0); b.BackgroundColor3 = Color3.fromRGB(25,25,30)
            b.Text = lbl; b.TextColor3 = Color3.fromRGB(255,255,255)
            b.Font = Enum.Font.GothamBold; b.TextSize = 9; b.LayoutOrder = order; b.ZIndex = 7
            Instance.new("UICorner", b).CornerRadius = UDim.new(0,6)
            Instance.new("UIStroke", b).Color = Color3.fromRGB(60,60,65)
            b.MouseButton1Click:Connect(cb); return b
        end
        
        MkHopBtn("HOP", 1, function()
            if SF.Busy then return end
            SF.Busy = true
            task.spawn(function()
                local svs = FetchServers("Asc")
                if svs then
                    local cj = GetJobId()
                    for _, s in ipairs(svs) do
                        if s.playing < s.maxPlayers and s.id ~= cj then TeleportSrv(s.id); break end
                    end
                end
                SF.Busy = false
            end)
        end)
        MkHopBtn("REJOIN", 2, function()
            pcall(function()
                local jid = GetJobId()
                if jid then Services.TeleportService:TeleportToPlaceInstance(game.PlaceId, jid, Player)
                else Services.TeleportService:Teleport(game.PlaceId, Player) end
            end)
        end)
        MkHopBtn("RANDOM", 3, function()
            if SF.Busy then return end
            SF.Busy = true
            task.spawn(function()
                local svs = FetchServers("Desc")
                if svs and #svs > 0 then
                    local s = svs[math.random(1,#svs)]
                    if s.id ~= GetJobId() then TeleportSrv(s.id) end
                end
                SF.Busy = false
            end)
        end)
        
        local searchRow = Instance.new("Frame", pageServer)
        searchRow.Size = UDim2.new(1,0,0,30); searchRow.Position = UDim2.new(0,0,0,64)
        searchRow.BackgroundTransparency = 1; searchRow.ZIndex = 6
        local srchBox = Instance.new("TextBox", searchRow)
        srchBox.Size = UDim2.new(1,-90,1,0); srchBox.BackgroundColor3 = Color3.fromRGB(15,15,18)
        srchBox.BorderSizePixel = 0; srchBox.PlaceholderText = "Filter by server ID..."
        srchBox.PlaceholderColor3 = Color3.fromRGB(100,100,105); srchBox.Text = ""
        srchBox.TextColor3 = Color3.fromRGB(255,255,255); srchBox.Font = Enum.Font.GothamMedium
        srchBox.TextSize = 10; srchBox.ClearTextOnFocus = false
        srchBox.TextXAlignment = Enum.TextXAlignment.Left; srchBox.ZIndex = 8
        Instance.new("UICorner", srchBox).CornerRadius = UDim.new(0,6)
        Instance.new("UIPadding", srchBox).PaddingLeft = UDim.new(0,8)
        
        local scanSrvBtn = Instance.new("TextButton", searchRow)
        scanSrvBtn.Size = UDim2.new(0,86,1,0); scanSrvBtn.Position = UDim2.new(1,-86,0,0)
        scanSrvBtn.BackgroundColor3 = Color3.fromRGB(25,25,30); scanSrvBtn.Text = "SCAN"
        scanSrvBtn.TextColor3 = Color3.fromRGB(255,255,255); scanSrvBtn.Font = Enum.Font.GothamBold
        scanSrvBtn.TextSize = 10; scanSrvBtn.ZIndex = 8
        Instance.new("UICorner", scanSrvBtn).CornerRadius = UDim.new(0,6)
        
        local filterRow = Instance.new("Frame", pageServer)
        filterRow.Size = UDim2.new(1,0,0,26); filterRow.Position = UDim2.new(0,0,0,100)
        filterRow.BackgroundTransparency = 1; filterRow.ZIndex = 6
        Instance.new("UIListLayout", filterRow).FillDirection = Enum.FillDirection.Horizontal
        Instance.new("UIListLayout", filterRow).Padding = UDim.new(0,4)
        
        local sortBtn = Instance.new("TextButton", filterRow)
        sortBtn.Size = UDim2.new(0.25,-3,1,0); sortBtn.BackgroundColor3 = Color3.fromRGB(25,25,30)
        sortBtn.Text = "SORT ↑"; sortBtn.TextColor3 = Color3.fromRGB(255,255,255)
        sortBtn.Font = Enum.Font.GothamBold; sortBtn.TextSize = 8; sortBtn.ZIndex = 7
        Instance.new("UICorner", sortBtn).CornerRadius = UDim.new(0,6)
        sortBtn.MouseButton1Click:Connect(function()
            SF.Sort = (SF.Sort == "Asc") and "Desc" or "Asc"
            sortBtn.Text = SF.Sort == "Asc" and "SORT ↑" or "SORT ↓"
            if ApplyFilters then ApplyFilters() end
        end)
        
        local function MkFiltBtn(lbl, def, order, cb)
            local s = def
            local b = Instance.new("TextButton", filterRow)
            b.Size = UDim2.new(0.25,-3,1,0); b.BackgroundColor3 = s and Color3.fromRGB(255,255,255) or Color3.fromRGB(25,25,30)
            b.Text = lbl; b.TextColor3 = s and Color3.fromRGB(0,0,0) or Color3.fromRGB(255,255,255)
            b.Font = Enum.Font.GothamBold; b.TextSize = 8; b.LayoutOrder = order; b.ZIndex = 7
            Instance.new("UICorner", b).CornerRadius = UDim.new(0,6)
            b.MouseButton1Click:Connect(function()
                s = not s
                b.BackgroundColor3 = s and Color3.fromRGB(255,255,255) or Color3.fromRGB(25,25,30)
                b.TextColor3 = s and Color3.fromRGB(0,0,0) or Color3.fromRGB(255,255,255)
                cb(s)
                if ApplyFilters then ApplyFilters() end
            end)
            return b
        end
        MkFiltBtn("HIDE FULL", true, 1, function(v) SF.HideFull = v end)
        MkFiltBtn("HIDE EMPTY", false, 2, function(v) SF.HideEmpty = v end)
        
        local srvList = Instance.new("ScrollingFrame", pageServer)
        srvList.Size = UDim2.new(1,0,0,380); srvList.Position = UDim2.new(0,0,0,134)
        srvList.BackgroundColor3 = Color3.fromRGB(10,10,12); srvList.BorderSizePixel = 0
        srvList.ScrollBarThickness = 3; srvList.ScrollBarImageColor3 = Color3.fromRGB(100,100,105)
        srvList.CanvasSize = UDim2.new(0,0,0,0); srvList.AutomaticCanvasSize = Enum.AutomaticSize.Y
        srvList.ZIndex = 7
        Instance.new("UICorner", srvList).CornerRadius = UDim.new(0,6)
        Instance.new("UIListLayout", srvList).Padding = UDim.new(0,3)
        
        local srvStatus = MakeLbl(pageServer, "Press SCAN", UDim2.new(0,0,0,520), UDim2.new(1,0,0,14), Color3.fromRGB(150,150,155))
        srvStatus.TextSize = 9
        
        ApplyFilters = function()
            if not SF.Servers then return end
            local filtered = {}
            local q = string.lower(tostring(srchBox.Text or ""))
            for _, s in ipairs(SF.Servers) do
                local pass = true
                local slots = (s.maxPlayers or 0) - (s.playing or 0)
                if SF.HideFull and slots <= 0 then pass = false end
                if SF.HideEmpty and (s.playing or 0) <= 0 then pass = false end
                if pass and q ~= "" then
                    if not string.find(string.lower(tostring(s.id)), q, 1, true) then pass = false end
                end
                if pass then table.insert(filtered, s) end
            end
            if SF.Sort == "Asc" then
                table.sort(filtered, function(a, b) return (tonumber(a.ping) or 0) < (tonumber(b.ping) or 0) end)
            else
                table.sort(filtered, function(a, b) return (tonumber(a.ping) or 0) > (tonumber(b.ping) or 0) end)
            end
            for _, c in ipairs(srvList:GetChildren()) do if c:IsA("Frame") then c:Destroy() end end
            local cj = GetJobId()
            for i, s in ipairs(filtered) do
                local card = Instance.new("Frame", srvList)
                card.Size = UDim2.new(1,-4,0,56); card.Position = UDim2.new(0,2,0,(i-1)*60+4)
                card.BackgroundColor3 = (s.id == cj) and Color3.fromRGB(40,40,45) or Color3.fromRGB(20,20,25)
                card.ZIndex = 8
                Instance.new("UICorner", card).CornerRadius = UDim.new(0,6)
                local cs = Instance.new("UIStroke", card)
                cs.Color = (s.id == cj) and Color3.fromRGB(255,255,255) or Color3.fromRGB(60,60,65)
                cs.Thickness = 1
                local pv = tonumber(s.ping) or 0
                local rc, rcol = ResolveReg(pv)
                local bg = Instance.new("Frame", card)
                bg.Size = UDim2.new(0,36,0,36); bg.Position = UDim2.new(0,6,0,10)
                bg.BackgroundColor3 = rcol; bg.ZIndex = 9
                Instance.new("UICorner", bg).CornerRadius = UDim.new(0,6)
                local bl = Instance.new("TextLabel", bg)
                bl.Size = UDim2.new(1,0,1,0); bl.BackgroundTransparency = 1
                bl.Text = rc; bl.TextColor3 = Color3.fromRGB(240,240,240)
                bl.Font = Enum.Font.GothamBold; bl.TextSize = 10; bl.ZIndex = 10
                local pl = Instance.new("TextLabel", card)
                pl.Size = UDim2.new(0,120,0,16); pl.Position = UDim2.new(0,48,0,8)
                pl.BackgroundTransparency = 1
                pl.Text = tostring(s.playing) .. "/" .. tostring(s.maxPlayers)
                pl.TextColor3 = Color3.fromRGB(220,220,225); pl.Font = Enum.Font.GothamMedium
                pl.TextSize = 11; pl.TextXAlignment = Enum.TextXAlignment.Left; pl.ZIndex = 9
                local il = Instance.new("TextLabel", card)
                il.Size = UDim2.new(0,120,0,12); il.Position = UDim2.new(0,48,0,28)
                il.BackgroundTransparency = 1
                il.Text = string.sub(tostring(s.id), 1, 10) .. "..."
                il.TextColor3 = Color3.fromRGB(150,150,155); il.Font = Enum.Font.GothamMedium
                il.TextSize = 9; il.TextXAlignment = Enum.TextXAlignment.Left; il.ZIndex = 9
                local pg = Instance.new("TextLabel", card)
                pg.Size = UDim2.new(0,80,0,16); pg.Position = UDim2.new(1,-100,0,8)
                pg.BackgroundTransparency = 1; pg.Text = "Ping " .. tostring(pv) .. "ms"
                pg.TextColor3 = (pv < 80) and Color3.fromRGB(0,255,100) or ((pv < 160) and Color3.fromRGB(255,200,100) or Color3.fromRGB(255,120,120))
                pg.Font = Enum.Font.GothamBold; pg.TextSize = 9
                pg.TextXAlignment = Enum.TextXAlignment.Right; pg.ZIndex = 9
                local br = Instance.new("Frame", card)
                br.Size = UDim2.new(1,-12,0,20); br.Position = UDim2.new(0,6,0,32)
                br.BackgroundTransparency = 1; br.ZIndex = 9
                local cb = Instance.new("TextButton", br)
                cb.Size = UDim2.new(0,50,1,0); cb.BackgroundColor3 = Color3.fromRGB(25,25,30)
                cb.Text = "COPY"; cb.TextColor3 = Color3.fromRGB(255,255,255)
                cb.Font = Enum.Font.GothamBold; cb.TextSize = 9; cb.ZIndex = 10
                Instance.new("UICorner", cb).CornerRadius = UDim.new(0,4)
                local cpd = false
                cb.MouseButton1Click:Connect(function()
                    if cpd then return end; cpd = true
                    pcall(function()
                        if typeof(setclipboard) == "function" then setclipboard(tostring(s.id))
                        elseif typeof(toclipboard) == "function" then toclipboard(tostring(s.id)) end
                    end)
                    cb.Text = "✓"; task.delay(1.5, function() cb.Text = "COPY"; cpd = false end)
                end)
                local jb = Instance.new("TextButton", br)
                jb.Size = UDim2.new(0,60,1,0); jb.Position = UDim2.new(0,56,0,0)
                jb.BackgroundColor3 = (s.id == cj) and Color3.fromRGB(60,60,65) or Color3.fromRGB(255,255,255)
                jb.Text = (s.id == cj) and "HERE" or "JOIN"
                jb.TextColor3 = (s.id == cj) and Color3.fromRGB(150,150,155) or Color3.fromRGB(0,0,0)
                jb.Font = Enum.Font.GothamBold; jb.TextSize = 9; jb.ZIndex = 10
                Instance.new("UICorner", jb).CornerRadius = UDim.new(0,4)
                if s.id ~= cj then jb.MouseButton1Click:Connect(function() TeleportSrv(s.id) end) end
            end
            UHL(srvStatus, "Showing " .. #filtered .. "/" .. #SF.Servers .. " servers")
            srvStatus.TextColor3 = (#filtered > 0) and Color3.fromRGB(255,255,255) or Color3.fromRGB(150,150,155)
        end
        
        scanSrvBtn.MouseButton1Click:Connect(function()
            if SF.Scanning then return end
            SF.Scanning = true; scanSrvBtn.Text = "..."
            UHL(srvStatus, "Scanning..."); srvStatus.TextColor3 = Color3.fromRGB(200,200,205)
            task.spawn(function()
                local svs = FetchServers(SF.Sort)
                SF.Scanning = false; scanSrvBtn.Text = "SCAN"
                if svs then SF.Servers = svs; ApplyFilters()
                else UHL(srvStatus, "Scan failed — HTTP unavailable"); srvStatus.TextColor3 = Color3.fromRGB(200,100,100) end
            end)
        end)
        
        srchBox:GetPropertyChangedSignal("Text"):Connect(function()
            if SF.Servers and #SF.Servers > 0 then ApplyFilters() end
        end)
        
        State.ServerStop = function()
            SF.Busy = false; SF.Scanning = false
        end
    end

    -- ═══ TAB SHIELD ═══
    local pageShield = MakeScrollPage(content, "SHIELD", false)
    pages["SHIELD"] = pageShield
    do
        local WHITELIST_CONFIG = {
            DevURL = "https://raw.githubusercontent.com/dafaremixeruhuy-ctr/hama-hub/main/dev.txt",
            PremiumURL = "https://raw.githubusercontent.com/dafaremixeruhuy-ctr/hama-hub/main/premium.txt",
            CacheTTL = 300,
            Fallback = {Dev={["dpnvhr"]=true,["fire6uns"]=true}, Premium={}},
        }
        local PRIORITY = {Enabled=false, AutoRejoin=true, ExcludeFriends=true,
            DevUsers={}, PremiumUsers={}, FriendCache={}, RejoinCooldown=0, Conn=nil,
            LastFetch=0, Fetching=false, FetchStatus="Not fetched yet"}
        for k, v in pairs(WHITELIST_CONFIG.Fallback.Dev) do PRIORITY.DevUsers[k] = v end
        for k, v in pairs(WHITELIST_CONFIG.Fallback.Premium) do PRIORITY.PremiumUsers[k] = v end
        getgenv().PRIORITY = PRIORITY
        getgenv().WHITELIST_CONFIG = WHITELIST_CONFIG
        
        local function FetchURL(url)
            local body
            if typeof(syn) == "table" and typeof(syn.request) == "function" then
                local ok, r = pcall(syn.request, {Url=url, Method="GET"})
                if ok and r and r.Body then body = r.Body end
            end
            if not body and typeof(http_request) == "function" then
                local ok, r = pcall(http_request, {Url=url, Method="GET"})
                if ok and r and r.Body then body = r.Body end
            end
            if not body and typeof(request) == "function" then
                local ok, r = pcall(request, {Url=url, Method="GET"})
                if ok and r and r.Body then body = r.Body end
            end
            if not body then
                local ok, r = pcall(function() return game:HttpGet(url) end)
                if ok and type(r) == "string" then body = r end
            end
            return body
        end
        local function ParseNames(b)
            local s = {}
            if type(b) ~= "string" then return s end
            for l in b:gmatch("[^\r\n]+") do
                local n = l:match("^%s*(.-)%s*$")
                if n and n ~= "" and not n:match("^#") then s[n] = true end
            end
            return s
        end
        local function CountT(t)
            local n = 0; for _ in pairs(t) do n = n + 1 end; return n
        end
        
        local IsLocalDev, IsLocalPrem, IsDevInSrv, IsPremInSrv, DoRejoin, IsFriendOfLocal
        IsLocalDev = function() return PRIORITY.DevUsers[Player.Name] == true end
        IsLocalPrem = function() return PRIORITY.PremiumUsers[Player.Name] == true end
        IsFriendOfLocal = function(pl)
            if not pl or pl == Player then return false end
            if PRIORITY.FriendCache[pl.Name] then return true end
            local ok, r = pcall(function() return Player:IsFriendsWith(pl.UserId) end)
            if ok and r then PRIORITY.FriendCache[pl.Name] = true; return true end
            return false
        end
        IsDevInSrv = function(exSelf)
            for _, p in ipairs(Players:GetPlayers()) do
                if (not exSelf or p ~= Player) and PRIORITY.DevUsers[p.Name] then return true, p end
            end
            return false, nil
        end
        IsPremInSrv = function(exSelf)
            for _, p in ipairs(Players:GetPlayers()) do
                if (not exSelf or p ~= Player) and PRIORITY.PremiumUsers[p.Name] then return true, p end
            end
            return false, nil
        end
        DoRejoin = function(reason)
            if tick() < PRIORITY.RejoinCooldown then return end
            PRIORITY.RejoinCooldown = tick() + 5
            warn("[HAMA SHIELD] Rejoin: " .. tostring(reason))
            if getgenv()._HAMA_StopSpam then pcall(getgenv()._HAMA_StopSpam) end
            if State.PhysicStop then pcall(State.PhysicStop) end
            if State.HijackStop then pcall(State.HijackStop) end
            if State.SpectateStop then pcall(State.SpectateStop) end
            task.delay(0.5, function()
                pcall(function()
                    local jid = game.JobId
                    if jid and jid ~= "" then Services.TeleportService:TeleportToPlaceInstance(game.PlaceId, jid, Player)
                    else Services.TeleportService:Teleport(game.PlaceId, Player) end
                end)
            end)
        end
        getgenv().HAMA_IsLocalDev = IsLocalDev
        getgenv().HAMA_IsLocalPremium = IsLocalPrem
        getgenv().HAMA_IsDevInServer = IsDevInSrv
        getgenv().HAMA_IsPremiumInServer = IsPremInSrv
        getgenv().HAMA_DoRejoin = DoRejoin
        
        local function UpdFromGH(silent)
            if PRIORITY.Fetching then return end
            PRIORITY.Fetching = true; PRIORITY.FetchStatus = "Fetching..."
            task.spawn(function()
                local nD, nP, ok = {}, {}, false
                local db = FetchURL(WHITELIST_CONFIG.DevURL)
                if db and #db > 0 then nD = ParseNames(db); ok = true end
                local pb = FetchURL(WHITELIST_CONFIG.PremiumURL)
                if pb and #pb > 0 then nP = ParseNames(pb); ok = true end
                if ok then
                    for k, v in pairs(WHITELIST_CONFIG.Fallback.Dev) do nD[k] = nD[k] or v end
                    for k, v in pairs(WHITELIST_CONFIG.Fallback.Premium) do nP[k] = nP[k] or v end
                    PRIORITY.DevUsers = nD; PRIORITY.PremiumUsers = nP
                    PRIORITY.LastFetch = tick()
                    PRIORITY.FetchStatus = "✓ " .. os.date("%H:%M:%S")
                    PRIORITY.FriendCache = {}
                    if not silent then
                        warn("[HAMA] Whitelist updated DEV:" .. CountT(nD) .. " PREM:" .. CountT(nP))
                    end
                    if PRIORITY.Enabled and not IsLocalDev() then
                        local hD, dP = IsDevInSrv(true)
                        local hP, pP = IsPremInSrv(true)
                        if hD and PRIORITY.AutoRejoin and Spam.Running then
                            DoRejoin("DEV " .. (dP and dP.Name or "?"))
                        elseif hP and not IsLocalPrem() and PRIORITY.AutoRejoin and Spam.Running then
                            DoRejoin("PREM " .. (pP and pP.Name or "?"))
                        end
                    end
                else
                    PRIORITY.FetchStatus = "⚠ Fetch failed"
                end
                PRIORITY.Fetching = false
            end)
        end
        UpdFromGH(true)
        task.spawn(function()
            while true do
                task.wait(WHITELIST_CONFIG.CacheTTL)
                if not PRIORITY.Fetching then UpdFromGH(true) end
            end
        end)
        
        local shTitle = MakeLbl(pageShield, "🔒 PRIORITY SHIELD", UDim2.new(0,0,0,0), UDim2.new(1,0,0,20), Color3.fromRGB(255,255,255))
        shTitle.TextSize = 14
        local shLocalStatus = MakeLbl(pageShield, "Local: ...", UDim2.new(0,0,0,24), UDim2.new(1,0,0,16), Color3.fromRGB(200,200,205))
        shLocalStatus.TextSize = 10
        local shSrvStatus = MakeLbl(pageShield, "Server: ...", UDim2.new(0,0,0,42), UDim2.new(1,0,0,16), Color3.fromRGB(200,200,205))
        shSrvStatus.TextSize = 10
        
        local function UpdStatus()
            local r, c
            if IsLocalDev() then r, c = "DEV 👑", Color3.fromRGB(255,215,0)
            elseif IsLocalPrem() then r, c = "PREMIUM ⭐", Color3.fromRGB(180,200,255)
            else r, c = "REGULAR", Color3.fromRGB(200,200,205) end
            UHL(shLocalStatus, "Local: " .. r); shLocalStatus.TextColor3 = c
            local hD, dP = IsDevInSrv(true); local hP, pP = IsPremInSrv(true)
            if hD then UHL(shSrvStatus, "⚠ DEV: " .. dP.Name); shSrvStatus.TextColor3 = Color3.fromRGB(255,80,80)
            elseif hP then UHL(shSrvStatus, "⚠ PREM: " .. pP.Name); shSrvStatus.TextColor3 = Color3.fromRGB(255,180,80)
            else UHL(shSrvStatus, "✓ Server CLEAN"); shSrvStatus.TextColor3 = Color3.fromRGB(0,255,100) end
        end
        
        local shEnableBtn = MakeBtn(pageShield, "SHIELD: OFF", UDim2.new(0,0,0,68), UDim2.new(0.48,-2,0,32), Color3.fromRGB(25,25,30))
                -- ═══ UNIVERSAL ANTI-LAG SHIELD (ANTI CHEATER) ═══
                local isUniversalShieldOn = false
                local shieldHooked = false
                local _hookedRemotes = setmetatable({}, {__mode = "k"})
        
                local shieldBtn = MakeBtn(pageShield, "UNIVERSAL ANTI-LAG: OFF", UDim2.new(0,0,0,376), UDim2.new(1,0,0,32), Color3.fromRGB(25,25,30))
                shieldBtn.MouseButton1Click:Connect(function()
                    isUniversalShieldOn = not isUniversalShieldOn
                    shieldBtn.Text = "UNIVERSAL ANTI-LAG: " .. (isUniversalShieldOn and "ON" or "OFF")
                    shieldBtn.BackgroundColor3 = isUniversalShieldOn and Color3.fromRGB(255,255,255) or Color3.fromRGB(25,25,30)
                    shieldBtn.TextColor3 = isUniversalShieldOn and Color3.fromRGB(0,0,0) or Color3.fromRGB(255,255,255)
                    
                    if isUniversalShieldOn then
                        warn("[SHIELD] Universal Anti-Lag aktif. Client lu kebal dari spam remote piano!")
                        -- Pasang Hook ke Metamethod buat nyegat data spam
                        if not shieldHooked then
                            pcall(function()
                                local mt = getrawmetatable(game)
                                if setreadonly then setreadonly(mt, false) end
                                local origNC = mt.__namecall
                                mt.__namecall = newcclosure(function(self, ...)
                                    local method = getnamecallmethod()
                                    -- Jika ada remote piano yang nembak client lu, kita BLOKIR
                                    if method == "FireClient" or method == "InvokeClient" then
                                        if isUniversalShieldOn then
                                            local name = self.Name:lower()
                                            -- Deteksi nama remote spam (piano, note, music, dll)
                                            if name:find("piano") or name:find("note") or name:find("play") or name:find("music") or name:find("sound") then
                                                if not _hookedRemotes[self] then
                                                    _hookedRemotes[self] = 0
                                                end
                                                _hookedRemotes[self] = _hookedRemotes[self] + 1
                                                
                                                -- Kalo spam nya keterlaluan, kita drop (biarin kosong, jangan diproses)
                                                if _hookedRemotes[self] > 50 then -- batas wajar spam per detik
                                                    return -- Drop paket! Client aman.
                                                end
                                            end
                                        end
                                    end
                                    return origNC(self, ...)
                                end)
                                if setreadonly then setreadonly(mt, true) end
                                shieldHooked = true
                            end)
                        end
                    else
                        warn("[SHIELD] Universal Anti-Lag dimatikan.")
                    end
                end)
        local function StartMon()
            if PRIORITY.Conn then return end
            PRIORITY.Conn = Players.PlayerAdded:Connect(function(pl)
                if not PRIORITY.Enabled then return end
                if IsLocalDev() then return end
                if PRIORITY.ExcludeFriends and IsFriendOfLocal(pl) then return end
                if PRIORITY.DevUsers[pl.Name] then
                    if Spam.Running and PRIORITY.AutoRejoin then DoRejoin("DEV " .. pl.Name .. " joined") end
                elseif PRIORITY.PremiumUsers[pl.Name] then
                    if Spam.Running and PRIORITY.AutoRejoin and not IsLocalPrem() then DoRejoin("PREM " .. pl.Name .. " joined") end
                end
            end)
        end
        shEnableBtn.MouseButton1Click:Connect(function()
            PRIORITY.Enabled = not PRIORITY.Enabled
            shEnableBtn.Text = "SHIELD: " .. (PRIORITY.Enabled and "ON" or "OFF")
            shEnableBtn.BackgroundColor3 = PRIORITY.Enabled and Color3.fromRGB(255,255,255) or Color3.fromRGB(25,25,30)
            shEnableBtn.TextColor3 = PRIORITY.Enabled and Color3.fromRGB(0,0,0) or Color3.fromRGB(255,255,255)
            if PRIORITY.Enabled then StartMon(); UpdStatus()
            else
                if PRIORITY.Conn then PRIORITY.Conn:Disconnect(); PRIORITY.Conn = nil end
            end
        end)
        
        local shARBtn = MakeBtn(pageShield, "AUTO REJOIN: ON", UDim2.new(0.52,2,0,68), UDim2.new(0.48,-2,0,32), Color3.fromRGB(255,255,255))
        shARBtn.TextColor3 = Color3.fromRGB(0,0,0)
        shARBtn.MouseButton1Click:Connect(function()
            PRIORITY.AutoRejoin = not PRIORITY.AutoRejoin
            shARBtn.Text = "AUTO REJOIN: " .. (PRIORITY.AutoRejoin and "ON" or "OFF")
            shARBtn.BackgroundColor3 = PRIORITY.AutoRejoin and Color3.fromRGB(255,255,255) or Color3.fromRGB(25,25,30)
            shARBtn.TextColor3 = PRIORITY.AutoRejoin and Color3.fromRGB(0,0,0) or Color3.fromRGB(255,255,255)
        end)
        
        local shExclBtn = MakeBtn(pageShield, "EXCL FRIENDS: ON", UDim2.new(0,0,0,104), UDim2.new(1,0,0,32), Color3.fromRGB(255,255,255))
        shExclBtn.TextColor3 = Color3.fromRGB(0,0,0)
        shExclBtn.MouseButton1Click:Connect(function()
            PRIORITY.ExcludeFriends = not PRIORITY.ExcludeFriends
            shExclBtn.Text = "EXCL FRIENDS: " .. (PRIORITY.ExcludeFriends and "ON" or "OFF")
            shExclBtn.BackgroundColor3 = PRIORITY.ExcludeFriends and Color3.fromRGB(255,255,255) or Color3.fromRGB(25,25,30)
            shExclBtn.TextColor3 = PRIORITY.ExcludeFriends and Color3.fromRGB(0,0,0) or Color3.fromRGB(255,255,255)
            if not PRIORITY.ExcludeFriends then PRIORITY.FriendCache = {} end
        end)
        
        local shFRBtn = MakeBtn(pageShield, "🔄 FORCE REJOIN", UDim2.new(0,0,0,144), UDim2.new(0.48,-2,0,34), Color3.fromRGB(25,25,30))
        shFRBtn.MouseButton1Click:Connect(function() DoRejoin("Manual rejoin") end)
        
        local shPanicBtn = MakeBtn(pageShield, "🛑 PANIC STOP", UDim2.new(0.52,2,0,144), UDim2.new(0.48,-2,0,34), Color3.fromRGB(25,25,30))
        shPanicBtn.MouseButton1Click:Connect(function()
            if getgenv()._HAMA_StopSpam then pcall(getgenv()._HAMA_StopSpam) end
            if State.PhysicStop then pcall(State.PhysicStop) end
            if State.HijackStop then pcall(State.HijackStop) end
            if State.SpectateStop then pcall(State.SpectateStop) end
            if State.VoidStop then pcall(State.VoidStop) end
            UHL(shSrvStatus, "✓ ALL STOPPED"); shSrvStatus.TextColor3 = Color3.fromRGB(255,255,255)
        end)
        
        local shRefreshBtn = MakeBtn(pageShield, "🔄 REFRESH WHITELIST", UDim2.new(0,0,0,186), UDim2.new(1,0,0,30), Color3.fromRGB(25,25,30))
        shRefreshBtn.MouseButton1Click:Connect(function() UpdFromGH(false); task.delay(2, UpdStatus) end)
        
        local shFetchLbl = MakeLbl(pageShield, "GitHub: ...", UDim2.new(0,0,0,220), UDim2.new(1,0,0,14), Color3.fromRGB(150,150,155))
        shFetchLbl.TextSize = 9
        local shListTitle = MakeLbl(pageShield, "📋 PRIORITY LIST", UDim2.new(0,0,0,242), UDim2.new(1,0,0,14), Color3.fromRGB(255,255,255))
        shListTitle.TextSize = 10
        local shListContent = Instance.new("TextLabel", pageShield)
        shListContent.Size = UDim2.new(1,0,0,120); shListContent.Position = UDim2.new(0,0,0,260)
        shListContent.BackgroundColor3 = Color3.fromRGB(10,10,12); shListContent.BorderSizePixel = 0
        shListContent.RichText = true; shListContent.TextColor3 = Color3.fromRGB(220,220,225)
        shListContent.Font = Enum.Font.GothamMedium; shListContent.TextSize = 9
        shListContent.TextXAlignment = Enum.TextXAlignment.Left
        shListContent.TextYAlignment = Enum.TextYAlignment.Top
        shListContent.TextWrapped = true; shListContent.ZIndex = 7
        Instance.new("UICorner", shListContent).CornerRadius = UDim.new(0,6)
        Instance.new("UIPadding", shListContent).PaddingLeft = UDim.new(0,8)
        Instance.new("UIPadding", shListContent).PaddingTop = UDim.new(0,4)
        
        local function UpdList()
            local dN, pN = {}, {}
            for n in pairs(PRIORITY.DevUsers) do dN[#dN+1] = n end
            for n in pairs(PRIORITY.PremiumUsers) do pN[#pN+1] = n end
            table.sort(dN); table.sort(pN)
            shListContent.Text = '<font color="#FFD700">👑 DEV:</font>\n  ' .. ((#dN > 0) and table.concat(dN, ", ") or "—") ..
                '\n\n<font color="#B0C8FF">⭐ PREM:</font>\n  ' .. ((#pN > 0) and table.concat(pN, ", ") or "—")
        end
        UpdList()
        
        task.spawn(function()
            while true do
                task.wait(3)
                if not pageShield.Parent then break end
                pcall(UpdStatus); pcall(UpdList)
                if shFetchLbl.Parent then UHL(shFetchLbl, "GitHub: " .. tostring(PRIORITY.FetchStatus)) end
            end
        end)
        
        State.ShieldStop = function()
            if PRIORITY.Conn then PRIORITY.Conn:Disconnect(); PRIORITY.Conn = nil end
            PRIORITY.Enabled = false
        end
    end

    -- ═══ TAB ABOUT ═══
    local pageAbout = MakeScrollPage(content, "ABOUT", false)
    pages["ABOUT"] = pageAbout
    do
        local aboutT = MakeLbl(pageAbout, "HAMA UNIVERSAL HUB", UDim2.new(0,0,0,10), UDim2.new(1,0,0,30), Color3.fromRGB(255,255,255))
        aboutT.TextSize = 18; aboutT.TextXAlignment = Enum.TextXAlignment.Center
        local aboutV = MakeLbl(pageAbout, "Version 4.0 | HAMA Monochrome Edition", UDim2.new(0,0,0,40), UDim2.new(1,0,0,20), Color3.fromRGB(150,150,155))
        aboutV.TextXAlignment = Enum.TextXAlignment.Center
        local devLbl = MakeLbl(pageAbout, "— DEVELOPED BY —", UDim2.new(0,0,0,80), UDim2.new(1,0,0,20), Color3.fromRGB(200,200,205))
        devLbl.TextXAlignment = Enum.TextXAlignment.Center
        local devNames = MakeLbl(pageAbout, "@dpnvhr\n@fire6uns", UDim2.new(0,0,0,105), UDim2.new(1,0,0,50), Color3.fromRGB(255,255,255))
        devNames.TextSize = 14; devNames.TextXAlignment = Enum.TextXAlignment.Center
        devNames.TextYAlignment = Enum.TextYAlignment.Top
        local thanks = MakeLbl(pageAbout, "Complete Edition - All HAMA features merged\n100 Levels Spam | 4-Phase | Hook Amp | Void | Spectate | Safe Follow | Forest | Server Finder | Priority Shield",
            UDim2.new(0,0,0,180), UDim2.new(1,0,0,60), Color3.fromRGB(180,180,185))
        thanks.TextXAlignment = Enum.TextXAlignment.Center; thanks.TextWrapped = true
        local copy = MakeLbl(pageAbout, "© 2026 HAMA Universal Hub.", UDim2.new(0,0,0,260), UDim2.new(1,0,0,20), Color3.fromRGB(100,100,105))
        copy.TextXAlignment = Enum.TextXAlignment.Center
    end

        -- ═══ CLOSE ═══
        closeBtn.MouseButton1Click:Connect(function()
            gui:Destroy()
        end)
    
        gui.Destroying:Connect(function()
            pcall(function() if State.VoidStop then State.VoidStop() end end)
            pcall(function() if State.SpectateStop then State.SpectateStop() end end)
            pcall(function() if State.PhysicStop then State.PhysicStop() end end)
            pcall(function() if State.PlayerExtraStop then State.PlayerExtraStop() end end)
            pcall(function() if State.ServerStop then State.ServerStop() end end)
            pcall(function() if State.ShieldStop then State.ShieldStop() end end)
            pcall(function() if getgenv()._HAMA_StopSpam then getgenv()._HAMA_StopSpam() end end)
            _HM_Uninstall(); RestoreSimulation()
            _G.HamaGUI = nil
        end)
    
        switchTab("PIANO")
    end
end -- <-- TAMBAHKAN END INI UNTUK MENUTUP FUNCTION CreateUI

local ok, err = pcall(CreateUI)
if not ok then warn("[HAMA] CreateUI ERROR:", err) end
print("[HAMA] Universal V4.0 loaded")
