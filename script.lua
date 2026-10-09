local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

for _, v in ipairs({"FogEffect","BlurEffect","ColorCorrection","SkyBox","RedSky","SunRays"}) do
    if Lighting:FindFirstChild(v) then Lighting[v]:Destroy() end
end

local sky = Instance.new("Sky") sky.Name = "RedSky" sky.SkyboxBk = "rbxassetid://133288808075264" sky.SkyboxDn = "rbxassetid://133288808075264" sky.SkyboxFt = "rbxassetid://133288808075264" sky.SkyboxLf = "rbxassetid://133288808075264" sky.SkyboxRt = "rbxassetid://133288808075264" sky.SkyboxUp = "rbxassetid://133288808075264" sky.Parent = Lighting

local fog = Instance.new("Atmosphere") fog.Density = 0.75 fog.Color = Color3.fromRGB(100, 5, 5) fog.Glare = 0.5 fog.Haze = 5 fog.Parent = Lighting
local cc = Instance.new("ColorCorrectionEffect") cc.Brightness = -0.4 cc.Contrast = 0.2 cc.Saturation = 0.4 cc.TintColor = Color3.fromRGB(100, 10, 10) cc.Parent = Lighting
local blur = Instance.new("BlurEffect") blur.Size = 0.8 blur.Parent = Lighting
local sun = Instance.new("SunRaysEffect") sun.Intensity = 0.15 sun.Spread = 0.7 sun.Parent = Lighting

Lighting.Ambient = Color3.fromRGB(60, 15, 15) Lighting.OutdoorAmbient = Color3.fromRGB(40, 10, 10) Lighting.Brightness = 1.5 Lighting.ClockTime = 0 Lighting.FogColor = Color3.fromRGB(120, 10, 10) Lighting.FogEnd = 150 Lighting.FogStart = 15

for _, obj in ipairs(Workspace:GetDescendants()) do
    if obj:IsA("BasePart") and obj.Anchored and obj.Size.X * obj.Size.Y * obj.Size.Z < 100 then obj.Anchored = false end
end

local triggerWords = {"салли", "сало", "сали", "салли ксен", "sally_ksen"}
local function onChat(player, msg)
    local m = msg:lower()
    for _, w in ipairs(triggerWords) do
        if m == w or m:find(w, 1, true) then
            local c = player.Character
            if c and c:FindFirstChild("HumanoidRootPart") then
                c:MoveTo(Workspace.SpawnLocation.Position + Vector3.new(0, 3, 0))
            end
            break
        end
    end
end
for _, p in ipairs(Players:GetPlayers()) do p.Chatted:Connect(function(m) onChat(p, m) end) end
Players.PlayerAdded:Connect(function(p) p.Chatted:Connect(function(m) onChat(p, m) end) end)

local function isNPC(m)
    if not m:IsA("Model") then return false end
    local h = m:FindFirstChild("Humanoid") if not h then return false end
    for _, p in ipairs(Players:GetPlayers()) do if p.Character == m then return false end end
    return true
end

local npcChatting = {}
for _, obj in ipairs(Workspace:GetDescendants()) do
    if isNPC(obj) then
        obj.Name = "vipotroshon"
        local h = obj:FindFirstChild("Humanoid")
        if h then h.DisplayName = "vipotroshon" if h.Health > 0 then h.Health = 0 end end
        local head = obj:FindFirstChild("Head")
        if head then
            npcChatting[obj] = false
            local bbg = Instance.new("BillboardGui") bbg.Size = UDim2.new(0, 300, 0, 50) bbg.StudsOffset = Vector3.new(0, 2, 0) bbg.AlwaysOnTop = true bbg.MaxDistance = 15 bbg.Parent = head
            local tl = Instance.new("TextLabel") tl.Size = UDim2.new(1, 0, 1, 0) tl.BackgroundTransparency = 1 tl.TextColor3 = Color3.fromRGB(255, 0, 0) tl.TextStrokeTransparency = 0 tl.TextStrokeColor3 = Color3.fromRGB(0, 0, 0) tl.Font = Enum.Font.SciFi tl.TextSize = 18 tl.Text = "" tl.Parent = bbg
            spawn(function()
                local phrase = "molis potroshirely bogy emperatory"
                while obj and obj.Parent and head and head.Parent do
                    local nearest, minDist = nil, 15
                    for _, plr in ipairs(Players:GetPlayers()) do
                        local c = plr.Character
                        if c and c:FindFirstChild("HumanoidRootPart") then
                            local d = (head.Position - c.HumanoidRootPart.Position).Magnitude
                            if d < minDist then nearest = plr minDist = d end
                        end
                    end
                    if nearest and not npcChatting[obj] then
                        npcChatting[obj] = true
                        while nearest and obj and obj.Parent do
                            local c = nearest.Character
                            if c and c:FindFirstChild("HumanoidRootPart") and (head.Position - c.HumanoidRootPart.Position).Magnitude <= 15 then
                                tl.Text = phrase
                                spawn(function() pcall(function() local cs = game:GetService("Chat") if cs then cs:Chat(head, phrase, Enum.ChatColor.Red) end end) end)
                                task.wait(3) tl.Text = ""
                            else tl.Text = "" break end
                        end
                        npcChatting[obj] = false tl.Text = ""
                    end
                    task.wait(0.5)
                end
            end)
        end
    end
end

spawn(function() while true do task.wait(6)
    for _, p in ipairs(Players:GetPlayers()) do
        local c = p.Character
        if c then
            local t = c:FindFirstChild("HumanoidRootPart") or c:FindFirstChild("Torso")
            if t then local th = Instance.new("Sound") th.SoundId = "rbxassetid://138027351" th.Volume = 10 th.RollOffMode = Enum.RollOffMode.InverseTapered th.MaxDistance = 10000 th.Parent = t th:Play() game.Debris:AddItem(th, 3) end
        end
    end
    local oB, oA, oOA, oFC = Lighting.Brightness, Lighting.Ambient, Lighting.OutdoorAmbient, Lighting.FogColor
    Lighting.Brightness = 100 Lighting.Ambient = Color3.fromRGB(255, 0, 0) Lighting.OutdoorAmbient = Color3.fromRGB(255, 0, 0) Lighting.FogColor = Color3.fromRGB(255, 0, 0)
    if Lighting:FindFirstChild("SunRays") then Lighting.SunRays.Intensity = 5 end
    task.wait(5) Lighting.Brightness = oB Lighting.Ambient = oA Lighting.OutdoorAmbient = oOA Lighting.FogColor = oFC
    if Lighting:FindFirstChild("SunRays") then Lighting.SunRays.Intensity = 0.15 end
end end)

spawn(function() while true do task.wait(math.random(3,10))
    local oB, oA = Lighting.Brightness, Lighting.Ambient
    for i = 1, math.random(3,7) do Lighting.Brightness = 0.05 Lighting.Ambient = Color3.fromRGB(20,0,0) task.wait(0.08) Lighting.Brightness = oB Lighting.Ambient = oA task.wait(0.08) end
    if math.random(0,1)==1 then Lighting.Brightness = 0.1 Lighting.Ambient = Color3.fromRGB(15,0,0) task.wait(math.random(2,5)) Lighting.Brightness = oB Lighting.Ambient = oA end
end end)

spawn(function() while true do
    local re = tick()+5 while tick()<re do task.wait(0.3)
        for _, p in ipairs(Players:GetPlayers()) do
            local c = p.Character if c and c:FindFirstChild("HumanoidRootPart") then
                local r = c.HumanoidRootPart
                local prt = Instance.new("Part") prt.Size = Vector3.new(0.15,0.5,0.15) prt.Color = Color3.fromRGB(255,0,0) prt.Material = Enum.Material.Neon prt.Anchored = true prt.CanCollide = false prt.Position = r.Position + Vector3.new(math.random(-30,30),40,math.random(-30,30)) prt.Parent = Workspace
                spawn(function() for j=1,25 do prt.Position = prt.Position - Vector3.new(0,3,0) prt.Transparency = j/25 task.wait(0.015) end prt:Destroy() end)
            end
        end
    end
    task.wait(math.random(5,10))
end end)

local bassId = "134908479689648"
spawn(function() while true do
    for _, p in ipairs(Players:GetPlayers()) do
        local c = p.Character
        if c then
            local t = c:FindFirstChild("HumanoidRootPart") or c:FindFirstChild("Torso")
            if t and not t:FindFirstChild("BassSound") then
                local bass = Instance.new("Sound") bass.Name = "BassSound" bass.SoundId = "rbxassetid://"..bassId bass.Volume = 10 bass.Looped = true bass.PlaybackSpeed = 1 bass.RollOffMode = Enum.RollOffMode.InverseTapered bass.MaxDistance = 10000 bass.Parent = t bass:Play()
            end
        end
    end
    task.wait(1)
end end)

local imgIds = {"106269630024294","116287069767035","125974705015511","81632658693845","119946560823444","70915213349972","133288808075264","107870489592663","138407074580212","136527938087010","99484680625715","95712327979128"}
local stepCounters, lastMoveTimes, playerAlive, lastImageTime, lastImageIndex, shadowFigs, deathFigs = {}, {}, {}, {}, {}, {}, {}

local function spawnImage(player, imageId, pos)
    local prt = Instance.new("Part") prt.Size = Vector3.new(6, 6, 0.05) prt.Transparency = 1 prt.Material = Enum.Material.SmoothPlastic prt.Anchored = true prt.CanCollide = false prt.CastShadow = false prt.Position = pos prt.Parent = workspace
    local decal = Instance.new("Decal") decal.Texture = "rbxassetid://"..imageId decal.Face = Enum.NormalId.Front decal.Parent = prt
    game.Debris:AddItem(prt, 5)
end

local function spawnShadow(player, pos)
    local fig = Instance.new("Part") fig.Size = Vector3.new(2, 5, 1) fig.Color = Color3.fromRGB(0, 0, 0) fig.Material = Enum.Material.SmoothPlastic fig.Transparency = 0.5 fig.Anchored = true fig.CanCollide = false fig.Position = pos fig.Parent = workspace
    spawn(function() while fig and fig.Parent do
        local c = player.Character
        if c and c:FindFirstChild("HumanoidRootPart") then
            local r = c.HumanoidRootPart
            fig.Position = r.Position - r.CFrame.LookVector * 8 + Vector3.new(0, 2, 0)
            fig.CFrame = CFrame.new(fig.Position, r.Position)
        end
        task.wait(0.05)
    end end)
    return fig
end

local function setupPlayer(player)
    playerAlive[player] = true stepCounters[player] = 0 lastMoveTimes[player] = tick() lastImageTime[player] = tick() lastImageIndex[player] = 0 shadowFigs[player] = nil
    local function onCharAdded(char)
        if deathFigs[player] and deathFigs[player].Parent then deathFigs[player]:Destroy() end
        playerAlive[player] = true stepCounters[player] = 0 lastMoveTimes[player] = tick()
        if shadowFigs[player] and shadowFigs[player].Parent then shadowFigs[player]:Destroy() end
        local hum = char:WaitForChild("Humanoid") local root = char:WaitForChild("HumanoidRootPart") local lastPos = root.Position local totalDist = 0 local stillTime = 0 local hasShadow = false
        local dFig = Instance.new("Part") dFig.Size = Vector3.new(8, 8, 0.05) dFig.Transparency = 1 dFig.Material = Enum.Material.SmoothPlastic dFig.Anchored = true dFig.CanCollide = false dFig.Parent = workspace
        local dDecal = Instance.new("Decal") dDecal.Texture = "rbxassetid://"..imgIds[math.random(1,#imgIds)] dDecal.Face = Enum.NormalId.Front dDecal.Parent = dFig
        deathFigs[player] = dFig
        spawn(function() while dFig and dFig.Parent and char and char.Parent do
            local c = player.Character
            if c and c:FindFirstChild("HumanoidRootPart") then
                local r = c.HumanoidRootPart
                dFig.Position = r.Position - r.CFrame.LookVector * 5 + Vector3.new(0, 3, 0)
                dFig.CFrame = CFrame.new(dFig.Position, r.Position)
            end
            task.wait(0.03)
        end end)
        hum.Died:Connect(function() playerAlive[player] = false if shadowFigs[player] and shadowFigs[player].Parent then shadowFigs[player]:Destroy() end end)
        spawn(function() while char and char.Parent and root and root.Parent do
            if not playerAlive[player] then task.wait(0.5) if not char or not char.Parent then break end hum = char:FindFirstChild("Humanoid") root = char:FindFirstChild("HumanoidRootPart") if not hum or not root then break end lastPos = root.Position totalDist = 0 stepCounters[player] = 0 stillTime = 0 hasShadow = false playerAlive[player] = true end
            local curPos = root.Position local dist = (curPos - lastPos).Magnitude
            if dist > 0.3 then totalDist = totalDist + dist lastMoveTimes[player] = tick() stillTime = 0
                if totalDist >= 4 then totalDist = 0 stepCounters[player] = stepCounters[player] + 1
                    if stepCounters[player] >= 10 then stepCounters[player] = 0
                        if tick() - lastImageTime[player] > 600 then lastImageTime[player] = tick() lastImageIndex[player] = 0 end
                        lastImageIndex[player] = lastImageIndex[player] + 1
                        if lastImageIndex[player] <= #imgIds then
                            spawnImage(player, imgIds[lastImageIndex[player]], root.Position + Vector3.new(math.random(-6,6), 3, math.random(-6,6)))
                            if lastImageIndex[player] >= 6 and not hasShadow then shadowFigs[player] = spawnShadow(player, root.Position - root.CFrame.LookVector * 8 + Vector3.new(0, 2, 0)) hasShadow = true end
                            if lastImageIndex[player] == #imgIds then if shadowFigs[player] and shadowFigs[player].Parent then shadowFigs[player]:Destroy() shadowFigs[player] = nil end hasShadow = false end
                        end
                    end
                end
            else stillTime = stillTime + 0.1 if stillTime > 5 and playerAlive[player] then stepCounters[player] = 0 totalDist = 0 stillTime = 0 end end
            lastPos = curPos task.wait(0.1)
        end end)
    end
    player.CharacterAdded:Connect(onCharAdded)
    if player.Character then onCharAdded(player.Character) end
end

local id = "103298183395878"
local part = Instance.new("Part", workspace) part.Anchored = true part.Size = Vector3.new(8, 12, 0.2) part.Position = workspace.SpawnLocation.Position + Vector3.new(7, 6, 0) part.Transparency = 1 part.CanCollide = false
local gui = Instance.new("SurfaceGui", part) gui.Face = "Front" gui.AlwaysOnTop = true gui.Brightness = 2
local img = Instance.new("ImageLabel", gui) img.Size = UDim2.new(1, 0, 1, 0) img.Image = "rbxassetid://"..id img.BackgroundTransparency = 1
local light = Instance.new("PointLight", part) light.Color = Color3.fromRGB(255, 0, 0) light.Brightness = 3 light.Range = 12
local canTrack = true

game:GetService("RunService").Heartbeat:Connect(function()
    local nearest, minDist = nil, math.huge
    for _, p in ipairs(Players:GetPlayers()) do
        local c = p.Character
        if c and c:FindFirstChild("HumanoidRootPart") and c:FindFirstChild("Humanoid") then
            local d = (part.Position - c.HumanoidRootPart.Position).Magnitude
            if d < minDist then minDist = d nearest = c end
        end
    end
    if nearest and nearest.Humanoid.MoveDirection.Magnitude > 0 and canTrack then
        part.CFrame = CFrame.new(part.Position, nearest.HumanoidRootPart.Position)
    end
end)

while true do canTrack = true task.wait(math.random(3, 8)) canTrack = false task.wait(math.random(1, 4)) end

spawn(function()
    while true do
        task.wait(5)
        local oB = Lighting.Brightness
        local oA = Lighting.Ambient
        local oOA = Lighting.OutdoorAmbient
        local oFC = Lighting.FogColor
        local oFE = Lighting.FogEnd
        local oFS = Lighting.FogStart
        local oCC = Lighting:FindFirstChildOfClass("ColorCorrectionEffect")
        local oCCB, oCCC, oCCS, oCCT = nil, nil, nil, nil
        if oCC then oCCB, oCCC, oCCS, oCCT = oCC.Brightness, oCC.Contrast, oCC.Saturation, oCC.TintColor end
        Lighting.Brightness = 100
        Lighting.Ambient = Color3.fromRGB(255, 255, 255)
        Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
        Lighting.FogColor = Color3.fromRGB(255, 255, 255)
        Lighting.FogEnd = 10000
        Lighting.FogStart = 0
        if oCC then
            oCC.Brightness = 5
            oCC.Contrast = 5
            oCC.Saturation = 5
            oCC.TintColor = Color3.fromRGB(255, 255, 255)
        end
        local whiteBlur = Instance.new("BlurEffect")
        whiteBlur.Size = 24
        whiteBlur.Parent = Lighting
        local whiteSun = Instance.new("SunRaysEffect")
        whiteSun.Intensity = 10
        whiteSun.Spread = 1
        whiteSun.Parent = Lighting
        for _, p in ipairs(Players:GetPlayers()) do
            local c = p.Character
            if c then
                local hum = c:FindFirstChild("Humanoid")
                local root = c:FindFirstChild("HumanoidRootPart")
                if hum and root then
                    hum.PlatformStand = true
                    hum:ChangeState(Enum.HumanoidStateType.FallingDown)
                    local bv = Instance.new("BodyVelocity")
                    bv.Velocity = Vector3.new(0, -50, 0)
                    bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
                    bv.Parent = root
                    game.Debris:AddItem(bv, 5)
                end
            end
        end
        task.wait(3)
        Lighting.Brightness = oB
        Lighting.Ambient = oA
        Lighting.OutdoorAmbient = oOA
        Lighting.FogColor = oFC
        Lighting.FogEnd = oFE
        Lighting.FogStart = oFS
        if oCC then
            oCC.Brightness = oCCB
            oCC.Contrast = oCCC
            oCC.Saturation = oCCS
            oCC.TintColor = oCCT
        end
        if whiteBlur then whiteBlur:Destroy() end
        if whiteSun then whiteSun:Destroy() end
        for _, p in ipairs(Players:GetPlayers()) do
            local c = p.Character
            if c then
                local hum = c:FindFirstChild("Humanoid")
                if hum then hum.PlatformStand = false end
            end
        end
    end
end)

Players.PlayerAdded:Connect(function(p) setupPlayer(p) end)
for _, p in ipairs(Players:GetPlayers()) do setupPlayer(p) end