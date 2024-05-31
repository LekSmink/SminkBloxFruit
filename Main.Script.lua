 if game.PlaceId ~= 3956818381 then
    game.Players.LocalPlayer:Kick("Script não suporta esse jogo, apenas Ninja Legends")
    return
end

game:GetService("StarterGui"):SetCore("SendNotification",{
	Title = "Ninja Legends HUd",
	Text = "Carregando...",
	Icon = ""
})
wait(2) 
game:GetService("StarterGui"):SetCore("SendNotification",{
	Title = "Ninja Legends(50%)",
	Text = "Carregamento completo",
	Icon = ""
})

local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/ionlyusegithubformcmods/1-Line-Scripts/main/Mobile%20Friendly%20Orion')))()
local Player = game.Players.LocalPlayer
  local Window = OrionLib:MakeWindow({
		Name = "Ninja Legends",
		HidePremium = false,
		SaveConfig = true,
		ConfigFolder = "OrionTest",
        IntroText = "Ninja Legends"
        
})

_G.autoSwing = false
_G.teleportPosition = getChiFarmPosition()
_G.espPlayer = false

local function getChiFarmPosition()
    return CFrame.new(Vector3.new(0, 100, 0))
end

local function drawESP(player)
end

local function autoSwingFunction()
    while _G.autoSwing do
        local args = {
            [1] = "Swing"
        }
        game:GetService("ReplicatedStorage").RemoteEvent:FireServer(unpack(args))
        
        wait(0.00001)
    end
end

local function buyNinjutsu()
    local args = {
        [1] = "Ninjutsu"
    }
    game:GetService("ReplicatedStorage").BuyNinjutsuEvent:FireServer(unpack(args))
end

local function toggleAutoSwing(value)
    _G.autoSwing = value
    if _G.autoSwing then
        spawn(autoSwingFunction)
    end
end

spawn(function()
    while true do
        wait(1)
        if _G.autoBuyNinjutsu then
            buyNinjutsu()
        end
    end
end)

local function drawESP(player)
    if player == game.Players.LocalPlayer then return end
    
    local highlight = Instance.new("Highlight")
    highlight.Adornee = player.Character
    highlight.Parent = player.Character

    player.CharacterAdded:Connect(function(character)
        highlight.Adornee = character
    end)

    player.AncestryChanged:Connect(function()
        if not player:IsDescendantOf(game) then
            highlight:Destroy()
        end
    end)
end

local InfTab = Window:MakeTab({
    Name = "Inf",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

InfTab:AddParagraph("Data de criação do Script:","30/05/2024")
InfTab:AddParagraph("Versão:","V1.0")
InfTab:AddParagraph("Idade","12 anos")
InfTab:AddParagraph("Amigos:","José Arthur Miguel Davi etc...")
InfTab:AddParagraph("Parceiros:","Nenhum")

InfTab:AddSection({
    Name = "ENTRE NO MEU DISCORD PRINCIPAL"
})

InfTab:AddButton({
	Name = "Link do Discord",
	Callback = function()
      setclipboard("https://discord.com/invite/aP39gMbY")
      OrionLib:MakeNotification({
	Name = "Link Copiado",
	Content = "agora vá para o navegador e cole",
	Image = "rbxassetid://4483345998",
	Time = 5
})
  	
  	end
})
      
InfTab:AddSection({
    Name = "ENTRE NO MEU DISCORD SECUNDÁRIO"
})

InfTab:AddButton({
	Name = "Link do Discord",
	Callback = function()
      setclipboard("https://discord.com/invite/8UkHWzxu")
      OrionLib:MakeNotification({
	Name = "Link copiado!",
	Content = "agora vai para o navegador e cole",
	Image = "rbxassetid://4483345998",
	Time = 5
})
    end
})

local MainTab = Window:MakeTab({
    Name = "Main",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

MainTab:AddSection({
    Name = "Auto Farme"
})

MainTab:AddToggle({
    Name = "Auto Swing",
    Default = false,
    Callback = toggleAutoSwing

})

MainTab:AddToggle({
    Name = "Auto Buy Ninjutsu",
    Default = false,
    Callback = function(value)
        _G.autoBuyNinjutsu = value
        if _G.autoBuyNinjutsu then
            print("Auto Buy Ninjutsu ativado")
        else
            print("Auto Buy Ninjutsu desativado")
        end
    end
})

local TeleportTab = Window:MakeTab({
    Name = "Teleport(beta)",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

TeleportTab:AddSection({
    Name = "Bypass teleporte ilha"
})

TeleportTab:AddDropdown({
    Name = "Teleport",
    Default = "Island",
    Options = {"Inicio"},
    Callback = function(Value)
        if Value == "Inicio" then
            _G.teleportPosition = getChiFarmPosition()
        end
    end
})

TeleportTab:AddButton({
    Name = "Teleport Island",
    Callback = function()
        game.Players.LocalPlayer.Character:SetPrimaryPartCFrame(_G.teleportPosition)
    end
})

local EspTab = Window:MakeTab({
    Name = "Esp",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

EspTab:AddSection({
    Name = "Auto observar player"
})

EspTab:AddToggle({
    Name = "ESP player",
    Default = false,
    Callback = function(value)
        _G.espPlayer = value
        if _G.espPlayer then
            for _, player in ipairs(game.Players:GetPlayers()) do
                drawESP(player)
            end
            game.Players.PlayerAdded:Connect(drawESP)
        else
            for _, player in ipairs(game.Players:GetPlayers()) do
                local highlight = player.Character:FindFirstChildOfClass("Highlight")
                if highlight then
                    highlight:Destroy()
                end
            end
        end
    end
})

local PlayerTab = Window:MakeTab({
    Name = "Settings",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

PlayerTab:AddSlider({
	Name = "Velocidade",
	Min = 0,
	Max = 100,
	Default = 50,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "Speed",
	Callback = function(Value)
        local character = Player.Character or Player.CharacterAdded:Wait()
        local humanoid = character:WaitForChild("Humanoid")
        humanoid.WalkSpeed = Value
	end    
})

OrionLib:Init()
