function FPSBooster()
    local decalsyeeted = true
    local g = game
    local w = g.Workspace
    local l = g.Lighting
    local t = w.Terrain

    l.GlobalShadows = false
    l.FogEnd = 1e10
    l.Brightness = 0
    settings().Rendering.QualityLevel = 1
    
    local descendants = g:GetDescendants()
    for _, v in ipairs(descendants) do
        if v:IsA("Part") or v:IsA("Union") or v:IsA("CornerWedgePart") or v:IsA("TrussPart") then
            v.Material = Enum.Material.Plastic
            v.Reflectance = 0
        elseif (v:IsA("Decal") or v:IsA("Texture")) and decalsyeeted then
            v.Transparency = 1
        elseif v:IsA("Explosion") then
            v:Destroy()
        elseif v:IsA("Fire") or v:IsA("SpotLight") or v:IsA("Smoke") or v:IsA("Sparkles") or v:IsA("ParticleEmitter") then
            v.Enabled = false
        elseif v:IsA("MeshPart") then
            v.Material = Enum.Material.Plastic
            v.Reflectance = 0
            v.TextureID = ""
        elseif v:IsA("Sound") then
            v.Volume = 0
        end
    end

    for _, e in ipairs(l:GetChildren()) do
        if e:IsA("BlurEffect") or e:IsA("SunRaysEffect") or e:IsA("ColorCorrectionEffect") or e:IsA("BloomEffect") or e:IsA("DepthOfFieldEffect") then
            e.Enabled = false
        end
    end
    
    for _, obj in ipairs(w:GetChildren()) do
        if obj.Name ~= "Camera" and obj ~= g.Players.LocalPlayer.Character and not obj:IsA("Terrain") then
            if obj:IsA("Model") and obj.Name:lower():find("map") then
                for _, part in ipairs(obj:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.Transparency = 1
                        part.CanCollide = false
                    end
                end
            elseif obj:IsA("BasePart") and (obj.Size.X > 100 or obj.Size.Y > 100 or obj.Size.Z > 100) then
                obj.Transparency = 1
                obj.CanCollide = false
            end
        end
    end
end

pcall(FPSBooster)
