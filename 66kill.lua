-- PRISON LIFE - EXPLOIT KILL ALL REAL
-- Ejecutar con Synapse X, KRNL u otro ejecutor

-- UI botón flotante
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.CoreGui

local KillButton = Instance.new("TextButton")
KillButton.Size = UDim2.new(0, 100, 0, 40)
KillButton.Position = UDim2.new(0, 20, 0, 100)
KillButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
KillButton.Text = "Kill All"
KillButton.TextColor3 = Color3.new(1, 1, 1)
KillButton.Parent = ScreenGui
KillButton.Active = true
KillButton.Draggable = true

-- Función de Kill All
local function killAll()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local args = {
                [1] = player.Character.Humanoid,
                [2] = 9999999 -- daño real
            }

            -- Disparar el RemoteEvent de Prison Life (si existe)
            local remotes = LocalPlayer:FindFirstChild("Backpack") or LocalPlayer:FindFirstChildOfClass("Tool")
            local gunRemote = game.ReplicatedStorage:FindFirstChild("ShootEvent") or remotes:FindFirstChild("GunScript_Server")

            if gunRemote and gunRemote:IsA("RemoteEvent") then
                gunRemote:FireServer(unpack(args))
            else
                -- Si no existe el RemoteEvent, usar método alternativo: teleport al enemigo + damage loop
                local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                if root then
                    root.CFrame = player.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 1)
                    task.wait(0.1)
                    local weapon = LocalPlayer.Backpack:FindFirstChildOfClass("Tool") or LocalPlayer.Character:FindFirstChildOfClass("Tool")
                    if weapon and weapon:FindFirstChild("Handle") then
                        for i = 1, 10 do
                            LocalPlayer.Character:FindFirstChild("Humanoid"):EquipTool(weapon)
                            weapon:Activate()
                            task.wait(0.1)
                        end
                    end
                end
            end
        end
    end
end

KillButton.MouseButton1Click:Connect(killAll)
