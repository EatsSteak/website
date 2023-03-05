task.spawn(function()
    local Remotes = game:GetService("ReplicatedStorage").Remotes

    local Cheat = {
        Remotes:WaitForChild("clientkick"),
        Remotes.ClanRemotes:WaitForChild("KickPlayer"),
        Remotes.ClanRemotes:WaitForChild("LocalKick"),
    }

    do
        for i, v in next, Cheat do
            if v ~= nil then
                v:Destroy()
            end
        end
    end
end)

task.spawn(function()
    local Connection;
    local Force;
    
    local function GetMass(Model)
        local Mass = 0;
        
        for i,v in next,Model:GetDescendants() do
            if v:IsA("BasePart") then
                Mass = Mass + v:GetMass();
            end
        end
        
        return Mass;
    end
    
    local function Float(Character)
        if Connection then
            Connection:Disconnect();
            Connection = nil;
        end
        
        if not Force then
            Force = Instance.new("BodyForce");
        end
        
        local Root = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart");
        
        Force.Parent = Root;
        
        Connection = game.RunService.Stepped:Connect(function()
            if (game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").Position - game:GetService("Workspace").FountainKnife.Position).Magnitude > 300 then
                Root.Velocity = Vector3.new(Root.Velocity.X, 0, Root.Velocity.Z);
                Force.Force = Vector3.new(0, GetMass(Character) * game.Workspace.Gravity, 0);
            else
                Force.Force = Vector3.zero;
            end
        end)
    end
    
    if game.Players.LocalPlayer.Character then
        Float(game.Players.LocalPlayer.Character);
    end
    
    game.Players.LocalPlayer.CharacterAdded:Connect(Float);
end)

game:GetService("RunService").Stepped:Connect(function()
    game.Players.LocalPlayer.Character['Left Arm']:Destroy();
    game.Players.LocalPlayer.Character['Left Leg']:Destroy();
    game.Players.LocalPlayer.Character["Right Leg"]:Destroy();
	game.Players.LocalPlayer.Character["Right Arm"]:Destroy();
end);

game:GetService("RunService").RenderStepped:connect(function()
    if game.Players.LocalPlayer.PlayerGui.ScreenGui.UI.Target.Visible == true then
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Workspace[game.Players.LocalPlayer.PlayerGui.ScreenGui.UI.Target.TargetText.Text].HumanoidRootPart.CFrame * CFrame.new(0, -5.5, 0);
        game.Workspace.GameMap:Destroy();
    end;
end);


local Player = game.Players.LocalPlayer;

local cooldown = false;

task.spawn(function()
    game:GetService("RunService").Stepped:connect(function()
        if Player.Character and not cooldown and game.Players.LocalPlayer.PlayerGui.ScreenGui.UI.Target.Visible == true then
            if Player:DistanceFromCharacter(game.Workspace[game.Players.LocalPlayer.PlayerGui.ScreenGui.UI.Target.TargetText.Text].Head.Position) <= 6.5 then
                Player.PlayerScripts.localknifehandler.HitCheck:Fire(game.Workspace[game.Players.LocalPlayer.PlayerGui.ScreenGui.UI.Target.TargetText.Text])
                coroutine.wrap(function()
                    cooldown = true;
                    task.wait(0.75);
					cooldown = false;
                end)();
            else
                task.wait();
            end;
        end;
    end);
end);

game:GetService("Players").PlayerRemoving:Connect(function()
	if #game.Players:GetPlayers() >= 4 then
		loadstring(game:HttpGet("https://pastebin.com/raw/QzKkcxcb", true))();
	end;
end);


local lp,po,ts = game:GetService('Players').LocalPlayer,game.CoreGui.RobloxPromptGui.promptOverlay,game:GetService('TeleportService');
 
po.ChildAdded:connect(function(a)
    if a.Name == 'ErrorPrompt' then
        repeat
            ts:Teleport(game.PlaceId);
            wait(2);
        until false;
    end;
end);

game:GetService("StarterGui"):SetCore("SendNotification", {
	Title = "Credits",
	Text = "Scripted/Coded And Edited By ng#9906, Credits To Supa And Tech Hog And Not Same Servers (Whoever Made It) And Sustor."
});
