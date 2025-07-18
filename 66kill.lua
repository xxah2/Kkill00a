-- STEAL A BRAINROT EXPLOIT V1 by Ale & GPT
-- Ejecútalo en Synapse/KRNL/Fluxus

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local UIS = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

-- 🧠 Crear UI de botones
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
local MainBtn = Instance.new("TextButton", ScreenGui)
MainBtn.Size = UDim2.new(0, 160, 0, 40)
MainBtn.Position = UDim2.new(0, 20, 0, 100)
MainBtn.Text = "🧠 IR A BRAINROT"
MainBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 200)
MainBtn.TextColor3 = Color3.new(1, 1, 1)
MainBtn.TextSize = 20
MainBtn.Font = Enum.Font.SourceSansBold
MainBtn.Active = true
MainBtn.Draggable = true

local ESPEnabled = true
local NoclipEnabled = true

-- 🧠 FUNC: Teleport a Brainrot (o al jugador que lo tiene)
local function gotoBrainrot()
    local brainrot = nil

    -- Buscar el Brainrot suelto
    brainrot = Workspace:FindFirstChild("Brainrot") or Workspace:FindFirstChildWhichIsA("Tool")
    
    -- Si no está suelto, buscar quién lo tiene
    if not brainrot then
        for _, p in pairs(Players:GetPlayers()) do
            if p.Character and p.Character:FindFirstChild("Brainrot") then
                brainrot = p.Character:FindFirstChild("Brainrot")
                break
            end
        end
    end

    if brainrot and brainrot:IsDescendantOf(Workspace) then
        local handle = brainrot:FindFirstChild("Handle") or brainrot:FindFirstChildWhichIsA("BasePart")
        if handle and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.Character.HumanoidRootPart.CFrame = handle.CFrame + Vector3.new(0, 1, 0)
        end
    end
end

MainBtn.MouseButton1Click:Connect(gotoBrainrot)

-- 🧱 Noclip Activado
RunService.Stepped:Connect(function()
    if NoclipEnabled and LocalPlayer.Character then
        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end)

-- 👁️ ESP Brainrot
local billboard = nil
RunService.RenderStepped:Connect(function()
    if not ESPEnabled then return end

    local brainrot = Workspace:FindFirstChild("Brainrot") or Workspace:FindFirstChildWhichIsA("Tool")
    if not brainrot then
        for _, p in pairs(Players:GetPlayers()) do
            if p.Character and p.Character:FindFirstChild("Brainrot") then
                brainrot = p.Character:FindFirstChild("Brainrot")
                break
            end
        end
    end

    if brainrot then
        local targetPart = brainrot:FindFirstChild("Handle") or brainrot:FindFirstChildWhichIsA("BasePart")
        if targetPart and not billboard then
            billboard = Instance.new("BillboardGui", targetPart)
            billboard.Size = UDim2.new(0, 100, 0, 40)
            billboard.AlwaysOnTop = true

            local label = Instance.new("TextLabel", billboard)
            label.Size = UDim2.new(1, 0, 1, 0)
            label.Text = "🧠 BRAINROT!"
            label.TextColor3 = Color3.fromRGB(255, 0, 0)
            label.BackgroundTransparency = 1
            label.TextScaled = true
            label.Font = Enum.Font.SourceSansBold
        end
    elseif billboard then
        billboard:Destroy()
        billboard = nil
    end
end)
