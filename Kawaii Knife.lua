--SCRIPT MADE BY HDGUEST1337HD!
--Hat needed: https://www.roblox.com/catalog/4684948729/Kawaii-Knife
--Controls are: R (Stab knife in urself), c (throw knife), z(Stab knife in ur head)--
        local movers = {}
		local tog = true
		local move = false
		local Player = game:GetService("Players").LocalPlayer
		local Character = Player.Character
		local mov = {};
		local mov2 = {};
		 

       

		local Hats = {Ex1 = Character:WaitForChild("YandereKnife"),
        }



		for i,v in next, Hats do
			v.Handle.AccessoryWeld:Remove()
			for _,mesh in next, v:GetDescendants() do
				if mesh:IsA("Mesh") or mesh:IsA("SpecialMesh") then 
					--mesh:Remove()
				end
			end
		end
        
        local Network = coroutine.create(function()
            while true do
                game:GetService("RunService").Heartbeat:Wait()
                settings().Physics.AllowSleep = false
                game:GetService("Players").LocalPlayer.MaximumSimulationRadius = math.pow(math.huge,math.huge)*math.huge
                game:GetService("Players").LocalPlayer.SimulationRadius = math.pow(math.huge,math.huge)*math.huge
            end
        end)
coroutine.resume(Network)
        
		function ftp(str)
			local pt = {};
			if str ~= 'me' and str ~= 'random' then
				for i, v in pairs(game.Players:GetPlayers()) do
					if v.Name:lower():find(str:lower()) then
						table.insert(pt, v);
					end
				end
			elseif str == 'me' then
				table.insert(pt, plr);
			elseif str == 'random' then
				table.insert(pt, game.Players:GetPlayers()[math.random(1, #game.Players:GetPlayers())]);
			end
			return pt;
		end
		
        
        local function align(i,v)
			local att0 = Instance.new("Attachment", i)
			att0.Position = Vector3.new(0,0,0)
			local att1 = Instance.new("Attachment", v)
			att1.Position = Vector3.new(0,0,0)
			local AP = Instance.new("AlignPosition", i)
			AP.Attachment0 = att0
			AP.Attachment1 = att1
			AP.RigidityEnabled = false
			AP.ReactionForceEnabled = false
			AP.ApplyAtCenterOfMass = false
			AP.MaxForce = 9999999
			AP.MaxVelocity = math.huge
			AP.Responsiveness = 200
			local AO = Instance.new("AlignOrientation", i)
			AO.Attachment0 = att0
			AO.Attachment1 = att1
			AO.ReactionTorqueEnabled = false
			AO.PrimaryAxisOnly = false
			AO.MaxTorque = 9999999
			AO.MaxAngularVelocity = math.huge
			AO.Responsiveness = 200
		end




		align(Hats.Ex1.Handle, Character["Torso"])





		Hats.Ex1.Handle.Attachment.Rotation = Vector3.new(180,-100,90)

        

        
		Character:WaitForChild("Torso"):FindFirstChild("Attachment").Name = "Attachment1" 


        Character:WaitForChild("Torso").Attachment1.Position = Vector3.new(1.6, -1, -0.5) 

game.Players.LocalPlayer:GetMouse().KeyDown:Connect(function(KeyPressed)
    if KeyPressed ==  "r" then 
        Hats.Ex1.Handle.Attachment.Rotation = Vector3.new(0,90,45)
        Character:WaitForChild("Torso").Attachment1.Position = Vector3.new(0, 0.5, -1.7)
        wait(0.7)
        Character:WaitForChild("Torso").Attachment1.Position = Vector3.new(0, 0.5, -2)
        Hats.Ex1.Handle.Attachment.Rotation = Vector3.new(-90,45,90)
        wait(0.7)
        Character:WaitForChild("Torso").Attachment1.Position = Vector3.new(0, 0.5, -0.7)
        end
end)

game.Players.LocalPlayer:GetMouse().KeyDown:Connect(function(KeyPressed)
    if KeyPressed ==  "c" then 
Hats.Ex1.Handle.Attachment.Rotation = Vector3.new(180,125,90)
        Character:WaitForChild("Torso").Attachment1.Position = Vector3.new(1.5, -1, -1.7)
        wait(0.1)
        Character:WaitForChild("Torso").Attachment1.Position = Vector3.new(1.5, -1, -3.7)
        Hats.Ex1.Handle.Attachment.Rotation = Vector3.new(180,-100,90)
        wait(0.1)
        Character:WaitForChild("Torso").Attachment1.Position = Vector3.new(1.5, -1, -5.7)
        end
end)


game.Players.LocalPlayer:GetMouse().KeyDown:Connect(function(KeyPressed)
if KeyPressed == "z" then
Hats.Ex1.Handle.Attachment.Rotation = Vector3.new(180,60,90)
        Character:WaitForChild("Torso").Attachment1.Position = Vector3.new(0, 8, -0)
        wait(0.2)
        Character:WaitForChild("Torso").Attachment1.Position = Vector3.new(0, 5, -0)
        Hats.Ex1.Handle.Attachment.Rotation = Vector3.new(180,9,90)
        wait(0.2)
        Character:WaitForChild("Torso").Attachment1.Position = Vector3.new(0, 3, -0)
        end
end)