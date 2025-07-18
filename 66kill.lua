-- Añadimos un botón para "Forzar robo abierto"
local StealBtn = Instance.new("TextButton", Frame)
StealBtn.Size = UDim2.new(1, 0, 0, 50)
StealBtn.Position = UDim2.new(0, 0, 0, 120)
StealBtn.Text = "🔓 Forzar Robo ON/OFF"
StealBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
StealBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

local stealEnabled = false

StealBtn.MouseButton1Click:Connect(function()
    stealEnabled = not stealEnabled
    StealBtn.Text = stealEnabled and "✅ Robo Forzado: ON" or "🔓 Forzar Robo OFF"

    if stealEnabled then
        -- Forzar que la base esté abierta (esto es un ejemplo, hay que adaptarlo según el juego)
        local baseFolder = workspace:FindFirstChild("Base") or workspace:FindFirstChild("BrainrotBase")
        if baseFolder then
            -- Ejemplo variable que bloquea el robo
            local lockedValue = baseFolder:FindFirstChild("Locked") or baseFolder:FindFirstChild("IsClosed")
            if lockedValue and (lockedValue:IsA("BoolValue") or lockedValue:IsA("IntValue")) then
                lockedValue.Value = false
                -- Para que no se vuelva a cerrar automáticamente
                lockedValue.Changed:Connect(function()
                    if stealEnabled then
                        lockedValue.Value = false
                    end
                end)
            end
        end
    end
end)
