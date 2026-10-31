local _0x108D = {
_0x7E7C = game:GetService("Players"),
_0x1EE5 = game:GetService("RunService"),
_0x938B = game:GetService("Workspace"),
ReplicatedStorage = game:GetService("ReplicatedStorage"),
UserInputService = game:GetService("UserInputService"),
TeleportService = game:GetService("TeleportService"),
_0x1B54 = game:GetService("TweenService"),
_0x633F = game:GetService("HttpService"),
}
local _0xAD3B = _0x108D.Players.LocalPlayer
local _0x1EE5 = _0x108D.RunService
local _0xE442 = _0x108D.UserInputService
local _0x1B54 = _0x108D.TweenService
local _0x633F = _0x108D.HttpService
local _0x938B = _0x108D.Workspace
local _0x1DDD = _0x108D.ReplicatedStorage
local _0x7E7C = _0x108D.Players
local _0xFCCE = {
OwnerName ="dpnvhr", IsWhitelisted = true,
PianoSpamming = false, SelectedRemote = nil, SelectedPiano = nil, FoundPianos = {},
Level = 10, Threads = 10, KeyMult = 1, Mode ="nuke", FireCount = 0, RemoteFormat ="positional",
FlyEnabled = false, FlySpeed = 50, FlyKeybind = Enum.KeyCode.F,
NoclipEnabled = false, InvisibleEnabled = false, SpeedEnabled = false, WalkSpeed = 16,
TargetPlayer = nil, TrollMode ="NONE", TrollActive = false, TrollConn = nil,
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
if not getrawmetatable then getrawmetatable = function() return {} end endlocal _0x10FF, _0x739D, _0x27D7 = false, nil, {}
local function _0x3231(_0xE24D, _0xC35E)
if typeof(setreadonly) =="function"then pcall(setreadonly, _0xE24D, not _0xC35E)
elseif typeof(make_writeable) =="function"and _0xC35E then pcall(make_writeable, _0xE24D) end
end
local function _0x09B1()
if _0x10FF then return end
if typeof(hookmetamethod) ~="function"or typeof(getrawmetatable) ~="function"then return end
local _0xE24D = getrawmetatable(game)
_0x739D = _0xE24D.__namecall
local _0x9448 = _0x739D
_0x3231(_0xE24D, true)
_0xE24D.__namecall = newcclosure(function(self, ...)
local _0xFBBD = getnamecallmethod()
if _0xFBBD ~="FireServer"and _0xFBBD ~="InvokeServer"then return _0x9448(self, ...) end
if _0x27D7[self] then
local _0xD1DF = {...}; local _0x89CE = _0xFCCE.HookAmplifier
if _0xFBBD =="FireServer"then
for _ = 1, _0x89CE do _0x9448(self, table.unpack(_0xD1DF)) end
else
for _ = 1, _0x89CE do task.spawn(_0x9448, self, table.unpack(_0xD1DF)) end
end
end
return _0x9448(self, ...)
end)
_0x3231(_0xE24D, false)
_0x10FF = true
end
local function _0x6049()
if not _0x10FF or typeof(getrawmetatable) ~="function"then return end
local _0xE24D = getrawmetatable(game)
_0x3231(_0xE24D, true)
if _0x739D then _0xE24D.__namecall = _0x739D; _0x739D = nil end
_0x3231(_0xE24D, false)
_0x10FF = false; _0x27D7 = {}
end
local function _0x9700(_0x16F9)
_0x27D7 = {}
for _, _0x13FA in ipairs(_0x16F9) do if _0x13FA and _0x13FA.Parent then _0x27D7[_0x13FA] = true end end
end
local function _0x40DB()
if not _0xFCCE.SimHack then return end
pcall(function()
sethiddenproperty(_0xAD3B,"SimulationRadius", 1e15)
sethiddenproperty(_0xAD3B,"MaxSimulationRadius", 1e15)
settings().Physics.AllowSleep = false
settings().Physics.ThrottleAdjustTime = 0
end)
end
local function _0x14BB()
pcall(function()
sethiddenproperty(_0xAD3B,"SimulationRadius", 1024)
sethiddenproperty(_0xAD3B,"MaxSimulationRadius", 1024)
settings().Physics.AllowSleep = true
end)
endlocal _0x6AE8 = {"piano","keyboard","keys","organ","synthesizer","grand","upright","key","music","sound","instrument","note","play"}
local function _0xC58B(_0x9A34)
if not _0x9A34 then return false end
_0x9A34 = _0x9A34:lower()
for _, kw in ipairs(_0x6AE8) do if _0x9A34:find(kw) then return true end end
return false
end
local function _0x8DF0()
local _0x8F3D, _0x4A0B = {}, {}
for _, obj in ipairs(_0x938B:GetDescendants()) do
if (obj:IsA("Seat") or obj:IsA("VehicleSeat")) and not _0x4A0B[obj] then
local _0xC083 = _0xC58B(obj.Name)
local _0x9E37 = obj.Parent and _0xC58B(obj.Parent.Name)
local _0x681C = obj.Parent and obj.Parent.Parent and _0xC58B(obj.Parent.Parent.Name)
local _0x0E7B = false
if obj.Parent and obj.Parent:IsA("BasePart") then
for _, _0x16E4 in ipairs(obj.Parent:GetChildren()) do
if _0x16E4:IsA("ProximityPrompt") and (_0xC58B(_0x16E4.ActionText) or _0xC58B(_0x16E4.ObjectText)) then _0x0E7B = true end
end
end
if _0xC083 or _0x9E37 or _0x681C or _0x0E7B then
_0x4A0B[obj] = true
local _0xBD98 = obj.Name
local _0x076C = obj.Parent
for _ = 1, 3 do
if _0x076C and _0x076C ~= _0x938B and _0x076C:IsA("Model") then _0xBD98 = _0x076C.Name; break end
if _0x076C then _0x076C = _0x076C.Parent end
end
table.insert(_0x8F3D, {
_0xEA85 = obj, pos = obj.Position, name = _0xBD98,
label = string.format("[%d] %s [%d, %d, %d]", #_0x8F3D + 1, _0xBD98, math.floor(obj.Position.X), math.floor(obj.Position.Y), math.floor(obj.Position.Z))
})
end
end
end
return _0x8F3D
end
local function _0x76E7()
local _0x7C5C = {}
for _, obj in ipairs(_0x1DDD:GetDescendants()) do
if obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction") then
local _0x89CE = obj.Name:lower()
if _0x89CE:find("piano") or _0x89CE:find("note") or _0x89CE:find("play") or _0x89CE:find("music") or _0x89CE:find("sound") then table.insert(_0x7C5C, obj) end
end
end
if #_0x7C5C == 0 then
local _0x463A = _0x938B:FindFirstChild("GlobalPianoConnector")
if _0x463A and (_0x463A:IsA("RemoteEvent") or _0x463A:IsA("RemoteFunction")) then table.insert(_0x7C5C, _0x463A) end
end
return _0x7C5C
endlocal _0x3553, _0x029E, _0x85D7
local function _0xC760(_0x9023)
_0xFCCE.FlyEnabled = _0x9023
local _0x5E24 = _0xAD3B.Character
local _0x7503 = _0x5E24 and _0x5E24:FindFirstChild("HumanoidRootPart")
local _0xCA3D = _0x5E24 and _0x5E24:FindFirstChildOfClass("Humanoid")
if _0x9023 and _0x7503 and _0xCA3D then
_0xCA3D.PlatformStand = true
_0x3553 = Instance.new("BodyVelocity", _0x7503); _0x3553.MaxForce = Vector3.new(1e5,1e5,1e5); _0x3553.Velocity = Vector3.zero
_0x029E = Instance.new("BodyGyro", _0x7503); _0x029E.MaxTorque = Vector3.new(1e5,1e5,1e5); _0x029E.P = 1000
_0x85D7 = _0x1EE5.RenderStepped:Connect(function()
if not _0xFCCE.FlyEnabled then return end
local _0x46E8 = _0x938B.CurrentCamera
local _0xDC86 = Vector3.zero
if _0xE442:IsKeyDown(Enum.KeyCode.W) then _0xDC86 += _0x46E8.CFrame.LookVector end
if _0xE442:IsKeyDown(Enum.KeyCode.S) then _0xDC86 -= _0x46E8.CFrame.LookVector end
if _0xE442:IsKeyDown(Enum.KeyCode.A) then _0xDC86 -= _0x46E8.CFrame.RightVector end
if _0xE442:IsKeyDown(Enum.KeyCode.D) then _0xDC86 += _0x46E8.CFrame.RightVector end
if _0xE442:IsKeyDown(Enum.KeyCode.Space) then _0xDC86 += Vector3.new(0,1,0) end
if _0xE442:IsKeyDown(Enum.KeyCode.LeftControl) then _0xDC86 -= Vector3.new(0,1,0) end
_0x3553.Velocity = _0xDC86.Magnitude > 0 and _0xDC86.Unit * _0xFCCE.FlySpeed or Vector3.zero
_0x029E.CFrame = _0x46E8.CFrame
end)
else
if _0x85D7 then _0x85D7:Disconnect(); _0x85D7 = nil end
if _0x3553 then _0x3553:Destroy(); _0x3553 = nil end
if _0x029E then _0x029E:Destroy(); _0x029E = nil end
if _0xCA3D then _0xCA3D.PlatformStand = false end
end
end
local function _0x2210()
local _0xCA3D = _0xAD3B.Character and _0xAD3B.Character:FindFirstChildOfClass("Humanoid")
if _0xCA3D then _0xCA3D.WalkSpeed = _0xFCCE.SpeedEnabled and _0xFCCE.WalkSpeed or 16 end
end
local _0xCC83
local function _0x5C6E(_0x9023)
_0xFCCE.NoclipEnabled = _0x9023
if _0xCC83 then _0xCC83:Disconnect(); _0xCC83 = nil end
if _0x9023 then
_0xCC83 = _0x1EE5.Stepped:Connect(function()
if not _0xFCCE.NoclipEnabled then return end
local _0x16E4 = _0xAD3B.Character; if not _0x16E4 then return end
for _, _0x7ADD in ipairs(_0x16E4:GetDescendants()) do if _0x7ADD:IsA("BasePart") then _0x7ADD.CanCollide = false end end
end)
end
end
_0xE442.InputBegan:Connect(function(input, gp)
if gp then return end
if input.KeyCode == _0xFCCE.FlyKeybind then _0xC760(not _0xFCCE.FlyEnabled) end
end)local _0x85FF = {}
local _0x8E1C = {
{_0x16E4=14,_0x98D0=0.00060,_0x9A34=0.0016,_0x8170="WARM-UP"},{_0x16E4=20,_0x98D0=0.00050,_0x9A34=0.0019,_0x8170="RISING"},
{_0x16E4=27,_0x98D0=0.00040,_0x9A34=0.0022,_0x8170="HEATING"},{_0x16E4=34,_0x98D0=0.00033,_0x9A34=0.0024,_0x8170="AGGRESSIVE"},
{_0x16E4=42,_0x98D0=0.00027,_0x9A34=0.0026,_0x8170="STORM"},{_0x16E4=54,_0x98D0=0.00021,_0x9A34=0.0028,_0x8170="OVERLOAD"},
{_0x16E4=68,_0x98D0=0.00017,_0x9A34=0.0030,_0x8170="BRUTAL"},{_0x16E4=88,_0x98D0=0.00013,_0x9A34=0.0030,_0x8170="SAVAGE"},
{_0x16E4=114,_0x98D0=0.00010,_0x9A34=0.0030,_0x8170="CATASTROPHIC"},{_0x16E4=150,_0x98D0=0.00008,_0x9A34=0.0030,_0x8170="EXTINCTION"},
}
for i = 1, 10 do _0x85FF[i] = {_0xD8C8=_0x8E1C[i].c, _0xF006=_0x8E1C[i].b, sigBudget=_0x8E1C[i].s, label="Lv."..i.." ".._base[i].l} end
local _0x27B2 = {"MASSACRE","CARNAGE","RAMPAGE","DEVASTATION","ANNIHILATION","OBLITERATION","ERADICATION","EXTERMINATION","TERMINATION","ARMAGEDDON","HELLFIRE","INFERNO","NAPALM","FIRESTORM","NUCLEAR","MELTDOWN","FALLOUT","SUPERNOVA","SINGULARITY","VOID COLLAPSE","ENTROPY","CHAOS THEORY","DARK MATTER","NEUTRON FLUX","GRAVITON","EVENT HORIZON","WARP CORE","ANTIMATTER","PLASMA SURGE","QUANTUM RIFT","ZERO-POINT","TEMPORAL FLUX","GAMMA BURST","X-RAY PULSE","NEUTRON STAR","PULSAR WAVE","BLACK HOLE","DARK ENERGY","TACHYON FLOOD","COSMIC RAY","ION STORM","PHOTON LANCE","NEUTRINO BLAST","MUON SURGE","QUARK STORM","SUBATOMIC","ZERO-KELVIN","ULTRAVIOLET","HYPERWAVE","DEATHWAVE","OMNISLASH","GODMODE","JUDGMENT","RECKONING","NO ESCAPE","FINAL FORM","ULTRA KILL","MEGADEATH","ABSOLUTE ZERO","GENOCIDE","ENDGAME","TERMINUS","OMEGA","SIGMA","APOCALYPSE NOW","CATACLYSM","RAPTURE","DOOMSDAY","HEAT DEATH","UNIVERSE END","SILENT KILLER","PHANTOM NUKE","GHOST PROTOCOL","DARK OPERATION","SHADOW COLLAPSE","MAXIMUM CARNAGE","REIGN OF CHAOS","ETERNAL STORM","IMMORTAL RAGE","SERVER DEATH","PURE CHAOS","RAW POWER","BRUTAL FORCE","NO MERCY","SYSTEM FAILURE"}
for i = 11, 100 do
local _0xE0FB = (i - 10) / 90
local _0xD8C8 = math.floor(150 + (2200 - 150) * (_0xE0FB ^ 0.7))
local _0xF006 = 0.00008 * math.exp(-_0xE0FB * 6.4)
_0x85FF[i] = {_0xD8C8=_0xD8C8, _0xF006=_0xF006, sigBudget=0.0020, label="Lv."..i.." "..(_0x27B2[i - 10] or"TIER "..i)}
endlocal function _0xB397(_0xE0FB) return tostring(_0xE0FB):gsub("(%d+)",'<font color="#00ff64">%1</font>') end
local function _0x97B6(_0x7F51)
local _0xB7DE = Instance.new("Frame", _0x7F51); _0xB7DE.Size = UDim2.new(1,0,1,0)
_0xB7DE.Position = UDim2.new(0,3,0,3); _0xB7DE.BackgroundColor3 = Color3.fromRGB(0,0,0)
_0xB7DE.BackgroundTransparency = 0.4; _0xB7DE.BorderSizePixel = 0; _0xB7DE.ZIndex = _0x7F51.ZIndex - 1
Instance.new("UICorner", _0xB7DE).CornerRadius = UDim.new(0, 4)
local _0xD5C6 = Instance.new("Frame", _0x7F51)
_0xD5C6.Size = UDim2.new(1,-4,0,3); _0xD5C6.Position = UDim2.new(0,2,0,1)
_0xD5C6.BackgroundColor3 = Color3.fromRGB(255,255,255); _0xD5C6.BackgroundTransparency = 0.7
_0xD5C6.BorderSizePixel = 0; _0xD5C6.ZIndex = _0x7F51.ZIndex + 1
Instance.new("UICorner", _0xD5C6).CornerRadius = UDim.new(0, 2)
local _0x3580, _0x7853 = _0x7F51.Size, _0x7F51.Position
_0x7F51.MouseButton1Down:Connect(function() _0x7F51.Size = UDim2.new(_0x3580.X.Scale, _0x3580.X.Offset-2, _0x3580.Y.Scale, _0x3580.Y.Offset-2); _0x7F51.Position = _0x7853 + UDim2.new(0,1,0,1) end)
_0x7F51.MouseButton1Up:Connect(function() _0x7F51.Size = _0x3580; _0x7F51.Position = _0x7853 end)
_0x7F51.MouseLeave:Connect(function() _0x7F51.Size = _0x3580; _0x7F51.Position = _0x7853 end)
end
local function _0x3025(parent, text, pos, size, color)
local _0x98D0 = Instance.new("TextButton", parent)
_0x98D0.Size = size or UDim2.new(1,0,0,32); _0x98D0.Position = pos
_0x98D0.BackgroundColor3 = color or Color3.fromRGB(20,20,24)
_0x98D0.Text = text; _0x98D0.TextColor3 = Color3.fromRGB(255,255,255)
_0x98D0.Font = Enum.Font.GothamBold; _0x98D0.TextSize = 11; _0x98D0.ZIndex = 7
Instance.new("UICorner", _0x98D0).CornerRadius = UDim.new(0,6)
local _0x9A34 = Instance.new("UIStroke", _0x98D0)
_0x9A34.Color = Color3.fromRGB(60,60,65); _0x9A34.Thickness = 1
_0x97B6(_0x98D0); return _0x98D0
end
local function _0x9565(parent, text, pos, size, color)
local _0x8170 = Instance.new("TextLabel", parent)
_0x8170.Size = size or UDim2.new(1,0,0,18); _0x8170.Position = pos
_0x8170.BackgroundTransparency = 1; _0x8170.RichText = true; _0x8170.Text = _0xB397(text)
_0x8170.TextColor3 = color or Color3.fromRGB(220,220,225)
_0x8170.Font = Enum.Font.GothamMedium; _0x8170.TextSize = 11
_0x8170.TextXAlignment = Enum.TextXAlignment.Left; _0x8170.ZIndex = 7
return _0x8170
end
local function _0xAF1E(_0x8170, _0xE0FB) if _0x8170 then _0x8170.Text = _0xB397(_0xE0FB) end end
local function _0x64D0(parent, label, pos, mn, mx, def, _0xC7EB)
local _0x8170 = Instance.new("TextLabel", parent)
_0x8170.Size = UDim2.new(1,0,0,16); _0x8170.Position = pos; _0x8170.BackgroundTransparency = 1
_0x8170.RichText = true; _0x8170.Text = _0xB397(label..": "..def)
_0x8170.TextColor3 = Color3.fromRGB(180,180,185); _0x8170.Font = Enum.Font.GothamMedium
_0x8170.TextSize = 10; _0x8170.TextXAlignment = Enum.TextXAlignment.Left; _0x8170.ZIndex = 7
local _0x2168 = Instance.new("Frame", parent)
_0x2168.Size = UDim2.new(1,0,0,14); _0x2168.Position = pos + UDim2.new(0,0,0,18)
_0x2168.BackgroundColor3 = Color3.fromRGB(30,30,35); _0x2168.ZIndex = 6
Instance.new("UICorner", _0x2168).CornerRadius = UDim.new(1,0)
local _0x4344 = Instance.new("UIStroke", _0x2168); _0x4344.Color = Color3.fromRGB(60,60,65); _0x4344.Thickness = 1; _0x4344.Transparency = 0.5
local _0xE85C = Instance.new("Frame", _0x2168)
_0xE85C.Size = UDim2.new((def-mn)/(mx-mn),0,1,0)
_0xE85C.BackgroundColor3 = Color3.fromRGB(255,255,255); _0xE85C.BorderSizePixel = 0; _0xE85C.ZIndex = 7
Instance.new("UICorner", _0xE85C).CornerRadius = UDim.new(1,0)
local _0x7B19 = false
local function _0x9DF6(i)
local _0x9F13 = math.clamp((i.Position.X - _0x2168.AbsolutePosition.X) / _0x2168.AbsoluteSize.X, 0, 1)
local _0x8A30 = math.floor(mn + _0x9F13 * (mx - mn))
_0xE85C.Size = UDim2.new(_0x9F13,0,1,0); _0xAF1E(_0x8170, label..": "..v); _0xC7EB(_0x8A30)
end
_0x2168.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then _0x7B19 = true; _0x9DF6(i) end end)
_0xE442.InputChanged:Connect(function(i) if _0x7B19 and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then _0x9DF6(i) end end)
_0xE442.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then _0x7B19 = false end end)
end
local function _0x9927(parent, name, vis)
local _0x8BC2 = Instance.new("ScrollingFrame", parent)
_0x8BC2.Name = name; _0x8BC2.Size = UDim2.new(1,0,1,0)
_0x8BC2.BackgroundTransparency = 1; _0x8BC2.BorderSizePixel = 0
_0x8BC2.ScrollBarThickness = 3; _0x8BC2.ScrollBarImageColor3 = Color3.fromRGB(100,100,105)
_0x8BC2.CanvasSize = UDim2.new(0,0,0,0); _0x8BC2.Visible = vis or false
_0x8BC2.AutomaticCanvasSize = Enum.AutomaticSize.Y; _0x8BC2.ZIndex = 7
return _0x8BC2
end
local function _0x9C59(parent, label, options, default, callback, posY)
local _0x9023 = { value = default or options[1], open = false }
local _0x6988 = Instance.new("TextLabel", parent)
_0x6988.Size = UDim2.new(1, 0, 0, 14); _0x6988.Position = UDim2.new(0, 0, 0, posY or 0)
_0x6988.BackgroundTransparency = 1; _0x6988.Text = label
_0x6988.TextColor3 = Color3.fromRGB(150, 150, 155); _0x6988.Font = Enum.Font.GothamMedium
_0x6988.TextSize = 9; _0x6988.TextXAlignment = Enum.TextXAlignment.Left; _0x6988.ZIndex = 7
local _0x7F51 = Instance.new("TextButton", parent)
_0x7F51.Size = UDim2.new(1, 0, 0, 28); _0x7F51.Position = UDim2.new(0, 0, 0, (posY or 0) + 16)
_0x7F51.BackgroundColor3 = Color3.fromRGB(20, 20, 24)
_0x7F51.Text ="  ".. tostring(_0x9023.value) .." ▼"_0x7F51.TextColor3 = Color3.fromRGB(255, 255, 255); _0x7F51.Font = Enum.Font.GothamBold
_0x7F51.TextSize = 11; _0x7F51.TextXAlignment = Enum.TextXAlignment.Left
_0x7F51.AutoButtonColor = false; _0x7F51.ZIndex = 7
Instance.new("UICorner", _0x7F51).CornerRadius = UDim.new(0, 6)
local _0x4344 = Instance.new("UIStroke", _0x7F51); _0x4344.Color = Color3.fromRGB(60, 60, 65); _0x4344.Thickness = 1; _0x4344.Transparency = 0.4
local _0x7F8E = Instance.new("Frame", parent)
_0x7F8E.Size = UDim2.new(1, 0, 0, 0); _0x7F8E.Position = UDim2.new(0, 0, 0, (posY or 0) + 48)
_0x7F8E.BackgroundColor3 = Color3.fromRGB(15, 15, 18); _0x7F8E.BorderSizePixel = 0
_0x7F8E.Visible = false; _0x7F8E.ClipsDescendants = true; _0x7F8E.ZIndex = 100
Instance.new("UICorner", _0x7F8E).CornerRadius = UDim.new(0, 6)
local _0x6E70 = Instance.new("UIStroke", _0x7F8E); _0x6E70.Color = Color3.fromRGB(60, 60, 65); _0x6E70.Thickness = 1; _0x6E70.Transparency = 0.3
local _0x9F73 = Instance.new("UIListLayout", _0x7F8E)
_0x9F73.Padding = UDim.new(0, 1); _0x9F73.SortOrder = Enum.SortOrder.LayoutOrder
local _0xE9FB = 24
local function _0x6DFB()
_0x9023.open = false
_0x7F51.Text ="  ".. tostring(_0x9023.value) .." ▼"_0x1B54:Create(_0x7F8E, TweenInfo.new(0.15), {Size = UDim2.new(1, 0, 0, 0)}):Play()
task.delay(0.16, function() if not _0x9023.open then _0x7F8E.Visible = false end end)
end
local function _0xE6E8()
_0x9023.open = true
_0x7F51.Text ="  ".. tostring(_0x9023.value) .." ▲"_0x7F8E.Visible = true
_0x1B54:Create(_0x7F8E, TweenInfo.new(0.18), {Size = UDim2.new(1, 0, 0, #options * _0xE9FB + 4)}):Play()
end
for i, opt in ipairs(options) do
local _0x9D78 = Instance.new("TextButton", _0x7F8E)
_0x9D78.Size = UDim2.new(1, 0, 0, _0xE9FB); _0x9D78.Position = UDim2.new(0, 0, 0, (i - 1) * _0xE9FB + 2)
_0x9D78.BackgroundColor3 = (opt == _0x9023.value) and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(25, 25, 30)
_0x9D78.Text ="  ".. tostring(opt)
_0x9D78.TextColor3 = (opt == _0x9023.value) and Color3.fromRGB(0, 0, 0) or Color3.fromRGB(220, 220, 220)
_0x9D78.Font = Enum.Font.GothamMedium; _0x9D78.TextSize = 10
_0x9D78.TextXAlignment = Enum.TextXAlignment.Left; _0x9D78.AutoButtonColor = false
_0x9D78.ZIndex = 101; _0x9D78.LayoutOrder = i
_0x9D78.MouseEnter:Connect(function() if opt ~= _0x9023.value then _0x9D78.BackgroundColor3 = Color3.fromRGB(40, 40, 45) end end)
_0x9D78.MouseLeave:Connect(function() _0x9D78.BackgroundColor3 = (opt == _0x9023.value) and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(25, 25, 30) end)
_0x9D78.MouseButton1Click:Connect(function()
_0x9023.value = opt
for _, _0x16E4 in ipairs(_0x7F8E:GetChildren()) do
if _0x16E4:IsA("TextButton") then
local _0x556A = (_0x16E4.Text:gsub("^%s+","") == tostring(opt))
_0x16E4.BackgroundColor3 = _0x556A and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(25, 25, 30)
_0x16E4.TextColor3 = _0x556A and Color3.fromRGB(0, 0, 0) or Color3.fromRGB(220, 220, 220)
end
end
_0x6DFB()
if callback then pcall(callback, opt) end
end)
end
_0x7F51.MouseButton1Click:Connect(function()
if _0x9023.open then _0x6DFB() else _0xE6E8() end
end)
return { GetValue = function() return _0x9023.value end, Close = _0x6DFB }
endlocal function _0xD1D8()
local _0xCF04 = _0xAD3B:WaitForChild("PlayerGui")
local _0x0474 = _0xCF04:FindFirstChild("HamaUniversalV3")
if _0x0474 then _0x0474:Destroy() end
local _0x5085 = Instance.new("ScreenGui")
_0x5085.Name ="HamaUniversalV3"; _0x5085.ResetOnSpawn = false
_0x5085.IgnoreGuiInset = false; _0x5085.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
_0x5085.DisplayOrder = 999; _0x5085.Enabled = true; _0x5085.Parent = _0xCF04
_G.HamaGUI = _0x5085
local _0xC15C = Instance.new("Frame", _0x5085)
_0xC15C.Name ="Main"; _0xC15C.AnchorPoint = Vector2.new(0.5, 0.5)
_0xC15C.Position = UDim2.new(0.5, 0, 0.5, 0); _0xC15C.Size = UDim2.new(0, 560, 0, 380)
_0xC15C.BackgroundColor3 = Color3.fromRGB(8, 8, 10); _0xC15C.BorderSizePixel = 0
_0xC15C.Active = true; _0xC15C.ClipsDescendants = false; _0xC15C.ZIndex = 5
Instance.new("UICorner", _0xC15C).CornerRadius = UDim.new(0, 10)
local _0xFDD0 = Instance.new("UISizeConstraint", _0xC15C)
_0xFDD0.MaxSize = Vector2.new(640, 460); _0xFDD0.MinSize = Vector2.new(420, 280)
local _0x940F = Instance.new("UIStroke", _0xC15C)
_0x940F.Thickness = 1.5; _0x940F.Color = Color3.fromRGB(60, 60, 65)
_0x940F.Transparency = 0.3; _0x940F.ApplyStrokeMode = Enum.ApplyStrokeMode.Borderlocal _0xA833 = Instance.new("Frame", _0xC15C)
_0xA833.Size = UDim2.new(1,0,0,40); _0xA833.BackgroundColor3 = Color3.fromRGB(5,5,8)
_0xA833.BorderSizePixel = 0; _0xA833.Active = true; _0xA833.ZIndex = 6
Instance.new("UICorner", _0xA833).CornerRadius = UDim.new(0,10)
local _0x6247 = Instance.new("TextLabel", _0xA833)
_0x6247.Size = UDim2.new(1,-100,1,0); _0x6247.Position = UDim2.new(0,14,0,0)
_0x6247.BackgroundTransparency = 1; _0x6247.Text ="HAMA UNIVERSAL V4.0"_0x6247.TextColor3 = Color3.fromRGB(255,255,255); _0x6247.Font = Enum.Font.GothamBold
_0x6247.TextSize = 15; _0x6247.TextXAlignment = Enum.TextXAlignment.Left; _0x6247.ZIndex = 7
local _0xBBA5 = Instance.new("TextButton", _0xA833)
_0xBBA5.Size = UDim2.new(0,28,0,28); _0xBBA5.Position = UDim2.new(1,-64,0,6)
_0xBBA5.BackgroundColor3 = Color3.fromRGB(25,25,30); _0xBBA5.Text ="—"_0xBBA5.TextColor3 = Color3.fromRGB(255,255,255); _0xBBA5.Font = Enum.Font.GothamBold; _0xBBA5.TextSize = 16; _0xBBA5.ZIndex = 7
Instance.new("UICorner", _0xBBA5).CornerRadius = UDim.new(0,6); _0x97B6(_0xBBA5)
local _0x2D1A = Instance.new("TextButton", _0xA833)
_0x2D1A.Size = UDim2.new(0,28,0,28); _0x2D1A.Position = UDim2.new(1,-32,0,6)
_0x2D1A.BackgroundColor3 = Color3.fromRGB(200,50,50); _0x2D1A.Text ="X"_0x2D1A.TextColor3 = Color3.fromRGB(255,255,255); _0x2D1A.Font = Enum.Font.GothamBold; _0x2D1A.TextSize = 14; _0x2D1A.ZIndex = 7
Instance.new("UICorner", _0x2D1A).CornerRadius = UDim.new(0,6); _0x97B6(_0x2D1A)
local _0x11B6, _0x9F63, _0x16DF = false, nil, nil
_0xA833.InputBegan:Connect(function(i)
if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
if i.Position.X > _0xA833.AbsolutePosition.X + _0xA833.AbsoluteSize.X - 70 then return end
_0x11B6 = true; _0x9F63 = i.Position; _0x16DF = _0xC15C.Position
end
end)
_0xE442.InputChanged:Connect(function(i)
if _0x11B6 and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
local _0x2736 = i.Position - _0x9F63
_0xC15C.Position = UDim2.new(_0x16DF.X.Scale, _0x16DF.X.Offset + _0x2736.X, _0x16DF.Y.Scale, _0x16DF.Y.Offset + _0x2736.Y)
end
end)
_0xE442.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then _0x11B6 = false end end)local _0x5573 = Instance.new("Frame", _0xC15C)
_0x5573.Size = UDim2.new(0,100,1,-55); _0x5573.Position = UDim2.new(0,8,0,48)
_0x5573.BackgroundTransparency = 1; _0x5573.ZIndex = 6
local _0x6869 = Instance.new("UIListLayout", _0x5573); _0x6869.Padding = UDim.new(0,4); _0x6869.SortOrder = Enum.SortOrder.LayoutOrder
local _0xDCD8 = Instance.new("Frame", _0xC15C)
_0xDCD8.Size = UDim2.new(1,-120,1,-55); _0xDCD8.Position = UDim2.new(0,112,0,48)
_0xDCD8.BackgroundTransparency = 1; _0xDCD8.ClipsDescendants = true; _0xDCD8.ZIndex = 6local _0x0DDE = Instance.new("TextButton", _0x5085)
_0x0DDE.Name ="MiniIcon"_0x0DDE.Size = UDim2.new(0, 50, 0, 50)
_0x0DDE.Position = UDim2.new(0, 50, 0, 50)_0x0DDE.BackgroundColor3 = Color3.fromRGB(8, 8, 10)
_0x0DDE.Text ="H"_0x0DDE.TextColor3 = Color3.fromRGB(255, 255, 255)
_0x0DDE.Font = Enum.Font.GothamBlack
_0x0DDE.TextSize = 24
_0x0DDE.ZIndex = 10
_0x0DDE.Visible = false
Instance.new("UICorner", _0x0DDE).CornerRadius = UDim.new(1, 0)
local _0x46D4 = Instance.new("UIStroke", _0x0DDE)
_0x46D4.Color = Color3.fromRGB(255, 255, 255); _0x46D4.Thickness = 0
local _0x392E = false
local _0xC3C9, _0x038F = nil, nil_0xBBA5.MouseButton1Click:Connect(function()
_0xC15C.Visible = false
_0x0DDE.Visible = true_0x0DDE.Position = _0xC15C.Position
end)_0x0DDE.InputBegan:Connect(function(i)
if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
_0x392E = true
_0xC3C9 = i.Position
_0x038F = _0x0DDE.Position
end
end)
_0xE442.InputChanged:Connect(function(i)
if _0x392E and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
local _0x2736 = i.Position - _0xC3C9
_0x0DDE.Position = UDim2.new(_0x038F.X.Scale, _0x038F.X.Offset + _0x2736.X, _0x038F.Y.Scale, _0x038F.Y.Offset + _0x2736.Y)
end
end)
_0xE442.InputEnded:Connect(function(i)
if _0x392E and (i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch) then
_0x392E = falseif (i.Position - _0xC3C9).Magnitude < 5 then
_0x0DDE.Visible = false
_0xC15C.Visible = true_0xC15C.Position = UDim2.new(0.5, 0, 0.5, 0)
end
end
end)
local _0x7807 = {"PIANO","PLAYER","VOID","PHYSIC","FOREST","SERVER","SHIELD","ABOUT"}
local _0x008B, _0x6DE4 = {}, {}
for i, name in ipairs(_0x7807) do
local _0x98D0 = Instance.new("TextButton", _0x5573)
_0x98D0.Size = UDim2.new(1,0,0,26); _0x98D0.BackgroundColor3 = Color3.fromRGB(20,20,25)
_0x98D0.Text = name; _0x98D0.TextColor3 = Color3.fromRGB(220,220,225)
_0x98D0.Font = Enum.Font.GothamBold; _0x98D0.TextSize = 10; _0x98D0.LayoutOrder = i; _0x98D0.ZIndex = 7
Instance.new("UICorner", _0x98D0).CornerRadius = UDim.new(0,6)
local _0x9A34 = Instance.new("UIStroke", _0x98D0); _0x9A34.Color = Color3.fromRGB(50,50,55); _0x9A34.Thickness = 1
_0x97B6(_0x98D0); _0x008B[name] = _0x98D0
end
local _0x7E9F
_0x7E9F = function(name)
for _0x89CE, _0x98D0 in pairs(_0x008B) do
_0x98D0.BackgroundColor3 = _0x89CE == name and Color3.fromRGB(255,255,255) or Color3.fromRGB(20,20,25)
_0x98D0.TextColor3 = _0x89CE == name and Color3.fromRGB(0,0,0) or Color3.fromRGB(220,220,225)
end
for _0x89CE, _0x7ADD in pairs(_0x6DE4) do _0x7ADD.Visible = (_0x89CE == name) end
end
for _, name in ipairs(_0x7807) do
_0x008B[name].MouseButton1Click:Connect(function() _0x7E9F(name) end)
endlocal _0x9D98 = _0x9927(_0xDCD8,"PIANO", true)
_0x6DE4["PIANO"] = _0x9D98
do
local _0xE820 = {Running=false, Gen=0, FireCount=0, Connections={}, RateCount=0, RateWin=os.clock(), SelectedRemotes={}, KeyPool={}, Format="positional"}
local _0x8007
_StopSpam = function()
_0xE820.Running = false; _0xE820.Gen = _0xE820.Gen + 1
for _, _0x16E4 in ipairs(_0xE820.Connections) do pcall(function() _0x16E4:Disconnect() end) end
_0xE820.Connections = {}
_0x6049(); _0x14BB()
if _0x8007 then _0xAF1E(_0x8007,"Fires: ".. _0xE820.FireCount) end
end
local function _0x3E10()
local _0x56AE = {}; local _0x854D = math.max(1, math.floor(_0xFCCE.KeyMult))
for i = 1, 61 do for _ = 1, _0x854D do table.insert(_0x56AE, i) end end
return _0x56AE
end
local function _0xCBB3(_0x7C5C, fmt)
local _0xA231, _0x1EA3 = {}, {}
for _, _0x16F9 in ipairs(_0x7C5C) do
if _0x16F9 and _0x16F9.Parent then
if _0x16F9:IsA("RemoteEvent") then _0xA231[#_0xA231+1] = _0x16F9
elseif _0x16F9:IsA("RemoteFunction") then _0x1EA3[#_0x1EA3+1] = _0x16F9 end
end
end
local _0x3E31, _0x9F54 = #_0xA231, #_0x1EA3
if _0x3E31 == 0 and _0x9F54 == 0 then return function() return 0 end end
if fmt =="positional"then
return function(k)
local _0x561C = 0
for i = 1, _0x3E31 do local _0x77BB = _0xA231[i]; if _0x77BB.Parent then _0x77BB:FireServer("play", k); _0x561C = _0x561C + 1 end end
for i = 1, _0x9F54 do local _0xC5AD = _0x1EA3[i]; if _0xC5AD.Parent then task.spawn(_0xC5AD.InvokeServer, _0xC5AD,"play", k); _0x561C = _0x561C + 1 end end
return _0x561C
end
else
return function(k)
local _0x7ADD = {play=true, action="play", key=k, note=k, index=k, value=k}
local _0x561C = 0
for i = 1, _0x3E31 do local _0x77BB = _0xA231[i]; if _0x77BB.Parent then _0x77BB:FireServer(_0x7ADD); _0x561C = _0x561C + 1 end end
for i = 1, _0x9F54 do local _0xC5AD = _0x1EA3[i]; if _0xC5AD.Parent then task.spawn(_0xC5AD.InvokeServer, _0xC5AD, _0x7ADD); _0x561C = _0x561C + 1 end end
return _0x561C
end
end
end
local _0x9F33
_0x9F33 = function()
if not _0xFCCE.IsWhitelisted and _0xAD3B.Name ~= _0xFCCE.OwnerName then return end
if getgenv().PRIORITY and getgenv().PRIORITY.Enabled then
local _0x3738 = getgenv().PRIORITY
local _0x2B56 = getgenv().HAMA_IsLocalDev and getgenv().HAMA_IsLocalDev() or false
local _0xB9FC = getgenv().HAMA_IsLocalPremium and getgenv().HAMA_IsLocalPremium() or false
local _0x55AE = getgenv().HAMA_IsDevInServer and getgenv().HAMA_IsDevInServer(true) or false
local _0x3BE6 = getgenv().HAMA_IsPremiumInServer and getgenv().HAMA_IsPremiumInServer(true) or false
if not _0x2B56 then
if _0x55AE then warn("[HAMA] DEV in server. Spam blocked."); return end
if _0x3BE6 and not _0xB9FC then warn("[HAMA] PREMIUM in server. Spam blocked."); return end
end
end
local _0x213B = {}
for _, _0x16F9 in ipairs(_0xE820.SelectedRemotes) do if _0x16F9 and _0x16F9.Parent then _0x213B[#_0x213B+1] = _0x16F9 end end
if #_0x213B == 0 then warn("[HAMA] Pilih remote dulu!"); return end
local _0xCA3D = _0xAD3B.Character and _0xAD3B.Character:FindFirstChildOfClass("Humanoid")
if not _0xCA3D or not _0xCA3D.Sit then warn("[HAMA] Duduk dulu di piano!"); return end
_StopSpam()
_0x9700(_0x213B); _0x09B1(); _0x40DB()
_0xE820.Running = true; _0xE820.FireCount = 0; _0xE820.Gen = _0xE820.Gen + 1
_0xE820.RateCount = 0; _0xE820.RateWin = os.clock()
local _0x2A70 = _0xE820.Gen
local _0x6D66 = math.max(1, math.min(100, _0xFCCE.Level))
local _0x8803 = _0x85FF[_0x6D66]
local _0xD427 = math.min((_0x8803.conns / 4) * _0x8803.budget, _0x8803.sigBudget)
local _0xB87A = tonumber(getgenv().HAMA_RATE_CAP) or 150000
_0xE820.KeyPool = _0x3E10()
local _0xD6FF = _0xCBB3(_0x213B, _0xE820.Format)
local _0x7671 = _0xE820.KeyPool; local _0x44D1 = #_0x7671
local _0x6427 = {_0x1EE5.Heartbeat, _0x1EE5.Stepped, _0x1EE5.PreSimulation, _0x1EE5.PostSimulation}
local function _0x013F()
if not _0xE820.Running or _0xE820.Gen ~= _0x2A70 or _0xE820.RateCount >= _0xB87A then return end
local _0x3F53 = os.clock() + _0xD427
local _0x561C = 0
repeat
for ki = 1, _0x44D1 do _0x561C = _0x561C + _0xD6FF(_0x7671[ki]) end
if os.clock() >= _0x3F53 then break end
until _0xE820.RateCount + _0x561C >= _0xB87A
_0xE820.FireCount = _0xE820.FireCount + _0x561C
_0xE820.RateCount = _0xE820.RateCount + _0x561C
end
for _, _0x9A34 in ipairs(_0x6427) do
local _0x931A, _0x16E4 = pcall(function() return _0x9A34:Connect(_0x013F) end)
if _0x931A and _0x16E4 then table.insert(_0xE820.Connections, _0x16E4) end
end
local _0x753E = 0
local _0x16E4 = _0x1EE5.Heartbeat:Connect(function()
local _0xF70D = os.clock()
if _0xF70D - _0xE820.RateWin >= 1 then _0xE820.RateWin = _0xF70D; _0xE820.RateCount = 0 end
if _0xF70D - _0x753E >= 0.2 then
_0x753E = _0xF70D
if _0x8007 and _0x8007.Parent then _0xAF1E(_0x8007,"Fires: ".. _0xE820.FireCount) end
end
end)
table.insert(_0xE820.Connections, _0x16E4)
print("[HAMA] Spam ACTIVE: ".. _0x8803.label)
end
local _0xE447 = _0x3025(_0x9D98,"SCAN REMOTES", UDim2.new(0,0,0,0), UDim2.new(0.48,-2,0,32), Color3.fromRGB(25,25,30))
local _0x3F1E = _0x3025(_0x9D98,"SCAN PIANO", UDim2.new(0.52,2,0,0), UDim2.new(0.48,-2,0,32), Color3.fromRGB(25,25,30))
local _0x00FD = _0x9565(_0x9D98,"Remote List (klik max 2):", UDim2.new(0,0,0,36), UDim2.new(1,0,0,16), Color3.fromRGB(200,200,205))
_0x00FD.TextSize = 10
local _0x507A = Instance.new("ScrollingFrame", _0x9D98)
_0x507A.Size = UDim2.new(1,0,0,70); _0x507A.Position = UDim2.new(0,0,0,54)
_0x507A.BackgroundColor3 = Color3.fromRGB(10,10,12); _0x507A.BorderSizePixel = 0
_0x507A.ScrollBarThickness = 2; _0x507A.ZIndex = 7
Instance.new("UICorner", _0x507A).CornerRadius = UDim.new(0,6)
Instance.new("UIListLayout", _0x507A).Padding = UDim.new(0,2)
local _0xA324 = _0x9565(_0x9D98,"Piano Found:", UDim2.new(0,0,0,128), UDim2.new(1,0,0,16), Color3.fromRGB(200,200,205))
_0xA324.TextSize = 10
local _0x00E9 = Instance.new("ScrollingFrame", _0x9D98)
_0x00E9.Size = UDim2.new(1,0,0,50); _0x00E9.Position = UDim2.new(0,0,0,146)
_0x00E9.BackgroundColor3 = Color3.fromRGB(10,10,12); _0x00E9.BorderSizePixel = 0
_0x00E9.ScrollBarThickness = 2; _0x00E9.ZIndex = 7
Instance.new("UICorner", _0x00E9).CornerRadius = UDim.new(0,6)
Instance.new("UIListLayout", _0x00E9).Padding = UDim.new(0,2)
_0x64D0(_0x9D98,"Level (1-100)", UDim2.new(0,0,0,204), 1, 100, 10, function(_0x8A30) _0xFCCE.Level = _0x8A30 end)
_0x64D0(_0x9D98,"Threads (1-8000)", UDim2.new(0,0,0,244), 1, 8000, 10, function(_0x8A30) _0xFCCE.Threads = _0x8A30 end)
_0x64D0(_0x9D98,"Key Mult (1-100)", UDim2.new(0,0,0,284), 1, 100, 1, function(_0x8A30) _0xFCCE.KeyMult = _0x8A30 end)
_0x64D0(_0x9D98,"Hook Amp (1-50x)", UDim2.new(0,0,0,324), 1, 50, 20, function(_0x8A30) _0xFCCE.HookAmplifier = _0x8A30 end)
local _0x6D5B = _0x9C59(_0x9D98,"Attack Mode",
{"Random","Sequential","Chromatic","Burst Chord","NUKE","White Flood","Black Flood","Chaos","Thunderclap"},"NUKE",
function(val)
local _0x21F5 = {
["Random"] ="random", ["Sequential"] ="sequential", ["Chromatic"] ="chromatic",
["Burst Chord"] ="chord", ["NUKE"] ="nuke", ["White Flood"] ="whiteflood",
["Black Flood"] ="blackflood", ["Chaos"] ="chaos", ["Thunderclap"] ="thunderclap"}
_0xFCCE.Mode = _0x21F5[val] or"random"end,
364
)
_0x8007 = _0x9565(_0x9D98,"Fires: 0", UDim2.new(0.52,2,0,364), UDim2.new(0.48,-2,0,32), Color3.fromRGB(255,255,255))
_0x8007.BackgroundColor3 = Color3.fromRGB(15,15,18); _0x8007.BackgroundTransparency = 0
_0x8007.TextXAlignment = Enum.TextXAlignment.Center
Instance.new("UICorner", _0x8007).CornerRadius = UDim.new(0,6)
local _0x15D8 = _0x3025(_0x9D98,"🔥 START SPAM", UDim2.new(0,0,0,406), UDim2.new(0.48,-2,0,34), Color3.fromRGB(25,25,30))
local _0x6EAB = _0x3025(_0x9D98,"■ STOP", UDim2.new(0.52,2,0,406), UDim2.new(0.48,-2,0,34), Color3.fromRGB(25,25,30))
local _0xF417 = _0x9C59(_0x9D98,"Remote Format",
{"Positional (\"play\", key)","Table {play=true, key}"},"Positional (\"play\", key)",
function(val)
_0xE820.Format = val:find("Table") and"table"or"positional"end,
448
)
local _0xFE79 = _0x3025(_0x9D98,"🔄 REJOIN", UDim2.new(0,0,0,486), UDim2.new(1,0,0,32), Color3.fromRGB(25,25,30))
_0xFE79.MouseButton1Click:Connect(function()
_StopSpam()
task.delay(0.4, function()
pcall(function()
local _0x1DF8 = game.JobId
if _0x1DF8 and _0x1DF8 ~=""then
_0x108D.TeleportService:TeleportToPlaceInstance(game.PlaceId, _0x1DF8, _0xAD3B)
else
_0x108D.TeleportService:Teleport(game.PlaceId, _0xAD3B)
end
end)
end)
end)
_0xE447.MouseButton1Click:Connect(function()
pcall(function()
local _0x7C5C = _0x76E7()
for _, _0x16E4 in ipairs(_0x507A:GetChildren()) do if _0x16E4:IsA("TextButton") then _0x16E4:Destroy() end end
if #_0x7C5C == 0 then _0xAF1E(_0x00FD,"❌ No remote"); return end
_0xAF1E(_0x00FD,"Remote List (".. #_0x7C5C .." found):")
_0xE820.SelectedRemotes = {_0x7C5C[1]}
for i, _0x16F9 in ipairs(_0x7C5C) do
local _0x98D0 = Instance.new("TextButton", _0x507A)
_0x98D0.Size = UDim2.new(1,-4,0,26); _0x98D0.Position = UDim2.new(0,2,0,(i-1)*28)
_0x98D0.BackgroundColor3 = (i==1) and Color3.fromRGB(255,255,255) or Color3.fromRGB(20,20,25)
_0x98D0.Text ="  [".. _0x16F9.ClassName .."] ".. _0x16F9:GetFullName()
_0x98D0.TextColor3 = (i==1) and Color3.fromRGB(0,0,0) or Color3.fromRGB(220,220,225); _0x98D0.Font = Enum.Font.GothamMedium
_0x98D0.TextSize = 9; _0x98D0.TextXAlignment = Enum.TextXAlignment.Left; _0x98D0.ZIndex = 8
Instance.new("UICorner", _0x98D0).CornerRadius = UDim.new(0,4)
_0x98D0.MouseButton1Click:Connect(function()
local _0x61EE = nil
for si, _0x13FA in ipairs(_0xE820.SelectedRemotes) do if _0x13FA == _0x16F9 then _0x61EE = si; break end end
if _0x61EE then table.remove(_0xE820.SelectedRemotes, _0x61EE)
else
if #_0xE820.SelectedRemotes < 2 then table.insert(_0xE820.SelectedRemotes, _0x16F9)
else _0xE820.SelectedRemotes[2] = _0x16F9 end
end
for _, _0x16E4 in ipairs(_0x507A:GetChildren()) do if _0x16E4:IsA("TextButton") then _0x16E4.BackgroundColor3 = Color3.fromRGB(20,20,25) end end
for si, _0x13FA in ipairs(_0xE820.SelectedRemotes) do
for _, _0x16E4 in ipairs(_0x507A:GetChildren()) do
if _0x16E4:IsA("TextButton") and _0x16E4.Text:find(_0x13FA.Name, 1, true) then
_0x16E4.BackgroundColor3 = Color3.fromRGB(255,255,255); _0x16E4.TextColor3 = Color3.fromRGB(0,0,0)
end
end
end
_0x9700(_0xE820.SelectedRemotes)
end)
end
_0x507A.CanvasSize = UDim2.new(0,0,0,#_0x7C5C*28+4)
_0x9700(_0xE820.SelectedRemotes)
end)
end)
_0x3F1E.MouseButton1Click:Connect(function()
pcall(function()
_0xFCCE.FoundPianos = _0x8DF0()
for _, _0x16E4 in ipairs(_0x00E9:GetChildren()) do if _0x16E4:IsA("TextButton") then _0x16E4:Destroy() end end
if #_0xFCCE.FoundPianos == 0 then _0xAF1E(_0xA324,"❌ No piano"); return end
_0xAF1E(_0xA324,"Piano Found (".. #_0xFCCE.FoundPianos .."):")
for i, _0x7ADD in ipairs(_0xFCCE.FoundPianos) do
local _0x98D0 = Instance.new("TextButton", _0x00E9)
_0x98D0.Size = UDim2.new(1,-4,0,24); _0x98D0.Position = UDim2.new(0,2,0,(i-1)*26)
_0x98D0.BackgroundColor3 = Color3.fromRGB(20,20,25); _0x98D0.Text ="  ".. _0x7ADD.label
_0x98D0.TextColor3 = Color3.fromRGB(220,220,225); _0x98D0.Font = Enum.Font.GothamMedium
_0x98D0.TextSize = 9; _0x98D0.TextXAlignment = Enum.TextXAlignment.Left; _0x98D0.ZIndex = 8
Instance.new("UICorner", _0x98D0).CornerRadius = UDim.new(0,4)
_0x98D0.MouseButton1Click:Connect(function()
_0xFCCE.SelectedPiano = _0x7ADD
for _, _0x16E4 in ipairs(_0x00E9:GetChildren()) do if _0x16E4:IsA("TextButton") then _0x16E4.BackgroundColor3 = Color3.fromRGB(20,20,25) end end
_0x98D0.BackgroundColor3 = Color3.fromRGB(255,255,255); _0x98D0.TextColor3 = Color3.fromRGB(0,0,0)
local _0x7503 = _0xAD3B.Character and _0xAD3B.Character:FindFirstChild("HumanoidRootPart")
if _0x7503 and _0x7ADD.seat then
_0x7503.CFrame = CFrame.new(_0x7ADD.pos + Vector3.new(0,4,0))
task.wait(0.25)
local _0xCA3D = _0xAD3B.Character:FindFirstChildOfClass("Humanoid")
if _0xCA3D and _0x7ADD.seat:IsA("Seat") then pcall(function() _0x7ADD.seat:Sit(_0xCA3D) end) end
end
end)
end
_0x00E9.CanvasSize = UDim2.new(0,0,0,#_0xFCCE.FoundPianos*26+4)
end)
end)
_0x15D8.MouseButton1Click:Connect(_0x9F33)
_0x6EAB.MouseButton1Click:Connect(_StopSpam)
getgenv()._HAMA_StopSpam = _StopSpam
endlocal _0x2668 = _0x9927(_0xDCD8,"PLAYER", false)
_0x6DE4["PLAYER"] = _0x2668
do
local _0xD618 = _0x3025(_0x2668,"SPEED: OFF", UDim2.new(0,0,0,0), UDim2.new(1,0,0,32), Color3.fromRGB(25,25,30))
local _0xD4F1 = false
_0xD618.MouseButton1Click:Connect(function()
_0xD4F1 = not _0xD4F1; _0xFCCE.SpeedEnabled = _0xD4F1
_0xD618.Text ="SPEED: ".. (_0xD4F1 and"ON"or"OFF")
_0xD618.BackgroundColor3 = _0xD4F1 and Color3.fromRGB(255,255,255) or Color3.fromRGB(25,25,30)
_0xD618.TextColor3 = _0xD4F1 and Color3.fromRGB(0,0,0) or Color3.fromRGB(255,255,255)
_0x2210()
end)
_0x64D0(_0x2668,"WalkSpeed", UDim2.new(0,0,0,44), 16, 500, 16, function(_0x8A30) _0xFCCE.WalkSpeed = _0x8A30; if _0xFCCE.SpeedEnabled then _0x2210() end end)
local _0xB4F9 = _0x3025(_0x2668,"FLY: OFF", UDim2.new(0,0,0,84), UDim2.new(0.48,-2,0,32), Color3.fromRGB(25,25,30))
_0xB4F9.MouseButton1Click:Connect(function()
_0xC760(not _0xFCCE.FlyEnabled)
_0xB4F9.Text ="FLY: ".. (_0xFCCE.FlyEnabled and"ON"or"OFF")
_0xB4F9.BackgroundColor3 = _0xFCCE.FlyEnabled and Color3.fromRGB(255,255,255) or Color3.fromRGB(25,25,30)
_0xB4F9.TextColor3 = _0xFCCE.FlyEnabled and Color3.fromRGB(0,0,0) or Color3.fromRGB(255,255,255)
end)
local _0x1ACA = _0x3025(_0x2668,"Keybind: F", UDim2.new(0.52,2,0,84), UDim2.new(0.48,-2,0,32), Color3.fromRGB(40,40,45))
_0x1ACA.MouseButton1Click:Connect(function()
_0x1ACA.Text ="Press key..."local _0x75CD
_0x75CD = _0xE442.InputBegan:Connect(function(input)
if input.UserInputType == Enum.UserInputType.Keyboard then
_0xFCCE.FlyKeybind = input.KeyCode
_0x1ACA.Text ="Keybind: ".. input.KeyCode.Name
_0x75CD:Disconnect()
end
end)
end)
_0x64D0(_0x2668,"Fly Speed", UDim2.new(0,0,0,124), 10, 200, 50, function(_0x8A30) _0xFCCE.FlySpeed = _0x8A30 end)
local _0x0F01 = _0x3025(_0x2668,"NOCLIP: OFF", UDim2.new(0,0,0,164), UDim2.new(0.48,-2,0,32), Color3.fromRGB(25,25,30))
_0x0F01.MouseButton1Click:Connect(function()
_0x5C6E(not _0xFCCE.NoclipEnabled)
_0x0F01.Text ="NOCLIP: ".. (_0xFCCE.NoclipEnabled and"ON"or"OFF")
_0x0F01.BackgroundColor3 = _0xFCCE.NoclipEnabled and Color3.fromRGB(255,255,255) or Color3.fromRGB(25,25,30)
_0x0F01.TextColor3 = _0xFCCE.NoclipEnabled and Color3.fromRGB(0,0,0) or Color3.fromRGB(255,255,255)
end)
local _0x9EDA = _0x3025(_0x2668,"INVISIBLE → VOID TAB", UDim2.new(0.52,2,0,164), UDim2.new(0.48,-2,0,32), Color3.fromRGB(40,40,45))
_0x9EDA.MouseButton1Click:Connect(function() _0x7E9F("VOID") end)
endlocal _0xB13C = _0x9927(_0xDCD8,"VOID", false)
_0x6DE4["VOID"] = _0xB13C
do
local _0x28C6 = {VoidDropEnabled=false, VoidDropConn=nil, VoidDropOrigCF=nil,
VXZ=2^26*30000000, VY=2^26*30000000,
VoidTrapActive=false, VTPNoclip=nil, VTPDesc=nil, VTPOrigCF=nil, VTPGodSt=nil, VTPDied=nil, VTPHit=nil,
VT_SPEED=20, VT_NOCLIP={HumanoidRootPart=true,Torso=true,UpperTorso=true,LowerTorso=true,Head=true},
Markers={}}
local _0xD1F7 = _0x9565(_0xB13C,"🕳️ VOID DROP", UDim2.new(0,0,0,0), UDim2.new(1,0,0,20), Color3.fromRGB(255,255,255))
_0xD1F7.TextSize = 14
local _0xB34B = _0x9565(_0xB13C,"Void Drop • Void Trap • Stealth Invisible", UDim2.new(0,0,0,22), UDim2.new(1,0,0,16), Color3.fromRGB(150,150,155))
_0xB34B.TextSize = 10
local function _0xB197()
local _0x16E4 = _0xAD3B.Character; local _0x16F9 = _0x16E4 and _0x16E4:FindFirstChild("HumanoidRootPart")
if not _0x16F9 then return false end
_0x28C6.VoidDropOrigCF = _0x16F9.CFrame
local _0x6F9A = CFrame.new(_0x28C6.VXZ, _0x28C6.VY, _0x28C6.VXZ) * (_0x28C6.VoidDropOrigCF - _0x28C6.VoidDropOrigCF.Position)
task.spawn(function() _0x16F9.CFrame = _0x6F9A end)
_0x28C6.VoidDropConn = _0x1EE5.Heartbeat:Connect(function()
pcall(function()
local _0x2E93 = _0xAD3B.Character; local _0x8AE5 = _0x2E93 and _0x2E93:FindFirstChild("HumanoidRootPart")
if not _0x8AE5 then return end
_0x8AE5.CFrame = _0x6F9A; _0x8AE5.AssemblyLinearVelocity = Vector3.zero; _0x8AE5.AssemblyAngularVelocity = Vector3.zero
end)
end)
local _0xFBBD = Instance.new("Part"); _0xFBBD.Name ="VoidMarker"; _0xFBBD.Size = Vector3.new(4,1,4)
_0xFBBD.Anchored = true; _0xFBBD.CanCollide = false; _0xFBBD.Transparency = 0.5
_0xFBBD.Color = Color3.fromRGB(255,255,255); _0xFBBD.Material = Enum.Material.Neon
_0xFBBD.CFrame = _0x6F9A; _0xFBBD.Parent = _0x938B; _0x28C6.Markers.VD = _0xFBBD
return true
end
local function _0x3018()
if _0x28C6.VoidDropConn then _0x28C6.VoidDropConn:Disconnect(); _0x28C6.VoidDropConn = nil end
local _0x16E4 = _0xAD3B.Character; local _0x16F9 = _0x16E4 and _0x16E4:FindFirstChild("HumanoidRootPart")
local _0x6E46 = {}; local _0xCBFA = _0x16F9 and _0x16F9.Position
if _0xCBFA then
for _, _0xD00C in ipairs(_0x7E7C:GetPlayers()) do
if _0xD00C ~= _0xAD3B and _0xD00C.Character then
local _0x7C69 = _0xD00C.Character:FindFirstChild("HumanoidRootPart")
if _0x7C69 and (_0x7C69.Position - _0xCBFA).Magnitude < 20 then table.insert(_0x6E46, _0x7C69) end
end
end
end
if _0x16F9 and _0x28C6.VoidDropOrigCF then
task.spawn(function() _0x16F9.CFrame = _0x28C6.VoidDropOrigCF end)
if #_0x6E46 > 0 then
local _0xC357 = CFrame.new(_0x28C6.VXZ, _0x28C6.VY, _0x28C6.VXZ)
task.spawn(function()
for _ = 1, 5 do task.wait(); for _, _0x8AE5 in ipairs(_0x6E46) do pcall(function() _0x8AE5.CFrame = _0xC357 end) end end
end)
end
end
if _0x28C6.Markers.VD then pcall(function() _0x28C6.Markers.VD:Destroy() end); _0x28C6.Markers.VD = nil end
end
local function _0xED8C()
if _0x28C6.VTPNoclip then return end
_0x28C6.VTPNoclip = _0x1EE5.Stepped:Connect(function()
if not _0x28C6.VoidTrapActive then return end
local _0x2DFA = _0xAD3B.Character; if not _0x2DFA then return end
for _, _0x8A30 in ipairs(_0x2DFA:GetDescendants()) do
if _0x8A30:IsA("BasePart") and _0x28C6.VT_NOCLIP[_0x8A30.Name] then _0x8A30.CanCollide = false end
end
end)
end
local function _0x4678()
if _0x28C6.VTPNoclip then _0x28C6.VTPNoclip:Disconnect(); _0x28C6.VTPNoclip = nil end
local _0x2DFA = _0xAD3B.Character
if _0x2DFA then for _, _0x8A30 in ipairs(_0x2DFA:GetDescendants()) do
if _0x8A30:IsA("BasePart") and _0x28C6.VT_NOCLIP[_0x8A30.Name] then _0x8A30.CanCollide = true end
end end
end
local function _0xE540()
if _0x28C6.VTPDesc then return end
_0x28C6.VTPDesc = _0x1EE5.Heartbeat:Connect(function()
if not _0x28C6.VoidTrapActive then return end
local _0x16E4 = _0xAD3B.Character; local _0x16F9 = _0x16E4 and _0x16E4:FindFirstChild("HumanoidRootPart")
if not _0x16F9 then return end
_0x16F9.CFrame = _0x16F9.CFrame * CFrame.new(0, -_0x28C6.VT_SPEED, 0)
end)
end
local function _0x3094() if _0x28C6.VTPDesc then _0x28C6.VTPDesc:Disconnect(); _0x28C6.VTPDesc = nil end end
local function _0x7530()
if _0x28C6.VTPHit then return end
_0x28C6.VTPHit = _0x1EE5.Stepped:Connect(function()
if not _0x28C6.VoidTrapActive then return end
local _0x16E4 = _0xAD3B.Character; if not _0x16E4 then return end
for _, _0x8A30 in ipairs(_0x16E4:GetDescendants()) do
if _0x8A30:IsA("BasePart") then
if _0x8A30.CanCollide then _0x8A30.CanCollide = false end
if _0x8A30.CanTouch then _0x8A30.CanTouch = false end
end
end
end)
end
local function _0x3803()
if _0x28C6.VTPHit then _0x28C6.VTPHit:Disconnect(); _0x28C6.VTPHit = nil end
local _0x16E4 = _0xAD3B.Character
if _0x16E4 then for _, _0x8A30 in ipairs(_0x16E4:GetDescendants()) do
if _0x8A30:IsA("BasePart") then pcall(function() _0x8A30.CanCollide = true; _0x8A30.CanTouch = true end) end
end end
end
local function _0x5E20(_0x74C5)
if not _0x74C5 then return end
pcall(function()
_0x74C5.MaxHealth = 1e308; _0x74C5.Health = 1e308
_0x74C5:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
_0x74C5:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
_0x74C5:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
_0x74C5.BreakJointsOnDeath = false
end)
if _0x28C6.VTPGodSt then pcall(function() _0x28C6.VTPGodSt:Disconnect() end) end
_0x28C6.VTPGodSt = _0x74C5.StateChanged:Connect(function(_, ns)
if not _0x28C6.VoidTrapActive then return end
if ns == Enum.HumanoidStateType.Dead or ns == Enum.HumanoidStateType.Ragdoll or ns == Enum.HumanoidStateType.FallingDown then
pcall(function() _0x74C5:SetStateEnabled(ns, false); _0x74C5:ChangeState(Enum.HumanoidStateType.GettingUp) end)
end
end)
end
local function _0x13E3(_0x74C5)
if _0x28C6.VTPGodSt then pcall(function() _0x28C6.VTPGodSt:Disconnect() end); _0x28C6.VTPGodSt = nil end
if not _0x74C5 then return end
pcall(function()
_0x74C5.MaxHealth = 100; _0x74C5.Health = 100
_0x74C5:SetStateEnabled(Enum.HumanoidStateType.Dead, true)
_0x74C5:SetStateEnabled(Enum.HumanoidStateType.FallingDown, true)
_0x74C5:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, true)
_0x74C5.BreakJointsOnDeath = true
end)
end
local function _0x40E1(_0xC7A4)
_0x28C6.VoidTrapActive = false
if _0x28C6.VTPDied then pcall(function() _0x28C6.VTPDied:Disconnect() end); _0x28C6.VTPDied = nil end
_0x3094(); _0x4678(); _0x3803()
local _0x16E4 = _0xAD3B.Character; local _0x74C5 = _0x16E4 and _0x16E4:FindFirstChildOfClass("Humanoid")
local _0x16F9 = _0x16E4 and _0x16E4:FindFirstChild("HumanoidRootPart")
_0x13E3(_0x74C5)
if _0xC7A4 and _0x16F9 and _0x28C6.VTPOrigCF then task.spawn(function() _0x16F9.CFrame = _0x28C6.VTPOrigCF end) end
_0x28C6.VTPOrigCF = nil
end
local _0x6368 = _0x3025(_0xB13C,"VOID DROP: OFF", UDim2.new(0,0,0,58), UDim2.new(1,0,0,32), Color3.fromRGB(25,25,30))
_0x6368.MouseButton1Click:Connect(function()
_0x28C6.VoidDropEnabled = not _0x28C6.VoidDropEnabled
if _0x28C6.VoidDropEnabled then
if _0xB197() then
_0x6368.Text ="VOID DROP: ON"; _0x6368.BackgroundColor3 = Color3.fromRGB(255,255,255); _0x6368.TextColor3 = Color3.fromRGB(0,0,0)
else _0x28C6.VoidDropEnabled = false end
else
_0x3018(); _0x6368.Text ="VOID DROP: OFF"; _0x6368.BackgroundColor3 = Color3.fromRGB(25,25,30); _0x6368.TextColor3 = Color3.fromRGB(255,255,255)
end
end)
local _0xC1E8 = _0x3025(_0xB13C,"VOID TRAP: OFF", UDim2.new(0,0,0,116), UDim2.new(1,0,0,32), Color3.fromRGB(25,25,30))
_0xC1E8.MouseButton1Click:Connect(function()
_0x28C6.VoidTrapActive = not _0x28C6.VoidTrapActive
local _0x16E4 = _0xAD3B.Character; local _0x74C5 = _0x16E4 and _0x16E4:FindFirstChildOfClass("Humanoid")
local _0x16F9 = _0x16E4 and _0x16E4:FindFirstChild("HumanoidRootPart")
if _0x28C6.VoidTrapActive then
if not _0x16F9 then _0x28C6.VoidTrapActive = false; return end
_0x28C6.VTPOrigCF = _0x16F9.CFrame
_0xED8C(); _0xE540(); _0x7530(); _0x5E20(_0x74C5)
if _0x74C5 then
if _0x28C6.VTPDied then pcall(function() _0x28C6.VTPDied:Disconnect() end) end
_0x28C6.VTPDied = _0x74C5.Died:Connect(function()
_0x40E1(false); _0xC1E8.Text ="VOID TRAP: OFF"; _0xC1E8.BackgroundColor3 = Color3.fromRGB(25,25,30); _0xC1E8.TextColor3 = Color3.fromRGB(255,255,255)
end)
end
_0xC1E8.Text ="VOID TRAP: ON"; _0xC1E8.BackgroundColor3 = Color3.fromRGB(255,255,255); _0xC1E8.TextColor3 = Color3.fromRGB(0,0,0)
else
_0x40E1(true); _0xC1E8.Text ="VOID TRAP: OFF"; _0xC1E8.BackgroundColor3 = Color3.fromRGB(25,25,30); _0xC1E8.TextColor3 = Color3.fromRGB(255,255,255)
end
end)
local _0xA606 = _0x3025(_0xB13C,"INVISIBLE (FE): OFF", UDim2.new(0,0,0,174), UDim2.new(1,0,0,32), Color3.fromRGB(25,25,30))
local _0x730C = {Enabled=false, Parts={}, Conn=nil}
local function _0x7F38()
local _0x16E4 = _0xAD3B.Character; local _0x74C5 = _0x16E4 and _0x16E4:FindFirstChildOfClass("Humanoid")
local _0x16F9 = _0x16E4 and _0x16E4:FindFirstChild("HumanoidRootPart")
if not _0x16E4 or not _0x16F9 then return false end
_0x730C.Parts = {}
for _, _0x8A30 in ipairs(_0x16E4:GetDescendants()) do
if _0x8A30:IsA("BasePart") and _0x8A30.Name ~="HumanoidRootPart"and _0x8A30.Transparency < 1 then
table.insert(_0x730C.Parts, _0x8A30)
end
end
if _0x730C.Conn then _0x730C.Conn:Disconnect(); _0x730C.Conn = nil end
for _, _0x8A30 in ipairs(_0x730C.Parts) do _0x8A30.Transparency = 0.5 end
_0x730C.Conn = _0x1EE5.Heartbeat:Connect(function()
if not _0x730C.Enabled then return end
local _0x2E93 = _0xAD3B.Character; local _0xE3E4 = _0x2E93 and _0x2E93:FindFirstChildOfClass("Humanoid")
local _0x8AE5 = _0x2E93 and _0x2E93:FindFirstChild("HumanoidRootPart")
if not _0x2E93 or not _0xE3E4 or not _0x8AE5 then return end
local _0xECEC = _0x8AE5.CFrame; local _0xEE32 = _0xE3E4.CameraOffset
local _0xDBA5 = _0xECEC * CFrame.new(0, -25, 0)
_0x8AE5.CFrame = _0xDBA5
_0xE3E4.CameraOffset = _0xDBA5:ToObjectSpace(CFrame.new(_0xECEC.Position)).Position
_0x1EE5.RenderStepped:Wait()
_0x8AE5.CFrame = _0xECEC; _0xE3E4.CameraOffset = _0xEE32
end)
return true
end
local function _0xA9B7()
for _, _0x8A30 in ipairs(_0x730C.Parts) do if _0x8A30 and _0x8A30.Parent then _0x8A30.Transparency = 0 end end
local _0x16E4 = _0xAD3B.Character; local _0x74C5 = _0x16E4 and _0x16E4:FindFirstChildOfClass("Humanoid")
if _0x74C5 then _0x74C5.CameraOffset = Vector3.new(0,0,0) end
if _0x730C.Conn then _0x730C.Conn:Disconnect(); _0x730C.Conn = nil end
_0x730C.Parts = {}
end
_0xA606.MouseButton1Click:Connect(function()
_0x730C.Enabled = not _0x730C.Enabled
if _0x730C.Enabled then
if _0x7F38() then _0xA606.Text ="INVISIBLE (FE): ON"; _0xA606.BackgroundColor3 = Color3.fromRGB(255,255,255); _0xA606.TextColor3 = Color3.fromRGB(0,0,0)
else _0x730C.Enabled = false end
else
_0xA9B7(); _0xA606.Text ="INVISIBLE (FE): OFF"; _0xA606.BackgroundColor3 = Color3.fromRGB(25,25,30); _0xA606.TextColor3 = Color3.fromRGB(255,255,255)
end
end)
_0xFCCE.VoidStop = function()
if _0x28C6.VoidDropEnabled then _0x3018() end
if _0x28C6.VoidTrapActive then _0x40E1(false) end
_0xA9B7()
end
endlocal _0x7F93 = _0x9927(_0xDCD8,"PHYSIC", false)
_0x6DE4["PHYSIC"] = _0x7F93
do
local _0x06E4 = _0x9565(_0x7F93,"PHYSIC MANIPULATOR", UDim2.new(0,0,0,0), UDim2.new(1,0,0,20), Color3.fromRGB(255,255,255))
_0x06E4.TextSize = 14
local _0xA077 = _0x9565(_0x7F93,"Status: Idle", UDim2.new(0,0,0,22), UDim2.new(1,0,0,18), Color3.fromRGB(150,150,155))
local _0xCC12 = {"STACK","ORBIT","BLACKHOLE","TORNADO","VORTEX","WAVE","CAGE","SPIRAL","SATURN"}
local _0x7EFB ="STACK"local _0x55C4 = _0x3025(_0x7F93,"Mode: ".. _0x7EFB, UDim2.new(0,0,0,45), UDim2.new(0.48,-2,0,32), Color3.fromRGB(25,25,30))
_0x55C4.MouseButton1Click:Connect(function()
local _0xA677 = 1
for i, _0x8A30 in ipairs(_0xCC12) do if _0x8A30 == _0x7EFB then _0xA677 = i; break end end
_0xA677 = _0xA677 % #_0xCC12 + 1; _0x7EFB = _0xCC12[_0xA677]; _0x55C4.Text ="Mode: ".. _0x7EFB
end)
local _0xCE34 = 2500
local _0xD94F = _0x3025(_0x7F93,"Radius: ".. _0xCE34, UDim2.new(0.52,2,0,45), UDim2.new(0.48,-2,0,32), Color3.fromRGB(25,25,30))
_0xD94F.MouseButton1Click:Connect(function()
_0xCE34 = _0xCE34 + 500
if _0xCE34 > 5000 then _0xCE34 = 500 end
_0xD94F.Text ="Radius: ".. _0xCE34
end)
local _0x8588, _0xBDC3, _0xC81C, _0x0727 = false, nil, {}, 0
local function _0xAEA4(_0x7ADD)
if not _0x7ADD:IsA("BasePart") or _0x7ADD.Anchored then return false end
if _0xAD3B.Character and _0x7ADD:IsDescendantOf(_0xAD3B.Character) then return false end
if _0x7ADD.Parent and _0x7ADD.Parent:FindFirstChildOfClass("Humanoid") then return false end
if _0x7ADD.Name =="Baseplate"or _0x7ADD.Name =="Terrain"then return false end
return true
end
local function _0xC9BD(_0x7ADD)
if _0xC81C[_0x7ADD] then return end
pcall(function()
local _0x74C5 = _0xAD3B.Character and _0xAD3B.Character:FindFirstChild("Head")
if not _0x74C5 then return end
local _0x91CC = _0x74C5:FindFirstChild("An9xTA")
if not _0x91CC then
_0x91CC = Instance.new("Attachment"); _0x91CC.Name ="An9xTA"_0x91CC.Parent = _0x74C5; _0x91CC.Position = Vector3.new(0, 3, 0)
end
local _0xFD62 = Instance.new("Attachment"); _0xFD62.Name ="An9xPA"; _0xFD62.Parent = _0x7ADD
local _0x17B8 = Instance.new("AlignPosition"); _0x17B8.Name ="An9xA"_0x17B8.Attachment0 = _0xFD62; _0x17B8.Attachment1 = _0x91CC
_0x17B8.MaxForce = 9e18; _0x17B8.Responsiveness = 200; _0x17B8.RigidityEnabled = true
_0x17B8.ApplyAtCenterOfMass = true; _0x17B8.Parent = _0x7ADD
_0x7ADD.CanCollide = false; _0x7ADD.Velocity = Vector3.new(0, 5, 0)
_0xC81C[_0x7ADD] = {Att = _0xFD62, Align = _0x17B8, Seed = math.random()*math.pi*2,
HOff = math.random(-8,8), RJ = 0.7 + math.random()*0.6}
end)
end
local function _0xB968(_0x7ADD)
local _0x16E4 = _0xC81C[_0x7ADD]
if _0x16E4 then
pcall(function() if _0x16E4.Att then _0x16E4.Att:Destroy() end; if _0x16E4.Align then _0x16E4.Align:Destroy() end end)
_0xC81C[_0x7ADD] = nil
end
end
local function _0xEC50(mode, pos, data, i, _0x89CE, _0xE0FB)
local _0xEBAD = data.Seed; local _0x74C5 = data.HOff
if mode =="STACK"then return pos + Vector3.new(0, 10, 0)
elseif mode =="ORBIT"then
local _0xD1DF = _0xE0FB * 1.5 + _0xEBAD + (_0x89CE > 0 and (i/_0x89CE)*math.pi*2 or 0)
local _0x16F9 = 30 * data.RJ
return pos + Vector3.new(math.cos(_0xD1DF)*_0x16F9, 10 + _0x74C5, math.sin(_0xD1DF)*_0x16F9)
elseif mode =="BLACKHOLE"then
local _0xD1DF = _0xE0FB * 3 + _0xEBAD; local _0x16F9 = 6 * (0.3 + 0.7 * math.abs(math.sin(_0xE0FB*0.5 + _0xEBAD)))
return pos + Vector3.new(math.cos(_0xD1DF)*_0x16F9, 10 + _0x74C5*0.5, math.sin(_0xD1DF)*_0x16F9)
elseif mode =="TORNADO"then
local _0x9A34 = _0xE0FB * 2.25; local _0xD1DF = _0x9A34 + _0xEBAD
local _0xC35E = (math.sin(_0xE0FB*0.8 + _0xEBAD) + 1) / 2
local _0x16F9 = 25 * (1 - _0xC35E*0.5) * data.RJ
return pos + Vector3.new(math.cos(_0xD1DF)*_0x16F9, _0xC35E*60, math.sin(_0xD1DF)*_0x16F9)
elseif mode =="VORTEX"then
local _0xF443 = (math.sin(_0xE0FB*1.2 + _0xEBAD) + 1) / 2
local _0x16F9 = 5 + _0xF443*60*data.RJ; local _0xD1DF = _0xE0FB * 3 + _0xEBAD
return pos + Vector3.new(math.cos(_0xD1DF)*_0x16F9, 10 + (_0xF443-0.5)*30, math.sin(_0xD1DF)*_0x16F9)
elseif mode =="WAVE"then
local _0xD1DF = _0xE0FB*0.75 + _0xEBAD; local _0x16F9 = 40 * data.RJ
local _0xE3E4 = 10 + math.sin(_0xE0FB*2 + _0xEBAD)*20
return pos + Vector3.new(math.cos(_0xD1DF)*_0x16F9, _0xE3E4, math.sin(_0xD1DF)*_0x16F9)
elseif mode =="CAGE"then
local _0xC3DA = math.acos(1 - 2*(i+0.5)/math.max(_0x89CE,1))
local _0xE54C = math.pi * (1 + 5^0.5) * i; local _0x16F9 = 15 * data.RJ
return pos + Vector3.new(math.cos(_0xE54C)*math.sin(_0xC3DA)*_0x16F9, math.cos(_0xC3DA)*_0x16F9 + 10, math.sin(_0xE54C)*math.sin(_0xC3DA)*_0x16F9)
elseif mode =="SPIRAL"then
local _0xDF51 = (i/math.max(_0x89CE,1)) + _0xE0FB*0.3
local _0xD1DF = _0xDF51*math.pi*2*3 + _0xEBAD
local _0xE3E4 = (_0xDF51%1)*80
local _0x16F9 = 30*data.RJ*(0.6 + 0.4*math.sin(_0xDF51*math.pi))
return pos + Vector3.new(math.cos(_0xD1DF)*_0x16F9, _0xE3E4, math.sin(_0xD1DF)*_0x16F9)
elseif mode =="SATURN"then
local _0xD1DF = _0xE0FB*1.5 + _0xEBAD + (_0x89CE > 0 and (i/_0x89CE)*math.pi*2 or 0)
local _0x16F9 = 45 * data.RJ; local _0xF1C2 = math.rad(25)
local _0x13FA = math.cos(_0xD1DF)*_0x16F9; local _0x0183 = math.sin(_0xD1DF)*_0x16F9; local _0xB859 = _0x74C5*0.3
local _0xE0E3 = _0xB859*math.cos(_0xF1C2) - _0x0183*math.sin(_0xF1C2)
local _0x2E89 = _0xB859*math.sin(_0xF1C2) + _0x0183*math.cos(_0xF1C2)
return pos + Vector3.new(_0x13FA, _0xE0E3 + 10, _0x2E89)
end
return pos + Vector3.new(0, 10, 0)
end
local function _0x7CC9()
_0x8588 = false
if _0xBDC3 then _0xBDC3:Disconnect(); _0xBDC3 = nil end
for _0x7ADD in pairs(_0xC81C) do _0xB968(_0x7ADD) end
_0xC81C = {}
_0xAF1E(_0xA077,"Status: Idle"); _0xE612.Text ="START PHYSIC"; _0xE612.BackgroundColor3 = Color3.fromRGB(25,25,30)
end
local function _0x1001()
_0x8588 = true; _0xC81C = {}; _0x0727 = 0
_0xE612.Text ="STOP PHYSIC"; _0xE612.BackgroundColor3 = Color3.fromRGB(255,255,255); _0xE612.TextColor3 = Color3.fromRGB(0,0,0)
_0xBDC3 = _0x1EE5.Heartbeat:Connect(function(dt)
if not _0x8588 then return end
_0x40DB(); _0x0727 = _0x0727 + dt
local _0x1A53 = _0xAD3B.Character; local _0x1B34 = _0x1A53 and _0x1A53:FindFirstChild("HumanoidRootPart")
local _0x835B = _0x1A53 and _0x1A53:FindFirstChild("Head")
if not _0x1B34 or not _0x835B then _0x7CC9(); return end
local _0x0E7B = _0x835B.Position + Vector3.new(0, 3, 0)
for _, _0x7ADD in pairs(_0x938B:GetDescendants()) do
if _0xAEA4(_0x7ADD) then
if (_0x7ADD.Position - _0x0E7B).Magnitude < _0xCE34 then _0xC9BD(_0x7ADD) end
end
end
local _0x6373 = 0
for _ in pairs(_0xC81C) do _0x6373 = _0x6373 + 1 end
local _0x95B7, _0x29E6 = 0, 0
for _0x7ADD, _0x2736 in pairs(_0xC81C) do
if _0x7ADD.Parent and _0xAEA4(_0x7ADD) then
_0x29E6 = _0x29E6 + 1; _0x95B7 = _0x95B7 + 1
local _0xC7A4 = _0xEC50(_0x7EFB, _0x0E7B, _0x2736, _0x29E6, _0x6373, _0x0727)
if _0x7EFB =="STACK"then
_0x2736.Att.WorldPosition = _0xC7A4; _0x7ADD.Velocity = Vector3.new(0, 0.5, 0)
else
_0x2736.Att.WorldPosition = _0xC7A4; _0x7ADD.Velocity = Vector3.zero
_0x7ADD.RotVelocity = Vector3.new(math.random()*5, math.random()*5, math.random()*5)
end
else _0xB968(_0x7ADD) end
end
_0xAF1E(_0xA077,"Active: ".. _0x95B7)
end)
end
local _0xE612 = _0x3025(_0x7F93,"START PHYSIC", UDim2.new(0,0,0,87), UDim2.new(1,0,0,36), Color3.fromRGB(25,25,30))
_0xE612.MouseButton1Click:Connect(function()
if _0x8588 then _0x7CC9() else _0x1001() end
end)
_0xFCCE.PhysicStop = _0x7CC9
endlocal _0xEB0D = _0x9927(_0xDCD8,"FOREST", false)
_0x6DE4["FOREST"] = _0xEB0D
do
local _0xF01B = {'wheel.*barrow','barrow','^carriage$','carriage','gerobak','^cart$','handcart','pushcart','vehicle','flingcart','pushvehicle'}
local _0x5C25 = {HumanoidRootPart=true,Torso=true,UpperTorso=true,LowerTorso=true,Head=true}
local function _0x41D6(_0xFBBD)
if not _0xFBBD or not _0xFBBD:IsA("Model") then return false end
local _0x89CE = _0xFBBD.Name:lower()
for _, _0x7ADD in ipairs(_0xF01B) do if _0x89CE:match(_0x7ADD) then return true end end
return false
end
local function _0x4C31()
local _0x8170 = {}
for _, o in ipairs(_0x938B:GetDescendants()) do
if o:IsA("Model") and _0x41D6(o) then _0x8170[#_0x8170+1] = o end
end
return _0x8170
end
local function _0xF3F9(_0xFBBD)
if not _0xFBBD then return nil end
for _, _0x7ADD in ipairs(_0xFBBD:GetDescendants()) do
if (_0x7ADD:IsA("VehicleSeat") or _0x7ADD:IsA("Seat")) and _0x7ADD.Occupant == nil then return _0x7ADD end
end
return nil
end
local function _0xC139(_0x16E4)
if not _0x16E4 then return 0 end
local _0xE0FB = 0
for _, _0x7ADD in ipairs(_0x16E4:GetDescendants()) do if _0x7ADD:IsA("BasePart") then _0xE0FB = _0xE0FB + _0x7ADD.AssemblyMass end end
return _0xE0FB
end
local function _0x0B88(_0xFBBD)
if not _0xFBBD then return end
for _, _0x7ADD in ipairs(_0xFBBD:GetDescendants()) do
if _0x7ADD:IsA("BasePart") then
pcall(function() _0x7ADD:SetNetworkOwner(_0xAD3B) end)
pcall(function() sethiddenproperty(_0x7ADD,"NetworkOwnershipRule", Enum.NetworkOwnershipRule.Manual) end)
end
end
end
local _0x4048 = Instance.new("Frame", _0xEB0D)
_0x4048.Size = UDim2.new(1,0,0,26); _0x4048.Position = UDim2.new(0,0,0,0)
_0x4048.BackgroundColor3 = Color3.fromRGB(20,20,25); _0x4048.ZIndex = 6
Instance.new("UICorner", _0x4048).CornerRadius = UDim.new(0,6)
Instance.new("UIStroke", _0x4048).Color = Color3.fromRGB(60,60,65)
local _0x93C6 = {{key="wb",label="WB"},{key="canopy",label="CANOPY"},{key="rock",label="ROCK"}}
local _0x30B4, _0x6A74 = {}, {}
local _0x3CF7 ="wb"for i, def in ipairs(_0x93C6) do
local _0x98D0 = Instance.new("TextButton", _0x4048)
_0x98D0.Size = UDim2.new((1/#_0x93C6),-4,0,18); _0x98D0.Position = UDim2.new((i-1)/#_0x93C6,2,0,4)
_0x98D0.BackgroundColor3 = (def.key==_0x3CF7) and Color3.fromRGB(255,255,255) or Color3.fromRGB(30,30,35)
_0x98D0.Text = def.label; _0x98D0.TextColor3 = (def.key==_0x3CF7) and Color3.fromRGB(0,0,0) or Color3.fromRGB(200,200,205)
_0x98D0.Font = Enum.Font.GothamBold; _0x98D0.TextSize = 10; _0x98D0.ZIndex = 7
Instance.new("UICorner", _0x98D0).CornerRadius = UDim.new(0,4)
_0x6A74[def.key] = _0x98D0
_0x98D0.MouseButton1Click:Connect(function()
_0x3CF7 = def.key
for k, _0x7F51 in pairs(_0x6A74) do
_0x7F51.BackgroundColor3 = (k==_0x3CF7) and Color3.fromRGB(255,255,255) or Color3.fromRGB(30,30,35)
_0x7F51.TextColor3 = (k==_0x3CF7) and Color3.fromRGB(0,0,0) or Color3.fromRGB(200,200,205)
end
for k, _0x7ADD in pairs(_0x30B4) do _0x7ADD.Visible = (k == _0x3CF7) end
end)
local _0x8BC2 = Instance.new("ScrollingFrame", _0xEB0D)
_0x8BC2.Size = UDim2.new(1,0,1,-34); _0x8BC2.Position = UDim2.new(0,0,0,34)
_0x8BC2.BackgroundTransparency = 1; _0x8BC2.BorderSizePixel = 0
_0x8BC2.ScrollBarThickness = 3; _0x8BC2.ScrollBarImageColor3 = Color3.fromRGB(100,100,105)
_0x8BC2.CanvasSize = UDim2.new(0,0,0,0); _0x8BC2.AutomaticCanvasSize = Enum.AutomaticSize.Y
_0x8BC2.Visible = (def.key == _0x3CF7); _0x8BC2.ZIndex = 7
_0x30B4[def.key] = _0x8BC2
endlocal _0xD9AF = _0x30B4["wb"]
local _0xE4B1 = {AutoSit=false, AutoGetUp=false, SkipHeavy=false, FlyEnabled=false, FlySpeed=60,
WalkFling=false, WFGen=0, PriorityMode=false, ExcludedPlayers={}, FriendCache={},
HModel=nil, HSeat=nil, HWelds={}, HAnch={}, AutoSitConn=nil, FlyConn=nil, FlyModel=nil, FlySeat=nil, FlyBase=nil, FlyWelds={}, FlyAnch={},
CharConn=nil, CooldownUntil=0, AutoExcludeFriends=false}
local function _0x909B(_0xD00C)
local _0x931A, _0x72EA = pcall(function()
local _0x5E24 = _0xD00C.Character
if _0x5E24 then
local _0xE636 = _0x5E24:FindFirstChildOfClass("Tool")
if _0xE636 and _0xE636.Name:lower():sub(1, 11) =="wheelbarrow"then return true end
end
local _0xFE7D = _0xD00C:FindFirstChild("Backpack")
if _0xFE7D then
for _, _0xE0FB in ipairs(_0xFE7D:GetChildren()) do
if _0xE0FB:IsA("Tool") and _0xE0FB.Name:lower():sub(1, 11) =="wheelbarrow"then return true end
end
end
return false
end)
return _0x931A and _0x72EA or false
end
local function _0x9EEA()
if _0xE4B1.AutoSitConn then return end
_0xE4B1.AutoSitConn = _0x1EE5.Heartbeat:Connect(function()
if not _0xE4B1.AutoSit then return end
local _0x16E4 = _0xAD3B.Character; local _0x16F9 = _0x16E4 and _0x16E4:FindFirstChild("HumanoidRootPart")
local _0x74C5 = _0x16E4 and _0x16E4:FindFirstChildOfClass("Humanoid")
if not _0x16F9 or not _0x74C5 then return end
if tick() < _0xE4B1.CooldownUntil then return end
if _0x74C5.Sit then
local _0x9A34 = _0x74C5.SeatPart
if _0x9A34 and not _0x41D6(_0x9A34:FindFirstAncestorOfClass("Model")) then return end
end
if _0x74C5.Sit and _0xE4B1.AutoGetUp and _0xE4B1.HSeat then
task.delay(1, function()
_0x74C5.Sit = false; _0x74C5.Jump = true
_0xE4B1.HSeat = nil; _0xE4B1.CooldownUntil = tick() + 2
end)
return
end
if _0x74C5.Sit then return end
local _0x68DF = _0xC139(_0x16E4)
local _0x293A, _0x61ED = nil, 120
for _, _0x778F in ipairs(_0x4C31()) do
local _0xEA85 = _0xF3F9(_0x778F)
if _0xEA85 then
local _0x2736 = (_0xEA85.Position - _0x16F9.Position).Magnitude
if _0x2736 < _0x61ED then
local _0x07B7 = false
if _0xE4B1.SkipHeavy then
local _0x3DC5 = nil
for _, _0xD00C in ipairs(_0x7E7C:GetPlayers()) do
if _0xD00C ~= _0xAD3B and _0xD00C.Character then
for _, _0xC35E in ipairs(_0xD00C.Character:GetDescendants()) do
if _0xC35E:IsA("Weld") and ((_0xC35E.Part0 and _0xC35E.Part0:IsDescendantOf(_0x778F)) or (_0xC35E.Part1 and _0xC35E.Part1:IsDescendantOf(_0x778F))) then
_0x3DC5 = _0xD00C.Character; break
end
end
if _0x3DC5 then break end
end
end
if _0x3DC5 and _0xC139(_0x3DC5) > _0x68DF then _0x07B7 = true end
end
if not _0x07B7 then _0x61ED = _0x2736; _0x293A = _0x778F end
end
end
end
if _0x293A then
local _0xEA85 = _0xF3F9(_0x293A)
if _0xEA85 then
_0x0B88(_0x293A)
local _0x761D = _0x293A:FindFirstChild("NoTool") or _0x293A:FindFirstChild("Base") or _0xEA85
if _0x761D then
for _, _0xC35E in ipairs(_0xE4B1.HWelds) do pcall(function() _0xC35E:Destroy() end) end
_0xE4B1.HWelds = {}; _0xE4B1.HAnch = {}
_0xE4B1.HAnch[_0x761D] = _0x761D.Anchored; pcall(function() _0x761D.Anchored = false end)
for _, _0x7ADD in ipairs(_0x293A:GetDescendants()) do
if _0x7ADD:IsA("BasePart") and _0x7ADD ~= _0x761D then
_0xE4B1.HAnch[_0x7ADD] = _0x7ADD.Anchored; pcall(function() _0x7ADD.Anchored = false end)
local _0xBBE1 = Instance.new("WeldConstraint")
_0xBBE1.Part0 = _0x761D; _0xBBE1.Part1 = _0x7ADD; _0xBBE1.Parent = _0x761D
table.insert(_0xE4B1.HWelds, _0xBBE1)
end
end
_0xE4B1.HModel = _0x293A; _0xE4B1.HSeat = _0xEA85
task.wait(0.1); pcall(function() _0xEA85:Sit(_0x74C5) end)
end
end
end
end)
end
local _0x6A42 = _0x3025(_0xD9AF,"AUTO SIT: OFF", UDim2.new(0,0,0,0), UDim2.new(0.48,-2,0,30), Color3.fromRGB(25,25,30))
_0x6A42.MouseButton1Click:Connect(function()
_0xE4B1.AutoSit = not _0xE4B1.AutoSit
_0x6A42.Text ="AUTO SIT: ".. (_0xE4B1.AutoSit and"ON"or"OFF")
_0x6A42.BackgroundColor3 = _0xE4B1.AutoSit and Color3.fromRGB(255,255,255) or Color3.fromRGB(25,25,30)
_0x6A42.TextColor3 = _0xE4B1.AutoSit and Color3.fromRGB(0,0,0) or Color3.fromRGB(255,255,255)
if _0xE4B1.AutoSit then _0x9EEA()
else
if _0xE4B1.AutoSitConn then _0xE4B1.AutoSitConn:Disconnect(); _0xE4B1.AutoSitConn = nil end
end
end)
local _0xF530 = _0x3025(_0xD9AF,"AUTO GET UP: OFF", UDim2.new(0.52,2,0,0), UDim2.new(0.48,-2,0,30), Color3.fromRGB(25,25,30))
_0xF530.MouseButton1Click:Connect(function()
_0xE4B1.AutoGetUp = not _0xE4B1.AutoGetUp
_0xF530.Text ="AUTO GET UP: ".. (_0xE4B1.AutoGetUp and"ON"or"OFF")
_0xF530.BackgroundColor3 = _0xE4B1.AutoGetUp and Color3.fromRGB(255,255,255) or Color3.fromRGB(25,25,30)
_0xF530.TextColor3 = _0xE4B1.AutoGetUp and Color3.fromRGB(0,0,0) or Color3.fromRGB(255,255,255)
end)
local _0x1C20 = _0x3025(_0xD9AF,"WB FLY: OFF", UDim2.new(0,0,0,72), UDim2.new(0.48,-2,0,30), Color3.fromRGB(25,25,30))
local function _0x0499()
local _0x16E4 = _0xAD3B.Character; local _0x16F9 = _0x16E4 and _0x16E4:FindFirstChild("HumanoidRootPart")
local _0x74C5 = _0x16E4 and _0x16E4:FindFirstChildOfClass("Humanoid")
if not _0x16F9 or not _0x74C5 then return false end
local _0x293A, _0x61ED = nil, 30
for _, _0x778F in ipairs(_0x4C31()) do
local _0xEA85 = _0x778F:FindFirstChildWhichIsA("Seat") or _0x778F:FindFirstChildWhichIsA("VehicleSeat")
if _0xEA85 then
local _0x2736 = (_0xEA85.Position - _0x16F9.Position).Magnitude
if _0x2736 < _0x61ED then _0x61ED = _0x2736; _0x293A = _0x778F end
end
end
if not _0x293A then return false end
_0x0B88(_0x293A)
local _0xEA85 = _0x293A:FindFirstChildWhichIsA("Seat") or _0x293A:FindFirstChildWhichIsA("VehicleSeat")
local _0x761D = _0x293A:FindFirstChild("NoTool") or _0x293A:FindFirstChild("Base") or _0xEA85
if not _0x761D then return false end
_0xE4B1.FlyModel = _0x293A; _0xE4B1.FlySeat = _0xEA85; _0xE4B1.FlyBase = _0x761D
_0xE4B1.FlyWelds = {}; _0xE4B1.FlyAnch = {}
for _, _0x7ADD in ipairs(_0x293A:GetDescendants()) do
if _0x7ADD:IsA("BasePart") then
_0xE4B1.FlyAnch[_0x7ADD] = _0x7ADD.Anchored; pcall(function() _0x7ADD.Anchored = false end)
if _0x7ADD ~= _0x761D then
local _0xBBE1 = Instance.new("WeldConstraint"); _0xBBE1.Part0 = _0x761D; _0xBBE1.Part1 = _0x7ADD; _0xBBE1.Parent = _0x761D
table.insert(_0xE4B1.FlyWelds, _0xBBE1)
end
end
end
_0xE4B1.FlyConn = _0x1EE5.Heartbeat:Connect(function()
if not _0xE4B1.FlyEnabled then return end
local _0x2E93 = _0xAD3B.Character; local _0x8AE5 = _0x2E93 and _0x2E93:FindFirstChild("HumanoidRootPart")
local _0xE3E4 = _0x2E93 and _0x2E93:FindFirstChildOfClass("Humanoid")
if not _0x8AE5 or not _0xE3E4 then return end
local _0x46E8 = _0x938B.CurrentCamera; if not _0x46E8 then return end
local _0xDC86 = Vector3.zero
if _0xE442:IsKeyDown(Enum.KeyCode.W) then _0xDC86 += _0x46E8.CFrame.LookVector end
if _0xE442:IsKeyDown(Enum.KeyCode.S) then _0xDC86 -= _0x46E8.CFrame.LookVector end
if _0xE442:IsKeyDown(Enum.KeyCode.A) then _0xDC86 -= _0x46E8.CFrame.RightVector end
if _0xE442:IsKeyDown(Enum.KeyCode.D) then _0xDC86 += _0x46E8.CFrame.RightVector end
if _0xE442:IsKeyDown(Enum.KeyCode.Space) then _0xDC86 += Vector3.new(0,1,0) end
if _0xE442:IsKeyDown(Enum.KeyCode.LeftShift) then _0xDC86 -= Vector3.new(0,1,0) end
local _0x4D1F = _0xDC86.Magnitude > 0 and _0xDC86.Unit * _0xE4B1.FlySpeed or Vector3.zero
pcall(function()
_0xE4B1.FlyBase.AssemblyLinearVelocity = _0x4D1F; _0xE4B1.FlyBase.AssemblyAngularVelocity = Vector3.zero
_0x8AE5.AssemblyLinearVelocity = _0x4D1F; _0x8AE5.AssemblyAngularVelocity = Vector3.zero
end)
if _0xE4B1.FlySeat and _0xE3E4.SeatPart ~= _0xE4B1.FlySeat then pcall(function() _0xE4B1.FlySeat:Sit(_0xE3E4) end) end
_0xE3E4.PlatformStand = true
end)
return true
end
_0x1C20.MouseButton1Click:Connect(function()
_0xE4B1.FlyEnabled = not _0xE4B1.FlyEnabled
_0x1C20.Text ="WB FLY: ".. (_0xE4B1.FlyEnabled and"ON"or"OFF")
_0x1C20.BackgroundColor3 = _0xE4B1.FlyEnabled and Color3.fromRGB(255,255,255) or Color3.fromRGB(25,25,30)
_0x1C20.TextColor3 = _0xE4B1.FlyEnabled and Color3.fromRGB(0,0,0) or Color3.fromRGB(255,255,255)
if _0xE4B1.FlyEnabled then _0x0499()
else
if _0xE4B1.FlyConn then _0xE4B1.FlyConn:Disconnect(); _0xE4B1.FlyConn = nil end
for _, _0xC35E in ipairs(_0xE4B1.FlyWelds) do pcall(function() _0xC35E:Destroy() end) end
_0xE4B1.FlyWelds = {}
for _0x7ADD in pairs(_0xE4B1.FlyAnch) do pcall(function() _0x7ADD.Anchored = false end) end
_0xE4B1.FlyAnch = {}; _0xE4B1.FlyModel = nil; _0xE4B1.FlySeat = nil; _0xE4B1.FlyBase = nil
end
end)
local _0x63A3 = _0x3025(_0xD9AF,"WALKFLING: OFF", UDim2.new(0,0,0,110), UDim2.new(1,0,0,30), Color3.fromRGB(25,25,30))
local _0xE477 = _0x9565(_0xD9AF,"Status: OFF", UDim2.new(0,0,0,144), UDim2.new(1,0,0,14), Color3.fromRGB(150,150,155))
_0xE477.TextSize = 9
local _0x28EE = _0x3025(_0xD9AF,"PRIORITY MODE: OFF", UDim2.new(0,0,0,168), UDim2.new(0.48,-2,0,30), Color3.fromRGB(25,25,30))
_0x28EE.MouseButton1Click:Connect(function()
_0xE4B1.PriorityMode = not _0xE4B1.PriorityMode
_0x28EE.Text ="PRIORITY MODE: ".. (_0xE4B1.PriorityMode and"ON"or"OFF")
_0x28EE.BackgroundColor3 = _0xE4B1.PriorityMode and Color3.fromRGB(255,255,255) or Color3.fromRGB(25,25,30)
_0x28EE.TextColor3 = _0xE4B1.PriorityMode and Color3.fromRGB(0,0,0) or Color3.fromRGB(255,255,255)
if _0xE4B1.PriorityMode then _0x28EE.Text ="PRIORITY: PICK IN EXCL"end
end)
local _0x88C8 = _0x3025(_0xD9AF,"EXCL FRIENDS: OFF", UDim2.new(0.52,2,0,168), UDim2.new(0.48,-2,0,30), Color3.fromRGB(25,25,30))
_0x88C8.MouseButton1Click:Connect(function()
_0xE4B1.AutoExcludeFriends = not (_0xE4B1.AutoExcludeFriends or false)
_0x88C8.Text ="EXCL FRIENDS: ".. (_0xE4B1.AutoExcludeFriends and"ON"or"OFF")
_0x88C8.BackgroundColor3 = _0xE4B1.AutoExcludeFriends and Color3.fromRGB(255,255,255) or Color3.fromRGB(25,25,30)
_0x88C8.TextColor3 = _0xE4B1.AutoExcludeFriends and Color3.fromRGB(0,0,0) or Color3.fromRGB(255,255,255)
_0xE4B1.FriendCache = {}
end)
local _0x185B = _0x9565(_0xD9AF,"Player List (Klik = Target/Exclude):", UDim2.new(0,0,0,206), UDim2.new(1,0,0,16), Color3.fromRGB(200,200,205))
_0x185B.TextSize = 9
local _0x550F = Instance.new("ScrollingFrame", _0xD9AF)
_0x550F.Size = UDim2.new(1,0,0,120); _0x550F.Position = UDim2.new(0,0,0,224)
_0x550F.BackgroundColor3 = Color3.fromRGB(10,10,12); _0x550F.BorderSizePixel = 0
_0x550F.ScrollBarThickness = 2; _0x550F.ZIndex = 7
Instance.new("UICorner", _0x550F).CornerRadius = UDim.new(0,6)
Instance.new("UIListLayout", _0x550F).Padding = UDim.new(0,2)
local function _0x2756()
for _, _0x16E4 in ipairs(_0x550F:GetChildren()) do
if _0x16E4:IsA("TextButton") then _0x16E4:Destroy() end
end
local _0x29E6 = 0
for _, _0xD00C in ipairs(_0x7E7C:GetPlayers()) do
if _0xD00C ~= _0xAD3B then
_0x29E6 = _0x29E6 + 1
local _0x512D = _0xE4B1.ExcludedPlayers[_0xD00C.Name]
local _0x35C2 = _0x909B(_0xD00C)
local _0x98D0 = Instance.new("TextButton", _0x550F)
_0x98D0.Size = UDim2.new(1,-4,0,24); _0x98D0.Position = UDim2.new(0,2,0,(_0x29E6-1)*26)
if _0xE4B1.PriorityMode then
_0x98D0.BackgroundColor3 = _0x512D and Color3.fromRGB(255,255,255) or Color3.fromRGB(20,20,25)
_0x98D0.TextColor3 = _0x512D and Color3.fromRGB(0,0,0) or (_0x35C2 and Color3.fromRGB(255,255,255) or Color3.fromRGB(150,150,155))
else
_0x98D0.BackgroundColor3 = _0x512D and Color3.fromRGB(255,255,255) or Color3.fromRGB(20,20,25)
_0x98D0.TextColor3 = _0x512D and Color3.fromRGB(0,0,0) or (_0x35C2 and Color3.fromRGB(255,255,255) or Color3.fromRGB(150,150,155))
end
_0x98D0.Text ="  ".. _0xD00C.Name .. (_0x35C2 and" [WB]"or"")
_0x98D0.Font = Enum.Font.GothamMedium; _0x98D0.TextSize = 10
_0x98D0.TextXAlignment = Enum.TextXAlignment.Left; _0x98D0.ZIndex = 8
Instance.new("UICorner", _0x98D0).CornerRadius = UDim.new(0,4)
_0x98D0.MouseButton1Click:Connect(function()
_0xE4B1.ExcludedPlayers[_0xD00C.Name] = not _0xE4B1.ExcludedPlayers[_0xD00C.Name] or nil
_0x2756()
end)
end
end
_0x550F.CanvasSize = UDim2.new(0,0,0, _0x29E6 * 26 + 4)
end
_0x2756()
_0x7E7C.PlayerAdded:Connect(function() task.wait(1); _0x2756() end)
_0x7E7C.PlayerRemoving:Connect(function() task.wait(1); _0x2756() end)
_0x28EE.MouseButton1Click:Connect(function() task.wait(0.1); _0x2756() end)local function _0xB680(_0x2A70)
local _0x578F = 2^30 * 99999999
local _0x5CE9 = 0.1
while _0xE4B1.WalkFling and _0xE4B1.WFGen == _0x2A70 do
_0x1EE5.Heartbeat:Wait()
local _0x2DFA = _0xAD3B.Character
local _0xEF61 = _0x2DFA and _0x2DFA:FindFirstChild("HumanoidRootPart")
local _0xCA3D = _0x2DFA and _0x2DFA:FindFirstChildOfClass("Humanoid")
while _0xE4B1.WalkFling and _0xE4B1.WFGen == _0x2A70 and not (_0x2DFA and _0x2DFA.Parent and _0xEF61 and _0xEF61.Parent and _0xCA3D and _0xCA3D.Health > 0) do
_0x1EE5.Heartbeat:Wait()
_0x2DFA = _0xAD3B.Character
_0xEF61 = _0x2DFA and _0x2DFA:FindFirstChild("HumanoidRootPart")
_0xCA3D = _0x2DFA and _0x2DFA:FindFirstChildOfClass("Humanoid")
end
if not (_0xE4B1.WalkFling and _0xE4B1.WFGen == _0x2A70) then break end
pcall(function() _0xEF61:SetNetworkOwner(_0xAD3B) end)
pcall(function() sethiddenproperty(_0xEF61,"NetworkOwnershipRule", Enum.NetworkOwnershipRule.Manual) end)
local _0x4D1F = _0xEF61.AssemblyLinearVelocity
_0xEF61.AssemblyLinearVelocity = Vector3.new(_0x578F, _0x578F, _0x578F)pcall(function()
for _, _0xD00C in ipairs(_0x7E7C:GetPlayers()) do
if _0xD00C ~= _0xAD3B and _0xD00C.Character and _0x909B(_0xD00C) then
local _0x2376
if _0xE4B1.PriorityMode then
_0x2376 = _0xE4B1.ExcludedPlayers[_0xD00C.Name] == true
else
_0x2376 = not _0xE4B1.ExcludedPlayers[_0xD00C.Name]
end
if _0x2376 and _0xE4B1.AutoExcludeFriends then
if _0xE4B1.FriendCache[_0xD00C.Name] then
_0x2376 = false
else
local _0x931A, _0x110B = pcall(function() return _0xAD3B:IsFriendsWith(_0xD00C.UserId) end)
if _0x931A and _0x110B then
_0xE4B1.FriendCache[_0xD00C.Name] = true
_0x2376 = false
end
end
end
if _0x2376 then
for _, part in ipairs(_0xD00C.Character:GetDescendants()) do
if part:IsA("BasePart") then
pcall(firetouchinterest, _0xEF61, part, 0)
pcall(firetouchinterest, _0xEF61, part, 1)
end
end
end
end
end
end)
_0x1EE5.RenderStepped:Wait()
if _0xEF61 and _0xEF61.Parent then
_0xEF61.AssemblyLinearVelocity = _0x4D1F
end
_0x1EE5.Stepped:Wait()
if _0xEF61 and _0xEF61.Parent then
_0xEF61.AssemblyLinearVelocity = _0x4D1F + Vector3.new(0, _0x5CE9, 0)
_0x5CE9 = -_0x5CE9
end
end
end
_0x63A3.MouseButton1Click:Connect(function()
if _0xE4B1.WalkFling then
_0xE4B1.WalkFling = false; _0xE4B1.WFGen = _0xE4B1.WFGen + 1
if _0xE4B1.CharConn then pcall(function() _0xE4B1.CharConn:Disconnect() end); _0xE4B1.CharConn = nil end
local _0x16E4 = _0xAD3B.Character
local _0x16F9 = _0x16E4 and _0x16E4:FindFirstChild("HumanoidRootPart")
if _0x16F9 then _0x16F9.AssemblyLinearVelocity = Vector3.zero; _0x16F9.AssemblyAngularVelocity = Vector3.zero end
_0x63A3.Text ="WALKFLING: OFF"; _0x63A3.BackgroundColor3 = Color3.fromRGB(25,25,30); _0x63A3.TextColor3 = Color3.fromRGB(255,255,255)
_0xAF1E(_0xE477,"Status: OFF")
else
_0xE4B1.WalkFling = true; _0xE4B1.WFGen = _0xE4B1.WFGen + 1; _0xE4B1.FriendCache = {}
if not _0xE4B1.CharConn then
_0xE4B1.CharConn = _0xAD3B.CharacterAdded:Connect(function()
if not _0xE4B1.WalkFling then return end
_0xE4B1.WFGen = _0xE4B1.WFGen + 1
task.spawn(_0xB680, _0xE4B1.WFGen)
end)
end
task.spawn(_0xB680, _0xE4B1.WFGen)
_0x63A3.Text ="WALKFLING: ON"; _0x63A3.BackgroundColor3 = Color3.fromRGB(255,255,255); _0x63A3.TextColor3 = Color3.fromRGB(0,0,0)
_0xAF1E(_0xE477,"Status: ON (Hitting All WB)")
end
end)local _0x1575 = _0x30B4["canopy"]
local _0x71D8 = {Lifts={}, Selected="Lift1", AutoSit=false, FlyEnabled=false, FlySpeed=60, Conn=nil,
TPPusher=false, AntiDisappear=false, TPConn=nil, StabilityConn=nil, LockY=0}
local function _0xA1A9()
local _0x0A69 = _0x938B:FindFirstChild("Canopy Ride")
if not _0x0A69 then return {"Lift1","Lift2","Lift4","Lift5","Lift6"} end
local _0x89CE = {}
for _, _0x16E4 in ipairs(_0x0A69:GetChildren()) do
if _0x16E4:IsA("Model") and _0x16E4.Name:match("^Lift%d+$") then _0x89CE[#_0x89CE+1] = _0x16E4.Name end
end
table.sort(_0x89CE, function(_0xD1DF, _0x98D0) return tonumber(_0xD1DF:match("%d+")) < tonumber(_0x98D0:match("%d+")) end)
return #_0x89CE > 0 and _0x89CE or {"Lift1","Lift2","Lift4","Lift5","Lift6"}
end
local function _0x4920(name)
local _0x0A69 = _0x938B:FindFirstChild("Canopy Ride")
return _0x0A69 and _0x0A69:FindFirstChild(name)
end
local function _0x3A97(_0x8170)
if not _0x8170 then return nil end
for _, _0x8A30 in ipairs(_0x8170:GetDescendants()) do
if _0x8A30:IsA("Seat") or _0x8A30:IsA("VehicleSeat") then return _0x8A30 end
end
return nil
end
local function _0x8648(refPos, maxDist)
local _0xB36A = {'wheel.*barrow','barrow','gerobak','cart'}
local _0x293A, _0x61ED = nil, maxDist or 120
for _, obj in ipairs(_0x938B:GetDescendants()) do
if obj:IsA("Model") then
local _0x89CE = obj.Name:lower()
local _0xA1E6 = false
for _, pat in ipairs(_0xB36A) do if _0x89CE:match(pat) then _0xA1E6 = true; break end end
if _0xA1E6 then
local _0x4E71; pcall(function() _0x4E71 = obj:GetPivot() end)
if _0x4E71 then
local _0x2736 = (_0x4E71.Position - refPos).Magnitude
if _0x2736 < _0x61ED then _0x61ED = _0x2736; _0x293A = obj end
end
end
end
end
return _0x293A
end
local function _0xBC60(wbModel)
if not wbModel then return nil end
local _0xA9C5
for _, _0x7ADD in ipairs(wbModel:GetDescendants()) do
if _0x7ADD:IsA("BasePart") and _0x7ADD.Name:lower() =="handles"then _0xA9C5 = _0x7ADD; break end
end
if not _0xA9C5 then
for _, _0x7ADD in ipairs(wbModel:GetDescendants()) do
if _0x7ADD:IsA("BasePart") then _0xA9C5 = _0x7ADD; break end
end
end
if not _0xA9C5 then return nil end
local function _0x5460(part)
if not part then return nil end
for _, _0xD00C in ipairs(_0x7E7C:GetPlayers()) do
if _0xD00C ~= _0xAD3B then
local _0x2DFA = _0xD00C.Character
if _0x2DFA and part:IsDescendantOf(_0x2DFA) then return _0x2DFA end
end
end
return nil
end
for _, _0xC35E in ipairs(wbModel:GetDescendants()) do
if _0xC35E:IsA("Weld") or _0xC35E:IsA("WeldConstraint") then
local _0x3DC5 = _0x5460(_0xC35E.Part0) or _0x5460(_0xC35E.Part1)
if _0x3DC5 then return _0x3DC5 end
end
end
local _0x0FB5 = 10
local _0x0BAB = nil
for _, _0xD00C in ipairs(_0x7E7C:GetPlayers()) do
if _0xD00C ~= _0xAD3B then
local _0x2DFA = _0xD00C.Character
local _0xEF61 = _0x2DFA and _0x2DFA:FindFirstChild("HumanoidRootPart")
if _0xEF61 then
local _0x2736 = (_0xEF61.Position - _0xA9C5.Position).Magnitude
if _0x2736 < _0x0FB5 then _0x0FB5 = _0x2736; _0x0BAB = _0x2DFA end
end
end
end
return _0x0BAB
end
local function _0x4896()
if _0x71D8.TPConn then _0x71D8.TPConn:Disconnect(); _0x71D8.TPConn = nil end
local _0x8D09 = 0
_0x71D8.TPConn = _0x1EE5.Heartbeat:Connect(function(dt)
if not _0x71D8.TPPusher then
if _0x71D8.TPConn then _0x71D8.TPConn:Disconnect(); _0x71D8.TPConn = nil end
return
end
local _0xD8D8 = _0x4920(_0x71D8.Selected)
if not _0xD8D8 or not _0xD8D8.PrimaryPart then return end
_0x8D09 = _0x8D09 + dt
if _0x8D09 < 0.15 then return end
_0x8D09 = 0
local _0x778F = _0x8648(_0xD8D8.PrimaryPart.Position, 120)
if not _0x778F then return end
local _0x0BAB = _0xBC60(_0x778F)
local _0x8DCF = _0x0BAB and _0x0BAB:FindFirstChild("HumanoidRootPart")
if not _0x8DCF then return end
local _0x761D = _0xD8D8.PrimaryPart
local _0x177A = Vector3.new(_0x8DCF.Position.X, _0x71D8.LockY, _0x8DCF.Position.Z)
pcall(function()
_0x761D.CFrame = CFrame.new(_0x177A) * (_0x761D.CFrame - _0x761D.CFrame.Position)
_0x761D.AssemblyLinearVelocity = Vector3.zero
_0x761D.AssemblyAngularVelocity = Vector3.zero
end)
end)
end
local function _0x5FE6()
if _0x71D8.StabilityConn then _0x71D8.StabilityConn:Disconnect(); _0x71D8.StabilityConn = nil end
local _0xE0FB = 0
_0x71D8.StabilityConn = _0x1EE5.Heartbeat:Connect(function(dt)
if not _0x71D8.AntiDisappear then
if _0x71D8.StabilityConn then _0x71D8.StabilityConn:Disconnect(); _0x71D8.StabilityConn = nil end
return
end
_0xE0FB = _0xE0FB + dt
if _0xE0FB < 1.5 then return end
_0xE0FB = 0
local _0xD8D8 = _0x4920(_0x71D8.Selected)
if not _0xD8D8 then return end
_0x0B88(_0xD8D8)
pcall(function()
for _, _0x9A34 in ipairs(_0xD8D8:GetDescendants()) do
if _0x9A34:IsA("Script") or _0x9A34:IsA("LocalScript") then
local _0x1AF9 = _0x9A34.Name:lower()
if _0x1AF9:find("weld") or _0x1AF9:find("seat") then _0x9A34.Disabled = true end
end
end
end)
end)
end
_0x71D8.Lifts = _0xA1A9(); _0x71D8.Selected = _0x71D8.Lifts[1] or"Lift1"local _0x1B3C = _0x9565(_0x1575,"🎡 CANOPY RIDE", UDim2.new(0,0,0,0), UDim2.new(1,0,0,20), Color3.fromRGB(255,255,255))
_0x1B3C.TextSize = 13
local _0x9917 = Instance.new("ScrollingFrame", _0x1575)
_0x9917.Size = UDim2.new(1,0,0,80); _0x9917.Position = UDim2.new(0,0,0,24)
_0x9917.BackgroundColor3 = Color3.fromRGB(10,10,12); _0x9917.BorderSizePixel = 0
_0x9917.ScrollBarThickness = 2; _0x9917.ZIndex = 7
Instance.new("UICorner", _0x9917).CornerRadius = UDim.new(0,6)
Instance.new("UIListLayout", _0x9917).Padding = UDim.new(0,2)
local function _0x263A()
for _, _0x16E4 in ipairs(_0x9917:GetChildren()) do if _0x16E4:IsA("TextButton") then _0x16E4:Destroy() end end
for i, _0x89CE in ipairs(_0x71D8.Lifts) do
local _0x98D0 = Instance.new("TextButton", _0x9917)
_0x98D0.Size = UDim2.new(1,-4,0,24); _0x98D0.Position = UDim2.new(0,2,0,(i-1)*26)
_0x98D0.BackgroundColor3 = (_0x89CE == _0x71D8.Selected) and Color3.fromRGB(255,255,255) or Color3.fromRGB(20,20,25)
_0x98D0.Text ="  ".. _0x89CE; _0x98D0.TextColor3 = (_0x89CE == _0x71D8.Selected) and Color3.fromRGB(0,0,0) or Color3.fromRGB(220,220,225)
_0x98D0.Font = Enum.Font.GothamMedium; _0x98D0.TextSize = 9
_0x98D0.TextXAlignment = Enum.TextXAlignment.Left; _0x98D0.ZIndex = 8
Instance.new("UICorner", _0x98D0).CornerRadius = UDim.new(0,4)
_0x98D0.MouseButton1Click:Connect(function()
_0x71D8.Selected = _0x89CE
for _, _0x16E4 in ipairs(_0x9917:GetChildren()) do
if _0x16E4:IsA("TextButton") then _0x16E4.BackgroundColor3 = Color3.fromRGB(20,20,25); _0x16E4.TextColor3 = Color3.fromRGB(220,220,225) end
end
_0x98D0.BackgroundColor3 = Color3.fromRGB(255,255,255); _0x98D0.TextColor3 = Color3.fromRGB(0,0,0)
end)
end
_0x9917.CanvasSize = UDim2.new(0,0,0,#_0x71D8.Lifts*26+4)
end
_0x263A()
local _0x49FA = _0x3025(_0x1575,"🔄 RESCAN LIFTS", UDim2.new(0,0,0,110), UDim2.new(1,0,0,30), Color3.fromRGB(25,25,30))
_0x49FA.MouseButton1Click:Connect(function()
_0x71D8.Lifts = _0xA1A9(); _0x71D8.Selected = _0x71D8.Lifts[1]; _0x263A()
end)
local _0x62AF = _0x3025(_0x1575,"TP & SIT", UDim2.new(0,0,0,144), UDim2.new(0.48,-2,0,32), Color3.fromRGB(25,25,30))
_0x62AF.MouseButton1Click:Connect(function()
local _0x8170 = _0x4920(_0x71D8.Selected); if not _0x8170 then return end
local _0xEA85 = _0x3A97(_0x8170); if not _0xEA85 then return end
local _0x16E4 = _0xAD3B.Character; local _0x16F9 = _0x16E4 and _0x16E4:FindFirstChild("HumanoidRootPart")
local _0x74C5 = _0x16E4 and _0x16E4:FindFirstChildOfClass("Humanoid")
if not _0x16F9 or not _0x74C5 then return end
_0x0B88(_0x8170)
_0x16F9.CFrame = CFrame.new(_0xEA85.Position + Vector3.new(0,3,0))
task.wait(0.25); pcall(function() _0xEA85:Sit(_0x74C5) end)
end)
local _0xDB42 = _0x3025(_0x1575,"AUTO SIT: OFF", UDim2.new(0.52,2,0,144), UDim2.new(0.48,-2,0,32), Color3.fromRGB(25,25,30))
_0xDB42.MouseButton1Click:Connect(function()
_0x71D8.AutoSit = not _0x71D8.AutoSit
_0xDB42.Text ="AUTO SIT: ".. (_0x71D8.AutoSit and"ON"or"OFF")
_0xDB42.BackgroundColor3 = _0x71D8.AutoSit and Color3.fromRGB(255,255,255) or Color3.fromRGB(25,25,30)
_0xDB42.TextColor3 = _0x71D8.AutoSit and Color3.fromRGB(0,0,0) or Color3.fromRGB(255,255,255)
end)
local _0xC75B = _0x3025(_0x1575,"CANOPY FLY: OFF", UDim2.new(0,0,0,184), UDim2.new(1,0,0,32), Color3.fromRGB(25,25,30))
_0xC75B.MouseButton1Click:Connect(function()
_0x71D8.FlyEnabled = not _0x71D8.FlyEnabled
_0xC75B.Text ="CANOPY FLY: ".. (_0x71D8.FlyEnabled and"ON"or"OFF")
_0xC75B.BackgroundColor3 = _0x71D8.FlyEnabled and Color3.fromRGB(255,255,255) or Color3.fromRGB(25,25,30)
_0xC75B.TextColor3 = _0x71D8.FlyEnabled and Color3.fromRGB(0,0,0) or Color3.fromRGB(255,255,255)
if _0x71D8.FlyEnabled then
local _0x8170 = _0x4920(_0x71D8.Selected); if not _0x8170 then _0x71D8.FlyEnabled = false; return end
_0x0B88(_0x8170)
local _0xEA85 = _0x3A97(_0x8170)
local _0x761D = _0x8170:FindFirstChild("NoTool") or _0x8170:FindFirstChild("Base") or _0xEA85
if not _0x761D then _0x71D8.FlyEnabled = false; return end
_0x71D8.Conn = _0x1EE5.Heartbeat:Connect(function()
if not _0x71D8.FlyEnabled then return end
local _0x46E8 = _0x938B.CurrentCamera; if not _0x46E8 then return end
local _0xDC86 = Vector3.zero
if _0xE442:IsKeyDown(Enum.KeyCode.W) then _0xDC86 += _0x46E8.CFrame.LookVector end
if _0xE442:IsKeyDown(Enum.KeyCode.S) then _0xDC86 -= _0x46E8.CFrame.LookVector end
if _0xE442:IsKeyDown(Enum.KeyCode.A) then _0xDC86 -= _0x46E8.CFrame.RightVector end
if _0xE442:IsKeyDown(Enum.KeyCode.D) then _0xDC86 += _0x46E8.CFrame.RightVector end
if _0xE442:IsKeyDown(Enum.KeyCode.Space) then _0xDC86 += Vector3.new(0,1,0) end
if _0xE442:IsKeyDown(Enum.KeyCode.LeftShift) then _0xDC86 -= Vector3.new(0,1,0) end
local _0x4D1F = _0xDC86.Magnitude > 0 and _0xDC86.Unit * _0x71D8.FlySpeed or Vector3.zero
pcall(function()
_0x761D.AssemblyLinearVelocity = _0x4D1F; _0x761D.AssemblyAngularVelocity = Vector3.zero
end)
end)
else
if _0x71D8.Conn then _0x71D8.Conn:Disconnect(); _0x71D8.Conn = nil end
end
end)
local _0x58C3 = _0x3025(_0x1575,"TP TO PUSHER: OFF", UDim2.new(0,0,0,224), UDim2.new(1,0,0,32), Color3.fromRGB(25,25,30))
_0x58C3.MouseButton1Click:Connect(function()
_0x71D8.TPPusher = not _0x71D8.TPPusher
_0x58C3.Text ="TP TO PUSHER: ".. (_0x71D8.TPPusher and"ON"or"OFF")
_0x58C3.BackgroundColor3 = _0x71D8.TPPusher and Color3.fromRGB(255,255,255) or Color3.fromRGB(25,25,30)
_0x58C3.TextColor3 = _0x71D8.TPPusher and Color3.fromRGB(0,0,0) or Color3.fromRGB(255,255,255)
if _0x71D8.TPPusher then
local _0xD8D8 = _0x4920(_0x71D8.Selected)
_0x71D8.LockY = _0xD8D8 and _0xD8D8.PrimaryPart and _0xD8D8.PrimaryPart.Position.Y or 0
_0x4896()
end
end)
local _0x41DF = _0x3025(_0x1575,"ANTI-DISAPPEAR: OFF", UDim2.new(0,0,0,264), UDim2.new(1,0,0,32), Color3.fromRGB(25,25,30))
_0x41DF.MouseButton1Click:Connect(function()
_0x71D8.AntiDisappear = not _0x71D8.AntiDisappear
_0x41DF.Text ="ANTI-DISAPPEAR: ".. (_0x71D8.AntiDisappear and"ON"or"OFF")
_0x41DF.BackgroundColor3 = _0x71D8.AntiDisappear and Color3.fromRGB(255,255,255) or Color3.fromRGB(25,25,30)
_0x41DF.TextColor3 = _0x71D8.AntiDisappear and Color3.fromRGB(0,0,0) or Color3.fromRGB(255,255,255)
if _0x71D8.AntiDisappear then _0x5FE6() end
end)local _0x303F = _0x30B4["rock"]
local _0xA609 = {TargetPlayer=nil, PartName="HumanoidRootPart", AutoFling=false, Gen=0,
PART_MAP={HumanoidRootPart={"HumanoidRootPart"},Head={"Head"},Torso={"Torso","UpperTorso"},
["Left Arm"]={"Left Arm","LeftHand","LeftLowerArm","LeftUpperArm"},
["Right Arm"]={"Right Arm","RightHand","RightLowerArm","RightUpperArm"},
["Left Leg"]={"Left Leg","LeftFoot","LeftLowerLeg","LeftUpperLeg"},
["Right Leg"]={"Right Leg","RightFoot","RightLowerLeg","RightUpperLeg"}}}
local _0x975F = _0x9565(_0x303F,"🪨 ROCK FLING", UDim2.new(0,0,0,0), UDim2.new(1,0,0,20), Color3.fromRGB(255,255,255))
_0x975F.TextSize = 13
local _0x94E3 = _0x9565(_0x303F,"Target: none", UDim2.new(0,0,0,22), UDim2.new(1,0,0,14), Color3.fromRGB(200,200,205))
_0x94E3.TextSize = 9
local _0x88CB = Instance.new("ScrollingFrame", _0x303F)
_0x88CB.Size = UDim2.new(1,0,0,80); _0x88CB.Position = UDim2.new(0,0,0,40)
_0x88CB.BackgroundColor3 = Color3.fromRGB(10,10,12); _0x88CB.BorderSizePixel = 0
_0x88CB.ScrollBarThickness = 2; _0x88CB.ZIndex = 7
Instance.new("UICorner", _0x88CB).CornerRadius = UDim.new(0,6)
Instance.new("UIListLayout", _0x88CB).Padding = UDim.new(0,2)
local function _0x7BA4()
for _, _0x16E4 in ipairs(_0x88CB:GetChildren()) do if _0x16E4:IsA("TextButton") then _0x16E4:Destroy() end end
local _0x29E6 = 0
for _, _0x7ADD in ipairs(_0x7E7C:GetPlayers()) do
if _0x7ADD ~= _0xAD3B then
local _0x98D0 = Instance.new("TextButton", _0x88CB)
_0x98D0.Size = UDim2.new(1,-4,0,22); _0x98D0.Position = UDim2.new(0,2,0,_0x29E6*24)
_0x98D0.BackgroundColor3 = (_0x7ADD == _0xA609.TargetPlayer) and Color3.fromRGB(255,255,255) or Color3.fromRGB(20,20,25)
_0x98D0.Text ="  ".. _0x7ADD.Name; _0x98D0.TextColor3 = (_0x7ADD == _0xA609.TargetPlayer) and Color3.fromRGB(0,0,0) or Color3.fromRGB(220,220,225)
_0x98D0.Font = Enum.Font.GothamMedium; _0x98D0.TextSize = 9
_0x98D0.TextXAlignment = Enum.TextXAlignment.Left; _0x98D0.ZIndex = 8
Instance.new("UICorner", _0x98D0).CornerRadius = UDim.new(0,4)
_0x98D0.MouseButton1Click:Connect(function()
_0xA609.TargetPlayer = _0x7ADD
_0xAF1E(_0x94E3,"Target: ".. _0x7ADD.Name)
for _, _0x16E4 in ipairs(_0x88CB:GetChildren()) do
if _0x16E4:IsA("TextButton") then _0x16E4.BackgroundColor3 = Color3.fromRGB(20,20,25); _0x16E4.TextColor3 = Color3.fromRGB(220,220,225) end
end
_0x98D0.BackgroundColor3 = Color3.fromRGB(255,255,255); _0x98D0.TextColor3 = Color3.fromRGB(0,0,0)
_0xFCCE.TargetPlayer = _0x7ADD
end)
_0x29E6 = _0x29E6 + 1
end
end
_0x88CB.CanvasSize = UDim2.new(0,0,0,_0x29E6*24+4)
end
_0x7BA4()
_0x7E7C.PlayerAdded:Connect(function() task.wait(1); _0x7BA4() end)
_0x7E7C.PlayerRemoving:Connect(function() task.wait(1); _0x7BA4() end)
local function _0xEFF2()
local _0x7ADD = _0xA609.TargetPlayer; if not _0x7ADD or not _0x7ADD.Character then return nil end
for _, _0x89CE in ipairs(_0xA609.PART_MAP[_0xA609.PartName] or {"HumanoidRootPart"}) do
local _0x13FA = _0x7ADD.Character:FindFirstChild(_0x89CE)
if _0x13FA and _0x13FA:IsA("BasePart") then return _0x13FA end
end
return _0x7ADD.Character:FindFirstChild("HumanoidRootPart")
end
local function _0xEE47()
local _0x7ADD = _0xA609.TargetPlayer; if not _0x7ADD or not _0x7ADD.Character then return nil end
local _0x3A2A = {}
for _, _0x13FA in ipairs(_0x7ADD.Character:GetDescendants()) do
if _0x13FA:IsA("BasePart") then _0x3A2A[#_0x3A2A + 1] = _0x13FA end
end
return _0x3A2A
endlocal function _0x66B8(_0x2A70)
local _0x578F = 2^30 * 99999999
local _0x5CE9 = 0.1
local _0x0F6B = 0
while _0xA609.AutoFling and _0xA609.Gen == _0x2A70 do
_0x1EE5.Heartbeat:Wait()
local _0x2DFA = _0xAD3B.Character
local _0xEF61 = _0x2DFA and _0x2DFA:FindFirstChild("HumanoidRootPart")
local _0xCA3D = _0x2DFA and _0x2DFA:FindFirstChildOfClass("Humanoid")
while _0xA609.AutoFling and _0xA609.Gen == _0x2A70 and not (_0x2DFA and _0x2DFA.Parent and _0xEF61 and _0xEF61.Parent and _0xCA3D and _0xCA3D.Health > 0) do
_0x1EE5.Heartbeat:Wait()
_0x2DFA = _0xAD3B.Character
_0xEF61 = _0x2DFA and _0x2DFA:FindFirstChild("HumanoidRootPart")
_0xCA3D = _0x2DFA and _0x2DFA:FindFirstChildOfClass("Humanoid")
end
if not (_0xA609.AutoFling and _0xA609.Gen == _0x2A70) then break end
local _0xDCBA = _0xEFF2()
local _0x3A2A = _0xEE47()
if _0xDCBA and _0x3A2A then
_0xEF61.CFrame = _0xDCBA.CFrame
pcall(function() _0xEF61:SetNetworkOwner(_0xAD3B) end)
pcall(function() sethiddenproperty(_0xEF61,"NetworkOwnershipRule", Enum.NetworkOwnershipRule.Manual) end)
local _0x4D1F = _0xEF61.AssemblyLinearVelocity
_0xEF61.AssemblyLinearVelocity = Vector3.new(_0x578F, _0x578F, _0x578F)
for _, _0x7ADD in ipairs(_0x3A2A) do
pcall(firetouchinterest, _0xEF61, _0x7ADD, 0)
pcall(firetouchinterest, _0xEF61, _0x7ADD, 1)
end
_0x1EE5.RenderStepped:Wait()
if _0xEF61 and _0xEF61.Parent then
_0xEF61.AssemblyLinearVelocity = _0x4D1F
end
_0x1EE5.Stepped:Wait()
if _0xEF61 and _0xEF61.Parent then
_0xEF61.AssemblyLinearVelocity = _0x4D1F + Vector3.new(0, _0x5CE9, 0)
_0x5CE9 = -_0x5CE9
end
end
end
end
local _0x900C = _0x3025(_0x303F,"AUTO FLING: OFF", UDim2.new(0,0,0,128), UDim2.new(1,0,0,32), Color3.fromRGB(25,25,30))
_0x900C.MouseButton1Click:Connect(function()
if _0xA609.AutoFling then
_0xA609.AutoFling = false; _0xA609.Gen = _0xA609.Gen + 1
local _0x16E4 = _0xAD3B.Character; local _0x74C5 = _0x16E4 and _0x16E4:FindFirstChildOfClass("Humanoid")
if _0x74C5 then pcall(function() _0x74C5:UnequipTools() end) end
_0x900C.Text ="AUTO FLING: OFF"; _0x900C.BackgroundColor3 = Color3.fromRGB(25,25,30); _0x900C.TextColor3 = Color3.fromRGB(255,255,255)
else
if not _0xA609.TargetPlayer then warn("[HAMA] Pilih target"); return end
_0xA609.AutoFling = true; _0xA609.Gen = _0xA609.Gen + 1
task.spawn(_0x66B8, _0xA609.Gen)
_0x900C.Text ="AUTO FLING: ON"; _0x900C.BackgroundColor3 = Color3.fromRGB(255,255,255); _0x900C.TextColor3 = Color3.fromRGB(0,0,0)
end
end)
endlocal _0x1E7C = _0x9927(_0xDCD8,"SERVER", false)
_0x6DE4["SERVER"] = _0x1E7C
do
local _0x105D = {Busy=false, Scanning=false, Servers={}, HideFull=true, HideEmpty=false, Sort="Asc"}
local function _0x3BD1() return game.JobId and game.JobId ~=""and game.JobId or nil end
local function _0x7EDF(sort)
local _0x8A90 ="https://games.roblox.com/v1/games/".. game.PlaceId .."/servers/Public?sortOrder=".. sort .."&limit=100"local _0xA42A
local _0x931A, _0xC7A2 = pcall(function() return game:HttpGet(_0x8A90) end)
if _0x931A and type(_0xC7A2) =="string"then _0xA42A = _0xC7A2
elseif typeof(request) =="function"then
local _0xA5F0, _0x16F9 = pcall(request, {Url=_0x8A90, Method="GET"})
if _0xA5F0 and _0x16F9 and _0x16F9.Body then _0xA42A = _0x16F9.Body end
end
if not _0xA42A then return nil end
local _0xD136, _0x2736 = pcall(function() return _0x633F:JSONDecode(_0xA42A) end)
if _0xD136 and _0x2736 and _0x2736.data then return _0x2736.data end
return nil
end
local function _0x74A0(sid)
pcall(function() _0x108D.TeleportService:TeleportToPlaceInstance(game.PlaceId, sid, _0xAD3B) end)
end
local _0xDEBD = {
{max=35,code="SG",color=Color3.fromRGB(70,70,70)},{max=65,code="ID",color=Color3.fromRGB(60,60,60)},
{max=95,code="JP",color=Color3.fromRGB(30,30,30)},{max=130,code="AU",color=Color3.fromRGB(50,50,50)},
{max=180,code="US",color=Color3.fromRGB(45,45,45)},{max=260,code="EU",color=Color3.fromRGB(40,40,40)},
{max=350,code="BR",color=Color3.fromRGB(36,36,36)},{max=999,code="??",color=Color3.fromRGB(32,32,32)},
}
local function _0xF582(ping)
local _0x7ADD = tonumber(ping) or 999
for _, _0x16F9 in ipairs(_0xDEBD) do if _0x7ADD <= _0x16F9.max then return _0x16F9.code, _0x16F9.color end end
return"??", Color3.fromRGB(32,32,32)
end
local _0xDDF6 = _0x9565(_0x1E7C,"🌐 SERVER TOOLS", UDim2.new(0,0,0,0), UDim2.new(1,0,0,20), Color3.fromRGB(255,255,255))
_0xDDF6.TextSize = 14
local _0x57F1 = Instance.new("Frame", _0x1E7C)
_0x57F1.Size = UDim2.new(1,0,0,32); _0x57F1.Position = UDim2.new(0,0,0,24)
_0x57F1.BackgroundTransparency = 1; _0x57F1.ZIndex = 6
Instance.new("UIListLayout", _0x57F1).FillDirection = Enum.FillDirection.Horizontal
Instance.new("UIListLayout", _0x57F1).Padding = UDim.new(0,4)
local function _0x3C0F(_0x6988, order, _0xC7EB)
local _0x98D0 = Instance.new("TextButton", _0x57F1)
_0x98D0.Size = UDim2.new(0.33,-3,1,0); _0x98D0.BackgroundColor3 = Color3.fromRGB(25,25,30)
_0x98D0.Text = _0x6988; _0x98D0.TextColor3 = Color3.fromRGB(255,255,255)
_0x98D0.Font = Enum.Font.GothamBold; _0x98D0.TextSize = 9; _0x98D0.LayoutOrder = order; _0x98D0.ZIndex = 7
Instance.new("UICorner", _0x98D0).CornerRadius = UDim.new(0,6)
Instance.new("UIStroke", _0x98D0).Color = Color3.fromRGB(60,60,65)
_0x98D0.MouseButton1Click:Connect(_0xC7EB); return _0x98D0
end
_0x3C0F("HOP", 1, function()
if _0x105D.Busy then return end
_0x105D.Busy = true
task.spawn(function()
local _0xE24C = _0x7EDF("Asc")
if _0xE24C then
local _0x7092 = _0x3BD1()
for _, _0x9A34 in ipairs(_0xE24C) do
if _0x9A34.playing < _0x9A34.maxPlayers and _0x9A34.id ~= _0x7092 then _0x74A0(_0x9A34.id); break end
end
end
_0x105D.Busy = false
end)
end)
_0x3C0F("REJOIN", 2, function()
pcall(function()
local _0x1DF8 = _0x3BD1()
if _0x1DF8 then _0x108D.TeleportService:TeleportToPlaceInstance(game.PlaceId, _0x1DF8, _0xAD3B)
else _0x108D.TeleportService:Teleport(game.PlaceId, _0xAD3B) end
end)
end)
_0x3C0F("RANDOM", 3, function()
if _0x105D.Busy then return end
_0x105D.Busy = true
task.spawn(function()
local _0xE24C = _0x7EDF("Desc")
if _0xE24C and #_0xE24C > 0 then
local _0x9A34 = _0xE24C[math.random(1,#_0xE24C)]
if _0x9A34.id ~= _0x3BD1() then _0x74A0(_0x9A34.id) end
end
_0x105D.Busy = false
end)
end)
local _0x5444 = Instance.new("Frame", _0x1E7C)
_0x5444.Size = UDim2.new(1,0,0,30); _0x5444.Position = UDim2.new(0,0,0,64)
_0x5444.BackgroundTransparency = 1; _0x5444.ZIndex = 6
local _0x4D08 = Instance.new("TextBox", _0x5444)
_0x4D08.Size = UDim2.new(1,-90,1,0); _0x4D08.BackgroundColor3 = Color3.fromRGB(15,15,18)
_0x4D08.BorderSizePixel = 0; _0x4D08.PlaceholderText ="Filter by server ID..."_0x4D08.PlaceholderColor3 = Color3.fromRGB(100,100,105); _0x4D08.Text =""_0x4D08.TextColor3 = Color3.fromRGB(255,255,255); _0x4D08.Font = Enum.Font.GothamMedium
_0x4D08.TextSize = 10; _0x4D08.ClearTextOnFocus = false
_0x4D08.TextXAlignment = Enum.TextXAlignment.Left; _0x4D08.ZIndex = 8
Instance.new("UICorner", _0x4D08).CornerRadius = UDim.new(0,6)
Instance.new("UIPadding", _0x4D08).PaddingLeft = UDim.new(0,8)
local _0x4088 = Instance.new("TextButton", _0x5444)
_0x4088.Size = UDim2.new(0,86,1,0); _0x4088.Position = UDim2.new(1,-86,0,0)
_0x4088.BackgroundColor3 = Color3.fromRGB(25,25,30); _0x4088.Text ="SCAN"_0x4088.TextColor3 = Color3.fromRGB(255,255,255); _0x4088.Font = Enum.Font.GothamBold
_0x4088.TextSize = 10; _0x4088.ZIndex = 8
Instance.new("UICorner", _0x4088).CornerRadius = UDim.new(0,6)
local _0x9EC1 = Instance.new("Frame", _0x1E7C)
_0x9EC1.Size = UDim2.new(1,0,0,26); _0x9EC1.Position = UDim2.new(0,0,0,100)
_0x9EC1.BackgroundTransparency = 1; _0x9EC1.ZIndex = 6
Instance.new("UIListLayout", _0x9EC1).FillDirection = Enum.FillDirection.Horizontal
Instance.new("UIListLayout", _0x9EC1).Padding = UDim.new(0,4)
local _0x5213 = Instance.new("TextButton", _0x9EC1)
_0x5213.Size = UDim2.new(0.25,-3,1,0); _0x5213.BackgroundColor3 = Color3.fromRGB(25,25,30)
_0x5213.Text ="SORT ↑"; _0x5213.TextColor3 = Color3.fromRGB(255,255,255)
_0x5213.Font = Enum.Font.GothamBold; _0x5213.TextSize = 8; _0x5213.ZIndex = 7
Instance.new("UICorner", _0x5213).CornerRadius = UDim.new(0,6)
_0x5213.MouseButton1Click:Connect(function()
_0x105D.Sort = (_0x105D.Sort =="Asc") and"Desc"or"Asc"_0x5213.Text = _0x105D.Sort =="Asc"and"SORT ↑"or"SORT ↓"if ApplyFilters then ApplyFilters() end
end)
local function _0xA2A1(_0x6988, def, order, _0xC7EB)
local _0x9A34 = def
local _0x98D0 = Instance.new("TextButton", _0x9EC1)
_0x98D0.Size = UDim2.new(0.25,-3,1,0); _0x98D0.BackgroundColor3 = _0x9A34 and Color3.fromRGB(255,255,255) or Color3.fromRGB(25,25,30)
_0x98D0.Text = _0x6988; _0x98D0.TextColor3 = _0x9A34 and Color3.fromRGB(0,0,0) or Color3.fromRGB(255,255,255)
_0x98D0.Font = Enum.Font.GothamBold; _0x98D0.TextSize = 8; _0x98D0.LayoutOrder = order; _0x98D0.ZIndex = 7
Instance.new("UICorner", _0x98D0).CornerRadius = UDim.new(0,6)
_0x98D0.MouseButton1Click:Connect(function()
_0x9A34 = not _0x9A34
_0x98D0.BackgroundColor3 = _0x9A34 and Color3.fromRGB(255,255,255) or Color3.fromRGB(25,25,30)
_0x98D0.TextColor3 = _0x9A34 and Color3.fromRGB(0,0,0) or Color3.fromRGB(255,255,255)
_0xC7EB(_0x9A34)
if ApplyFilters then ApplyFilters() end
end)
return _0x98D0
end
_0xA2A1("HIDE FULL", true, 1, function(_0x8A30) _0x105D.HideFull = _0x8A30 end)
_0xA2A1("HIDE EMPTY", false, 2, function(_0x8A30) _0x105D.HideEmpty = _0x8A30 end)
local _0x2B79 = Instance.new("ScrollingFrame", _0x1E7C)
_0x2B79.Size = UDim2.new(1,0,0,380); _0x2B79.Position = UDim2.new(0,0,0,134)
_0x2B79.BackgroundColor3 = Color3.fromRGB(10,10,12); _0x2B79.BorderSizePixel = 0
_0x2B79.ScrollBarThickness = 3; _0x2B79.ScrollBarImageColor3 = Color3.fromRGB(100,100,105)
_0x2B79.CanvasSize = UDim2.new(0,0,0,0); _0x2B79.AutomaticCanvasSize = Enum.AutomaticSize.Y
_0x2B79.ZIndex = 7
Instance.new("UICorner", _0x2B79).CornerRadius = UDim.new(0,6)
Instance.new("UIListLayout", _0x2B79).Padding = UDim.new(0,3)
local _0x9008 = _0x9565(_0x1E7C,"Press SCAN", UDim2.new(0,0,0,520), UDim2.new(1,0,0,14), Color3.fromRGB(150,150,155))
_0x9008.TextSize = 9
ApplyFilters = function()
if not _0x105D.Servers then return end
local _0xB46B = {}
local _0x2377 = string.lower(tostring(_0x4D08.Text or""))
for _, _0x9A34 in ipairs(_0x105D.Servers) do
local _0x8594 = true
local _0x7772 = (_0x9A34.maxPlayers or 0) - (_0x9A34.playing or 0)
if _0x105D.HideFull and _0x7772 <= 0 then _0x8594 = false end
if _0x105D.HideEmpty and (_0x9A34.playing or 0) <= 0 then _0x8594 = false end
if _0x8594 and _0x2377 ~=""then
if not string.find(string.lower(tostring(_0x9A34.id)), _0x2377, 1, true) then _0x8594 = false end
end
if _0x8594 then table.insert(_0xB46B, _0x9A34) end
end
if _0x105D.Sort =="Asc"then
table.sort(_0xB46B, function(_0xD1DF, _0x98D0) return (tonumber(_0xD1DF.ping) or 0) < (tonumber(_0x98D0.ping) or 0) end)
else
table.sort(_0xB46B, function(_0xD1DF, _0x98D0) return (tonumber(_0xD1DF.ping) or 0) > (tonumber(_0x98D0.ping) or 0) end)
end
for _, _0x16E4 in ipairs(_0x2B79:GetChildren()) do if _0x16E4:IsA("Frame") then _0x16E4:Destroy() end end
local _0x7092 = _0x3BD1()
for i, _0x9A34 in ipairs(_0xB46B) do
local _0x4546 = Instance.new("Frame", _0x2B79)
_0x4546.Size = UDim2.new(1,-4,0,56); _0x4546.Position = UDim2.new(0,2,0,(i-1)*60+4)
_0x4546.BackgroundColor3 = (_0x9A34.id == _0x7092) and Color3.fromRGB(40,40,45) or Color3.fromRGB(20,20,25)
_0x4546.ZIndex = 8
Instance.new("UICorner", _0x4546).CornerRadius = UDim.new(0,6)
local _0xC378 = Instance.new("UIStroke", _0x4546)
_0xC378.Color = (_0x9A34.id == _0x7092) and Color3.fromRGB(255,255,255) or Color3.fromRGB(60,60,65)
_0xC378.Thickness = 1
local _0x80DB = tonumber(_0x9A34.ping) or 0
local _0xE58E, _0x8147 = _0xF582(_0x80DB)
local _0x1E20 = Instance.new("Frame", _0x4546)
_0x1E20.Size = UDim2.new(0,36,0,36); _0x1E20.Position = UDim2.new(0,6,0,10)
_0x1E20.BackgroundColor3 = _0x8147; _0x1E20.ZIndex = 9
Instance.new("UICorner", _0x1E20).CornerRadius = UDim.new(0,6)
local _0x0841 = Instance.new("TextLabel", _0x1E20)
_0x0841.Size = UDim2.new(1,0,1,0); _0x0841.BackgroundTransparency = 1
_0x0841.Text = _0xE58E; _0x0841.TextColor3 = Color3.fromRGB(240,240,240)
_0x0841.Font = Enum.Font.GothamBold; _0x0841.TextSize = 10; _0x0841.ZIndex = 10
local _0xD00C = Instance.new("TextLabel", _0x4546)
_0xD00C.Size = UDim2.new(0,120,0,16); _0xD00C.Position = UDim2.new(0,48,0,8)
_0xD00C.BackgroundTransparency = 1
_0xD00C.Text = tostring(_0x9A34.playing) .."/".. tostring(_0x9A34.maxPlayers)
_0xD00C.TextColor3 = Color3.fromRGB(220,220,225); _0xD00C.Font = Enum.Font.GothamMedium
_0xD00C.TextSize = 11; _0xD00C.TextXAlignment = Enum.TextXAlignment.Left; _0xD00C.ZIndex = 9
local _0xB195 = Instance.new("TextLabel", _0x4546)
_0xB195.Size = UDim2.new(0,120,0,12); _0xB195.Position = UDim2.new(0,48,0,28)
_0xB195.BackgroundTransparency = 1
_0xB195.Text = string.sub(tostring(_0x9A34.id), 1, 10) .."..."_0xB195.TextColor3 = Color3.fromRGB(150,150,155); _0xB195.Font = Enum.Font.GothamMedium
_0xB195.TextSize = 9; _0xB195.TextXAlignment = Enum.TextXAlignment.Left; _0xB195.ZIndex = 9
local _0xCF04 = Instance.new("TextLabel", _0x4546)
_0xCF04.Size = UDim2.new(0,80,0,16); _0xCF04.Position = UDim2.new(1,-100,0,8)
_0xCF04.BackgroundTransparency = 1; _0xCF04.Text ="Ping ".. tostring(_0x80DB) .."ms"_0xCF04.TextColor3 = (_0x80DB < 80) and Color3.fromRGB(0,255,100) or ((_0x80DB < 160) and Color3.fromRGB(255,200,100) or Color3.fromRGB(255,120,120))
_0xCF04.Font = Enum.Font.GothamBold; _0xCF04.TextSize = 9
_0xCF04.TextXAlignment = Enum.TextXAlignment.Right; _0xCF04.ZIndex = 9
local _0x41DE = Instance.new("Frame", _0x4546)
_0x41DE.Size = UDim2.new(1,-12,0,20); _0x41DE.Position = UDim2.new(0,6,0,32)
_0x41DE.BackgroundTransparency = 1; _0x41DE.ZIndex = 9
local _0xC7EB = Instance.new("TextButton", _0x41DE)
_0xC7EB.Size = UDim2.new(0,50,1,0); _0xC7EB.BackgroundColor3 = Color3.fromRGB(25,25,30)
_0xC7EB.Text ="COPY"; _0xC7EB.TextColor3 = Color3.fromRGB(255,255,255)
_0xC7EB.Font = Enum.Font.GothamBold; _0xC7EB.TextSize = 9; _0xC7EB.ZIndex = 10
Instance.new("UICorner", _0xC7EB).CornerRadius = UDim.new(0,4)
local _0x534F = false
_0xC7EB.MouseButton1Click:Connect(function()
if _0x534F then return end; _0x534F = true
pcall(function()
if typeof(setclipboard) =="function"then setclipboard(tostring(_0x9A34.id))
elseif typeof(toclipboard) =="function"then toclipboard(tostring(_0x9A34.id)) end
end)
_0xC7EB.Text ="✓"; task.delay(1.5, function() _0xC7EB.Text ="COPY"; _0x534F = false end)
end)
local _0x8DA7 = Instance.new("TextButton", _0x41DE)
_0x8DA7.Size = UDim2.new(0,60,1,0); _0x8DA7.Position = UDim2.new(0,56,0,0)
_0x8DA7.BackgroundColor3 = (_0x9A34.id == _0x7092) and Color3.fromRGB(60,60,65) or Color3.fromRGB(255,255,255)
_0x8DA7.Text = (_0x9A34.id == _0x7092) and"HERE"or"JOIN"_0x8DA7.TextColor3 = (_0x9A34.id == _0x7092) and Color3.fromRGB(150,150,155) or Color3.fromRGB(0,0,0)
_0x8DA7.Font = Enum.Font.GothamBold; _0x8DA7.TextSize = 9; _0x8DA7.ZIndex = 10
Instance.new("UICorner", _0x8DA7).CornerRadius = UDim.new(0,4)
if _0x9A34.id ~= _0x7092 then _0x8DA7.MouseButton1Click:Connect(function() _0x74A0(_0x9A34.id) end) end
end
_0xAF1E(_0x9008,"Showing ".. #_0xB46B .."/".. #_0x105D.Servers .." servers")
_0x9008.TextColor3 = (#_0xB46B > 0) and Color3.fromRGB(255,255,255) or Color3.fromRGB(150,150,155)
end
_0x4088.MouseButton1Click:Connect(function()
if _0x105D.Scanning then return end
_0x105D.Scanning = true; _0x4088.Text ="..."_0xAF1E(_0x9008,"Scanning..."); _0x9008.TextColor3 = Color3.fromRGB(200,200,205)
task.spawn(function()
local _0xE24C = _0x7EDF(_0x105D.Sort)
_0x105D.Scanning = false; _0x4088.Text ="SCAN"if _0xE24C then _0x105D.Servers = _0xE24C; ApplyFilters()
else _0xAF1E(_0x9008,"Scan failed — HTTP unavailable"); _0x9008.TextColor3 = Color3.fromRGB(200,100,100) end
end)
end)
_0x4D08:GetPropertyChangedSignal("Text"):Connect(function()
if _0x105D.Servers and #_0x105D.Servers > 0 then ApplyFilters() end
end)
_0xFCCE.ServerStop = function()
_0x105D.Busy = false; _0x105D.Scanning = false
end
endlocal _0x69EE = _0x9927(_0xDCD8,"SHIELD", false)
_0x6DE4["SHIELD"] = _0x69EE
do
local _0x6A84 = {
DevURL ="https://raw.githubusercontent.com/dafaremixeruhuy-ctr/hama-hub/main/dev.txt",
PremiumURL ="https://raw.githubusercontent.com/dafaremixeruhuy-ctr/hama-hub/main/premium.txt",
CacheTTL = 300,
Fallback = {Dev={["dpnvhr"]=true,["fire6uns"]=true}, Premium={}},
}
local _0x5165 = {Enabled=false, AutoRejoin=true, ExcludeFriends=true,
DevUsers={}, PremiumUsers={}, FriendCache={}, RejoinCooldown=0, Conn=nil,
LastFetch=0, Fetching=false, FetchStatus="Not fetched yet"}
for k, _0x8A30 in pairs(_0x6A84.Fallback.Dev) do _0x5165.DevUsers[k] = _0x8A30 end
for k, _0x8A30 in pairs(_0x6A84.Fallback.Premium) do _0x5165.PremiumUsers[k] = _0x8A30 end
getgenv().PRIORITY = _0x5165
getgenv().WHITELIST_CONFIG = _0x6A84
local function _0x6EAF(_0x8A90)
local _0xA42A
if typeof(syn) =="table"and typeof(syn.request) =="function"then
local _0x931A, _0x16F9 = pcall(syn.request, {Url=_0x8A90, Method="GET"})
if _0x931A and _0x16F9 and _0x16F9.Body then _0xA42A = _0x16F9.Body end
end
if not _0xA42A and typeof(http_request) =="function"then
local _0x931A, _0x16F9 = pcall(http_request, {Url=_0x8A90, Method="GET"})
if _0x931A and _0x16F9 and _0x16F9.Body then _0xA42A = _0x16F9.Body end
end
if not _0xA42A and typeof(request) =="function"then
local _0x931A, _0x16F9 = pcall(request, {Url=_0x8A90, Method="GET"})
if _0x931A and _0x16F9 and _0x16F9.Body then _0xA42A = _0x16F9.Body end
end
if not _0xA42A then
local _0x931A, _0x16F9 = pcall(function() return game:HttpGet(_0x8A90) end)
if _0x931A and type(_0x16F9) =="string"then _0xA42A = _0x16F9 end
end
return _0xA42A
end
local function _0xB888(_0x98D0)
local _0x9A34 = {}
if type(_0x98D0) ~="string"then return _0x9A34 end
for _0x8170 in _0x98D0:gmatch("[^\r\n]+") do
local _0x89CE = _0x8170:match("^%s*(.-)%s*$")
if _0x89CE and _0x89CE ~=""and not _0x89CE:match("^#") then _0x9A34[_0x89CE] = true end
end
return _0x9A34
end
local function _0x99CB(_0xE0FB)
local _0x89CE = 0; for _ in pairs(_0xE0FB) do _0x89CE = _0x89CE + 1 end; return _0x89CE
end
local _0xBDB2, _0xF1DC, _0xBF01, _0x2401, _0x112E, _0xF570
_0xBDB2 = function() return _0x5165.DevUsers[_0xAD3B.Name] == true end
_0xF1DC = function() return _0x5165.PremiumUsers[_0xAD3B.Name] == true end
_0xF570 = function(_0xD00C)
if not _0xD00C or _0xD00C == _0xAD3B then return false end
if _0x5165.FriendCache[_0xD00C.Name] then return true end
local _0x931A, _0x16F9 = pcall(function() return _0xAD3B:IsFriendsWith(_0xD00C.UserId) end)
if _0x931A and _0x16F9 then _0x5165.FriendCache[_0xD00C.Name] = true; return true end
return false
end
_0xBF01 = function(exSelf)
for _, _0x7ADD in ipairs(_0x7E7C:GetPlayers()) do
if (not exSelf or _0x7ADD ~= _0xAD3B) and _0x5165.DevUsers[_0x7ADD.Name] then return true, _0x7ADD end
end
return false, nil
end
_0x2401 = function(exSelf)
for _, _0x7ADD in ipairs(_0x7E7C:GetPlayers()) do
if (not exSelf or _0x7ADD ~= _0xAD3B) and _0x5165.PremiumUsers[_0x7ADD.Name] then return true, _0x7ADD end
end
return false, nil
end
_0x112E = function(reason)
if tick() < _0x5165.RejoinCooldown then return end
_0x5165.RejoinCooldown = tick() + 5
warn("[HAMA SHIELD] Rejoin: ".. tostring(reason))
if getgenv()._HAMA_StopSpam then pcall(getgenv()._HAMA_StopSpam) end
if _0xFCCE.PhysicStop then pcall(_0xFCCE.PhysicStop) end
if _0xFCCE.HijackStop then pcall(_0xFCCE.HijackStop) end
if _0xFCCE.SpectateStop then pcall(_0xFCCE.SpectateStop) end
task.delay(0.5, function()
pcall(function()
local _0x1DF8 = game.JobId
if _0x1DF8 and _0x1DF8 ~=""then _0x108D.TeleportService:TeleportToPlaceInstance(game.PlaceId, _0x1DF8, _0xAD3B)
else _0x108D.TeleportService:Teleport(game.PlaceId, _0xAD3B) end
end)
end)
end
getgenv().HAMA_IsLocalDev = _0xBDB2
getgenv().HAMA_IsLocalPremium = _0xF1DC
getgenv().HAMA_IsDevInServer = _0xBF01
getgenv().HAMA_IsPremiumInServer = _0x2401
getgenv().HAMA_DoRejoin = _0x112E
local function _0x7009(silent)
if _0x5165.Fetching then return end
_0x5165.Fetching = true; _0x5165.FetchStatus ="Fetching..."task.spawn(function()
local _0xAA0F, _0xED7E, _0x931A = {}, {}, false
local _0xC96E = _0x6EAF(_0x6A84.DevURL)
if _0xC96E and #_0xC96E > 0 then _0xAA0F = _0xB888(_0xC96E); _0x931A = true end
local _0x73E9 = _0x6EAF(_0x6A84.PremiumURL)
if _0x73E9 and #_0x73E9 > 0 then _0xED7E = _0xB888(_0x73E9); _0x931A = true end
if _0x931A then
for k, _0x8A30 in pairs(_0x6A84.Fallback.Dev) do _0xAA0F[k] = _0xAA0F[k] or _0x8A30 end
for k, _0x8A30 in pairs(_0x6A84.Fallback.Premium) do _0xED7E[k] = _0xED7E[k] or _0x8A30 end
_0x5165.DevUsers = _0xAA0F; _0x5165.PremiumUsers = _0xED7E
_0x5165.LastFetch = tick()
_0x5165.FetchStatus ="✓ ".. os.date("%H:%M:%S")
_0x5165.FriendCache = {}
if not silent then
warn("[HAMA] Whitelist updated DEV:".. _0x99CB(_0xAA0F) .." PREM:".. _0x99CB(_0xED7E))
end
if _0x5165.Enabled and not _0xBDB2() then
local _0xBB3A, _0x6588 = _0xBF01(true)
local _0x3EF9, _0x79E7 = _0x2401(true)
if _0xBB3A and _0x5165.AutoRejoin and _0xE820.Running then
_0x112E("DEV ".. (_0x6588 and _0x6588.Name or"?"))
elseif _0x3EF9 and not _0xF1DC() and _0x5165.AutoRejoin and _0xE820.Running then
_0x112E("PREM ".. (_0x79E7 and _0x79E7.Name or"?"))
end
end
else
_0x5165.FetchStatus ="⚠ Fetch failed"end
_0x5165.Fetching = false
end)
end
_0x7009(true)
task.spawn(function()
while true do
task.wait(_0x6A84.CacheTTL)
if not _0x5165.Fetching then _0x7009(true) end
end
end)
local _0x6473 = _0x9565(_0x69EE,"🔒 PRIORITY SHIELD", UDim2.new(0,0,0,0), UDim2.new(1,0,0,20), Color3.fromRGB(255,255,255))
_0x6473.TextSize = 14
local _0x4E7E = _0x9565(_0x69EE,"Local: ...", UDim2.new(0,0,0,24), UDim2.new(1,0,0,16), Color3.fromRGB(200,200,205))
_0x4E7E.TextSize = 10
local _0xC3D9 = _0x9565(_0x69EE,"Server: ...", UDim2.new(0,0,0,42), UDim2.new(1,0,0,16), Color3.fromRGB(200,200,205))
_0xC3D9.TextSize = 10
local function _0xCE49()
local _0x16F9, _0x16E4
if _0xBDB2() then _0x16F9, _0x16E4 ="DEV 👑", Color3.fromRGB(255,215,0)
elseif _0xF1DC() then _0x16F9, _0x16E4 ="PREMIUM ⭐", Color3.fromRGB(180,200,255)
else _0x16F9, _0x16E4 ="REGULAR", Color3.fromRGB(200,200,205) end
_0xAF1E(_0x4E7E,"Local: ".. _0x16F9); _0x4E7E.TextColor3 = _0x16E4
local _0xBB3A, _0x6588 = _0xBF01(true); local _0x3EF9, _0x79E7 = _0x2401(true)
if _0xBB3A then _0xAF1E(_0xC3D9,"⚠ DEV: ".. _0x6588.Name); _0xC3D9.TextColor3 = Color3.fromRGB(255,80,80)
elseif _0x3EF9 then _0xAF1E(_0xC3D9,"⚠ PREM: ".. _0x79E7.Name); _0xC3D9.TextColor3 = Color3.fromRGB(255,180,80)
else _0xAF1E(_0xC3D9,"✓ Server CLEAN"); _0xC3D9.TextColor3 = Color3.fromRGB(0,255,100) end
end
local _0x1F17 = _0x3025(_0x69EE,"SHIELD: OFF", UDim2.new(0,0,0,68), UDim2.new(0.48,-2,0,32), Color3.fromRGB(25,25,30))
local function _0x5925()
if _0x5165.Conn then return end
_0x5165.Conn = _0x7E7C.PlayerAdded:Connect(function(_0xD00C)
if not _0x5165.Enabled then return end
if _0xBDB2() then return end
if _0x5165.ExcludeFriends and _0xF570(_0xD00C) then return end
if _0x5165.DevUsers[_0xD00C.Name] then
if _0xE820.Running and _0x5165.AutoRejoin then _0x112E("DEV ".. _0xD00C.Name .." joined") end
elseif _0x5165.PremiumUsers[_0xD00C.Name] then
if _0xE820.Running and _0x5165.AutoRejoin and not _0xF1DC() then _0x112E("PREM ".. _0xD00C.Name .." joined") end
end
end)
end
_0x1F17.MouseButton1Click:Connect(function()
_0x5165.Enabled = not _0x5165.Enabled
_0x1F17.Text ="SHIELD: ".. (_0x5165.Enabled and"ON"or"OFF")
_0x1F17.BackgroundColor3 = _0x5165.Enabled and Color3.fromRGB(255,255,255) or Color3.fromRGB(25,25,30)
_0x1F17.TextColor3 = _0x5165.Enabled and Color3.fromRGB(0,0,0) or Color3.fromRGB(255,255,255)
if _0x5165.Enabled then _0x5925(); _0xCE49()
else
if _0x5165.Conn then _0x5165.Conn:Disconnect(); _0x5165.Conn = nil end
end
end)
local _0x5E32 = _0x3025(_0x69EE,"AUTO REJOIN: ON", UDim2.new(0.52,2,0,68), UDim2.new(0.48,-2,0,32), Color3.fromRGB(255,255,255))
_0x5E32.TextColor3 = Color3.fromRGB(0,0,0)
_0x5E32.MouseButton1Click:Connect(function()
_0x5165.AutoRejoin = not _0x5165.AutoRejoin
_0x5E32.Text ="AUTO REJOIN: ".. (_0x5165.AutoRejoin and"ON"or"OFF")
_0x5E32.BackgroundColor3 = _0x5165.AutoRejoin and Color3.fromRGB(255,255,255) or Color3.fromRGB(25,25,30)
_0x5E32.TextColor3 = _0x5165.AutoRejoin and Color3.fromRGB(0,0,0) or Color3.fromRGB(255,255,255)
end)
local _0xE8EC = _0x3025(_0x69EE,"EXCL FRIENDS: ON", UDim2.new(0,0,0,104), UDim2.new(1,0,0,32), Color3.fromRGB(255,255,255))
_0xE8EC.TextColor3 = Color3.fromRGB(0,0,0)
_0xE8EC.MouseButton1Click:Connect(function()
_0x5165.ExcludeFriends = not _0x5165.ExcludeFriends
_0xE8EC.Text ="EXCL FRIENDS: ".. (_0x5165.ExcludeFriends and"ON"or"OFF")
_0xE8EC.BackgroundColor3 = _0x5165.ExcludeFriends and Color3.fromRGB(255,255,255) or Color3.fromRGB(25,25,30)
_0xE8EC.TextColor3 = _0x5165.ExcludeFriends and Color3.fromRGB(0,0,0) or Color3.fromRGB(255,255,255)
if not _0x5165.ExcludeFriends then _0x5165.FriendCache = {} end
end)
local _0x3871 = _0x3025(_0x69EE,"🔄 FORCE REJOIN", UDim2.new(0,0,0,144), UDim2.new(0.48,-2,0,34), Color3.fromRGB(25,25,30))
_0x3871.MouseButton1Click:Connect(function() _0x112E("Manual rejoin") end)
local _0xC46E = _0x3025(_0x69EE,"🛑 PANIC STOP", UDim2.new(0.52,2,0,144), UDim2.new(0.48,-2,0,34), Color3.fromRGB(25,25,30))
_0xC46E.MouseButton1Click:Connect(function()
if getgenv()._HAMA_StopSpam then pcall(getgenv()._HAMA_StopSpam) end
if _0xFCCE.PhysicStop then pcall(_0xFCCE.PhysicStop) end
if _0xFCCE.HijackStop then pcall(_0xFCCE.HijackStop) end
if _0xFCCE.SpectateStop then pcall(_0xFCCE.SpectateStop) end
if _0xFCCE.VoidStop then pcall(_0xFCCE.VoidStop) end
_0xAF1E(_0xC3D9,"✓ ALL STOPPED"); _0xC3D9.TextColor3 = Color3.fromRGB(255,255,255)
end)
local _0x8288 = _0x3025(_0x69EE,"🔄 REFRESH WHITELIST", UDim2.new(0,0,0,186), UDim2.new(1,0,0,30), Color3.fromRGB(25,25,30))
_0x8288.MouseButton1Click:Connect(function() _0x7009(false); task.delay(2, _0xCE49) end)
local _0xC40A = _0x9565(_0x69EE,"GitHub: ...", UDim2.new(0,0,0,220), UDim2.new(1,0,0,14), Color3.fromRGB(150,150,155))
_0xC40A.TextSize = 9
local _0x1F1E = _0x9565(_0x69EE,"📋 PRIORITY LIST", UDim2.new(0,0,0,242), UDim2.new(1,0,0,14), Color3.fromRGB(255,255,255))
_0x1F1E.TextSize = 10
local _0x22AD = Instance.new("TextLabel", _0x69EE)
_0x22AD.Size = UDim2.new(1,0,0,120); _0x22AD.Position = UDim2.new(0,0,0,260)
_0x22AD.BackgroundColor3 = Color3.fromRGB(10,10,12); _0x22AD.BorderSizePixel = 0
_0x22AD.RichText = true; _0x22AD.TextColor3 = Color3.fromRGB(220,220,225)
_0x22AD.Font = Enum.Font.GothamMedium; _0x22AD.TextSize = 9
_0x22AD.TextXAlignment = Enum.TextXAlignment.Left
_0x22AD.TextYAlignment = Enum.TextYAlignment.Top
_0x22AD.TextWrapped = true; _0x22AD.ZIndex = 7
Instance.new("UICorner", _0x22AD).CornerRadius = UDim.new(0,6)
Instance.new("UIPadding", _0x22AD).PaddingLeft = UDim.new(0,8)
Instance.new("UIPadding", _0x22AD).PaddingTop = UDim.new(0,4)
local function _0x4D65()
local _0x914B, _0x5ADB = {}, {}
for _0x89CE in pairs(_0x5165.DevUsers) do _0x914B[#_0x914B+1] = _0x89CE end
for _0x89CE in pairs(_0x5165.PremiumUsers) do _0x5ADB[#_0x5ADB+1] = _0x89CE end
table.sort(_0x914B); table.sort(_0x5ADB)
_0x22AD.Text ='<font color="#FFD700">👑 DEV:</font>\n  '.. ((#_0x914B > 0) and table.concat(_0x914B,", ") or"—") ..'\n\n<font color="#B0C8FF">⭐ PREM:</font>\n  '.. ((#_0x5ADB > 0) and table.concat(_0x5ADB,", ") or"—")
end
_0x4D65()
task.spawn(function()
while true do
task.wait(3)
if not _0x69EE.Parent then break end
pcall(_0xCE49); pcall(_0x4D65)
if _0xC40A.Parent then _0xAF1E(_0xC40A,"GitHub: ".. tostring(_0x5165.FetchStatus)) end
end
end)
_0xFCCE.ShieldStop = function()
if _0x5165.Conn then _0x5165.Conn:Disconnect(); _0x5165.Conn = nil end
_0x5165.Enabled = false
end
endlocal _0x9CD9 = _0x9927(_0xDCD8,"ABOUT", false)
_0x6DE4["ABOUT"] = _0x9CD9
do
local _0x3C22 = _0x9565(_0x9CD9,"HAMA UNIVERSAL HUB", UDim2.new(0,0,0,10), UDim2.new(1,0,0,30), Color3.fromRGB(255,255,255))
_0x3C22.TextSize = 18; _0x3C22.TextXAlignment = Enum.TextXAlignment.Center
local _0xE207 = _0x9565(_0x9CD9,"Version 4.0 | HAMA Monochrome Edition", UDim2.new(0,0,0,40), UDim2.new(1,0,0,20), Color3.fromRGB(150,150,155))
_0xE207.TextXAlignment = Enum.TextXAlignment.Center
local _0x1CFA = _0x9565(_0x9CD9,"— DEVELOPED BY —", UDim2.new(0,0,0,80), UDim2.new(1,0,0,20), Color3.fromRGB(200,200,205))
_0x1CFA.TextXAlignment = Enum.TextXAlignment.Center
local _0x4407 = _0x9565(_0x9CD9,"@dpnvhr\n@fire6uns", UDim2.new(0,0,0,105), UDim2.new(1,0,0,50), Color3.fromRGB(255,255,255))
_0x4407.TextSize = 14; _0x4407.TextXAlignment = Enum.TextXAlignment.Center
_0x4407.TextYAlignment = Enum.TextYAlignment.Top
local _0x8246 = _0x9565(_0x9CD9,"Complete Edition - All HAMA features merged\n100 Levels Spam | 4-Phase | Hook Amp | Void | Spectate | Safe Follow | Forest | Server Finder | Priority Shield",
UDim2.new(0,0,0,180), UDim2.new(1,0,0,60), Color3.fromRGB(180,180,185))
_0x8246.TextXAlignment = Enum.TextXAlignment.Center; _0x8246.TextWrapped = true
local _0x37F7 = _0x9565(_0x9CD9,"© 2026 HAMA Universal Hub.", UDim2.new(0,0,0,260), UDim2.new(1,0,0,20), Color3.fromRGB(100,100,105))
_0x37F7.TextXAlignment = Enum.TextXAlignment.Center
end_0x2D1A.MouseButton1Click:Connect(function()
_0x5085:Destroy()
end)
_0x5085.Destroying:Connect(function()
pcall(function() if _0xFCCE.VoidStop then _0xFCCE.VoidStop() end end)
pcall(function() if _0xFCCE.SpectateStop then _0xFCCE.SpectateStop() end end)
pcall(function() if _0xFCCE.PhysicStop then _0xFCCE.PhysicStop() end end)
pcall(function() if _0xFCCE.PlayerExtraStop then _0xFCCE.PlayerExtraStop() end end)
pcall(function() if _0xFCCE.ServerStop then _0xFCCE.ServerStop() end end)
pcall(function() if _0xFCCE.ShieldStop then _0xFCCE.ShieldStop() end end)
pcall(function() if getgenv()._HAMA_StopSpam then getgenv()._HAMA_StopSpam() end end)
_0x6049(); _0x14BB()
_G.HamaGUI = nil
end)
_0x7E9F("PIANO")
end
local _0x931A, _0x2CF9 = pcall(_0xD1D8)
if not _0x931A then warn("[HAMA] CreateUI ERROR:", _0x2CF9) end
print("[HAMA] Universal V4.0 loaded — JEYHUB Monochrome Edition")
