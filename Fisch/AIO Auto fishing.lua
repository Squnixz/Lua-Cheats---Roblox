---- Version Check ----
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
_VERSION = "1.0"
if _VERSION then
    if _VERSION ~= "1.0" then
        Player:Kick("This version doesn't release yet. Please confirm that you’re using the current versions / the lastest released one.")
    end
end
---- Auto Cast Usages And Require + Check ----
local function KansxyAutoCast()
    local rod = nil
    for _, item in pairs(Player.Character:GetChildren()) do
        if item:IsA("Tool") and item.Name:match("Rod") and item:FindFirstChild("events") and item.events:FindFirstChild("cast") then
            rod = item
            break
        end
    end

    if not rod then
        for _, item in pairs(Player.Backpack:GetChildren()) do
            if item:IsA("Tool") and item.Name:match("Rod") and item:FindFirstChild("events") and item.events:FindFirstChild("cast") then
                rod = item
                local Humanoid = Player.Character:FindFirstChild("Humanoid")
                if Humanoid then
                    Humanoid:EquipTool(rod)
                end
                break
            end
        end
    end

    if not rod then
        print("Rod Not found")
        return false
    end

    local args = {
        [1] = 100,
        [2] = 1
    }
    rod.events.cast:FireServer(unpack(args))
    return true
end

---- Auto Finish Reel ----
local function KansxyAutoReel()
    local events = game:GetService("ReplicatedStorage"):FindFirstChild("events")
    if events and events:FindFirstChild("reelfinished ") then
        local args = {
            [1] = 100,
            [2] = true
        }
        events:FindFirstChild("reelfinished "):FireServer(unpack(args))
    end
end

---- Main Loop ----

local GuiService = game:GetService("GuiService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local function Key(keys)
    VirtualInputManager:SendKeyEvent(true, keys, false, Player.PlayerGui)
    VirtualInputManager:SendKeyEvent(true, keys, false, Player.PlayerGui)
    VirtualInputManager:SendKeyEvent(false, keys, true, Player.PlayerGui)
end

local function UINevigation(button)
    if not button then return end
    GuiService.SelectedObject = button
    GuiService.SelectedObject = button
    Key(Enum.KeyCode.Return)
end

while true do
    if KansxyAutoCast() then
        local startTime = tick()
        while not Player.PlayerGui:FindFirstChild("shakeui") do
            if tick() - startTime > 2.5 then
                local Humanoid = Player.Character:FindFirstChild("Humanoid")
                if Humanoid then
                    Humanoid:UnequipTools()
                end
                break
            end
            task.wait(0.05)
        end

        if Player.PlayerGui:FindFirstChild("shakeui") then
            local safezone = Player.PlayerGui.shakeui:FindFirstChild("safezone")
            if safezone then
                local button = safezone:FindFirstChild("button")
                if button then
                    UINevigation(button)
                    button.Name = button.Name .. "_"
                    while Player.PlayerGui:FindFirstChild("shakeui") do
                        task.wait(0.05)
                    end
                else
                    task.wait(0.5)
                    if not safezone:FindFirstChild("button") then
                        local Humanoid = Player.Character:FindFirstChild("Humanoid")
                        if Humanoid then
                            Humanoid:UnequipTools()
                        end
                    end
                end
            end
        end

        KansxyAutoReel()
        KansxyAutoReel()
        task.wait(1)
    else
        task.wait(1)
    end
end

---- Created By Kansxy ! ----
