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
    
    task.spawn(function()
        local descendants = g:GetDescendants()
        local processed = 0
        local batchSize = 50
        
        for _, v in ipairs(descendants) do
            if v:IsA("Part") or v:IsA("Union") or v:IsA("CornerWedgePart") or v:IsA("TrussPart") then
                v.Material = Enum.Material.Plastic
                v.Reflectance = 0
                v.CanCollide = v.CanCollide
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
            elseif v:IsA("ParticleEmitter") then
                v.Enabled = false
            end
            
            processed = processed + 1
            if processed % batchSize == 0 then
                task.wait()
            end
        end
    end)

    task.spawn(function()
        for _, e in ipairs(l:GetChildren()) do
            if e:IsA("BlurEffect") or e:IsA("SunRaysEffect") or e:IsA("ColorCorrectionEffect") or e:IsA("BloomEffect") or e:IsA("DepthOfFieldEffect") then
                e.Enabled = false
            end
        end
    end)
    
    task.spawn(function()
        w.DescendantAdded:Connect(function(v)
            if v:IsA("Explosion") then
                v.BlastPressure = 1
                v.BlastRadius = 1
                task.wait(0.1)
                v:Destroy()
            elseif v:IsA("Fire") or v:IsA("Smoke") or v:IsA("Sparkles") then
                v.Enabled = false
            end
        end)
    end)
end

pcall(FPSBooster)
