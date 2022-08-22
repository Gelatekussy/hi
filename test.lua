local Global = (getgenv and getgenv()) or _G
local Enabled = (Global.GelatekReanimateConfig and Global.GelatekReanimateConfig.BulletConfig and Global.GelatekReanimateConfig.BulletConfig.RunAfterReanimate) or false
local LockOnTorso = (Global.GelatekReanimateConfig and Global.GelatekReanimateConfig.BulletConfig and Global.GelatekReanimateConfig.BulletConfig.LockBulletOnTorso) or false

if Enabled == true then
	local Players = game:GetService("Players") --// Needed For Bullet.
	local Player = Players.LocalPlayer --// Needed for bullet checking
	local Heartbeat = game:GetService("RunService").Heartbeat --// Needed for loop
	local Mouse = Player:GetMouse() --// Needed For Held Check and Position
	local Clone = workspace:WaitForChild("GelatekReanimate") --// Waiting for the dummy to get spawned.
	local Character = Global.OGChar
	local Root = Clone["HumanoidRootPart"]
	local BulletPart = Character:FindFirstChild("Bullet")
	local Held = false
	--// Instances/Properties
	local BodyPosition = Instance.new("BodyPosition")
	local BodyThrust = Instance.new("BodyThrust")

	--// BodyPosition (Move the bullet, CFrame isn't recommended due to lack of good stability for bullets.)
	BodyPosition.MaxForce = Vector3.new(1,1,1) * math.huge
	BodyPosition.P = 20000
	BodyPosition.D = 150
	BodyPosition.Position = Bullet.CFrame.Position
	--// BodyThrust (Makes the bullet flingable, If used well it's faster than AngularVelocity.)
	BodyThrust.Power = Vector3.new(1,1,1) * 250
	BodyThrust.Location = Vector3.new(-5,10,5)

	--// Parenting (Always Make sure to make it last! otherwise it will decrease perfomance.)
	BodyPosition.Parent = Bullet
	BodyThrust.Parent = Bullet

	--// Held Check.
	table.insert(Global.TableOfSignalEvents, Mouse.Button1Down:Connect(function()
		Held = true
	end))
	table.insert(Global.TableOfSignalEvents, Mouse.Button1Up:Connect(function()
		Held = false
	end))

	-- Main Part.
	if LockOnTorso == false then
		table.insert(Global.TableOfSignalEvents, Heartbeat:Connect(function()
			if Bullet and Bullet.Parent then --// It is better to use if Bullet Exists rather than pcalling.
				if Held == true then --// Check
					if Mouse.Target ~= nil then
						BodyPosition.Position = Mouse.Hit.Position
					end
				elseif Held == false then
					BodyPosition.Position = Root.CFrame.Position
				end
			end
		end))
	elseif LockOnTorso == true then
		table.insert(Global.TableOfSignalEvents, Heartbeat:Connect(function()
			if Bullet and Bullet.Parent then --// It is better to use if Bullet Exists rather than pcalling.
				if Held == true then --// Check
					if Players:GetPlayerFromCharacter(Mouse.Target.Parent) and Mouse.Target.Parent.Name ~= Player.Name then
						local Target = Mouse.Target.Parent:FindFirstChild("Torso") or Mouse.Target.Parent.Parent:FindFirstChild("UpperTorso") or Mouse.Target.Parent:FindFirstChild("Head") or Mouse.Target.Parent:FindFirstChildWhichIsA("BasePart")
						BodyPosition.Position = Target.Position
					elseif Players:GetPlayerFromCharacter(Mouse.Target.Parent.Parent) and Mouse.Target.Parent.Parent.Name ~= Player.Name then
						local Target = Mouse.Target.Parent.Parent:FindFirstChild("Torso") or Mouse.Target.Parent.Parent:FindFirstChild("UpperTorso") or Mouse.Target.Parent.Parent:FindFirstChild("Head") or Mouse.Target.Parent.Parent:FindFirstChildWhichIsA("BasePart")
						BodyPosition.Position = Target.Position
					elseif Mouse.Target ~= nil then
						BodyPosition.Position = Mouse.Hit.Position
					end
				elseif Held == false then
					BodyPosition.Position = Root.CFrame.Position
				end
			end
		end))
	end
end
