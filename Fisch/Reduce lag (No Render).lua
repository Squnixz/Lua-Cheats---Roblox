local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer.PlayerGui

local function notification(msg)
    return string.format("[No Render]: %s", msg)
end

local function NoRender(character)
    character:WaitForChild("Humanoid", math.huge)
    character:WaitForChild("HumanoidRootPart", math.huge)
    print(notification("Init Character"))
    local GuiToRemove = {"HandwrittenNote", "TimeEvent", "Events"}
    for _, name in pairs(guiToRemove) do
        local Gui = PlayerGui:FindFirstChild(name)
        if Gui then
            Gui:Destroy()
        end
    end

    local LeaderBoards = workspace:FindFirstChild("active") and workspace.active:FindFirstChild("Leaderboards")
    if LeaderBoards then
        LeaderBoards:Destroy()
    end
    local Hud = PlayerGui:FindFirstChild("hud")
    if Hud then
        for _, scroll in pairs(hud:GetDescendants()) do
            if scroll.Name == "scroll" then
                local Remover1 = scroll.Parent
                if Remover1 then
                    for _, child in pairs(scroll:GetChildren()) do
                        if child:IsA("ImageButton") or child:IsA("Frame") then
                            child.Visible = false
                        end
                    end

                    local function updateVisibility()
                        local shouldBeVisible = Remover1.Visible
                        for _, child in pairs(scroll:GetChildren()) do
                            if child:IsA("ImageButton") or child:IsA("Frame") then
                                child.Visible = shouldBeVisible
                            end
                        end
                    end

                    Remover1:GetPropertyChangedSignal("Visible"):Connect(updateVisibility)
                    updateVisibility()

                    scroll.ChildAdded:Connect(function(child)
                        if child:IsA("ImageButton") or child:IsA("Frame") then
                            child.Visible = container.Visible
                        end
                    end)
                end
            end
        end
    end
end

no_render(LocalPlayer.Character)
LocalPlayer.CharacterAdded:Connect(no_render)
