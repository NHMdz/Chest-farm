function FPSBooster()
    local decalsyeeted = true
    local g, w, l, t = game, game.Workspace, game.Lighting, game.Workspace.Terrain
    local players = g:GetService("Players")
    local localPlayer = players.LocalPlayer

    pcall(function()
        l.GlobalShadows = false
        l.FogEnd = 1e10
        l.Brightness = 0
    end)

    for _, v in pairs(g:GetDescendants()) do
        pcall(function()
            if v:IsA("BasePart") or v:IsA("UnionOperation") or v:IsA("CornerWedgePart") or v:IsA("TrussPart") then
                v.Material = Enum.Material.Plastic
                v.Reflectance = 0
                if v.Parent ~= localPlayer.Character then
                    v.CanCollide = false
                end
            elseif (v:IsA("Decal") or v:IsA("Texture")) and decalsyeeted then
                v.Transparency = 1
            elseif v:IsA("Explosion") then
                v.BlastPressure = 1
                v.BlastRadius = 1
            elseif v:IsA("Fire") or v:IsA("SpotLight") or v:IsA("Smoke") or v:IsA("Sparkles") then
                v.Enabled = false
            elseif v:IsA("MeshPart") then
                v.Material = Enum.Material.Plastic
                v.Reflectance = 0
                v.TextureID = ""
                if v.Parent ~= localPlayer.Character then
                    v.CanCollide = false
                end
            end
        end)
    end

    for _, e in pairs(l:GetChildren()) do
        pcall(function()
            if e:IsA("BlurEffect") or e:IsA("SunRaysEffect") or e:IsA("ColorCorrectionEffect") or e:IsA("BloomEffect") or e:IsA("DepthOfFieldEffect") then
                e.Enabled = false
            end
        end)
    end

    for _, player in pairs(players:GetPlayers()) do
        if player ~= localPlayer and player.Character then
            pcall(function()
                for _, part in pairs(player.Character:GetChildren()) do
                    if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                        part.Transparency = 1
                    elseif part:IsA("Accessory") then
                        part:Destroy()
                    end
                end
            end)
        end
    end

    for _, obj in pairs(w:GetChildren()) do
        pcall(function()
            if obj.Name ~= "Players" and obj ~= localPlayer.Character then
                if obj:IsA("Model") then
                    local humanoid = obj:FindFirstChildWhichIsA("Humanoid")
                    if not humanoid then
                        for _, part in pairs(obj:GetDescendants()) do
                            if part:IsA("BasePart") then
                                part.Transparency = 1
                            end
                        end
                    end
                elseif obj:IsA("BasePart") then
                    obj.Transparency = 1
                end
            end
        end)
    end

    pcall(function()
        t.WaterWaveSize = 0
        t.WaterWaveSpeed = 0
        t.WaterReflectance = 0
        t.WaterTransparency = 0
    end)

    w.DescendantAdded:Connect(function(v)
        pcall(function()
            if v:IsA("BasePart") then
                v.Material = Enum.Material.Plastic
                v.Reflectance = 0
                if v.Parent ~= localPlayer.Character then
                    v.CanCollide = false
                end
            elseif v:IsA("Decal") or v:IsA("Texture") then
                v.Transparency = 1
            elseif v:IsA("Fire") or v:IsA("SpotLight") or v:IsA("Smoke") or v:IsA("Sparkles") then
                v.Enabled = false
            end
        end)
    end)
end
pcall(FPSBooster)
