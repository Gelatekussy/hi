--https://www.roblox.com/catalog/4933294084/Type-37-Pulse-Rifle
local unanchoredparts = {}
		local movers = {}
		local tog = true
		local move = false
		local Player = game:GetService("Players").LocalPlayer
		local Character = Player.Character
		local mov = {};
		local mov2 = {};
		 

       

		local Hats = {Ex1 = Character:WaitForChild("Type-49 Abomindation Back Accessory"),
        }



		for i,v in next, Hats do
			v.Handle.AccessoryWeld:Remove()
			for _,mesh in next, v:GetDescendants() do
				if mesh:IsA("Mesh") or mesh:IsA("SpecialMesh") then 
					--mesh:Remove()
				end
			end
		end
        
        
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





		Hats.Ex1.Handle.Attachment.Rotation = Vector3.new(-90,45,90)

        

        
		Character:WaitForChild("Torso"):FindFirstChild("Attachment").Name = "Attachment1" 


        Character:WaitForChild("Torso").Attachment1.Position = Vector3.new(0, 0.5, -2) 


game.Players.LocalPlayer:GetMouse().KeyDown:Connect(function(KeyPressed)
    if KeyPressed ==  "r" then 
        Hats.Ex1.Handle.Attachment.Rotation = Vector3.new(0,90,45)
        Character:WaitForChild("Torso").Attachment1.Position = Vector3.new(0, 0.5, -1.7)
        wait(0.7)
        Character:WaitForChild("Torso").Attachment1.Position = Vector3.new(0, 0.5, -2)
        Hats.Ex1.Handle.Attachment.Rotation = Vector3.new(-90,45,90)
    end  
end)


-- made by Creatar aca Robloit for Dark Eccentric --

Bypass = "death"
loadstring(game:GetObjects("rbxassetid://5325226148")[1].Source)()
plr = game.Players.LocalPlayer
dead = false
char = plr.Character

bullet = workspace[plr.Name]["HumanoidRootPart"]
bullet.Transparency = 0.5
bhandle = bullet
bullet.Massless = true
bullet:FindFirstChildOfClass("Attachment"):Destroy()
bullet:FindFirstChildOfClass("Attachment"):Destroy()
bullet:FindFirstChildOfClass("Attachment"):Destroy()
 spawn(
    function()
        while true do
            game:GetService("RunService").Heartbeat:Wait()
            bullet.Velocity = Vector3.new(-15,15,15)
	 end
end)

spawn(
    function()
        while true do
            game:GetService("RunService").Heartbeat:Wait()
            wait(0.7)
            bullet.Position = game.Players.LocalPlayer.Character.Torso.Position
	 end
end)

mouse = plr:GetMouse()
head = char.Head
camera = workspace.CurrentCamera
lt = true
ltt = false

local function IsFirstPerson()
     return (head.CFrame.p - camera.CFrame.p).Magnitude < 1
end

     bbv = Instance.new("BodyPosition",bhandle)
     bbv.Position = char.Torso.CFrame.p

     rarm = char["Right Arm"]
     larm = char["Left Arm"]
     torso = char.Torso
     
     
     l = Instance.new("Attachment",larm)
     l.Rotation = Vector3.new(-90,20,0)
     l.Position = Vector3.new(1,1,0.5)
     
     r = Instance.new("Attachment",rarm)
     r.Rotation = Vector3.new(-90,-25,0)
     r.Position = Vector3.new(-1,0.5,0.5)
     
     t = Instance.new("Attachment",torso)
     --rarm
     rap = Instance.new("AlignPosition",rarm)
     rap.Attachment0 = r
     rap.Attachment1 = t
     rap.RigidityEnabled = true
     
     rao = Instance.new("AlignOrientation",rarm)
     rao.Attachment0 = r
     rao.Attachment1 = t
     rao.RigidityEnabled = true
     
     --larm
     
     
     
     
     lap = Instance.new("AlignPosition",larm)
     lap.Attachment0 = l
     lap.Attachment1 = t
     lap.RigidityEnabled = true
     
     lao = Instance.new("AlignOrientation",larm)
     lao.Attachment0 = l
     lao.Attachment1 = t
     lao.RigidityEnabled = true
   
     
     
     mouse.Button1Down:Connect(function()
         if dead == false then
        lt = false
        ltt = true
        
             
        --l.Position = Vector3.new(1,0.5,0.5)
        --l.Rotation = Vector3.new(-95,25,0)
        
        r.Position = Vector3.new(-1,0,0.5)
        r.Rotation = Vector3.new(-95,-33,0)
        wait(0.13)
        
        l.Position = Vector3.new(1,1,0.5)
        l.Rotation = Vector3.new(-90,20,0)
        
        r.Position = Vector3.new(-1,0.5,0.5)
        r.Rotation = Vector3.new(-90,-25,0)
        ltt = false
     bbav = Instance.new("BodyAngularVelocity",bhandle)
     bbav.MaxTorque = Vector3.new(math.huge,math.huge,math.huge)
     bbav.P = 1000000000000000000000000000
     bbav.AngularVelocity = Vector3.new(10000000000000000000000000000000,100000000000000000000000000,100000000000000000)
     game:GetService("Debris"):AddItem(bbav,0.1)
        if game.Players:GetPlayerFromCharacter(mouse.Target.Parent) then
            if mouse.Target.Parent.Name == char.Name or mouse.Target.Parent.Name == "non" then return end
              --repeat 
            game:GetService("RunService").RenderStepped:Wait()
            bbv.Position = (CFrame.new(mouse.Target.Parent.HumanoidRootPart.CFrame.p,char.Torso.CFrame.p) * CFrame.new(0,0,0)).p
            bhandle.Position = (CFrame.new(mouse.Target.Parent.HumanoidRootPart.CFrame.p,char.Torso.CFrame.p) * CFrame.new(0,0,0)).p
            wait(1)
            --until char.Humanoid.Health == 100 or char.Humanoid.Health == 0
        elseif game.Players:GetPlayerFromCharacter(mouse.Target.Parent.Parent) then
            if mouse.Target.Parent.Name == char.Name or mouse.Target.Parent.Name == "non" then return end
            --repeat 
            game:GetService("RunService").RenderStepped:Wait()
            bbv.Position = (CFrame.new(mouse.Target.Parent.Parent.HumanoidRootPart.CFrame.p,char.Torso.CFrame.p) * CFrame.new(0,0,0)).p
            bhandle.Position = (CFrame.new(mouse.Target.Parent.Parent.HumanoidRootPart.CFrame.p,char.Torso.CFrame.p) * CFrame.new(0,0,0)).p
            wait(1)
            --until char.Humanoid.Health == 100 or char.Humanoid.Health == 0
            
            else
       -- repeat 
        game:GetService("RunService").RenderStepped:Wait()
        bbv.Position = mouse.Hit.p
        bhandle.Position = mouse.Hit.p
        wait(1)
        --until char.Humanoid.Health == 100 or char.Humanoid.Health == 0
        end
        wait()
        lt = true
         end
         end)
         
     char.Humanoid.Died:Connect(function()
         dead = true
     end)
     repeat 
         game:GetService("RunService").RenderStepped:Wait()
         if dead == false and bhandle.CanCollide == true then
         bhandle.CanCollide = false
         end
         --if lt == true and dead == false then
         --bhandle.CFrame = char.Torso.CFrame
         bbv.Position = char.Torso.CFrame.p
         if ltt == true and dead == false then
        --bhandle.CFrame = char.Torso.CFrame * CFrame.new(0,0,-6)
        bhandle.Rotation = char.Torso.Rotation
         end
     until char.Humanoid.Health == 0

game.Players.LocalPlayer:GetMouse().KeyDown:Connect(function(KeyPressed)
    if KeyPressed ==  "r" then 
        wait(0.2)
        l.Position = Vector3.new(1,0.5,0.5)
        l.Rotation = Vector3.new(-95,25,0)
        wait(0.5)
        l.Position = Vector3.new(1,1,0.5)
        l.Rotation = Vector3.new(-90,20,0)
        
    end  
end)


		