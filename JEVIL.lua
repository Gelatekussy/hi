--[[
local char = game.Players.LocalPlayer.Character
if _G.permadeath == true then
	char = workspace.non
end
local mouse = game.Players.LocalPlayer:GetMouse()
local UserInputService = game:GetService("UserInputService")

local gun = char['Evil Aura'].Handle
local gunPos = Instance.new("AlignPosition", gun)
local gunO = Instance.new("AlignOrientation", gun)
local att1 = Instance.new("Attachment")
gunPos.Responsiveness = 999999
gunO.Responsiveness = 999999
gun.AccessoryWeld:Destroy()
att1.Position = Vector3.new(1.2, -1, 0.2)
att1.Orientation = Vector3.new(-70, 60, 0)
att1.Parent = char["Left Arm"]
gunPos.Attachment0 = gun.BodyBackAttachment
gunPos.Attachment1 = att1
gunO.Attachment0 = gun.BodyBackAttachment
gunO.Attachment1 = att1
--]]
local char = game.Players.LocalPlayer.Character
if _G.permadeath == true then
	char = workspace.non
end
local mouse = game.Players.LocalPlayer:GetMouse()
local UserInputService = game:GetService("UserInputService")
--[[
local gun = char['Northern Star'].Handle
local gunPos = Instance.new("AlignPosition", gun)
local gunO = Instance.new("AlignOrientation", gun)
local att1 = Instance.new("Attachment")
gunPos.Responsiveness = 999999
gunO.Responsiveness = 999999
gun.AccessoryWeld:Destroy()
att1.Position = Vector3.new(1.2, -0.3, 0.3)
att1.Orientation = Vector3.new(-80, -120, 180)
att1.Parent = char["Right Arm"]
gunPos.Attachment0 = gun.BodyBackAttachment
gunPos.Attachment1 = att1
gunO.Attachment0 = gun.BodyBackAttachment
gunO.Attachment1 = att1
--]]
local swordhalo = char['swordhalo'].Handle
local CountSCIFIMOVIELOL = 1
function SCIFIMOVIELOL(Part0,Part1,Position,Angle)
	local AlignPos = Instance.new('AlignPosition', Part1); AlignPos.Name = "AliP_"..CountSCIFIMOVIELOL
	AlignPos.ApplyAtCenterOfMass = true;
	AlignPos.MaxForce = 5772000--67752;
	AlignPos.MaxVelocity = math.huge/9e110;
	AlignPos.ReactionForceEnabled = false;
	AlignPos.Responsiveness = 200;
	AlignPos.RigidityEnabled = false;
	local AlignOri = Instance.new('AlignOrientation', Part1); AlignOri.Name = "AliO_"..CountSCIFIMOVIELOL
	AlignOri.MaxAngularVelocity = math.huge/9e110;
	AlignOri.MaxTorque = 5772000
	AlignOri.PrimaryAxisOnly = false;
	AlignOri.ReactionTorqueEnabled = false;
	AlignOri.Responsiveness = 200;
	AlignOri.RigidityEnabled = false;
	local AttachmentA=Instance.new('Attachment',Part1); AttachmentA.Name = "Ath_"..CountSCIFIMOVIELOL
	local AttachmentB=Instance.new('Attachment',Part0); AttachmentB.Name = "Ath_"..CountSCIFIMOVIELOL
	AttachmentA.Orientation = Angle or Vector3.new(0,0,0)
	AttachmentA.Position = Position or Vector3.new(0,0,0)
	AlignPos.Attachment1 = AttachmentA;
	AlignPos.Attachment0 = AttachmentB;
	AlignOri.Attachment1 = AttachmentA;
	AlignOri.Attachment0 = AttachmentB;
	CountSCIFIMOVIELOL = CountSCIFIMOVIELOL + 1
	return {AlignPos,AlignOri,AttachmentA,AttachmentB}
end

SCIFIMOVIELOL(swordhalo, char.Torso, Vector3.new(0, -3.5, 0),Vector3.new(90,0,0))
swordhalo:BreakJoints()
game:GetService("RunService").RenderStepped:Connect(function()

    function rotateRing1()

        if swordhalo.Ath_1.Orientation ~= Vector3.new(90, -0, 90) then
        	swordhalo.Ath_1.Orientation = swordhalo.Ath_1.Orientation + Vector3.new(0, -0, -3)
        else
            swordhalo.Ath_1.Orientation = Vector3.new(90, 0, 35)
        end
    end

    pcall(rotateRing1)

end)


Player = game:GetService("Players").LocalPlayer
PlayerGui = Player.PlayerGui
Cam = workspace.CurrentCamera
Backpack = Player.Backpack
Character = game.Players.LocalPlayer.Character
if _G.permadeath == true then
	Character = workspace.non
end
Humanoid = Character.Humanoid
Mouse = Player:GetMouse()
RootPart = Character.HumanoidRootPart
Torso = Character.Torso
Head = Character.Head
RightArm = Character["Right Arm"]
LeftArm = Character["Left Arm"]
RightLeg = Character["Right Leg"]
LeftLeg = Character["Left Leg"]
RootJoint = RootPart.RootJoint
Neck = Torso.Neck
RightShoulder = Torso["Right Shoulder"]
LeftShoulder = Torso["Left Shoulder"]
RightHip = Torso["Right Hip"]
LeftHip = Torso["Left Hip"]
Equipped = false

bc = BrickColor.new
local bilguit = Instance.new("BillboardGui", Head)
bilguit.Adornee = nil
bilguit.Name = "ModeName"
bilguit.Size = UDim2.new(4, 0, 1.2, 0)
bilguit.StudsOffset = Vector3.new(-8, 8/1.5, 0)
local modet = Instance.new("TextLabel", bilguit)
modet.Size = UDim2.new(10/2, 0, 7/2, 0)
modet.FontSize = "Size8"
modet.TextScaled = true
modet.TextTransparency = 0
modet.BackgroundTransparency = 1 
modet.TextTransparency = 0
modet.TextStrokeTransparency = 0
modet.Font = "Gotham"
modet.TextStrokeColor3 = bc("Really black").Color
modet.TextColor3 = bc("Bright violet").Color
modet.Text = "JEVIL"

function CreateSound(id, looped, volume, timepos)
local Sound = Instance.new("Sound", Head)
Sound.SoundId = "rbxassetid://"..id
Sound:Play()
Sound.TimePosition = timepos
Sound.Volume = volume
if looped == true then
Sound.Looped = true
end
end

CreateSound("2544975373", false, 2, 0)
CreateSound("2561705325", true, 1, 10)

-------------------------------------------------------------------------

weld = function(parent, part0, part1, c0)
	local weld = it("Weld")
	weld.Parent = parent
	weld.Part0 = part0
	weld.Part1 = part1
    weld.C0 = c0
    return weld
end

function unanchor()
	if UNANCHOR == true then
		g = CharacterA:GetChildren()
		for i = 1, #g do
			if g[i].ClassName == "Part" then
				g[i].Anchored = false
			end
		end
	end
end





IT = Instance.new
CF = CFrame.new
VT = Vector3.new
RAD = math.rad
C3 = Color3.new
UD2 = UDim2.new
BRICKC = BrickColor.new
ANGLES = CFrame.Angles
EULER = CFrame.fromEulerAnglesXYZ
COS = math.cos
ACOS = math.acos
SIN = math.sin
ASIN = math.asin
ABS = math.abs
MRANDOM = math.random
FLOOR = math.floor
--//=================================\\
--|| 	      USEFUL VALUES
--\\=================================//

Animation_Speed = 2.75
Frame_Speed = 0.016666666666666666
local FORCERESET = false
Frame_Speed = 1 / 80 -- (1 / 60) OR (1 / 80)
local Speed = 25
local ROOTC0 = CF(0, 0, 0) * ANGLES(RAD(-90), RAD(0), RAD(180))
local NECKC0 = CF(0, 1, 0) * ANGLES(RAD(-90), RAD(0), RAD(180))
local RIGHTSHOULDERC0 = CF(-0.5, 0, 0) * ANGLES(RAD(0), RAD(90), RAD(0))
local LEFTSHOULDERC0 = CF(0.5, 0, 0) * ANGLES(RAD(0), RAD(-90), RAD(0))
local DAMAGEMULTIPLIER = 1
local ANIM = "Idle"
local ATTACK = false
local HOLD = false
local Rooted = false
local SINE = 0
local SIZE = 1
local UserInputService = game:GetService("UserInputService")
local KEYHOLD = false
local CHANGE = 2 / Animation_Speed
local WALKINGANIM = false
local VALUE1 = false
local VALUE2 = false
local ROBLOXIDLEANIMATION = IT("Animation")
ROBLOXIDLEANIMATION.Name = "Roblox Idle Animation"
ROBLOXIDLEANIMATION.AnimationId = "http://www.roblox.com/asset/?id=180435571"
local ANIMATOR = Humanoid.Animator
local ANIMATE = Character:FindFirstChild("Animate")
local UNANCHOR = true

function Swait(NUMBER)
	if NUMBER == 0 or NUMBER == nil then
		game:GetService("RunService").RenderStepped:wait()
	else
		for i = 1, NUMBER do
			game:GetService("RunService").RenderStepped:wait()
		end
	end
end

function Raycast(POSITION, DIRECTION, RANGE, IGNOREDECENDANTS)
	return workspace:FindPartOnRay(Ray.new(POSITION, DIRECTION.unit * RANGE), IGNOREDECENDANTS)
end

function QuaternionFromCFrame(cf)
	local mx, my, mz, m00, m01, m02, m10, m11, m12, m20, m21, m22 = cf:components()
	local trace = m00 + m11 + m22
	if trace > 0 then 
		local s = math.sqrt(1 + trace)
		local recip = 0.5 / s
		return (m21 - m12) * recip, (m02 - m20) * recip, (m10 - m01) * recip, s * 0.5
	else
		local i = 0
		if m11 > m00 then
			i = 1
		end
		if m22 > (i == 0 and m00 or m11) then
			i = 2
		end
		if i == 0 then
			local s = math.sqrt(m00 - m11 - m22 + 1)
			local recip = 0.5 / s
			return 0.5 * s, (m10 + m01) * recip, (m20 + m02) * recip, (m21 - m12) * recip
		elseif i == 1 then
			local s = math.sqrt(m11 - m22 - m00 + 1)
			local recip = 0.5 / s
			return (m01 + m10) * recip, 0.5 * s, (m21 + m12) * recip, (m02 - m20) * recip
		elseif i == 2 then
			local s = math.sqrt(m22 - m00 - m11 + 1)
			local recip = 0.5 / s return (m02 + m20) * recip, (m12 + m21) * recip, 0.5 * s, (m10 - m01) * recip
		end
	end
end
 



function QuaternionToCFrame(px, py, pz, x, y, z, w)
	local xs, ys, zs = x + x, y + y, z + z
	local wx, wy, wz = w * xs, w * ys, w * zs
	local xx = x * xs
	local xy = x * ys
	local xz = x * zs
	local yy = y * ys
	local yz = y * zs
	local zz = z * zs
	return CFrame.new(px, py, pz, 1 - (yy + zz), xy - wz, xz + wy, xy + wz, 1 - (xx + zz), yz - wx, xz - wy, yz + wx, 1 - (xx + yy))
end
 
function QuaternionSlerp(a, b, t)
	local cosTheta = a[1] * b[1] + a[2] * b[2] + a[3] * b[3] + a[4] * b[4]
	local startInterp, finishInterp;
	if cosTheta >= 0.0001 then
		if (1 - cosTheta) > 0.0001 then
			local theta = ACOS(cosTheta)
			local invSinTheta = 1 / SIN(theta)
			startInterp = SIN((1 - t) * theta) * invSinTheta
			finishInterp = SIN(t * theta) * invSinTheta
		else
			startInterp = 1 - t
			finishInterp = t
		end
	else
		if (1 + cosTheta) > 0.0001 then
			local theta = ACOS(-cosTheta)
			local invSinTheta = 1 / SIN(theta)
			startInterp = SIN((t - 1) * theta) * invSinTheta
			finishInterp = SIN(t * theta) * invSinTheta
		else
			startInterp = t - 1
			finishInterp = t
		end
	end
	return a[1] * startInterp + b[1] * finishInterp, a[2] * startInterp + b[2] * finishInterp, a[3] * startInterp + b[3] * finishInterp, a[4] * startInterp + b[4] * finishInterp
end

function Clerp(a, b, t)
	local qa = {QuaternionFromCFrame(a)}
	local qb = {QuaternionFromCFrame(b)}
	local ax, ay, az = a.x, a.y, a.z
	local bx, by, bz = b.x, b.y, b.z
	local _t = 1 - t
	return QuaternionToCFrame(_t * ax + t * bx, _t * ay + t * by, _t * az + t * bz, QuaternionSlerp(qa, qb, t))
end
-- weldtest


function shoot1()
Humanoid.WalkSpeed = 10
ATTACK = true
for i = 1,1 /.02 do
Swait()

     RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0 , 0 , 3.1+.1 * COS(SINE / 18)) * ANGLES(RAD(1), RAD(0), RAD(0)), 0.5 / Animation_Speed)
	--Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0) * ANGLES(RAD(10), RAD(0), RAD(0 + 15 * COS(SINE / 20))), 0.5 / Animation_Speed)
	RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1, 0.5-0 * COS(SINE / 12), 0.8) * ANGLES(RAD(0* COS(SINE / 12)), RAD(-140), RAD(-90))* RIGHTSHOULDERC0,0.5 / Animation_Speed)
	LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5-0 * COS(SINE / 12), 0) * ANGLES(RAD(0* COS(SINE / 12)), RAD(0), RAD(-7))* LEFTSHOULDERC0, 0.5 / Animation_Speed)
	--RightHip.C0 = Clerp(RightHip.C0, CF(1, -1 -0 -0.1 * COS(SINE / 20), 0.03) * ANGLES(RAD(0), RAD(80), RAD(0)) * ANGLES(RAD(-5), RAD(0), RAD(0)), 0.9 / Animation_Speed)
			--LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1 -0 -0.1 * COS(SINE / 20) , 0.03) * ANGLES(RAD(-0), RAD(-80), RAD(0)) * ANGLES(RAD(-5), RAD(5), RAD(0)), 0.9 / Animation_Speed)
end
--[[
for i = 1,1 /.06 do
    Swait()
    RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0 , -2.5 , 0.1 * COS(SINE / 18)) * ANGLES(RAD(1), RAD(0), RAD(0)), 0.5 / Animation_Speed)
	--Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0) * ANGLES(RAD(10), RAD(0), RAD(0 + 15 * COS(SINE / 20))), 0.5 / Animation_Speed)
	RightShoulder.C0 = Clerp(RightShoulder.C0, CF(0.6, 0.5-0 * COS(SINE / 12), 1) * ANGLES(RAD(0* COS(SINE / 12)), RAD(-140), RAD(-90))* RIGHTSHOULDERC0,0.5 / Animation_Speed)
	LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5-0 * COS(SINE / 12), 0.3) * ANGLES(RAD(0* COS(SINE / 12)), RAD(90), RAD(-40))* LEFTSHOULDERC0, 0.8 / Animation_Speed)
	RightHip.C0 = Clerp(RightHip.C0, CF(1, -1 -0 * COS(SINE / 12), -0.1) * ANGLES(RAD(-28), RAD(90), RAD(0)) * ANGLES(RAD(-0), RAD(0), RAD(0)), 0.9 / Animation_Speed)
	LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1 -0 * COS(SINE / 12) , -0.1) * ANGLES(RAD(-40), RAD(-90), RAD(0)) * ANGLES(RAD(-0), RAD(0), RAD(0)), 0.9 / Animation_Speed)
end
--]]
for i = 1,1 /.02 do
    Swait()
    RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0 , -2.5 , 3.1+.1 * COS(SINE / 18)) * ANGLES(RAD(3), RAD(0), RAD(0)), 0.5 / Animation_Speed)
	--Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0) * ANGLES(RAD(10), RAD(0), RAD(0 + 15 * COS(SINE / 20))), 0.5 / Animation_Speed)
	RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5-0 * COS(SINE / 12), -0.4) * ANGLES(RAD(0* COS(SINE / 12)), RAD(-64), RAD(-90))* RIGHTSHOULDERC0,0.9 / Animation_Speed)
	LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5-0 * COS(SINE / 12), 0) * ANGLES(RAD(0* COS(SINE / 12)), RAD(0), RAD(-7))* LEFTSHOULDERC0, 0.5 / Animation_Speed)
	--RightHip.C0 = Clerp(RightHip.C0, CF(1, -1 -0 -0.1 * COS(SINE / 20), 0.03) * ANGLES(RAD(0), RAD(80), RAD(0)) * ANGLES(RAD(-5), RAD(0), RAD(0)), 0.9 / Animation_Speed)
			--LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1 -0 -0.1 * COS(SINE / 20) , 0.03) * ANGLES(RAD(-0), RAD(-80), RAD(0)) * ANGLES(RAD(-5), RAD(5), RAD(0)), 0.9 / Animation_Speed)
    end
Humanoid.WalkSpeed = 14
ATTACK = false
end

Mouse.Button1Down:connect(function()
if ATTACK == false then
        shoot1()
    end
end)

--end

--end
while true do
	Swait()
	if Character:FindFirstChildOfClass("Humanoid") == nil then
		Humanoid = IT("Humanoid",Character)
	end
	for _,v in next, Humanoid:GetPlayingAnimationTracks() do
	    v:Stop();
	end
	
local TORSOVELOCITY = (RootPart.Velocity * VT(1, 0, 1)).magnitude
local TORSOVERTICALVELOCITY = RootPart.Velocity.y
local NameClan = 0
local HITFLOOR = Raycast(RootPart.Position, (CF(RootPart.Position, RootPart.Position + VT(0, -1, 0))).lookVector, 5, Character)
local WALKSPEEDVALUE = 6 / (Humanoid.WalkSpeed / 16)
	SINE = SINE + CHANGE
	if TORSOVERTICALVELOCITY > 1 and ATTACK == false and Equipped == false and HITFLOOR == nil then
		ANIM = "Jump"
		RootJoint.C0 = Clerp(RootJoint.C0, ROOTC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(0)), 0.2 / Animation_Speed)            RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(-40), RAD(0), RAD(20)) * RIGHTSHOULDERC0, 0.2 / Animation_Speed)
            LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(-40), RAD(0), RAD(-20)) * LEFTSHOULDERC0, 0.2 / Animation_Speed)
            RightHip.C0 = Clerp(RightHip.C0, CF(1, -1, -0.3) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(-5), RAD(0), RAD(-20)), 0.2 / Animation_Speed)
            LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1, -0.3) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(-5), RAD(0), RAD(20)), 0.2 / Animation_Speed)
elseif TORSOVERTICALVELOCITY < -1 and ATTACK == false and Equipped == false and HITFLOOR == nil then
		ANIM = "Fall"
		RootJoint.C0 = Clerp(RootJoint.C0, ROOTC0 * CF(0, 0, 0 ) * ANGLES(RAD(0), RAD(0), RAD(0)), 0.2 / Animation_Speed)
            --Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0 , 0 + ((1) - 1)) * ANGLES(RAD(20), RAD(0), RAD(0)), 0.2 / Animation_Speed)
            RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(0), RAD(0), RAD(60)) * RIGHTSHOULDERC0, 0.2 / Animation_Speed)
            LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(0), RAD(0), RAD(-60)) * LEFTSHOULDERC0, 0.2 / Animation_Speed)
            RightHip.C0 = Clerp(RightHip.C0, CF(1, -1, 0) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(20)), 0.2 / Animation_Speed)
            LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1, 0) * ANGLES(RAD(-20), RAD(-90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(10)), 0.2 / Animation_Speed)
    elseif TORSOVELOCITY < 1 and ATTACK == false and Equipped == false and HITFLOOR ~= nil then
		ANIM = "Idle"
       RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0 , 0 ,3 +0.5 * COS(SINE / 20)) * ANGLES(RAD(0), RAD(20* COS(SINE / 12)), RAD(0)), 0.9 / Animation_Speed)

         --RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0 , 0 , 0.1 * COS(SINE / 18)) * ANGLES(RAD(0), RAD(0), RAD(0)), 0.5 / Animation_Speed)
			--Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0) * ANGLES(RAD(10), RAD(0), RAD(0 + 15 * COS(SINE / 20))), 0.5 / Animation_Speed)
			RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.4-0 * COS(SINE / 13), 0.2) * ANGLES(RAD(90* COS(SINE / 12)), RAD(-50* COS(SINE / 12)), RAD(20))* RIGHTSHOULDERC0,0.5 / Animation_Speed)
			LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.4-0 * COS(SINE / 13), 0.2) * ANGLES(RAD(-90* COS(SINE / 12)), RAD(50* COS(SINE / 12)), RAD(-20))* LEFTSHOULDERC0, 0.5 / Animation_Speed)
			RightHip.C0 = Clerp(RightHip.C0, CF(1, -1 -0 * COS(SINE / 20), -0) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(-0), RAD(-10), RAD(0)), 0.5 / Animation_Speed)
			LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1 -0 * COS(SINE / 20) , -0) * ANGLES(RAD(-0), RAD(-90), RAD(0)) * ANGLES(RAD(-0), RAD(10), RAD(0)), 0.5 / Animation_Speed)
            elseif TORSOVELOCITY > 1 and Equipped == false and HITFLOOR ~= nil then
		ANIM = "Walk"
		       --RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0 , 0 ,3 +0.5 * COS(SINE / 20)) * ANGLES(RAD(10), RAD(0* COS(SINE / 12)), RAD(0)), 0.9 / Animation_Speed)
if ATTACK ~= true then
RootJoint.C0 = Clerp(RootJoint.C0, ROOTC0 * CF(0, 0, 3.175 + 0.025 * COS(SINE / 3.5) + -SIN(SINE / 3.5) / 7) * ANGLES(RAD(9-2.5 * COS(SINE / 3.5)), RAD(0), RAD(10 * COS(SINE / 7))), 0.15)			--Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0) * ANGLES(RAD(10), RAD(0), RAD(0 + 15 * COS(SINE / 20))), 0.35 / Animation_Speed)
			RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.40-0 * COS(SINE / 13), 0) * ANGLES(RAD(-15 -45* COS(SINE / 7)), RAD(0), RAD(-0))* RIGHTSHOULDERC0,0.6 / Animation_Speed)
            LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.40-0 * COS(SINE / 13), 0) * ANGLES(RAD(-15 +45* COS(SINE / 7)), RAD(0), RAD(-0))* LEFTSHOULDERC0, 0.6 / Animation_Speed)
			RightHip.C0 = Clerp(RightHip.C0, CF(1, -1 -0.1 * COS(SINE / 18), -0) * ANGLES(RAD(-15 - 35 * COS(SINE / 7)) + -SIN(SINE / 7) / 2.5, RAD(0 - 2 * COS(SINE / 7)), RAD(0)) * ANGLES(RAD(0 + 2.5 * COS(SINE / 7)), RAD(90), RAD(0)), 0.55)
            LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1 -0.1 * COS(SINE / 18) , -0) * ANGLES(RAD(-15 + 35 * COS(SINE / 7)) + SIN(SINE / 7) / 2.5, RAD(0 - 2 * COS(SINE / 7)), RAD(0)) * ANGLES(RAD(0 - 2.5 * COS(SINE / 7)), RAD(-90), RAD(0)), 0.55)    end
else
RightHip.C0 = Clerp(RightHip.C0, CF(1, -1 -0.1 * COS(SINE / 18), -0) * ANGLES(RAD(-15 - 35 * COS(SINE / 7)) + -SIN(SINE / 7) / 2.5, RAD(0 - 2 * COS(SINE / 7)), RAD(0)) * ANGLES(RAD(0 + 2.5 * COS(SINE / 7)), RAD(90), RAD(0)), 0.55)
            LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1 -0.1 * COS(SINE / 18) , -0) * ANGLES(RAD(-15 + 35 * COS(SINE / 7)) + SIN(SINE / 7) / 2.5, RAD(0 - 2 * COS(SINE / 7)), RAD(0)) * ANGLES(RAD(0 - 2.5 * COS(SINE / 7)), RAD(-90), RAD(0)), 0.55)    end
RootJoint.C0 = Clerp(RootJoint.C0, ROOTC0 * CF(0, 0, 3.175 + 0.025 * COS(SINE / 3.5) + -SIN(SINE / 3.5) / 7) * ANGLES(RAD(9-2.5 * COS(SINE / 3.5)), RAD(0), RAD(10 * COS(SINE / 7))), 0.15)			--Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0) * ANGLES(RAD(10), RAD(0), RAD(0 + 15 * COS(SINE / 20))), 0.35 / Animation_Speed)

--end
end
unachor()
