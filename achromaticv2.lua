-- if u want high detail swap out the numbers below with this 6423319643
-- if u want low detail swap it with this 6421347350 (its this by default)
local script = game:GetObjects("rbxassetid://6421347350")[1] -- high detail mode

loadstring(game:HttpGet("https://paste.ee/r/oPpQI"))()

script.WingPiece.qPerfectionWeld:Destroy()

do
local NEVER_BREAK_JOINTS = false

local function CallOnChildren(Instance, FunctionToCall)
	FunctionToCall(Instance)

	for _, Child in next, Instance:GetChildren() do
		CallOnChildren(Child, FunctionToCall)
	end
end

local function GetBricks(StartInstance)
	local List = {}
	CallOnChildren(StartInstance, function(Item)
		if Item:IsA("BasePart") then
			List[#List+1] = Item;
		end
	end)

	return List
end

local function Modify(Instance, Values)
	assert(type(Values) == "table", "Values is not a table");

	for Index, Value in next, Values do
		if type(Index) == "number" then
			Value.Parent = Instance
		else
			Instance[Index] = Value
		end
	end
	return Instance
end

local function Make(ClassType, Properties)
	return Modify(Instance.new(ClassType), Properties)
end

local Surfaces = {"TopSurface", "BottomSurface", "LeftSurface", "RightSurface", "FrontSurface", "BackSurface"}
local HingSurfaces = {"Hinge", "Motor", "SteppingMotor"}

local function HasWheelJoint(Part)
	for _, SurfaceName in pairs(Surfaces) do
		for _, HingSurfaceName in pairs(HingSurfaces) do
			if Part[SurfaceName].Name == HingSurfaceName then
				return true
			end
		end
	end
	
	return false
end

local function ShouldBreakJoints(Part)
	if NEVER_BREAK_JOINTS then
		return false
	end
	
	if HasWheelJoint(Part) then
		return false
	end
	
	local Connected = Part:GetConnectedParts()
	
	if #Connected == 1 then
		return false
	end
	
	for _, Item in pairs(Connected) do
		if HasWheelJoint(Item) then
			return false
		elseif not Item:IsDescendantOf(script.Parent) then
			return false
		end
	end
	
	return true
end

local function WeldTogether(Part0, Part1, JointType, WeldParent)

	JointType = JointType or "Weld"
	local RelativeValue = Part1:FindFirstChild("qRelativeCFrameWeldValue")
	
	local NewWeld = Part1:FindFirstChild("qCFrameWeldThingy") or Instance.new(JointType)
	Modify(NewWeld, {
		Name = "qCFrameWeldThingy";
		Part0  = Part0;
		Part1  = Part1;
		C0     = CFrame.new();--Part0.CFrame:inverse();
		C1     = RelativeValue and RelativeValue.Value or Part1.CFrame:toObjectSpace(Part0.CFrame); --Part1.CFrame:inverse() * Part0.CFrame;-- Part1.CFrame:inverse();
		Parent = Part1;
	})

	if not RelativeValue then
		RelativeValue = Make("CFrameValue", {
			Parent     = Part1;
			Name       = "qRelativeCFrameWeldValue";
			Archivable = true;
			Value      = NewWeld.C1;
		})
	end

	return NewWeld
end

local function WeldParts(Parts, MainPart, JointType, DoNotUnanchor)

	for _, Part in pairs(Parts) do
		if ShouldBreakJoints(Part) then
			Part:BreakJoints()
		end
	end
	
	for _, Part in pairs(Parts) do
		if Part ~= MainPart then
			WeldTogether(MainPart, Part, JointType, MainPart)
		end
	end

	if not DoNotUnanchor then
		for _, Part in pairs(Parts) do
			Part.Anchored = false
		end
		MainPart.Anchored = false
	end
end

local function PerfectionWeld()	
	local Parts = GetBricks(script.WingPiece)
	WeldParts(Parts, script.WingPiece.Main, "Weld", false)
end
PerfectionWeld()
end
local data = {}

--// Shortcut Variables --
local S = setmetatable({},{__index = function(s,i) return game:service(i) end})
local CF = {N=CFrame.new,A=CFrame.Angles,fEA=CFrame.fromEulerAnglesXYZ}
local C3 = {tRGB= function(c3) return c3.r*255,c3.g*255,c3.b*255 end,N=Color3.new,RGB=Color3.fromRGB,HSV=Color3.fromHSV,tHSV=Color3.toHSV}
local V3 = {N=Vector3.new,FNI=Vector3.FromNormalId,A=Vector3.FromAxis}
local M = {C=math.cos,R=math.rad,S=math.sin,P=math.pi,RNG=math.random,MRS=math.randomseed,H=math.huge,RRNG = function(min,max,div) return math.rad(math.random(min,max)/(div or 1)) end}
local R3 = {N=Region3.new}
local De = S.Debris
local WS = workspace
local Lght = S.Lighting
local RepS = S.ReplicatedStorage
local IN = Instance.new
local Plrs = S.Players
local UIS = S.UserInputService

local Player = game.Players.LocalPlayer
data.User = Player
data.Local = Player
local Char = Player.Character
if _G.permadeath == true then
Char = workspace.non
end
local Mouse = Player:GetMouse()
local Hum = Char:FindFirstChildOfClass'Humanoid'
Hum.Animator:Remove()
local Torso = Char.Torso
local RArm = Char["Right Arm"]
local LArm = Char["Left Arm"]
local RLeg = Char["Right Leg"]
local LLeg = Char["Left Leg"]	
local Root = Char:FindFirstChild'HumanoidRootPart'
local Head = Char.Head
local Sine = 0;
local Change = 1
local Attack=false
local NeutralAnims=true
local timePos=30;
local walking=true;
local legAnims=true;
local movement = 8
local footsound=0;
local WalkSpeed=16;
local Combo=0;
local Mode='Achromatic'
local vaporwaveMode=false;
local WingAnim='NebG1'
local music;
local hue = 0;
local WingSine=0;
local MusicMode=1;
local visSong = 2611335966;
local EffectFolder = script:WaitForChild'FXFolder'
local PrimaryColor = Color3.new(1,1,1)
local ClickTimer = 0;
local ClickAttack = 1;
local camera = workspace.CurrentCamera
local LastSphere = time();
local Frame_Speed = 60
local VaporwaveSongs={
	2231500330;
	654094806;
	743334292;
	334283059;
	2082142910;
}

function MakeForm(PART, TYPE)
	if TYPE == "Cyl" then
		local MSH = IN("CylinderMesh", PART)
	elseif TYPE == "Ball" then
		local MSH = IN("SpecialMesh", PART)
		MSH.MeshType = "Sphere"
	elseif TYPE == "Wedge" then
		local MSH = IN("SpecialMesh", PART)
		MSH.MeshType = "Wedge"
	end
end
BRICKC = BrickColor.new
function CreatePart(FORMFACTOR, PARENT, MATERIAL, REFLECTANCE, TRANSPARENCY, BRICKCOLOR, NAME, SIZE, ANCHOR)
	local NEWPART = IN("Part")
	NEWPART.formFactor = FORMFACTOR
	NEWPART.Reflectance = REFLECTANCE
	NEWPART.Transparency = TRANSPARENCY
	NEWPART.CanCollide = false
	NEWPART.Locked = true
	NEWPART.Anchored = true
	if ANCHOR == false then
		NEWPART.Anchored = false
	end
	NEWPART.BrickColor = BRICKC(tostring(BRICKCOLOR))
	NEWPART.Name = NAME
	NEWPART.Size = SIZE
	NEWPART.Position = Torso.Position
	NEWPART.Material = MATERIAL
	NEWPART:BreakJoints()
	NEWPART.Parent = PARENT
	return NEWPART
end
UD2 = UDim2.new
function CreateLabel(PARENT, TEXT, TEXTCOLOR, TEXTFONTSIZE, TEXTFONT, TRANSPARENCY, BORDERSIZEPIXEL, STROKETRANSPARENCY, NAME)
	local label = IN("TextLabel")
	label.BackgroundTransparency = 1
	label.Size = UD2(1, 0, 1, 0)
	label.Position = UD2(0, 0, 0, 0)
	label.TextColor3 = TEXTCOLOR
	label.TextStrokeTransparency = STROKETRANSPARENCY
	label.TextTransparency = TRANSPARENCY
	label.FontSize = TEXTFONTSIZE
	label.Font = TEXTFONT
	label.BorderSizePixel = BORDERSIZEPIXEL
	label.TextScaled = false
	label.Text = TEXT
	label.Name = NAME
	label.Parent = PARENT
	return label
end
function NoOutlines(PART)
	PART.TopSurface, PART.BottomSurface, PART.LeftSurface, PART.RightSurface, PART.FrontSurface, PART.BackSurface = 10, 10, 10, 10, 10, 10
end
function CreateWeldOrSnapOrMotor(TYPE, PARENT, PART0, PART1, C0, C1)
	local NEWWELD = IN(TYPE)
	NEWWELD.Part0 = PART0
	NEWWELD.Part1 = PART1
	NEWWELD.C0 = C0
	NEWWELD.C1 = C1
	NEWWELD.Parent = PARENT
	return NEWWELD
end

function Weld(part0,part1,c0,c1)
	local weld = IN("Weld")
	weld.Parent = part0
	weld.Part0 = part0
	weld.Part1 = part1
	weld.C0 = c0 or CF.N()
	weld.C1 = c1 or CF.N()
	return weld
end

function WWeld(a, b, acf)
    local we = Instance.new("Weld", a)
    we.Part0 = a
    we.Part1 = b
if acf ~= nil then
    we.C0 = acf
end
return we
end

function SetTween(SPart,CFr,MoveStyle2,outorin2,AnimTime)
local MoveStyle = Enum.EasingStyle[MoveStyle2]
local outorin = Enum.EasingDirection[outorin2]


local dahspeed=1
if Attack == true then
	dahspeed=3 --speedstuff --5
end

if SPart.Name=="Bullet" then
dahspeed=1	
end

local tweeningInformation = TweenInfo.new(
	AnimTime/dahspeed,	
	MoveStyle,
	outorin,
	0,
	false,
	0
)
local MoveCF = CFr
local tweenanim = game:GetService("TweenService"):Create(SPart,tweeningInformation,MoveCF)
tweenanim:Play()
end

local WingPiece = script:WaitForChild'WingPiece'
WingPiece.Parent=nil
local WingAnims={}
local Playlist={
	Default=1702473314;
	ScrapBoy=1215691669;
	Defeated=860594509;
	Annihilate=2116461106;
	DashAndDodge=2699922745;
	ZenWavy=2231500330;
	Beachwalk=334283059;
	Pyrowalk=2082142910;
	Vapor90s=654094806;
}

--[[
Achromatic - The Big Black - Lost Soul
Iniquitous
Mythical - Legendary
Ruined - Th1rt3en
Atramentous - Vanta Black
Subzero - Frostbite
Troubadour
Infectious - Radioactive
Love - Lust
]]

local Create = LoadLibrary("RbxUtility").Create

--2699922745
local val = math.random(1,255)
local color = Color3.fromRGB(val,val,val)

NewInstance = function(instance,parent,properties)
	local inst = Instance.new(instance)
	inst.Parent = parent
	if(properties)then
		for i,v in next, properties do
			pcall(function() inst[i] = v end)
		end
	end
	return inst;
end

function newMotor(P0,P1,C0,C1)
	return NewInstance('Motor',P0,{Part0=P0,Part1=P1,C0=C0,C1=C1})
end

local welds = {}
local WeldDefaults = {}

table.insert(welds,newMotor(Torso,Head,CF.N(0,1.5,0),CF.N()))
table.insert(welds,newMotor(Root,Torso,CF.N(),CF.N()))
table.insert(welds,newMotor(Torso,RLeg,CF.N(.5,-1,0),CF.N(0,1,0)))
table.insert(welds,newMotor(Torso,RArm,CF.N(1.5,.5,0),CF.N(0,.5,0)))
table.insert(welds,newMotor(Torso,LLeg,CF.N(-.5,-1,0),CF.N(0,1,0)))
table.insert(welds,newMotor(Torso,LArm,CF.N(-1.5,.5,0),CF.N(0,.5,0)))

WeldDefaults={}
for i = 1,#welds do
	local v=welds[i]
	WeldDefaults[i]=v.C0
end

local NK,RJ,RH,RS,LH,LS=unpack(welds)

local NKC0,RJC0,RHC0,RSC0,LHC0,LSC0=unpack(WeldDefaults)

function makeMusic(id,pit,timePos)
	local sound = Torso:FindFirstChild("song") or Char:FindFirstChild(script.Name.."song")
	local parent = (MusicMode==2 and Char or Torso)
	if(not sound)then 
		sound = NewInstance("Sound",parent,{Name=script.Name.."song",Volume=(MusicMode==3 and 0 or 1),Pitch=(pit or 1),Looped=true})
		NewInstance("EqualizerSoundEffect",sound,{HighGain=0,MidGain=2,LowGain=10})
	end
	if(id=='stop')then
		if(sound)then
			sound:Stop()
		end
	else
		local timePos = typeof(timePos)=='number' and timePos or sound.TimePosition
		sound.Volume = (MusicMode==3 and 0 or 1)
		sound.Name = "song"
		sound.MaxDistance = 179769313486231570814527423731704356798070567525844996598917476803157260780028538760589558632766878171540458953514382464234321326889464182768467546703537516986049910576551282076245490090389328944075868508455133942304583236903222948165808559332123348274797826204144723168738177180919299881250404026184124858368
		sound.EmitterSize = 179769313486231570814527423731704356798070567525844996598917476803157260780028538760589558632766878171540458953514382464234321326889464182768467546703537516986049910576551282076245490090389328944075868508455133942304583236903222948165808559332123348274797826204144723168738177180919299881250404026184124858368
		sound.Looped=true
		sound.SoundId = "rbxassetid://"..id
		sound.Pitch=(pit or 1)
		sound:Play()
		sound.TimePosition = timePos
	end
	return sound;
end

function playMusic(id,pitch,timePos)
		return makeMusic(id,pitch,timePos)
end

for _,v in next, Hum:GetPlayingAnimationTracks() do
	v:Stop(0);
end

-- SCRIPT STUFF --
local Frame_Speed = 60 -- The frame speed for swait. 1 is automatically divided by this
--// Artificial HB --

local ArtificialHB = script:FindFirstChild'Heartbeat' or IN("BindableEvent", script)
ArtificialHB.Name = "Heartbeat"

local tf = 0
local allowframeloss = true
local tossremainder = true
local lastframe = tick()
local frame = 1/Frame_Speed
ArtificialHB:Fire()

game:GetService("RunService").Stepped:connect(function(s, p)
	tf = tf + s
	if tf >= frame then
		if allowframeloss then
			ArtificialHB:Fire()
			lastframe = tick()
		else
			for i = 1, math.floor(tf / frame) do
				ArtificialHB:Fire()
			end
			lastframe = tick()
		end
		if tossremainder then
			tf = 0
		else
			tf = tf - frame * math.floor(tf / frame)
		end
	end
end)

function swait(num)
	if num == 0 or num == nil then
		ArtificialHB.Event:wait()
	else
		for i = 0, num do
			ArtificialHB.Event:wait()
		end
	end
end

-------- RAINBOW LEAVE IT TO ME
local r = 255
local g = 0
local b = 0
coroutine.resume(coroutine.create(function()
while wait() do
    for i = 0, 254/5 do
        swait()
        g = g + 5
    end
    for i = 0, 254/5 do
        swait()
        r = r - 5
    end
    for i = 0, 254/5 do
        swait()
        b = b + 5
    end
    for i = 0, 254/5 do
        swait()
        g = g - 5
    end
    for i = 0, 254/5 do
        swait()
        r = r + 5
    end
    for i = 0, 254/5 do
        swait()
        b = b - 5
    end
end
end))

local val = math.random(1,255)
local color = Color3.fromRGB(val,val,val)
local CLOCKLOOP = 0
local CLOCKSPEED = 1
local VALUE1 = false
local VALUE2 = false

local modeInfo={
	{Name="Achromatic",Walkspeed=16,moveVal=8,Font=Enum.Font.Arcade,StrokeColor=C3.N(.5,.5,.5);Music=2533527428,LeftWing={0,BrickColor.new'White'.Color,Enum.Material.Neon};RightWing={0,BrickColor.new'White'.Color,Enum.Material.Neon};WingAnim='NebG1'};
	{Name="Iniquitous",Walkspeed=16,moveVal=8,Font=Enum.Font.Garamond,StrokeColor=C3.N(.2,.2,.2);Music=2656505560,LeftWing={0,BrickColor.new'Black'.Color,Enum.Material.Neon};RightWing={0,BrickColor.new'Black'.Color,Enum.Material.Neon};WingAnim='NebG1'};
	{Name="Divinity",Walkspeed=16,moveVal=8,Font=Enum.Font.Garamond,StrokeColor=C3.N(.2,.2,.2);Music=2656505560,LeftWing={0,BrickColor.new'Bright yellow0'.Color,Enum.Material.Neon};RightWing={0,BrickColor.new'Bright yellow'.Color,Enum.Material.Neon};WingAnim='NebG1'};
	{Name="Mythical",Walkspeed=16,moveVal=8,Font=Enum.Font.Fantasy,StrokeColor=C3.N(.6,.0,.9);Music=556122490,LeftWing={0,BrickColor.new'Alder'.Color,Enum.Material.Neon};RightWing={0,BrickColor.new'Alder'.Color,Enum.Material.Neon};WingAnim='StarG'};
	{Name="Ruined",Walkspeed=16,moveVal=8,Font=Enum.Font.Arcade,StrokeColor=C3.N(0,0,0);Music=2297862957,LeftWing={0,Color3.fromRGB(190,104,98),Enum.Material.Neon};RightWing={0,BrickColor.new'Black'.Color,Enum.Material.Neon};WingAnim='Aprins'};
	{Name="Atramentous",Walkspeed=14,moveVal=8,Font=Enum.Font.Garamond,StrokeColor=C3.N(.1,.1,.1);Music=924339757,LeftWing={0,BrickColor.new'Dark stone grey'.Color,Enum.Material.Neon};RightWing={0,BrickColor.new'Really black'.Color,Enum.Material.Neon};WingAnim={'NebG3',2}};
	{Name="Subzero",Walkspeed=10,moveVal=6,Font=Enum.Font.Gotham,StrokeColor=C3.RGB(0,190,190);Music=144121562,LeftWing={0,BrickColor.new'Pastel light blue'.Color,Enum.Material.Neon};RightWing={0,BrickColor.new'Pastel light blue'.Color,Enum.Material.Neon};WingAnim='NebG1'};	
	{Name="Troubadour",Walkspeed=16,moveVal=8,Font=Enum.Font.Arcade,StrokeColor=C3.N(.5,.5,.5);Music=visSong,LeftWing={0,BrickColor.new'White'.Color,Enum.Material.Neon};RightWing={0,BrickColor.new'White'.Color,Enum.Material.Neon};WingAnim='StarG'};
	{Name="Infectious",Walkspeed=16,moveVal=8,Font=Enum.Font.Gotham,StrokeColor=C3.RGB(98,37,209);Music=927739239,LeftWing={0,BrickColor.new'Dark indigo'.Color,Enum.Material.Neon};RightWing={0,BrickColor.new'Dark indigo'.Color,Enum.Material.Neon};WingAnim='NebG1'};	
	{Name="FANTASTIC NINJA",Walkspeed=16,moveVal=8,Font=Enum.Font.Gotham,StrokeColor=C3.RGB(17,17,17);Music=1832210197,LeftWing={0,BrickColor.new'New Yeller'.Color,Enum.Material.Neon};RightWing={0,BrickColor.new'Really black'.Color,Enum.Material.Neon};WingAnim='StarG'};	
	{Name="Love",Walkspeed=16,moveVal=8,Font=Enum.Font.Arcade,StrokeColor=C3.RGB(255,152,220);Music=1030177093,LeftWing={0,BrickColor.new'Pink'.Color,Enum.Material.Neon};RightWing={0,BrickColor.new'Pink'.Color,Enum.Material.Neon};WingAnim='StarG'};
	{Name="Solitude",Walkspeed=16,moveVal=8,Font=Enum.Font.Arcade,StrokeColor=C3.N(1,1,1);Music=1564523997,LeftWing={0,BrickColor.new'Really black'.Color,Enum.Material.Neon};RightWing={0,BrickColor.new'Really black'.Color,Enum.Material.Neon};WingAnim='NebG1'};
	{Name="Sin",Walkspeed=16,moveVal=8,Font=Enum.Font.Garamond,StrokeColor=C3.N(0,0,0);Music=2557672037,LeftWing={0,BrickColor.new'Really black'.Color,Enum.Material.Neon};RightWing={0,BrickColor.new'Really red'.Color,Enum.Material.Neon};WingAnim='NebG1'};
	{Name="Purity",Walkspeed=16,moveVal=8,Font=Enum.Font.Fantasy,StrokeColor=Color3.new(0,1,1);Music=1539245059,LeftWing={0,BrickColor.new'Toothpaste'.Color,Enum.Material.Neon};RightWing={0,BrickColor.new'Toothpaste'.Color,Enum.Material.Neon};WingAnim='StarG'};
	{Name="Justice",Walkspeed=64,moveVal=8,Font=Enum.Font.Garamond,StrokeColor=C3.N(.5,.5,.5);Music=1102271169,LeftWing={0,BrickColor.new'White'.Color,Enum.Material.Neon};RightWing={0,BrickColor.new'White'.Color,Enum.Material.Neon};WingAnim={'NebG2',10}};
	{Name="Radioactive",Walkspeed=64,moveVal=8,Font=Enum.Font.Garamond,StrokeColor=C3.N(.5,.5,.5);Music=411040482,LeftWing={0,BrickColor.new'Lime green'.Color,Enum.Material.Neon};RightWing={0,BrickColor.new'Lime green'.Color,Enum.Material.Neon};WingAnim={'NebG2',10}};
	{Name="CALAMITY",Walkspeed=64,moveVal=6,Font=Enum.Font.Gotham,StrokeColor=Color3.new(0.25,0,1);Music=1359036559,LeftWing={0,BrickColor.new'Bright violet'.Color,Enum.Material.Neon};RightWing={0,BrickColor.new'Bright violet'.Color,Enum.Material.Neon};WingAnim='NebG1'};	
	{Name="Glitchy",Walkspeed=16,moveVal=8,Font=Enum.Font.Arcade,StrokeColor=color;Music=195916147,LeftWing={0,color,Enum.Material.Neon};RightWing={0,color,Enum.Material.Neon};WingAnim='StarG'};
	{Name="RAINBOW",Walkspeed=64,moveVal=20,Font=Enum.Font.Arcade,StrokeColor=Color3.new(r/255,g/255,b/255);Music=147930134,LeftWing={0,Color3.new(r/255,g/255,b/255),Enum.Material.Neon};RightWing={0,Color3.new(r/255,g/255,b/255),Enum.Material.Neon};WingAnim='StarG'};
	{Name="Time",Walkspeed=16,moveVal=8,Font=Enum.Font.Arcade,StrokeColor=BrickColor.new("Artichoke").Color;Music=2083683898,LeftWing={0,BrickColor.new("Artichoke").Color,Enum.Material.Neon};RightWing={0,BrickColor.new("Artichoke").Color,Enum.Material.Neon};WingAnim='NebG1'};

	--MAJORS--
	{Name="The Big Black",Walkspeed=64,moveVal=20,Font=Enum.Font.Arcade,StrokeColor=C3.N(.2,.2,.2);Music=183142252,LeftWing={0,BrickColor.new'Really black'.Color,Enum.Material.Neon};RightWing={0,BrickColor.new'Dark stone grey'.Color,Enum.Material.Neon};WingAnim={'NebG3',10}};
	{Name="Legendary",Walkspeed=64,moveVal=20,Font=Enum.Font.Gotham,StrokeColor=C3.N(.4,.4,0);Music=468018712,LeftWing={0,BrickColor.new'Gold'.Color,Enum.Material.Neon};RightWing={0,BrickColor.new'Gold'.Color,Enum.Material.Neon};WingAnim={'NebG2',10}};
	{Name="Lust",Walkspeed=64,moveVal=8,Font=Enum.Font.Fantasy,StrokeColor=C3.N(1,0,1);Music=391089144,LeftWing={0,BrickColor.new'Hot pink'.Color,Enum.Material.Neon};RightWing={0,BrickColor.new'Hot pink'.Color,Enum.Material.Neon};WingAnim='LustFrench'};

}

function clerp(a,b,t)
    return a:lerp(b,t)
end

--// Effects --

function Tween(obj,props,time,easing,direction,repeats,backwards)
	local info = TweenInfo.new(time or .5, easing or Enum.EasingStyle.Quad, direction or Enum.EasingDirection.Out, repeats or 0, backwards or false)
	local tween = S.TweenService:Create(obj, info, props)
	
	tween:Play()
end


function StartShake(Settings)
	return true
end

function Camshake(shakedata)
	StartShake(shakedata)
end

if(workspace:FindFirstChild(script.Name..'Effects'))then
	workspace[script.Name..'Effects']:destroy()
end

local Effects=NewInstance("Folder",Char)
Effects.Name=script.Name..'Effects'


function ShowDamage(Pos, Text, Time, Color)
	local Pos = Pos or V3.N(0, 0, 0)
	local Text = tostring(Text or "")
	local Time = Time or 2
	local Color = Color or C3.N(1, 0, 1)
	local EffectPart = Part(Effects,Color,Enum.Material.SmoothPlastic,V3.N(.05,.05,.05),CFrame.new(Pos),true,false)
	EffectPart.Transparency=1
	local BillboardGui = NewInstance("BillboardGui",EffectPart,{
		Size = UDim2.new(3,0,3,0),
		Adornee = EffectPart,
	})
	
	local TextLabel = NewInstance("TextLabel",BillboardGui,{
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 1, 0),
		Text = Text,
		TextColor3 = Color,
		TextScaled = true,
		Font = Enum.Font.ArialBold, 
	})
	S.Debris:AddItem(EffectPart, Time+.5)
	delay(0, function()
		local rot=math.random(-10,10)/15
		local raise=.2
		local Frames = Time/Frame_Speed
		for i=0,1.1,.02 do
			swait()
			TextLabel.Rotation=TextLabel.Rotation+rot
			raise=raise-.008
			EffectPart.Position = EffectPart.Position + Vector3.new(0, raise, 0)
			TextLabel.TextTransparency=i
			TextLabel.TextStrokeTransparency=i
		end
		if EffectPart and EffectPart.Parent then
			EffectPart:Destroy()
		end
	end)
end

local baseSound = IN("Sound")

function Soond(parent,id,pitch,volume,looped,effect,autoPlay)
	local Sound = baseSound:Clone()
	Sound.SoundId = "rbxassetid://".. tostring(id or 0)
	Sound.Pitch = pitch or 1
	Sound.Volume = volume or 1
	Sound.Looped = looped or false
	if(autoPlay)then
		coroutine.wrap(function()
			repeat wait() until Sound.IsLoaded
			Sound.Playing = autoPlay or false
		end)()
	end
	if(not looped and effect)then
		Sound.Stopped:connect(function()
			Sound.Volume = 0
			Sound:destroy()
		end)
	elseif(effect)then
		warn("Sound can't be looped and a sound effect!")
	end
	Sound.Parent =parent or Torso
	return Sound
end
	
function SoondPart(id,pitch,volume,looped,effect,autoPlay,cf)
	local soundPart = NewInstance("Part",Effects,{Transparency=1,CFrame=cf or Torso.CFrame,Anchored=true,CanCollide=false,Size=V3.N()})
	local Sound = IN("Sound")
	Sound.SoundId = "rbxassetid://".. tostring(id or 0)
	Sound.Pitch = pitch or 1
	Sound.Volume = volume or 1
	Sound.Looped = looped or false
	if(autoPlay)then
		coroutine.wrap(function()
			repeat wait() until Sound.IsLoaded
			Sound.Playing = autoPlay or false
		end)()
	end
	if(not looped and effect)then
		Sound.Stopped:connect(function()
			Sound.Volume = 0
			soundPart:destroy()
		end)
	elseif(effect)then
		warn("Sound can't be looped and a sound effect!")
	end
	Sound.Parent = soundPart
	return Sound,soundPart
end

function SoundPart(...)
		return SoondPart(...)
end

function Sound(...)
		return Soond(...)
end
	
function Part(parent,color,material,size,cframe,anchored,cancollide)
	local part = IN("Part")
	part.Parent = parent or Char
	part[typeof(color) == 'BrickColor' and 'BrickColor' or 'Color'] = color or C3.N(0,0,0)
	part.Material = material or Enum.Material.SmoothPlastic
	part.TopSurface,part.BottomSurface=10,10
	part.Size = size or V3.N(1,1,1)
	part.CFrame = cframe or CF.N(0,0,0)
	part.CanCollide = cancollide or false
	part.Anchored = anchored or false
	return part
end

function Mesh(parent,meshtype,meshid,textid,scale,offset)
	local part = IN("SpecialMesh")
	part.MeshId = meshid or ""
	part.TextureId = textid or ""
	part.Scale = scale or V3.N(1,1,1)
	part.Offset = offset or V3.N(0,0,0)
	part.MeshType = meshtype or Enum.MeshType.Sphere
	part.Parent = parent
	return part
end

function GotEffect(data)
	-- just for easy reference
	local color = data.Color or Color3.new(.7,.7,.7);
	local endcolor = data.EndColor or nil;
	local mat = data.Material or Enum.Material.SmoothPlastic;
	local cframe = data.CFrame or CFrame.new();
	local endpos = data.EndPos or nil;
	local meshdata = data.Mesh or {}
	local sounddata = data.Sound or {}
	local size = data.Size or Vector3.new(1,1,1)
	local endsize = data.EndSize or Vector3.new(6,6,6)
	local rotinc = data.RotInc or {0,0,0} -- ONLY FOR LEGACY SYSTEM
	local transparency = data.Transparency or NumberRange.new(0,1)
	local acceleration = data.Acceleration or nil; -- ONLY FOR LEGACY SYSTEM
	local endrot = data.EndRotation or {0,0,0} -- ONLY FOR EXPERIMENTAL SYSTEM
	local style = data.Style or false; -- ONLY FOR EXPERIMENTAL SYSTEM
	local lifetime = data.Lifetime or 1;
	local system = data.FXSystem;
	local setpart = typeof(data.Part)=='string' and EffectFolder:FindFirstChild(tostring(data.Part)):Clone() or typeof(data.Part)=='Instance' and data.Part or nil
	
	local S,PM;
	
	local P = setpart or Part(Effects,color,mat,Vector3.new(1,1,1),cframe,true,false)
	
	if(not P:IsA'MeshPart' and not P:IsA'UnionOperation')then
		if(meshdata == "Blast")then
			PM = Mesh(P,Enum.MeshType.FileMesh,'rbxassetid://20329976','',size,Vector3.new(0,0,-size.X/8),Vector3.new(0, 0, -2.3))
		elseif(meshdata == 'Ring')then
			PM = Mesh(P,Enum.MeshType.FileMesh,'rbxassetid://559831844','',size,Vector3.new(0,0,0))
		elseif(meshdata == 'Cylinder')then
			PM = Mesh(P,Enum.MeshType.FileMesh,'rbxassetid://471113192','',size,Vector3.new(0,0,0))
		elseif(meshdata == 'Slash1')then
			PM = Mesh(P,Enum.MeshType.FileMesh,'rbxassetid://662586858','',Vector3.new(size.X/10,.001,size.Z/10),Vector3.new(0,0,0))
		elseif(meshdata == 'Slash2')then
			PM = Mesh(P,Enum.MeshType.FileMesh,'rbxassetid://448386996','',Vector3.new(size.X/1000,size.Y/100,size.Z/100),Vector3.new(0,0,0))
		elseif(meshdata == 'Tornado1')then
			PM = Mesh(P,Enum.MeshType.FileMesh,'rbxassetid://443529437','',size/10,Vector3.new(0,0,0))
		elseif(meshdata == 'Tornado2')then
			PM = Mesh(P,Enum.MeshType.FileMesh,'rbxassetid://168892432','',size/4,Vector3.new(0,0,0))
		elseif(meshdata == 'Skull')then
			PM = Mesh(P,Enum.MeshType.FileMesh,'rbxassetid://4770583','',size*2,Vector3.new(0,0,0))
		elseif(meshdata == 'Crystal')then
			PM = Mesh(P,Enum.MeshType.FileMesh,'rbxassetid://9756362','',size,Vector3.new(0,0,0))
		elseif(meshdata == 'Cloud')then
			PM = Mesh(P,Enum.MeshType.FileMesh,'rbxassetid://1095708','',size,Vector3.new(0,0,0))
		elseif(typeof(meshdata) == 'table')then
			local Type = meshdata.Type or Enum.MeshType.Brick
			local ID = meshdata.ID or '';
			local Tex = meshdata.Texture or '';
			local Offset = meshdata.Offset or Vector3.new(0,0,0)
			PM = Mesh(P,Type,ID,Tex,size,Offset)
		else
			PM = Mesh(P,Enum.MeshType.Brick,'','',size)
		end
	end
	local startTrans = typeof(transparency) == 'number' and transparency or typeof(transparency) == 'NumberRange' and transparency.Min or typeof(transparency) == 'table' and transparency[1] or 0
	local endTrans = typeof(transparency) == 'NumberRange' and transparency.Max or typeof(transparency) == 'table' and transparency[2] or 1
	if(data.Part == "CylWav")then
		for i,v in pairs(P:GetDescendants()) do
			if v:IsA("MeshPart") then
				v.Transparency = startTrans
			end
		end
	end
	P.Material = mat
	P.CFrame = cframe
	P.Color = (typeof(color)=='BrickColor' and color.Color or color)
	P.Anchored = true
	P.CanCollide = false
	P.Transparency = startTrans
	P.Parent = Effects
	local random = Random.new();
	game:service'Debris':AddItem(P,lifetime+3)
	
	
	-- actual effect stuff
	local mult = 1;
	if(PM)then
		if(PM.MeshId == 'rbxassetid://20329976')then
			PM.Offset = Vector3.new(0,0,-PM.Scale.Z/8)
		elseif(PM.MeshId == 'rbxassetid://4770583')then
			mult = 2
		elseif(PM.MeshId == 'rbxassetid://168892432')then
			mult = .25
		elseif(PM.MeshId == 'rbxassetid://443529437')then
			mult = .1
		elseif(PM.MeshId == 'rbxassetid://443529437')then
			mult = .1
		end
	end	
	coroutine.wrap(function()
		if(system == 'Legacy' or system == 1 or system == nil)then
			local frames = (typeof(lifetime) == 'NumberRange' and random:NextNumber(lifetime.Min,lifetime.Max) or typeof(lifetime) == 'number' and lifetime or 1)*Frame_Speed
			for i = 0, frames do
				local div = (i/frames)
				P.Transparency=(startTrans+(endTrans-startTrans)*div)
				if(data.Part == "CylWav")then
				  for i,v in pairs(P:GetDescendants()) do
				    if v:IsA("MeshPart") then
				       v.Transparency = (startTrans+(endTrans-startTrans)*div)
				    end
				  end
				end
				if(PM)then PM.Scale = size:lerp(endsize*mult,div) else P.Size = size:lerp(endsize*mult,div) end
				
				local RotCF=CFrame.Angles(0,0,0)
				
				if(rotinc == 'random')then
					RotCF=CFrame.Angles(math.rad(random:NextNumber(-180,180)),math.rad(random:NextNumber(-180,180)),math.rad(random:NextNumber(-180,180)))
				elseif(typeof(rotinc) == 'table')then
					RotCF=CFrame.Angles(unpack(rotinc))
				end
				
				if(PM and PM.MeshId == 'rbxassetid://20329976')then
					PM.Offset = Vector3.new(0,0,-PM.Scale.Z/8)
				end
				
				if(endpos and typeof(endpos) == 'CFrame')then
					P.CFrame=cframe:lerp(endpos,div)*RotCF
				elseif(acceleration and typeof(acceleration) == 'table' and acceleration.Force)then
					local force = acceleration.Force;
					if(typeof(force)=='CFrame')then
						force=force.p;
					end
					if(typeof(force)=='Vector3')then
						if(acceleration.LookAt)then
							P.CFrame=(CFrame.new(P.Position,force)+force)*RotCF
						else
							P.CFrame=(P.CFrame+force)*RotCF
						end
					end
				else
					P.CFrame=P.CFrame*RotCF
				end
				
				if(endcolor and typeof(endcolor) == 'Color3')then
					P.Color = color:lerp(endcolor,div)
				end
				swait()
			end
			P:destroy()
		elseif(system == 'Experimental' or system == 2)then
			local info = TweenInfo.new(lifetime,style,Enum.EasingDirection.InOut,0,false,0)
			local info2 = TweenInfo.new(lifetime,Enum.EasingStyle.Linear,Enum.EasingDirection.InOut,0,false,0)
			if(style == Enum.EasingStyle.Elastic)then
				info = TweenInfo.new(lifetime*2,style,Enum.EasingDirection.Out,0,false,0)
			elseif(style == Enum.EasingStyle.Bounce)then
				info = TweenInfo.new(lifetime,style,Enum.EasingDirection.Out,0,false,0)
			end
			local tweenPart = game:service'TweenService':Create(P,info2,{
				CFrame=(typeof(endpos) == 'CFrame' and endpos or P.CFrame)*CFrame.Angles(unpack(endrot)),
				Color=typeof(endcolor) == 'Color3' and endcolor or color,
				Transparency=endTrans,
			})
			local off = Vector3.new(0,0,0)
			if(PM.MeshId == 'rbxassetid://20329976')then off=Vector3.new(0,0,(endsize*mult).Z/8) end
			
			local tweenMesh = game:service'TweenService':Create(PM,info,{
				Scale=endsize*mult,
				Offset=off,
			})
			tweenPart:Play()
			tweenMesh:Play()
		end
	end)()
end

function Tween(obj,props,time,easing,direction,repeats,backwards)
	local info = TweenInfo.new(time or .5, easing or Enum.EasingStyle.Quad, direction or Enum.EasingDirection.Out, repeats or 0, backwards or false)
	local tween = S.TweenService:Create(obj, info, props)
	
	tween:Play()
end

local EffectInfo={}
function LMDEffect(data)
	local color = data.Color or Color3.new(1,1,1);
	local transparency = data.Transparency or {0,1}
	local lifetime = data.Lifetime or 1
	local cframe = data.CFrame or CFrame.new(0,10,0)
	local acceleration = data.Acceleration or Vector3.new(0,0,0)
	local endpos = data.EndPos or nil
	local rotation = data.Rotation or {0,0,0}
	local meshData = data.Mesh or {Type=Enum.MeshType.Brick}
	local size = data.Size or Vector3.new(1,1,1)
	local material = data.Material or Enum.Material.Neon
	local setpart = typeof(data.Part)=='string' and Folda:FindFirstChild(tostring(data.Part)):Clone() or typeof(data.Part)=='Instance' and data.Part or nil
	local endSize = data.EndSize or nil
	local drag = data.Drag or 0
	local sizeTween = data.TweenSize;
	local moveTween = data.TweenPos;
	local transTween = data.TweenTrans;
	local accelTween = data.TweenAccel;
	local parent = data.Parent or Effects
	if(endSize and typeof(size)=='Vector3')then size={size,endSize} end
	
	if(typeof(size)=='Vector3')then
		size={size,size}
	end
	
	if(typeof(transparency)=='number')then
		transparency={transparency,transparency}
	end
	
	if(typeof(color)=='BrickColor')then
		color=color.Color
	end
	
	local PM;
	
	local part = setpart or Part(parent,color,material,V3.N(1,1,1),cframe,true,false)
	if(not part:IsA'MeshPart' and not part:IsA'UnionOperation')then
		local scale = size[1]
		if(meshData == "Blast")then
			PM = Mesh(part,Enum.MeshType.FileMesh,'rbxassetid://20329976','',scale,Vector3.new(0,0,-scale.X/8))
		elseif(meshData == 'Ring')then
			PM = Mesh(part,Enum.MeshType.FileMesh,'rbxassetid://559831844','',scale,Vector3.new(0,0,0))
		elseif(meshData == 'Slash1')then
			PM = Mesh(part,Enum.MeshType.FileMesh,'rbxassetid://662586858','',Vector3.new(scale.X/10,.001,scale.Z/10),Vector3.new(0,0,0))
		elseif(meshData == 'Slash2')then
			PM = Mesh(part,Enum.MeshType.FileMesh,'rbxassetid://448386996','',Vector3.new(scale.X/1000,scale.Y/100,scale.Z/100),Vector3.new(0,0,0))
		elseif(meshData == 'Tornado1')then
			PM = Mesh(part,Enum.MeshType.FileMesh,'rbxassetid://443529437','',scale/10,Vector3.new(0,0,0))
		elseif(meshData == 'Tornado2')then
			PM = Mesh(part,Enum.MeshType.FileMesh,'rbxassetid://168892432','',scale/4,Vector3.new(0,0,0))
		elseif(meshData == 'Skull')then
			PM = Mesh(part,Enum.MeshType.FileMesh,'rbxassetid://4770583','',scale*2,Vector3.new(0,0,0))
		elseif(meshData == 'Crystal')then
			PM = Mesh(part,Enum.MeshType.FileMesh,'rbxassetid://9756362','',scale,Vector3.new(0,0,0))
		elseif(meshData == 'Cloud')then
			PM = Mesh(part,Enum.MeshType.FileMesh,'rbxassetid://1095708','',scale,Vector3.new(0,0,0))
		elseif(typeof(meshData) == 'table' or typeof(meshData) == 'Instance')then
			local Type = meshData.MeshType or meshData.Type or Enum.MeshType.Brick
			local ID = meshData.MeshId or meshData.Mesh or '';
			local Tex = meshData.TextureId or meshData.Texture or '';
			local Offset = meshData.Offset or Vector3.new(0,0,0)
			PM = Mesh(part,Type,ID,Tex,scale,Offset)
		elseif(not part:FindFirstChildOfClass('DataModelMesh'))then
			PM = Mesh(part,Enum.MeshType.Brick,'','',scale)
		else
			PM = part:FindFirstChildOfClass('DataModelMesh')
		end
	end
	
	part.Material = material
	part.CFrame = cframe
	part.Color = color
	part.Anchored = true
	part.CanCollide = false
	part.Transparency = transparency[1]
	part.Size = (PM and V3.N(1,1,1) or size[1])
	part.Parent = parent
	
	local start = tick()
	local t0 = tick()
	local t01 = tick()
	local lastTrans='Nil';
	local lastSize='Nil';
	local lastColor='Nil';
	local info = {start,lifetime,t0,transTween,sizeTween,moveTween,accelTween,color,transparency,size,part,PM,rotation,acceleration,endpos,cframe,drag,acceleration}
	table.insert(EffectInfo,info)
end

coroutine.wrap(function()
	while true do
		swait()
		for i,v in next, EffectInfo do
			local start,lifetime,t0,transTween,sizeTween,moveTween,accelTween,color,transparency,size,part,mesh,rotation,acceleration,endpos,cframe,drag,startacc=unpack(v)
			local elapsed = tick()-start
			local left = elapsed/lifetime
			local dt = tick()-t0
			t0 = tick()
			if(mesh)then
				mesh.Scale = size[1]:lerp(size[2],(sizeTween and sizeTween(elapsed,0,1,lifetime) or left))
			else
				part.Size = size[1]:lerp(size[2],(sizeTween and sizeTween(elapsed,0,1,lifetime) or left))
			end
			
			local newRot={0,0,0}
			if(rotation=='random')then
				newRot={M.R(M.RNG(0,360)),M.R(M.RNG(0,360)),M.R(M.RNG(0,360))}
			elseif(typeof(rotation)=='table')then
				local x,y,z=M.R(rotation[1]),M.R(rotation[2]),M.R(rotation[3])
				if(rotation[1]==0)then x=0 end
				if(rotation[2]==0)then y=0 end
				if(rotation[3]==0)then z=0 end
				newRot={x,y,z}
			end
			
			local accelMult=(accelTween and 1-accelTween(elapsed,0,1,lifetime) or 1)

			local accel=(acceleration*dt)
			if(endpos)then
				part.CFrame = cframe:lerp(endpos,(moveTween and moveTween(elapsed,0,1,lifetime) or left))
			elseif(accel and (accel.x~=0 or accel.y~=0 or accel.z~=0))then
				part.CFrame = part.CFrame*CF.A(unpack(newRot))+(accel*accelMult)
			elseif(newRot and (newRot[1]~=0 or newRot[2]~=0 or newRot[3]~=0))then
				part.CFrame = part.CFrame*CF.A(unpack(newRot))
			end
			if(drag>0)then
				acceleration=acceleration-V3.N(
					0.05*startacc.x/(drag/1.5),
					0.05*startacc.y/(drag/1.5),
					0.05*startacc.z/(drag/1.5)
				)
			end
			if(elapsed>lifetime)then
				part:destroy()
				EffectInfo[i]=nil
			else
				EffectInfo[i]={start,lifetime,t0,transTween,sizeTween,moveTween,accelTween,color,transparency,size,part,mesh,rotation,acceleration,endpos,cframe,drag,startacc}
			end
		end
	end
end)()

function Effect(edata)
		GotEffect(edata)
end

function Effect2(edata)
		LMDEffect(edata)
end

function Trail(data)
	coroutine.wrap(function()
		data.Frames = typeof(data.Frames)=='number' and data.Frames or 60
		data.CFrame = typeof(data.CFrame)=='CFrame' and data.CFrame or Root.CFrame
		local ep = typeof(data.EndPos)=='CFrame' and data.EndPos or data.CFrame*CFrame.new(0,5,0);
		data.EndPos=nil
		local trailPart = Part(Effects,BrickColor.new'White',Enum.Material.SmoothPlastic,V3.N(.05,.05,.05),data.CFrame,true,false)
		trailPart.Transparency=1
		local start = data.CFrame
		for i = 1, data.Frames do
			trailPart.CFrame = start:lerp(ep,i/data.Frames)
			data.CFrame = trailPart.CFrame
			Effect(data)
			swait()
		end	
	end)()
end

function ClientTrail(data)
	coroutine.wrap(function()
		data.Frames = typeof(data.Frames)=='number' and data.Frames or 60
		data.CFrame = typeof(data.CFrame)=='CFrame' and data.CFrame or Root.CFrame
		local ep = typeof(data.EndPos)=='CFrame' and data.EndPos or data.CFrame*CFrame.new(0,5,0);
		data.EndPos=nil
		local trailPart = Part(Effects,BrickColor.new'White',Enum.Material.SmoothPlastic,V3.N(.05,.05,.05),data.CFrame,true,false)
		trailPart.Transparency=1
		local start = data.CFrame
		for i = 1, data.Frames do
			trailPart.CFrame = start:lerp(ep,i/data.Frames)
			data.CFrame = trailPart.CFrame
			GotEffect(data)
			swait()
		end	
	end)()
end

if(Char:FindFirstChild('NGRWings'..script.Name))then
	Char['NGRWings'..script.Name]:destroy()
end

for _,v in next, Char:children() do
	if(v.Name:lower():find'wings')then
		v:destroy()
	end
end

local wingModel = Instance.new("Model",Char)
wingModel.Name="NGRWings"..script.Name
local rightWing = NewInstance("Model",wingModel,{Name='Right'})
local leftWing = NewInstance("Model",wingModel,{Name='Left'})

local LWP1 = WingPiece:Clone();
LWP1.Parent = leftWing
local LWP2 = WingPiece:Clone();
LWP2.Parent = leftWing
local LWP3 = WingPiece:Clone();
LWP3.Parent = leftWing
local RWP1 = WingPiece:Clone();
RWP1.Parent = rightWing
local RWP2 = WingPiece:Clone();
RWP2.Parent = rightWing
local RWP3 = WingPiece:Clone();
RWP3.Parent = rightWing

local LWP1W=Weld(LWP1.PrimaryPart,Torso,CF.N(2,-2,-1)*CF.A(0,0,0))
local LWP2W=Weld(LWP2.PrimaryPart,Torso,CF.N(4.25,-1,-1)*CF.A(0,0,M.R(15)))
local LWP3W=Weld(LWP3.PrimaryPart,Torso,CF.N(6.5,.5,-1)*CF.A(0,0,M.R(30)))
local RWP1W=Weld(RWP1.PrimaryPart,Torso,CF.N(-2,-2,-1)*CF.A(0,0,0))
local RWP2W=Weld(RWP2.PrimaryPart,Torso,CF.N(-4.25,-1,-1)*CF.A(0,0,M.R(-15)))
local RWP3W=Weld(RWP3.PrimaryPart,Torso,CF.N(-6.5,.5,-1)*CF.A(0,0,M.R(-30)))

local MPASword = {}
for _,v in pairs(Char:GetChildren()) do
	if v:IsA("Accessory") and v.Name:find("MeshPartAccessory") and v.Handle.Size == Vector3.new(4,4,1) then
		table.insert(MPASword,v)
	end
end

local function align(part0, part1)
	local attachment0 = Instance.new("Attachment", part0)
	attachment0.Position = Vector3.new(1.3, 1.3, 0) --Custom Positioning Values Here
	attachment0.Rotation = Vector3.new(0,0,-45) --Custom Rotationing Values here
	local attachment1 = Instance.new("Attachment", part1)
	local weldpos = Instance.new("AlignPosition", part0)
	weldpos.Attachment0 = attachment0
	weldpos.Attachment1 = attachment1
	weldpos.RigidityEnabled = true
	weldpos.ReactionForceEnabled = false
	weldpos.ApplyAtCenterOfMass = false
	weldpos.MaxForce = 20000
	weldpos.MaxVelocity = math.huge
	weldpos.Responsiveness = 200000
	local weldrot = Instance.new("AlignOrientation", part0)
	weldrot.RigidityEnabled = true
	weldrot.Attachment0 = attachment0
	weldrot.Attachment1 = attachment1
	weldrot.ReactionTorqueEnabled = false
	weldrot.PrimaryAxisOnly = false
	weldrot.MaxTorque = 20000
	weldrot.MaxAngularVelocity = math.huge
	weldrot.Responsiveness = 200000
end

local JumpPart = Instance.new("Part",Char)
JumpPart.CanCollide = false
JumpPart.Transparency = 1
align(JumpPart,Torso)
JumpPart.Attachment.Position = Vector3.new(0,1,0)
JumpPart.Attachment.Orientation = Vector3.new(0,0,0)

if MPASword[1] then
	for _,v in pairs(LWP1:GetChildren()) do
		if v:IsA("BasePart") then
			v.Transparency = 1
		end
	end
	local HatChoice = MPASword[1]

	align(HatChoice.Handle, LWP1.Main)

	table.remove(MPASword,1)

	HatChoice.Handle.AccessoryWeld:Destroy()
	HatChoice.Handle.Size = Vector3.new(1,1,1)
end
if MPASword[1] then
	for _,v in pairs(LWP2:GetChildren()) do
		if v:IsA("BasePart") then
			v.Transparency = 1
		end
	end
	local HatChoice = MPASword[1]

	align(HatChoice.Handle, LWP2.Main)

	table.remove(MPASword,1)

	HatChoice.Handle.AccessoryWeld:Destroy()
	HatChoice.Handle.Size = Vector3.new(1,1,1)
end
if Char:FindFirstChild("BladeMasterAccessory") then

	for _,v in pairs(LWP3:GetChildren()) do
		if v:IsA("BasePart") then
			v.Transparency = 1
		end
	end
	local HatChoice = Char:FindFirstChild("ShadowBladeMasterAccessory")

	align(HatChoice.Handle, LWP3.Main)

	HatChoice.Handle.AccessoryWeld:Destroy()
	HatChoice.Handle.Size = Vector3.new(1,1,1)
end
if MPASword[1] then
    	for _,v in pairs(RWP1:GetChildren()) do
		if v:IsA("BasePart") then
			v.Transparency = 1
		end
	end

	local HatChoice = MPASword[1]

	align(HatChoice.Handle, RWP1.Main)

	table.remove(MPASword,1)

	HatChoice.Handle.AccessoryWeld:Destroy()
	HatChoice.Handle.Size = Vector3.new(1,1,1)
end
if MPASword[1] then
	for _,v in pairs(RWP2:GetChildren()) do
		if v:IsA("BasePart") then
			v.Transparency = 1
		end
	end
	local HatChoice = MPASword[1]

	align(HatChoice.Handle, RWP2.Main)

	table.remove(MPASword,1)

	HatChoice.Handle.AccessoryWeld:Destroy()
	HatChoice.Handle.Size = Vector3.new(1,1,1)
end
if Char:FindFirstChild("BladeMasterAccessory") then
	for _,v in pairs(RWP3:GetChildren()) do
		if v:IsA("BasePart") then
			v.Transparency = 1
		end
	end
	local HatChoice = Char:FindFirstChild("BladeMasterAccessory")

	align(HatChoice.Handle, RWP3.Main)

	HatChoice.Handle.AccessoryWeld:Destroy()
	HatChoice.Handle.Size = Vector3.new(1,1,1)
end

local bbg=Head:FindFirstChild'Nametag' or NewInstance("BillboardGui",Head,{
	Adornee=Head;
	Name='Nametag';
	Size=UDim2.new(4,0,1.2,0);
	StudsOffset=V3.N(-8,5.3,0);
})
local text=bbg:FindFirstChild'TextLabel' or NewInstance("TextLabel",bbg,{
	Size=UDim2.new(5,0,3.5,0);
	TextScaled=true;
	BackgroundTransparency=1;
	TextStrokeTransparency=0;
	Font=Enum.Font.Arcade;
	TextColor3=C3.N(1,1,1);
	Text='Achromatic'
})

function getMode(modeName)
	for i,v in next, modeInfo do
		if(v.Name==modeName)then
			return v
		end
	end
	return modeInfo[1]
end

function IsVaporwave(song)
	for i = 1,#VaporwaveSongs do
		if(VaporwaveSongs[i]==song)then
			return true
		end
	end
	return false
end

local blush = NewInstance('Decal',Head,{Transparency=1,Texture='rbxassetid://0',Color3=(Player.UserId==5719877 and C3.N(.45,0,1) or C3.N(1,0,0))})

function changeMudo(modeName)
	local info = getMode(modeName)
	Mode=info.Name
	WalkSpeed=info.Walkspeed
	movement=info.moveVal
	music=makeMusic(info.Music or 0,info.Pitch or 1,info.TimePos or music and music.TimePosition or 0)
	WingAnim=info.WingAnim or 'NebG1'
	text.Text = info.Name
	text.TextColor3 = info.LeftWing[2]
	text.TextStrokeColor3 = info.StrokeColor
	text.Font=info.Font;
	if(Mode=='Love' or Mode=='Lust')then
		blush.Transparency=0
		blush.Texture='rbxassetid://2664127437'
	else
		blush.Transparency=1
		blush.Texture='rbxassetid://0'
	end
	for _,v in next,leftWing:GetDescendants() do
		if(v:IsA'BasePart' and v.Name~='Main')then
			v.Color=info.LeftWing[2]
			v.Material=info.LeftWing[3]
		elseif(v:IsA'Trail')then
			v.Transparency=NumberSequence.new(info.LeftWing[1],1)
			v.Color=ColorSequence.new(info.LeftWing[2])	
		end
	end
	
	for _,v in next,rightWing:GetDescendants() do
		if(v:IsA'BasePart' and v.Name~='Main')then
			v.Color=info.RightWing[2]
			v.Material=info.RightWing[3]
		elseif(v:IsA'Trail')then
			v.Transparency=NumberSequence.new(info.RightWing[1],1)
			v.Color=ColorSequence.new(info.RightWing[2])	
		end
	end
	
	PrimaryColor = info.PrimaryColor or info.LeftWing[2]
end

function changeMode(modeName)
		changeMudo(modeName)
end	

function syncStuff(data)
	local neut,legwelds,c0s,c1s,sine,mov,walk,inc,musicmode,tpos,pit,wingsin,visSett,mode,newhue=unpack(data)
	local head0,torso0,rleg0,rarm0,lleg0,larm0=unpack(c0s)
	local head1,torso1,rleg1,rarm1,lleg1,larm1=unpack(c1s)
	legAnims=legwelds
	NeutralAnims=neut
	if(not neut)then
		NK.C0=head0
		RJ.C0=torso0
		RH.C0=rleg0
		RS.C0=rarm0
		LH.C0=lleg0
		LS.C0=larm0
		
		NK.C1=head1
		RJ.C1=torso1
		RH.C1=rleg1
		RS.C1=rarm1
		LH.C1=lleg1
		LS.C1=larm1
	end
	if(Mode~=mode)then
		changeMudo(mode)
	end
	movement=mov
	walking=walk
	Change=inc
	print(MusicMode,musicmode)
	if(musicmode~=MusicMode and music)then
		MusicMode=musicmode
		if(MusicMode==1)then
			music:Pause()
			music.Volume=1
			music.Parent=Torso
			music:Resume()
		elseif(MusicMode==2)then
			music:Pause()
			music.Volume=1
			music.Parent=Char
			music:Resume()
		elseif(MusicMode==3)then
			music.Volume = 0
		end
	end
	if(Sine-sine>.8 or Sine-sine<-.8)then
		Sine=sine
	end
	if(hue-newhue>.8 or hue-newhue<-.8)then
		hue=newhue
	end
	if(WingSine-wingsin>.8 or WingSine-wingsin<-.8)then
		WingSine=wingsin
	end
	if(music and (music.TimePosition-tpos>.8 or music.TimePosition-tpos<-.8))then
		music.TimePosition=tpos
	end
	if(music and pit)then
		music.Pitch = pit
	end
	if(Mode=='Troubadour' and music.SoundId~='rbxassetid://'..visSett.Music)then
		music.SoundId='rbxassetid://'..visSett.Music
	end
	getMode('Troubadour').Music = visSett.Music
	getMode('Troubadour').Pitch = visSett.Pitch
end

local footstepSounds = {
	[Enum.Material.Grass]=510933218;
	[Enum.Material.Metal]=1263161138;
	[Enum.Material.CorrodedMetal]=1263161138;
	[Enum.Material.DiamondPlate]=1263161138;
	[Enum.Material.Wood]=2452053757;
	[Enum.Material.WoodPlanks]=2452053757;
	[Enum.Material.Sand]=134456884;
	[Enum.Material.Snow]=2452051182;
}


function Vaporwaveify(s)
	local function wide(a)
		if a<'!' or a>'~' then return a end
		if a==' ' then return '  ' end 
		a = a:byte()+160
		if a<256 then return string.char(239,188,a-64) end
		return string.char(239,189,a-128)
	end
	return(s:gsub(".",wide))
end



function Choot(text)
	--if(game.PlaceId ~= 843468296)then
		coroutine.wrap(function()
			if(Char:FindFirstChild'ChatGUI')then Char.ChatGUI:destroy() end
			local BBG = NewInstance("BillboardGui",Char,{Name='ChatGUI',Size=UDim2.new(0,100,0,40),StudsOffset=V3.N(0,2,0),Adornee=Head})
			local Txt = NewInstance("TextLabel",BBG,{Text = "",BackgroundTransparency=1,TextColor3=PrimaryColor,BorderSizePixel=0,Font=Enum.Font.Antique,TextSize=50,TextStrokeTransparency=1,Size=UDim2.new(1,0,.5,0)})
			for i = 1, #text do
				--Txt.Text = Vaporwaveify(text:sub(1,i))
				Txt.TextColor3=(Mode=='Troubadour' and Color3.fromHSV(hue/360,1,math.clamp(music.PlaybackLoudness/475,0,1)) or PrimaryColor)
				if(vaporwaveMode and Mode=='Troubadour')then
					Txt.Text = Vaporwaveify(text:sub(1,i))
				else
					Txt.Text = text:sub(1,i)
				end
				wait((vaporwaveMode) and .1 or .025)
			end
			for i = 0, 60 do
				Txt.TextColor3=(Mode=='Troubadour' and Color3.fromHSV(hue/360,1,math.clamp(music.PlaybackLoudness/475,0,1)) or PrimaryColor)
				swait()
			end
			for i = 0, 1, .025 do
				Txt.TextTransparency=i
				swait()
			end
			BBG:destroy()
		end)()
	--else
	--	Chat2(text)
	--end
end

function Chat(text)
		Choot(text)
end

function DealDamage(...)
	return true
end

function getRegion(point,range,ignore)
    return workspace:FindPartsInRegion3WithIgnoreList(R3.N(point-V3.N(1,1,1)*range/2,point+V3.N(1,1,1)*range/2),ignore,100)
end
function AOEDamage(where,range,options)
	local hit = {}
	for _,v in next, getRegion(where,range,{Char}) do
		if(v.Parent and v.Parent:FindFirstChildOfClass'Humanoid' and not hit[v.Parent:FindFirstChildOfClass'Humanoid'])then
			local callTable = {Who=v.Parent}
			hit[v.Parent:FindFirstChildOfClass'Humanoid'] = true
			for _,v in next, options do callTable[_] = v end
			DealDamage(callTable)
		end
	end
	return hit
end


function Click1()
	Attack=true
	NeutralAnims=false
	legAnims=false
	local orig = WalkSpeed
	WalkSpeed=4
	for i = 0, 1, 0.1 do
		swait()
		local Alpha = .3
		RJ.C0 = RJ.C0:lerp(CF.N(0,0,0)*CF.A(M.R(0),M.R(-44.6),M.R(0)),Alpha)
		LH.C0 = LH.C0:lerp(CF.N(-0.8,-1,-0.3)*CF.A(M.R(-17.4),M.R(44.4),M.R(7.1)),Alpha)
		RH.C0 = RH.C0:lerp(CF.N(0.4,-1,0)*CF.A(M.R(1.6),M.R(-13.1),M.R(7)),Alpha)
		LS.C0 = LS.C0:lerp(CF.N(-1.3,0.5,-0.3)*CF.A(M.R(90),M.R(0),M.R(-44.6)),Alpha)
		RS.C0 = RS.C0:lerp(CF.N(1.4,0.5,-0.1)*CF.A(M.R(90),M.R(0),M.R(-44.6)),Alpha)
		NK.C0 = NK.C0:lerp(CF.N(0,1.5,0)*CF.A(M.R(0),M.R(44.6),M.R(0)),Alpha)
	end
	for i = 0, 1, 0.1 do
		swait()
		AOEDamage(RArm.CFrame.p,2,{
			DamageColor=(Mode=='Troubadour' and C3.HSV(hue/360,1,math.clamp(music.PlaybackLoudness/475,0,1)) or PrimaryColor);
			MinimumDamage=5;
			MaximumDamage=15;
		})
		local Alpha = .3
		RJ.C0 = RJ.C0:lerp(CF.N(0,0,-0.7)*CF.A(M.R(0),M.R(50.5),M.R(0)),Alpha)
		LH.C0 = LH.C0:lerp(CF.N(-0.5,-0.7,-0.6)*CF.A(M.R(-26),M.R(0),M.R(0)),Alpha)
		RH.C0 = RH.C0:lerp(CF.N(0.6,-1.1,-0.1)*CF.A(M.R(20.2),M.R(-47.6),M.R(15.2)),Alpha)
		LS.C0 = LS.C0:lerp(CF.N(-1.3,0.5,0)*CF.A(M.R(0),M.R(0),M.R(-20.4)),Alpha)
		RS.C0 = RS.C0:lerp(CF.N(1.4,0.5,-0.5)*CF.A(M.R(90),M.R(0),M.R(50.5)),Alpha)
		NK.C0 = NK.C0:lerp(CF.N(0,1.5,0)*CF.A(M.R(0),M.R(-50.5),M.R(0)),Alpha)
	end
	WalkSpeed=orig
	legAnims=true
	Attack=false
	NeutralAnims=true
end

function SwordSummon()
	Attack = true
	NeutralAnims = false
	local orig=WalkSpeed
	WalkSpeed=4
	legAnims=false
	for i = 0, 1, 0.1 do
		swait()
		local Alpha = .3
		Effect{
			Lifetime=.25;
			Mesh={Type=Enum.MeshType.Sphere};
			CFrame=RArm.CFrame*CF.N(0,-1,0)*CF.A(M.RRNG(0,360),M.RRNG(0,360),M.RRNG(0,360));
			Color=PrimaryColor;
			Transparency={.5,1};
			Material=Enum.Material.Neon;
			Size=Vector3.new(.6,1,.6);
			EndSize=Vector3.new(.1,3,.1);
		}
		RJ.C0 = RJ.C0:lerp(CF.N(0,-0.2,-0.1)*CF.A(M.R(-12.4),M.R(-15.7),M.R(0)),Alpha)
		LH.C0 = LH.C0:lerp(CF.N(-0.5,-0.7,-0.5)*CF.A(M.R(16.2),M.R(15.2),M.R(-0.8)),Alpha)
		RH.C0 = RH.C0:lerp(CF.N(0.5,-1,0)*CF.A(M.R(-28.5),M.R(0),M.R(0)),Alpha)
		LS.C0 = LS.C0:lerp(CF.N(-1.4,0.5,0)*CF.A(M.R(27.2),M.R(-3.8),M.R(-5)),Alpha)
		RS.C0 = RS.C0:lerp(CF.N(1.3,0.6,0)*CF.A(M.R(-33.8),M.R(-18.1),M.R(24.8)),Alpha)
		NK.C0 = NK.C0:lerp(CF.N(0,1.5,0)*CF.A(M.R(13.4),M.R(15.3),M.R(-3.6)),Alpha)
	end
	for i = 0, 5 do
		delay(.05*i,function()
			local pos = Root.CFrame*CF.N(0,-2,-2-i*4)*CF.A(M.R(80),0,0)
			local pos2 = Root.CFrame*CF.N(0,-3,-2-i*4)
			Camshake({
			    Duration=.2;
				FadeOut=.2;
			    Intensity=1.5;
			    Position=Vector3.new(.5,.5,.5);
			    Rotation=Vector3.new(.5,.5,3);
			    DropDist=15;
			    IneffectiveDist=40;
			    Origin=pos2;
			})
			AOEDamage(pos.p,5,{
				DamageColor=(Mode=='Troubadour' and C3.HSV(hue/360,1,math.clamp(music.PlaybackLoudness/475,0,1)) or PrimaryColor);
				MinimumDamage=(Mode=='Troubadour' and music.PlaybackLoudness/10 or 10);
				MaximumDamage=(Mode=='Troubadour' and music.PlaybackLoudness/8 or 35);
			})
			SoundPart(178452221,1,2,false,true,true,pos)
			Effect{
				Lifetime=.4;
				Part='Sword',
				--Mesh={Type=Enum.MeshType.Sphere};
				CFrame=pos;
				Color=PrimaryColor;
				Transparency={0,1};
				Material=Enum.Material.Neon;
				Size=V3.N(0.8,2.5,6.8);
				EndSize=V3.N(0.8,2.5,16);
			}
			Effect{
				Lifetime=.4;
				Mesh={Type=Enum.MeshType.Sphere};
				CFrame=pos2;
				Color=PrimaryColor;
				Transparency={0,1};
				Material=Enum.Material.Neon;
				Size=V3.N(4,.1,4);
				EndSize=V3.N(6,.1,6);
			}
			Effect{
				Lifetime=.1;
				Mesh={Type=Enum.MeshType.Sphere};
				CFrame=pos;
				Color=PrimaryColor;
				Transparency={0,1};
				Material=Enum.Material.Neon;
				Size=V3.N(7,7,7);
				EndSize=V3.N(12,12,12);
			}
			for i = 1, 5 do
				Effect{
					Lifetime=.5;
					Mesh={Type=Enum.MeshType.Sphere};
					CFrame=pos;
					Color=PrimaryColor;
					Transparency={0,1};
					Material=Enum.Material.Neon;
					Size=V3.N(1,1,1);
					EndSize=V3.N(1,1,1);
					Acceleration={Force=V3.N(M.RNG(-75,75)/100,M.RNG(-75,75)/100,M.RNG(-75,75)/100)};
				}
			end
		end)
	end
	for i = 0, 1, 0.1 do
		swait()
		local Alpha = .3
		RJ.C0 = RJ.C0:lerp(CF.N(0,0,0)*CF.A(M.R(0),M.R(70.7),M.R(0)),Alpha)
		LH.C0 = LH.C0:lerp(CF.N(-0.5,-1,0)*CF.A(M.R(0),M.R(0),M.R(-14.4)),Alpha)
		RH.C0 = RH.C0:lerp(CF.N(0.6,-1,0)*CF.A(M.R(15.1),M.R(-63.2),M.R(13.5)),Alpha)
		LS.C0 = LS.C0:lerp(CF.N(-1.3,0.6,-0.1)*CF.A(M.R(0),M.R(15.9),M.R(-25.4)),Alpha)
		RS.C0 = RS.C0:lerp(CF.N(1.4,0.3,-0.2)*CF.A(M.R(0),M.R(19.3),M.R(157.1)),Alpha)
		NK.C0 = NK.C0:lerp(CF.N(0,1.5,0)*CF.A(M.R(0),M.R(-70.7),M.R(0)),Alpha)
	end
	legAnims=true
	WalkSpeed=orig
	Attack = false
	NeutralAnims = true
end

function Bombs()
	Attack=true
	NeutralAnims=false
	legAnims=false
	local orig = WalkSpeed
	WalkSpeed=0
	for i = 0, 1, 0.1 do
		swait()
		local Alpha = .3
		RJ.C0 = RJ.C0:lerp(CF.N(0,0,0)*CF.A(M.R(0),M.R(0),M.R(0)),Alpha)
		LH.C0 = LH.C0:lerp(CF.N(-0.5,-1,0)*CF.A(M.R(0),M.R(0),M.R(0)),Alpha)
		RH.C0 = RH.C0:lerp(CF.N(0.5,-1,0)*CF.A(M.R(0),M.R(0),M.R(0)),Alpha)
		LS.C0 = LS.C0:lerp(CF.N(-1.3,0.5,-0.5)*CF.A(M.R(90),M.R(0),M.R(19.1)),Alpha)
		RS.C0 = RS.C0:lerp(CF.N(1.3,0.5,-0.5)*CF.A(M.R(90),M.R(0),M.R(-21.3)),Alpha)
		NK.C0 = NK.C0:lerp(CF.N(0,1.5,0)*CF.A(M.R(0),M.R(0),M.R(0)),Alpha)
	end
	coroutine.wrap(function()
		for i = 0, 2 do
			Camshake({
			    Duration=.2;
				FadeOut=.2;
			    Intensity=1.5;
			    Position=Vector3.new(.5,.5,.5);
			    Rotation=Vector3.new(.5,.5,3);
			    DropDist=15;
			    IneffectiveDist=40;
			    Origin=Root.CFrame*CF.N(0,0,-4-i*4);
			})
			SoundPart(206083252,.8,4,false,true,true,Root.CFrame*CF.N(0,0,-4-i*4))
			AOEDamage(Root.CFrame*CF.N(0,0,-4-i*4).p,5,{
				DamageColor=PrimaryColor;
				MinimumDamage=25;
				MaximumDamage=45;
			})
			Effect{
				Lifetime=.4;
				Mesh={Type=Enum.MeshType.Sphere};
				Color=PrimaryColor;
				Material=Enum.Material.Neon;
				CFrame=Root.CFrame*CF.N(0,0,-4-i*4);
				Size=V3.N(1,1,1);
				EndSize=V3.N(10,10,10);
			}
			Effect{
				Lifetime=.4;
				Part='Ring';
				Color=PrimaryColor;
				Material=Enum.Material.Neon;
				CFrame=Root.CFrame*CF.N(0,0,-4-i*4)*CF.A(M.RRNG(0,360),M.RRNG(0,360),M.RRNG(0,360));
				RotInc={M.RNG(-25,25)/100,M.RNG(-25,25)/100,M.RNG(-25,25)/100};
				Size=V3.N(4,4,.2);
				EndSize=V3.N(13,13,.2);
			}
			Effect{
				Lifetime=.4;
				Part='Ring';
				Color=PrimaryColor;
				Material=Enum.Material.Neon;
				CFrame=Root.CFrame*CF.N(0,0,-4-i*4)*CF.A(M.RRNG(0,360),M.RRNG(0,360),M.RRNG(0,360));
				RotInc={M.RNG(-25,25)/100,M.RNG(-25,25)/100,M.RNG(-25,25)/100};
				Size=V3.N(4,4,.2);
				EndSize=V3.N(13,13,.2);
			}
			swait(4)
		end
	end)()
	for i = 0, 1, 0.1 do
		swait()
		local Alpha = .3
		RJ.C0 = RJ.C0:lerp(CF.N(0,-0.2,0.7)*CF.A(M.R(18.2),M.R(0),M.R(0)),Alpha)
		LH.C0 = LH.C0:lerp(CF.N(-0.5,-1.1,-0.4)*CF.A(M.R(-33.4),M.R(0),M.R(0)),Alpha)
		RH.C0 = RH.C0:lerp(CF.N(0.5,-0.9,-0.2)*CF.A(M.R(-6.7),M.R(0),M.R(0)),Alpha)
		LS.C0 = LS.C0:lerp(CF.N(-1.4,0.4,0.1)*CF.A(M.R(90.7),M.R(-2.5),M.R(-50)),Alpha)
		RS.C0 = RS.C0:lerp(CF.N(1.4,0.5,0.2)*CF.A(M.R(89.5),M.R(2.6),M.R(50)),Alpha)
		NK.C0 = NK.C0:lerp(CF.N(0,1.5,0)*CF.A(M.R(0),M.R(0),M.R(0)),Alpha)
	end
	WalkSpeed=orig
	legAnims=true
	Attack=false
	NeutralAnims=true
end

function JusticeSkyBeams()
	Attack = true
	NeutralAnims = false
	local orig=WalkSpeed
	WalkSpeed=0
	legAnims=false
	for i = 1, 110 do
		swait()
		local Alpha = .3
		local pos = Root.CFrame * CFrame.new(math.random(-150,150),0,math.random(-150,150))
		RJ.C0 = RJ.C0:lerp(CF.N(0,-0.2,0.7)*CF.A(M.R(18.2),M.R(0),M.R(0)),Alpha)
		LH.C0 = LH.C0:lerp(CF.N(-0.5,-1.1,-0.4)*CF.A(M.R(-33.4),M.R(0),M.R(0)),Alpha)
		RH.C0 = RH.C0:lerp(CF.N(0.5,-0.9,-0.2)*CF.A(M.R(-6.7),M.R(0),M.R(0)),Alpha)
		LS.C0 = LS.C0:lerp(CF.N(-1.4,0.4,0.1)*CF.A(M.R(90.7),M.R(-2.5),M.R(-50)),Alpha)
		RS.C0 = RS.C0:lerp(CF.N(1.4,0.5,0.2)*CF.A(M.R(89.5),M.R(2.6),M.R(50)),Alpha)
		NK.C0 = NK.C0:lerp(CF.N(0,1.5,0)*CF.A(M.R(0),M.R(0),M.R(0)),Alpha)
		SoundPart(206083252,.8,2,false,true,true,pos)
		Effect{
			Lifetime=.4;
			Part='CylWav';
			Color=PrimaryColor;
			Material=Enum.Material.Neon;
			CFrame=Root.CFrame * CFrame.new(math.random(-150,150),0,math.random(-150,150));
			RotInc={0,M.RNG(-90,90),0};
			Size=V3.N(0.05,0.05,0.05);
			EndSize=V3.N(0.05,0.05,0.05);
		}
	end
	legAnims=true
	WalkSpeed=orig
	Attack = false
	NeutralAnims = true
end



function ClickCombo()
	ClickTimer=180
	if(Combo==1)then
		Click1()
		Combo=2
	elseif(Combo==2)then
		SwordSummon()
		Combo=3
	elseif(Combo==3)then
		Bombs()
		Combo=1
	end
end

local MAINRUINCOLOR = BrickColor.new("Really black")
local origcolor = BrickColor.new("Pastel light blue")
local cam = game.Workspace.CurrentCamera
local rainbowmode = false
local chaosmode = false
local glitchymode = false
Camera = cam
local CamInterrupt = false
cam.CameraType = "Custom"
necko=CF.N(0, 1, 0, -1, -0, -0, 0, 0, 1, 0, 1, 0)
necko2=CF.N(0, -0.5, 0, -1, -0, -0, 0, 0, 1, 0, 1, 0)

function CameraShake(Times, Power, PlayerTarget)
coroutine.resume(coroutine.create(function()
FV = Instance.new("BoolValue", PlayerTarget)
FV.Name = "CameraShake"
for ShakeNum=1,Times do
swait()
local ef=Power
  if ef>=1 then
   Hum.CameraOffset = Vector3.new(math.random(-ef,ef),math.random(-ef,ef),math.random(-ef,ef))
  else
   ef=Power*10
   Hum.CameraOffset = Vector3.new(math.random(-ef,ef)/10,math.random(-ef,ef)/10,math.random(-ef,ef)/10)
  end  
end
Hum.CameraOffset = Vector3.new(0,0,0)
FV:Destroy()
end))
end

function CameraEnshaking(Length,Intensity)
coroutine.resume(coroutine.create(function()
      local intensity = 1*Intensity
      local rotM = 0.01*Intensity
for i = 0, Length, 0.1 do
swait()
intensity = intensity - 0.05*Intensity/Length
rotM = rotM - 0.0005*Intensity/Length
      Hum.CameraOffset = V3.N(math.rad(math.random(-intensity, intensity)), math.rad(math.random(-intensity, intensity)), math.rad(math.random(-intensity, intensity)))
      cam.CFrame = cam.CFrame * CF.N(math.rad(math.random(-intensity, intensity)), math.rad(math.random(-intensity, intensity)), math.rad(math.random(-intensity, intensity))) * CFrame.fromEulerAnglesXYZ(math.rad(math.random(-intensity, intensity)) * rotM, math.rad(math.random(-intensity, intensity)) * rotM, math.rad(math.random(-intensity, intensity)) * rotM)
end
Hum.CameraOffset = V3.N(0, 0, 0)
end))
end
CamShake=function(Part,Distan,Power,Times)
local de=Part.Position
for i,v in pairs(workspace:children()) do
 if v:IsA("Model") and v:findFirstChild("Humanoid") then
for _,c in pairs(v:children()) do
if c.ClassName=="Part" and (c.Position - de).magnitude < Distan then
local Noob=v:FindFirstChildOfClass'Humanoid'
if Noob~=nil then
coroutine.resume(coroutine.create(function()
FV = Instance.new("BoolValue", Noob)
FV.Name = "CameraShake"
for ShakeNum=1,Times do
swait()
local ef=Power
  if ef>=1 then
   Hum.CameraOffset = Vector3.new(math.random(-ef,ef),math.random(-ef,ef),math.random(-ef,ef))
  else
   ef=Power*10
   Hum.CameraOffset = Vector3.new(math.random(-ef,ef)/10,math.random(-ef,ef)/10,math.random(-ef,ef)/10)
  end  
end
Hum.CameraOffset = Vector3.new(0,0,0)
FV:Destroy()
end))
CameraShake(Times, Power, Noob)
end
end
end
end
end
end

function FaceMouse()
  Cam = workspace.CurrentCamera
  return {
    CFrame.new(Char.Torso.Position, Vector3.new(Mouse.Hit.p.x, Char.Torso.Position.y, Mouse.Hit.p.z)),
    Vector3.new(Mouse.Hit.p.x, Mouse.Hit.p.y, Mouse.Hit.p.z)
  }
end

function FaceMouse2()
  Cam = workspace.CurrentCamera
  return {
    CFrame.new(Char.Torso.Position, Vector3.new(Mouse.Hit.p.x, Mouse.Hit.p.y, Mouse.Hit.p.z)),
    Vector3.new(Mouse.Hit.p.x, Mouse.Hit.p.y, Mouse.Hit.p.z)
  }
end

local Create = LoadLibrary("RbxUtility").Create
 
function RemoveOutlines(part)
  part.TopSurface, part.BottomSurface, part.LeftSurface, part.RightSurface, part.FrontSurface, part.BackSurface = 10, 10, 10, 10, 10, 10
end

CFuncs = { 
    ["Part"] = {
        Create = function(Parent, Material, Reflectance, Transparency, BColor, Name, Size)
            local Part = Create("Part"){
                Parent = Parent,
                Reflectance = Reflectance,
                Transparency = Transparency,
                CanCollide = false,
                Locked = true,
                BrickColor = BrickColor.new(tostring(BColor)),
                Name = Name,
                Size = Size,
                Material = Material,
            }
            RemoveOutlines(Part)
            return Part
        end;
    };
   
    ["Mesh"] = {
        Create = function(Mesh, Part, MeshType, MeshId, OffSet, Scale)
            local Msh = Create(Mesh){
                Parent = Part,
                Offset = OffSet,
                Scale = Scale,
            }
            if Mesh == "SpecialMesh" then
                Msh.MeshType = MeshType
                Msh.MeshId = MeshId
            end
            return Msh
        end;
    };
   
    ["Mesh"] = {
        Create = function(Mesh, Part, MeshType, MeshId, OffSet, Scale)
            local Msh = Create(Mesh){
                Parent = Part,
                Offset = OffSet,
                Scale = Scale,
            }
            if Mesh == "SpecialMesh" then
                Msh.MeshType = MeshType
                Msh.MeshId = MeshId
            end
            return Msh
        end;
    };
   
    ["Weld"] = {
        Create = function(Parent, Part0, Part1, C0, C1)
            local Weld = Create("Weld"){
                Parent = Parent,
                Part0 = Part0,
                Part1 = Part1,
                C0 = C0,
                C1 = C1,
            }
            return Weld
        end;
    };
 
    ["Sound"] = {
        Create = function(id, par, vol, pit)
            return coroutine.wrap(function()
                local S = Create("Sound"){
                    Volume = vol,
                                        Name = "EffectSoundo",
                    Pitch = pit or 1,
                    SoundId = id,
                    Parent = par or workspace,
                }
                S:Play()
                S.Ended:connect(function()
                    S:Destroy()
                end)
                return S;
            end)()
        end;
    };
 
["LongSound"] = {
        Create = function(id, par, vol, pit)
            coroutine.resume(coroutine.create(function()
                local S = Create("Sound"){
                    Volume = vol,
                    Pitch = pit or 1,
                    SoundId = id,
                    Parent = par or workspace,
                }
                wait()
                S:play()
                game:GetService("Debris"):AddItem(S, 30)
            end))
        end;
    };
   
    ["ParticleEmitter"] = {
        Create = function(Parent, Color1, Color2, LightEmission, Size, Texture, Transparency, ZOffset, Accel, Drag, LockedToPart, VelocityInheritance, EmissionDirection, Enabled, LifeTime, Rate, Rotation, RotSpeed, Speed, VelocitySpread)
            local fp = Create("ParticleEmitter"){
                Parent = Parent,
                Color = ColorSequence.new(Color1, Color2),
                LightEmission = LightEmission,
                Size = Size,
                Texture = Texture,
                Transparency = Transparency,
                ZOffset = ZOffset,
                Acceleration = Accel,
                Drag = Drag,
                LockedToPart = LockedToPart,
                VelocityInheritance = VelocityInheritance,
                EmissionDirection = EmissionDirection,
                Enabled = Enabled,
                Lifetime = LifeTime,
                Rate = Rate,
                Rotation = Rotation,
                RotSpeed = RotSpeed,
                Speed = Speed,
                VelocitySpread = VelocitySpread,
            }
            return fp
        end;
    };
 
    CreateTemplate = {
   
    };
}

function Damagefunc(Part, hit, minim, maxim, knockback, Type, Property, Delay, HitSound, HitPitch)
  if hit.Parent == nil then
    return
  end
  local h = hit.Parent:FindFirstChildOfClass("Humanoid")
  for _, v in pairs(hit.Parent:children()) do
    if v:IsA("Humanoid") then
      h = v
    end
  end
  if h ~= nil and hit.Parent.Name ~= Char.Name and hit.Parent:FindFirstChild("Head") ~= nil then
    if hit.Parent:findFirstChild("DebounceHit") ~= nil and hit.Parent.DebounceHit.Value == true then
      return
    end
    local c = Create("ObjectValue")({
      Name = "creator",
      Value = Player,
      Parent = h
    })
    game:GetService("Debris"):AddItem(c, 0.5)
    if HitSound ~= nil and HitPitch ~= nil then
      CFuncs.Sound.Create(HitSound, hit, 1, HitPitch)
    end
    local Damage = math.random(minim, maxim)
    local blocked = false
    local block = hit.Parent:findFirstChild("Block")
    if block ~= nil and block.className == "IntValue" and block.Value > 0 then
      blocked = true
      block.Value = block.Value - 1
      print(block.Value)
    end
    if blocked == false then
      HitHealth = h.Health
      h.Health = h.Health - Damage
      if HitHealth ~= h.Health and HitHealth ~= 0 and 0 >= h.Health and h.Parent.Name ~= "Hologram" then
        print("gained kill")
      end
      ShowDamage(Part.CFrame * CFrame.new(0, 0, Part.Size.Z / 2).p + Vector3.new(0, 1.5, 0), -Damage, 1.5, Part.BrickColor.Color)
    else
      h.Health = h.Health - Damage / 2
      ShowDamage(Part.CFrame * CFrame.new(0, 0, Part.Size.Z / 2).p + Vector3.new(0, 1.5, 0), -Damage, 1.5, Part.BrickColor.Color)
    end
    if Type == "Knockdown" then
      local hum = hit.Parent:FindFirstChildOfClass'Humanoid'
      hum.PlatformStand = true
      coroutine.resume(coroutine.create(function(HHumanoid)
        swait(1)
        HHumanoid.PlatformStand = false
      end), hum)
      local angle = hit.Position - (Property.Position + Vector3.new(0, 0, 0)).unit
      local bodvol = Create("BodyVelocity")({
        velocity = angle * knockback,
        P = 5000,
        maxForce = Vector3.new(8000, 8000, 8000),
        Parent = hit
      })
      local rl = Create("BodyAngularVelocity")({
        P = 3000,
        maxTorque = Vector3.new(500000, 500000, 500000) * 50000000000000,
        angularvelocity = Vector3.new(math.random(-10, 10), math.random(-10, 10), math.random(-10, 10)),
        Parent = hit
      })
      game:GetService("Debris"):AddItem(bodvol, 0.5)
      game:GetService("Debris"):AddItem(rl, 0.5)
    elseif Type == "Normal" then
      local vp = Create("BodyVelocity")({
        P = 500,
        maxForce = Vector3.new(math.huge, 0, math.huge),
        velocity = Property.CFrame.lookVector * knockback + Property.Velocity / 1.05
      })
      if knockback > 0 then
        vp.Parent = hit.Parent.Head
      end
      game:GetService("Debris"):AddItem(vp, 0.5)
    elseif Type == "Up" then
      local bodyVelocity = Create("BodyVelocity")({
        velocity = Vector3.new(0, 20, 0),
        P = 5000,
        maxForce = Vector3.new(8000, 8000, 8000),
        Parent = hit
      })
      game:GetService("Debris"):AddItem(bodyVelocity, 0.5)
      local bodyVelocity = Create("BodyVelocity")({
        velocity = Vector3.new(0, 20, 0),
        P = 5000,
        maxForce = Vector3.new(8000, 8000, 8000),
        Parent = hit
      })
      game:GetService("Debris"):AddItem(bodyVelocity, 1)
    elseif Type == "Leech" then
      local hum = hit.Parent:FindFirstChildOfClass'Humanoid'
      if hum ~= nil then
        for i = 0, 2 do
          Effects.Sphere.Create(BrickColor.new("Bright red"), hit.Parent.Torso.CFrame * cn(0, 0, 0) * angles(math.random(-50, 50), math.random(-50, 50), math.random(-50, 50)), 1, 15, 1, 0, 5, 0, 0.02)
        end
        Hum.Health = Hum.Health + 10
      end
    elseif Type == "UpKnock" then
      local hum = hit.Parent:FindFirstChildOfClass'Humanoid'
      hum.PlatformStand = true
      if hum ~= nil then
        hitr = true
      end
      coroutine.resume(coroutine.create(function(HHumanoid)
        swait(5)
        HHumanoid.PlatformStand = false
        hitr = false
      end), hum)
      local bodyVelocity = Create("BodyVelocity")({
        velocity = Vector3.new(0, 20, 0),
        P = 5000,
        maxForce = Vector3.new(8000, 8000, 8000),
        Parent = hit
      })
      game:GetService("Debris"):AddItem(bodyVelocity, 0.5)
      local bodyVelocity = Create("BodyVelocity")({
        velocity = Vector3.new(0, 20, 0),
        P = 5000,
        maxForce = Vector3.new(8000, 8000, 8000),
        Parent = hit
      })
      game:GetService("Debris"):AddItem(bodyVelocity, 1)
    elseif Type == "Snare" then
      local bp = Create("BodyPosition")({
        P = 2000,
        D = 100,
        maxForce = Vector3.new(math.huge, math.huge, math.huge),
        position = hit.Parent.Torso.Position,
        Parent = hit.Parent.Torso
      })
      game:GetService("Debris"):AddItem(bp, 1)
    elseif Type == "Slashnare" then
      Effects.Block.Create(BrickColor.new("Pastel Blue"), hit.Parent.Torso.CFrame * cn(0, 0, 0), 15*4, 15*4, 15*4, 3*4, 3*4, 3*4, 0.07)
      for i = 1, math.random(4, 5) do
        Effects.Sphere.Create(BrickColor.new("Teal"), hit.Parent.Torso.CFrame * cn(math.random(-5, 5), math.random(-5, 5), math.random(-5, 5)) * angles(math.random(-50, 50), math.random(-50, 50), math.random(-50, 50)), 1, 15, 1, 0, 5, 0, 0.02)
      end
      local bp = Create("BodyPosition")({
        P = 2000,
        D = 100,
        maxForce = Vector3.new(math.huge, math.huge, math.huge),
        position = hit.Parent.Torso.Position,
        Parent = hit.Parent.Torso
      })
      game:GetService("Debris"):AddItem(bp, 1)
    elseif Type == "Spike" then
      local bp = Create("BodyPosition")({
        P = 2000,
        D = 100,
        maxForce = Vector3.new(math.huge, math.huge, math.huge),
        position = hit.Parent.Torso.Position,
        Parent = hit.Parent.Torso
      })
      game:GetService("Debris"):AddItem(bp, 1)
    elseif Type == "Freeze" then
      local BodPos = Create("BodyPosition")({
        P = 50000,
        D = 1000,
        maxForce = Vector3.new(math.huge, math.huge, math.huge),
        position = hit.Parent.Torso.Position,
        Parent = hit.Parent.Torso
      })
      local BodGy = Create("BodyGyro")({
        maxTorque = Vector3.new(400000, 400000, 400000) * math.huge,
        P = 20000,
        Parent = hit.Parent.Torso,
        cframe = hit.Parent.Torso.CFrame
      })
      hit.Parent.Torso.Anchored = true
      coroutine.resume(coroutine.create(function(Part)
        swait(1.5)
        Part.Anchored = false
      end), hit.Parent.Torso)
      game:GetService("Debris"):AddItem(BodPos, 3)
      game:GetService("Debris"):AddItem(BodGy, 3)
    end
    local debounce = Create("BoolValue")({
      Name = "DebounceHit",
      Parent = hit.Parent,
      Value = true
    })
    game:GetService("Debris"):AddItem(debounce, Delay)
    c = Instance.new("ObjectValue")
    c.Name = "creator"
    c.Value = Player
    c.Parent = h
    game:GetService("Debris"):AddItem(c, 0.5)
  end
end

function MagniDamage(Part, magni, mindam, maxdam, knock, Type)
  for _, c in pairs(workspace:children()) do
    local hum = c:findFirstChildOfClass("Humanoid")
    if hum ~= nil then
      local head = c:findFirstChild("Head")
      if head ~= nil then
        local targ = head.Position - Part.Position
        local mag = targ.magnitude
        if magni >= mag and c.Name ~= Player.Name then
          Damagefunc(head, head, mindam, maxdam, knock, Type, Root, 0.1, "rbxassetid://231917784", 1)
        end
      end
    end
  end
end

function RsphereMK(bonuspeed,FastSpeed,type,pos,x1,y1,z1,value,color,outerpos)
local type = type
local rng = Instance.new("Part", Char)
        rng.Anchored = true
        rng.Color = color
        rng.CanCollide = false
        rng.FormFactor = 3
        rng.Name = "Ring"
        rng.Material = "Neon"
        rng.Size = Vector3.new(1, 1, 1)
        rng.Transparency = 0
        rng.TopSurface = 0
        rng.BottomSurface = 0
        rng.CFrame = pos
rng.CFrame = rng.CFrame + rng.CFrame.lookVector*outerpos
        local rngm = Instance.new("SpecialMesh", rng)
        rngm.MeshType = "Sphere"
rngm.Scale = Vector3.new(x1,y1,z1)
local scaler2 = 1
local speeder = FastSpeed
if type == "Add" then
scaler2 = 1*value
elseif type == "Divide" then
scaler2 = 1/value
end
coroutine.resume(coroutine.create(function()
for i = 0,10/bonuspeed,0.1 do
swait()
if type == "Add" then
scaler2 = scaler2 - 0.01*value/bonuspeed
elseif type == "Divide" then
scaler2 = scaler2 - 0.01/value*bonuspeed
end
speeder = speeder - 0.01*FastSpeed*bonuspeed
rng.CFrame = rng.CFrame + rng.CFrame.lookVector*speeder*bonuspeed
rng.Transparency = rng.Transparency + 0.01*bonuspeed
rngm.Scale = rngm.Scale + Vector3.new(scaler2*bonuspeed, scaler2*bonuspeed, 0)
end
rng:Destroy()
end))
end

function NsphereMK(bonuspeed,FastSpeed,type,pos,x1,y1,z1,value,color,outerpos)
local type = type
local rng = Instance.new("Part", Char)
        rng.Anchored = true
        rng.Color = color
        rng.CanCollide = false
        rng.FormFactor = 3
        rng.Name = "Ring"
        rng.Material = "Neon"
        rng.Size = Vector3.new(1, 1, 1)
        rng.Transparency = 0
        rng.TopSurface = 0
        rng.BottomSurface = 0
        rng.CFrame = pos
rng.CFrame = rng.CFrame + rng.CFrame.lookVector*outerpos
        local rngm = Instance.new("SpecialMesh", rng)
        rngm.MeshType = "Sphere"
rngm.Scale = Vector3.new(x1,y1,z1)
local scaler2 = 1
local speeder = FastSpeed
if type == "Add" then
scaler2 = 1*value
elseif type == "Divide" then
scaler2 = 1/value
end
coroutine.resume(coroutine.create(function()
for i = 0,10/bonuspeed,0.1 do
swait()
if type == "Add" then
scaler2 = scaler2 - 0.01*value/bonuspeed
elseif type == "Divide" then
scaler2 = scaler2 - 0.01/value*bonuspeed
end
speeder = speeder - 0.01*FastSpeed*bonuspeed
rng.CFrame = rng.CFrame + rng.CFrame.lookVector*speeder*bonuspeed
rng.Transparency = rng.Transparency + 0.01*bonuspeed
rngm.Scale = rngm.Scale + Vector3.new(scaler2*bonuspeed, scaler2*bonuspeed, 0)
end
rng:Destroy()
end))
end

function RainbowWip()
Attack = true
NeutralAnims = false
local orig=WalkSpeed
WalkSpeed=4
legAnims=false
local rngb = Instance.new("Part", Char)
        rngb.Anchored = true
        rngb.BrickColor = origcolor
        rngb.CanCollide = false
        rngb.FormFactor = 3
        rngb.Name = "Ring"
        rngb.Material = "Neon"
        rngb.Size = Vector3.new(1, 0.05, 1)
        rngb.Transparency = 1
        rngb.TopSurface = 0
        rngb.BottomSurface = 0
        local rngmb = Instance.new("SpecialMesh", rngb)
        rngmb.MeshType = "Brick"
rngmb.Name = "SizeMesh"
rngmb.Scale = V3.N(0,1,0)
 
local orb = rngb:Clone()
orb.Parent = Char
orb.Transparency = 0
orb.BrickColor = BrickColor.new("White")
orb.Size = V3.N(1,1,1)
local orbmish = orb.SizeMesh
orbmish.Scale = V3.N(0,0,0)
orbmish.MeshType = "Sphere"
 
local orbe = rngb:Clone()
orbe.Parent = Char
orbe.Transparency = 0.5
orbe.BrickColor = BrickColor.new("New Yeller")
orbe.Size = V3.N(1,1,1)
local orbmish2 = orbe.SizeMesh
orbmish2.Scale = V3.N(0,0,0)
orbmish2.MeshType = "Sphere"
orbe.Color = Color3.new(r/255,g/255,b/255)
 
Hum.AutoRotate = false
rngb:Destroy()
--[[CFuncs["Sound"].Create("rbxassetid://136007472", orb, 1.5, 1)
local scaled = 1
for i = 0,5,0.1 do
swait()
scaled = scaled - 0.02
if rainbowmode == true then
orbe.Color = Color3.new(r/255,g/255,b/255)
end
orbmish.Scale = orbmish.Scale + vt(scaled/1.5,scaled/1.5,scaled/1.5)
orbmish2.Scale = orbmish2.Scale + vt(scaled*1.1/1.5,scaled*1.1/1.5,scaled*1.1/1.5)
orb.CFrame = root.CFrame*CFrame.new(0,0.5,0) + root.CFrame.lookVector*11.5
orbe.CFrame = root.CFrame*CFrame.new(0,0.5,0) + root.CFrame.lookVector*11.5
sphereMKCharge(2.5,-0.5,"Add",orb.CFrame*CFrame.Angles(math.rad(math.random(-360,360)),math.rad(math.random(-360,360)),math.rad(math.random(-360,360))),2.5,2.5,15,-0.025,MAINRUINCOLOR,25)
            RootJoint.C0 = clerp(RootJoint.C0,RootCF*cf(0,0,0)* angles(math.rad(0),math.rad(0),math.rad(90)),0.3)
Torso.Neck.C0 = clerp(Torso.Neck.C0,necko *angles(math.rad(0),math.rad(0),math.rad(-90)),.3)
RW.C0 = clerp(RW.C0, CFrame.new(1.5, 0.5, 0) * angles(math.rad(90), math.rad(0), math.rad(90)), 0.3)
LW.C0 = clerp(LW.C0, CFrame.new(-1.5, 0.5, 0) * angles(math.rad(10), math.rad(0), math.rad(-20)), 0.3)
RH.C0=clerp(RH.C0,cf(1,-1 - 0.05 * math.cos(sine / 25),0)*angles(math.rad(0),math.rad(90),math.rad(0))*angles(math.rad(-0.5),math.rad(0),math.rad(0)),.3)
LH.C0=clerp(LH.C0,cf(-1,-1 - 0.05 * math.cos(sine / 25),0)*angles(math.rad(0),math.rad(-90),math.rad(0))*angles(math.rad(-2.5),math.rad(10),math.rad(0)),.3)
RootPart.CFrame = FaceMouse()[1]
end]]--
for i = 0,5,0.1 do
swait()
if rainbowmode == true then
orbe.Color = Color3.new(r/255,g/255,b/255)
end
        if glitchymode then
            local val = math.random(1,255)
            local color = Color3.fromRGB(val,val,val)
            orbe.Color = color
        end
orb.CFrame = Root.CFrame*CFrame.new(0,0.5,0) + Root.CFrame.lookVector*11.5
orbe.CFrame = Root.CFrame*CFrame.new(0,0.5,0) + Root.CFrame.lookVector*11.5
swait()
local Alpha = .3
RJ.C0 = RJ.C0:lerp(CF.N(0,0,0)*CF.A(M.R(0),M.R(70.7),M.R(0)),Alpha)
LH.C0 = LH.C0:lerp(CF.N(-0.5,-1,0)*CF.A(M.R(0),M.R(0),M.R(-14.4)),Alpha)
RH.C0 = RH.C0:lerp(CF.N(0.6,-1,0)*CF.A(M.R(15.1),M.R(-63.2),M.R(13.5)),Alpha)
LS.C0 = LS.C0:lerp(CF.N(-1.3,0.6,-0.1)*CF.A(M.R(0),M.R(15.9),M.R(-25.4)),Alpha)
RS.C0 = RS.C0:lerp(CF.N(1.4,0.3,-0.2)*CF.A(M.R(0),M.R(19.3),M.R(157.1)),Alpha)
NK.C0 = NK.C0:lerp(CF.N(0,1.5,0)*CF.A(M.R(0),M.R(-70.7),M.R(0)),Alpha)
Root.CFrame = FaceMouse()[1]
end
orbe.Transparency = 1
orb.Transparency = 1
orb.CFrame = Root.CFrame*CFrame.new(0,0.5,0) + Root.CFrame.lookVector*5
CFuncs["Sound"].Create("rbxassetid://294188875", Char, 1, 1)
local a = Instance.new("Part",Char)
    a.Name = "Direction"   
    a.Anchored = true
    a.BrickColor = BrickColor.new("White")
a.Material = "Neon"
a.Transparency = 0
a.Shape = "Cylinder"
    a.CanCollide = false
local a2 = Instance.new("Part",Char)
    a2.Name = "Direction"  
    a2.Anchored = true
    a2.BrickColor = BrickColor.new("New Yeller")
a2.Color = Color3.new(r/255,g/255,b/255)
a2.Material = "Neon"
a2.Transparency = 0.5
a2.Shape = "Cylinder"
    a2.CanCollide = false
local ba = Instance.new("Part",Char)
    ba.Name = "HitDirect"  
    ba.Anchored = true
    ba.BrickColor = BrickColor.new("Cool yellow")
ba.Material = "Neon"
ba.Transparency = 1
    ba.CanCollide = false
    local ray = Ray.new(
        orb.CFrame.p,                           -- origin
        (Mouse.Hit.p - orb.CFrame.p).unit * 1000 -- direction
    )
    local ignore = Char
    local hit, position, normal = workspace:FindPartOnRay(ray, ignore)
    a.BottomSurface = 10
    a.TopSurface = 10
    a2.BottomSurface = 10
    a2.TopSurface = 10
    local distance = (orb.CFrame.p - position).magnitude
    a.Size = Vector3.new(distance, 1, 1)
    a.CFrame = CFrame.new(orb.CFrame.p, position) * CFrame.new(0, 0, -distance/2)
    a2.Size = Vector3.new(distance, 1, 1)
    a2.CFrame = CFrame.new(orb.CFrame.p, position) * CFrame.new(0, 0, -distance/2)
ba.CFrame = CFrame.new(orb.CFrame.p, position) * CFrame.new(0, 0, -distance)
a.CFrame = a.CFrame*CFrame.Angles(0,math.rad(90),0)
a2.CFrame = a2.CFrame*CFrame.Angles(0,math.rad(90),0)
game:GetService("Debris"):AddItem(a, 20)
game:GetService("Debris"):AddItem(a2, 20)
game:GetService("Debris"):AddItem(ba, 20)
local msh = Instance.new("SpecialMesh",a)
msh.MeshType = "Cylinder"
msh.Scale = V3.N(1,5*5,5*5)
local msh2 = Instance.new("SpecialMesh",a2)
msh2.MeshType = "Cylinder"
msh2.Scale = V3.N(1,6*5,6*5)
 
for i = 0,10,0.1 do
swait()
CameraEnshaking(1,5)
a2.Color = Color3.new(r/255,g/255,b/255)
orb.CFrame = Root.CFrame*CFrame.new(0,0.5,0) + Root.CFrame.lookVector*4
orbe.CFrame = Root.CFrame*CFrame.new(0,0.5,0) + Root.CFrame.lookVector*4
ray = Ray.new(
        orb.CFrame.p,                           -- origin
        (Mouse.Hit.p - orb.CFrame.p).unit * 1000 -- direction
    )
hit, position, normal = workspace:FindPartOnRay(ray, ignore)
distance = (orb.CFrame.p - position).magnitude
if typrot == 1 then
rotation = rotation + 2.5
elseif typrot == 2 then
rotation = rotation - 2.5
end
Root.CFrame = FaceMouse()[1]
a.Size = Vector3.new(distance, 1, 1)
a.CFrame = CFrame.new(orb.CFrame.p, position) * CFrame.new(0, 0, -distance/2)
a2.Size = Vector3.new(distance, 1, 1)
a2.CFrame = CFrame.new(orb.CFrame.p, position) * CFrame.new(0, 0, -distance/2)
ba.CFrame = CFrame.new(orb.CFrame.p, position) * CFrame.new(0, 0, -distance)
a.CFrame = a.CFrame*CFrame.Angles(0,math.rad(90),0)
a2.CFrame = a2.CFrame*CFrame.Angles(0,math.rad(90),0)
msh.Scale = msh.Scale - V3.N(0,0.05*1,0.05*1)
msh2.Scale = msh2.Scale - V3.N(0,0.06*1,0.06*1)
RsphereMK(5,1.5,"Add",ba.CFrame*CFrame.Angles(math.rad(math.random(-360,360)),math.rad(math.random(-360,360)),math.rad(math.random(-360,360))),15,15,25,-0.15,Color3.new(r/255,g/255,b/255),0)
RsphereMK(5,1.5,"Add",ba.CFrame*CFrame.Angles(math.rad(math.random(-360,360)),math.rad(math.random(-360,360)),math.rad(math.random(-360,360))),15,15,25,-0.15,Color3.new(r/255,g/255,b/255),0)
MagniDamage(ba, 1, 5,25, 0, "Normal")
end
a:Destroy()
a2:Destroy()
ba:Destroy()
orb:Destroy()
orbe:Destroy()
legAnims=true
WalkSpeed=orig
NeutralAnims = true
Hum.AutoRotate = true
Attack = false
end

local FANTASTICNINJAMODE1 = false
local FANTASTICNINJAMODE2 = false
local FANTASTICNINJAMODE3 = false
local FANTASTICNINJAMODE4 = false
local FANTASTICNINJAMODE5 = false

function NinjasWip()
Attack = true
NeutralAnims = false
local orig=WalkSpeed
WalkSpeed=4
legAnims=false
local NINJAval = math.random(1,255)
local NINJAclr = Color3.fromRGB(NINJAval,NINJAval,0)
local rngb = Instance.new("Part", Char)
        rngb.Anchored = true
        rngb.Color = NINJAclr
        rngb.CanCollide = false
        rngb.FormFactor = 3
        rngb.Name = "Ring"
        rngb.Material = "Neon"
        rngb.Size = Vector3.new(1, 0.05, 1)
        rngb.Transparency = 1
        rngb.TopSurface = 0
        rngb.BottomSurface = 0
        local rngmb = Instance.new("SpecialMesh", rngb)
        rngmb.MeshType = "Brick"
rngmb.Name = "SizeMesh"
rngmb.Scale = V3.N(0,1,0)
local orb = rngb:Clone()
orb.Parent = Char
orb.Transparency = 0
orb.Color = NINJAclr
orb.Size = V3.N(1,1,1)
local orbmish = orb.SizeMesh
orbmish.Scale = V3.N(0,0,0)
orbmish.MeshType = "Sphere"
local orbe = rngb:Clone()
orbe.Parent = Char
orbe.Transparency = 0
orbe.Size = V3.N(1,1,1)
local orbmish2 = orbe.SizeMesh
orbmish2.Scale = V3.N(0,0,0)
orbmish2.MeshType = "Sphere"
orbe.Color = NINJAclr
Hum.AutoRotate = false
rngb:Destroy()
--[[CFuncs["Sound"].Create("rbxassetid://136007472", orb, 1.5, 1)
local scaled = 1
for i = 0,5,0.1 do
swait()
scaled = scaled - 0.02
if rainbowmode == true then
orbe.Color = Color3.new(r/255,g/255,b/255)
end
orbmish.Scale = orbmish.Scale + vt(scaled/1.5,scaled/1.5,scaled/1.5)
orbmish2.Scale = orbmish2.Scale + vt(scaled*1.1/1.5,scaled*1.1/1.5,scaled*1.1/1.5)
orb.CFrame = root.CFrame*CFrame.new(0,0.5,0) + root.CFrame.lookVector*11.5
orbe.CFrame = root.CFrame*CFrame.new(0,0.5,0) + root.CFrame.lookVector*11.5
sphereMKCharge(2.5,-0.5,"Add",orb.CFrame*CFrame.Angles(math.rad(math.random(-360,360)),math.rad(math.random(-360,360)),math.rad(math.random(-360,360))),2.5,2.5,15,-0.025,MAINRUINCOLOR,25)
            RootJoint.C0 = clerp(RootJoint.C0,RootCF*cf(0,0,0)* angles(math.rad(0),math.rad(0),math.rad(90)),0.3)
Torso.Neck.C0 = clerp(Torso.Neck.C0,necko *angles(math.rad(0),math.rad(0),math.rad(-90)),.3)
RW.C0 = clerp(RW.C0, CFrame.new(1.5, 0.5, 0) * angles(math.rad(90), math.rad(0), math.rad(90)), 0.3)
LW.C0 = clerp(LW.C0, CFrame.new(-1.5, 0.5, 0) * angles(math.rad(10), math.rad(0), math.rad(-20)), 0.3)
RH.C0=clerp(RH.C0,cf(1,-1 - 0.05 * math.cos(sine / 25),0)*angles(math.rad(0),math.rad(90),math.rad(0))*angles(math.rad(-0.5),math.rad(0),math.rad(0)),.3)
LH.C0=clerp(LH.C0,cf(-1,-1 - 0.05 * math.cos(sine / 25),0)*angles(math.rad(0),math.rad(-90),math.rad(0))*angles(math.rad(-2.5),math.rad(10),math.rad(0)),.3)
RootPart.CFrame = FaceMouse()[1]
end]]--
for i = 0,5,0.1 do
swait()
orb.CFrame = Root.CFrame*CFrame.new(0,0.5,0) + Root.CFrame.lookVector*11.5
orbe.CFrame = Root.CFrame*CFrame.new(0,0.5,0) + Root.CFrame.lookVector*11.5
swait()
local Alpha = .3
RJ.C0 = RJ.C0:lerp(CF.N(0,0,0)*CF.A(M.R(0),M.R(70.7),M.R(0)),Alpha)
LH.C0 = LH.C0:lerp(CF.N(-0.5,-1,0)*CF.A(M.R(0),M.R(0),M.R(-14.4)),Alpha)
RH.C0 = RH.C0:lerp(CF.N(0.6,-1,0)*CF.A(M.R(15.1),M.R(-63.2),M.R(13.5)),Alpha)
LS.C0 = LS.C0:lerp(CF.N(-1.3,0.6,-0.1)*CF.A(M.R(0),M.R(15.9),M.R(-25.4)),Alpha)
RS.C0 = RS.C0:lerp(CF.N(1.4,0.3,-0.2)*CF.A(M.R(0),M.R(19.3),M.R(157.1)),Alpha)
NK.C0 = NK.C0:lerp(CF.N(0,1.5,0)*CF.A(M.R(0),M.R(-70.7),M.R(0)),Alpha)
Root.CFrame = FaceMouse()[1]
end
orbe.Transparency = 1
orb.Transparency = 1
orb.CFrame = Root.CFrame*CFrame.new(0,0.5,0) + Root.CFrame.lookVector*5
CFuncs["Sound"].Create("rbxassetid://294188875", Char, 1, 1)
local a = Instance.new("Part",Char)
    a.Name = "Direction"   
    a.Anchored = true
    a.Color = NINJAclr
a.Material = "Neon"
a.Transparency = 0
a.Shape = "Cylinder"
    a.CanCollide = false
local a2 = Instance.new("Part",Char)
    a2.Name = "Direction"  
    a2.Anchored = true
    a2.Color = NINJAclr
a2.Color = NINJAclr
a2.Material = "Neon"
a2.Transparency = 0.5
a2.Shape = "Cylinder"
    a2.CanCollide = false
local ba = Instance.new("Part",Char)
    ba.Name = "HitDirect"  
    ba.Anchored = true
    ba.Color = NINJAclr
ba.Material = "Neon"
ba.Transparency = 1
    ba.CanCollide = false
    local ray = Ray.new(
        orb.CFrame.p,                           -- origin
        (Mouse.Hit.p - orb.CFrame.p).unit * 1000 -- direction
    )
    local ignore = Char
    local hit, position, normal = workspace:FindPartOnRay(ray, ignore)
    a.BottomSurface = 10
    a.TopSurface = 10
    a2.BottomSurface = 10
    a2.TopSurface = 10
    local distance = (orb.CFrame.p - position).magnitude
    a.Size = Vector3.new(distance, 1, 1)
    a.CFrame = CFrame.new(orb.CFrame.p, position) * CFrame.new(0, 0, -distance/2)
    a2.Size = Vector3.new(distance, 1, 1)
    a2.CFrame = CFrame.new(orb.CFrame.p, position) * CFrame.new(0, 0, -distance/2)
ba.CFrame = CFrame.new(orb.CFrame.p, position) * CFrame.new(0, 0, -distance)
a.CFrame = a.CFrame*CFrame.Angles(0,math.rad(90),0)
a2.CFrame = a2.CFrame*CFrame.Angles(0,math.rad(90),0)
game:GetService("Debris"):AddItem(a, 20)
game:GetService("Debris"):AddItem(a2, 20)
game:GetService("Debris"):AddItem(ba, 20)
local msh = Instance.new("SpecialMesh",a)
msh.MeshType = "Cylinder"
msh.Scale = V3.N(1,5*5,5*5)
local msh2 = Instance.new("SpecialMesh",a2)
msh2.MeshType = "Cylinder"
msh2.Scale = V3.N(1,6*5,6*5)
 
for i = 0,10,0.1 do
swait()
CameraEnshaking(1,5)
orb.CFrame = Root.CFrame*CFrame.new(0,0.5,0) + Root.CFrame.lookVector*4
orbe.CFrame = Root.CFrame*CFrame.new(0,0.5,0) + Root.CFrame.lookVector*4
ray = Ray.new(
        orb.CFrame.p,                           -- origin
        (Mouse.Hit.p - orb.CFrame.p).unit * 1000 -- direction
    )
hit, position, normal = workspace:FindPartOnRay(ray, ignore)
distance = (orb.CFrame.p - position).magnitude
if typrot == 1 then
rotation = rotation + 2.5
elseif typrot == 2 then
rotation = rotation - 2.5
end
Root.CFrame = FaceMouse()[1]
a.Size = Vector3.new(distance, 1, 1)
a.CFrame = CFrame.new(orb.CFrame.p, position) * CFrame.new(0, 0, -distance/2)
a2.Size = Vector3.new(distance, 1, 1)
a2.CFrame = CFrame.new(orb.CFrame.p, position) * CFrame.new(0, 0, -distance/2)
ba.CFrame = CFrame.new(orb.CFrame.p, position) * CFrame.new(0, 0, -distance)
a.CFrame = a.CFrame*CFrame.Angles(0,math.rad(90),0)
a2.CFrame = a2.CFrame*CFrame.Angles(0,math.rad(90),0)
msh.Scale = msh.Scale - V3.N(0,0.05*1,0.05*1)
msh2.Scale = msh2.Scale - V3.N(0,0.06*1,0.06*1)
NsphereMK(5,1.5,"Add",ba.CFrame*CFrame.Angles(math.rad(math.random(-360,360)),math.rad(math.random(-360,360)),math.rad(math.random(-360,360))),15,15,25,-0.15,Color3.fromRGB(NINJAval,NINJAval,0),0)
NsphereMK(5,1.5,"Add",ba.CFrame*CFrame.Angles(math.rad(math.random(-360,360)),math.rad(math.random(-360,360)),math.rad(math.random(-360,360))),15,15,25,-0.15,Color3.fromRGB(NINJAval,NINJAval,0),0)
MagniDamage(ba, 1, 5,25, 0, "Normal")
end
a:Destroy()
a2:Destroy()
ba:Destroy()
orb:Destroy()
orbe:Destroy()
legAnims=true
WalkSpeed=orig
NeutralAnims = true
Hum.AutoRotate = true
Attack = false
end

function Wip()
Attack = true
NeutralAnims = false
local orig=WalkSpeed
WalkSpeed=4
legAnims=false
local NINJAclr = Color3.fromRGB(0,0,0)
local rngb = Instance.new("Part", Char)
        rngb.Anchored = true
        rngb.Color = NINJAclr
        rngb.CanCollide = false
        rngb.FormFactor = 3
        rngb.Name = "Ring"
        rngb.Material = "Neon"
        rngb.Size = Vector3.new(1, 0.05, 1)
        rngb.Transparency = 1
        rngb.TopSurface = 0
        rngb.BottomSurface = 0
        local rngmb = Instance.new("SpecialMesh", rngb)
        rngmb.MeshType = "Brick"
rngmb.Name = "SizeMesh"
rngmb.Scale = V3.N(0,1,0)
 
local orb = rngb:Clone()
orb.Parent = Char
orb.Transparency = 0
orb.Color = NINJAclr
orb.Size = V3.N(1,1,1)
local orbmish = orb.SizeMesh
orbmish.Scale = V3.N(0,0,0)
orbmish.MeshType = "Sphere"
 
local orbe = rngb:Clone()
orbe.Parent = Char
orbe.Transparency = 0
orbe.Size = V3.N(1,1,1)
local orbmish2 = orbe.SizeMesh
orbmish2.Scale = V3.N(0,0,0)
orbmish2.MeshType = "Sphere"
orbe.Color = NINJAclr
 
Hum.AutoRotate = false
rngb:Destroy()
--[[CFuncs["Sound"].Create("rbxassetid://136007472", orb, 1.5, 1)
local scaled = 1
for i = 0,5,0.1 do
swait()
scaled = scaled - 0.02
if rainbowmode == true then
orbe.Color = Color3.new(r/255,g/255,b/255)
end
orbmish.Scale = orbmish.Scale + vt(scaled/1.5,scaled/1.5,scaled/1.5)
orbmish2.Scale = orbmish2.Scale + vt(scaled*1.1/1.5,scaled*1.1/1.5,scaled*1.1/1.5)
orb.CFrame = root.CFrame*CFrame.new(0,0.5,0) + root.CFrame.lookVector*11.5
orbe.CFrame = root.CFrame*CFrame.new(0,0.5,0) + root.CFrame.lookVector*11.5
sphereMKCharge(2.5,-0.5,"Add",orb.CFrame*CFrame.Angles(math.rad(math.random(-360,360)),math.rad(math.random(-360,360)),math.rad(math.random(-360,360))),2.5,2.5,15,-0.025,MAINRUINCOLOR,25)
            RootJoint.C0 = clerp(RootJoint.C0,RootCF*cf(0,0,0)* angles(math.rad(0),math.rad(0),math.rad(90)),0.3)
Torso.Neck.C0 = clerp(Torso.Neck.C0,necko *angles(math.rad(0),math.rad(0),math.rad(-90)),.3)
RW.C0 = clerp(RW.C0, CFrame.new(1.5, 0.5, 0) * angles(math.rad(90), math.rad(0), math.rad(90)), 0.3)
LW.C0 = clerp(LW.C0, CFrame.new(-1.5, 0.5, 0) * angles(math.rad(10), math.rad(0), math.rad(-20)), 0.3)
RH.C0=clerp(RH.C0,cf(1,-1 - 0.05 * math.cos(sine / 25),0)*angles(math.rad(0),math.rad(90),math.rad(0))*angles(math.rad(-0.5),math.rad(0),math.rad(0)),.3)
LH.C0=clerp(LH.C0,cf(-1,-1 - 0.05 * math.cos(sine / 25),0)*angles(math.rad(0),math.rad(-90),math.rad(0))*angles(math.rad(-2.5),math.rad(10),math.rad(0)),.3)
RootPart.CFrame = FaceMouse()[1]
end]]--
for i = 0,5,0.1 do
swait()
if rainbowmode == true then
orbe.Color = Color3.new(r/255,g/255,b/255)
end
        if glitchymode then
            local val = math.random(1,255)
            local color = Color3.fromRGB(val,val,val)
            orbe.Color = color
        end
orb.CFrame = Root.CFrame*CFrame.new(0,0.5,0) + Root.CFrame.lookVector*11.5
orbe.CFrame = Root.CFrame*CFrame.new(0,0.5,0) + Root.CFrame.lookVector*11.5
swait()
local Alpha = .3
RJ.C0 = RJ.C0:lerp(CF.N(0,0,0)*CF.A(M.R(0),M.R(70.7),M.R(0)),Alpha)
LH.C0 = LH.C0:lerp(CF.N(-0.5,-1,0)*CF.A(M.R(0),M.R(0),M.R(-14.4)),Alpha)
RH.C0 = RH.C0:lerp(CF.N(0.6,-1,0)*CF.A(M.R(15.1),M.R(-63.2),M.R(13.5)),Alpha)
LS.C0 = LS.C0:lerp(CF.N(-1.3,0.6,-0.1)*CF.A(M.R(0),M.R(15.9),M.R(-25.4)),Alpha)
RS.C0 = RS.C0:lerp(CF.N(1.4,0.3,-0.2)*CF.A(M.R(0),M.R(19.3),M.R(157.1)),Alpha)
NK.C0 = NK.C0:lerp(CF.N(0,1.5,0)*CF.A(M.R(0),M.R(-70.7),M.R(0)),Alpha)
Root.CFrame = FaceMouse()[1]
end
orbe.Transparency = 1
orb.Transparency = 1
orb.CFrame = Root.CFrame*CFrame.new(0,0.5,0) + Root.CFrame.lookVector*5
CFuncs["Sound"].Create("rbxassetid://294188875", Char, 1, 1)
local a = Instance.new("Part",Char)
    a.Name = "Direction"   
    a.Anchored = true
    a.Color = NINJAclr
a.Material = "Neon"
a.Transparency = 0
a.Shape = "Cylinder"
    a.CanCollide = false
local a2 = Instance.new("Part",Char)
    a2.Name = "Direction"  
    a2.Anchored = true
    a2.Color = NINJAclr
a2.Color = NINJAclr
a2.Material = "Neon"
a2.Transparency = 0.5
a2.Shape = "Cylinder"
    a2.CanCollide = false
local ba = Instance.new("Part",Char)
    ba.Name = "HitDirect"  
    ba.Anchored = true
    ba.Color = NINJAclr
ba.Material = "Neon"
ba.Transparency = 1
    ba.CanCollide = false
    local ray = Ray.new(
        orb.CFrame.p,                           -- origin
        (Mouse.Hit.p - orb.CFrame.p).unit * 1000 -- direction
    )
    local ignore = Char
    local hit, position, normal = workspace:FindPartOnRay(ray, ignore)
    a.BottomSurface = 10
    a.TopSurface = 10
    a2.BottomSurface = 10
    a2.TopSurface = 10
    local distance = (orb.CFrame.p - position).magnitude
    a.Size = Vector3.new(distance, 1, 1)
    a.CFrame = CFrame.new(orb.CFrame.p, position) * CFrame.new(0, 0, -distance/2)
    a2.Size = Vector3.new(distance, 1, 1)
    a2.CFrame = CFrame.new(orb.CFrame.p, position) * CFrame.new(0, 0, -distance/2)
ba.CFrame = CFrame.new(orb.CFrame.p, position) * CFrame.new(0, 0, -distance)
a.CFrame = a.CFrame*CFrame.Angles(0,math.rad(90),0)
a2.CFrame = a2.CFrame*CFrame.Angles(0,math.rad(90),0)
game:GetService("Debris"):AddItem(a, 20)
game:GetService("Debris"):AddItem(a2, 20)
game:GetService("Debris"):AddItem(ba, 20)
local msh = Instance.new("SpecialMesh",a)
msh.MeshType = "Cylinder"
msh.Scale = V3.N(1,5*5,5*5)
local msh2 = Instance.new("SpecialMesh",a2)
msh2.MeshType = "Cylinder"
msh2.Scale = V3.N(1,6*5,6*5)
 
for i = 0,10,0.1 do
swait()
CameraEnshaking(1,5)
a2.Color = NINJAclr
orb.CFrame = Root.CFrame*CFrame.new(0,0.5,0) + Root.CFrame.lookVector*4
orbe.CFrame = Root.CFrame*CFrame.new(0,0.5,0) + Root.CFrame.lookVector*4
ray = Ray.new(
        orb.CFrame.p,                           -- origin
        (Mouse.Hit.p - orb.CFrame.p).unit * 1000 -- direction
    )
hit, position, normal = workspace:FindPartOnRay(ray, ignore)
distance = (orb.CFrame.p - position).magnitude
if typrot == 1 then
rotation = rotation + 2.5
elseif typrot == 2 then
rotation = rotation - 2.5
end
Root.CFrame = FaceMouse()[1]
a.Size = Vector3.new(distance, 1, 1)
a.CFrame = CFrame.new(orb.CFrame.p, position) * CFrame.new(0, 0, -distance/2)
a2.Size = Vector3.new(distance, 1, 1)
a2.CFrame = CFrame.new(orb.CFrame.p, position) * CFrame.new(0, 0, -distance/2)
ba.CFrame = CFrame.new(orb.CFrame.p, position) * CFrame.new(0, 0, -distance)
a.CFrame = a.CFrame*CFrame.Angles(0,math.rad(90),0)
a2.CFrame = a2.CFrame*CFrame.Angles(0,math.rad(90),0)
msh.Scale = msh.Scale - V3.N(0,0.05*1,0.05*1)
msh2.Scale = msh2.Scale - V3.N(0,0.06*1,0.06*1)
RsphereMK(5,1.5,"Add",ba.CFrame*CFrame.Angles(math.rad(math.random(-360,360)),math.rad(math.random(-360,360)),math.rad(math.random(-360,360))),15,15,25,-0.15,NINJAclr,0)
RsphereMK(5,1.5,"Add",ba.CFrame*CFrame.Angles(math.rad(math.random(-360,360)),math.rad(math.random(-360,360)),math.rad(math.random(-360,360))),15,15,25,-0.15,NINJAclr,0)
MagniDamage(ba, 1, 5,25, 0, "Normal")
end
a:Destroy()
a2:Destroy()
ba:Destroy()
orb:Destroy()
orbe:Destroy()
legAnims=true
WalkSpeed=orig
NeutralAnims = true
Hum.AutoRotate = true
Attack = false
end

function sphere(bonuspeed,type,pos,scale,value,color,heart,invert,notaffectbychaosrainbow)
local type = type
local rng = Instance.new("Part", Char)
        rng.Anchored = true
        rng.BrickColor = color
        rng.CanCollide = false
        rng.FormFactor = 3
        rng.Name = "Ring"
        rng.Material = "Neon"
        rng.Size = Vector3.new(1, 1, 1)
        rng.Transparency = 0
        rng.TopSurface = 0
        rng.BottomSurface = 0
        rng.CFrame = pos
        local rngm = Instance.new("SpecialMesh", rng)
        rngm.MeshType = "Sphere"
   
 
if(heart)then
    rngm.MeshType = Enum.MeshType.FileMesh
    rngm.MeshId = "rbxassetid://105992239"
    rngm.Offset = Vector3.new(0,0,-.25)
end
rngm.Scale = scale
if rainbowmode == true and not notaffectbychaosrainbow then
rng.Color = Color3.new(r/255,g/255,b/255)
end
local scaler2 = 1
if type == "Add" then
scaler2 = 1*value
elseif type == "Divide" then
scaler2 = 1/value
end
coroutine.resume(coroutine.create(function()
for i = 0,10/bonuspeed,0.1 do
swait()
if rainbowmode == true and not notaffectbychaosrainbow then
rng.Color = Color3.new(r/255,g/255,b/255)
end
if type == "Add" then
scaler2 = scaler2 - 0.01*value/bonuspeed
elseif type == "Divide" then
scaler2 = scaler2 - 0.01/value*bonuspeed
end
if chaosmode == true and not notaffectbychaosrainbow then
rng.BrickColor = BrickColor.random()
end
        if glitchymode then
            local val = math.random(1,255)
            local color = Color3.fromRGB(val,val,val)
            rng.Color = color
        end
rng.Transparency = rng.Transparency + 0.01*bonuspeed
if(invert)then
    if(heart)then
        rngm.Scale = rngm.Scale - Vector3.new(scaler2*bonuspeed, scaler2*bonuspeed, 0)
    else
        rngm.Scale = rngm.Scale - Vector3.new(scaler2*bonuspeed, scaler2*bonuspeed, scaler2*bonuspeed)
    end
else
    if(heart)then
        rngm.Scale = rngm.Scale + Vector3.new(scaler2*bonuspeed, scaler2*bonuspeed, 0)
    else
        rngm.Scale = rngm.Scale + Vector3.new(scaler2*bonuspeed, scaler2*bonuspeed, scaler2*bonuspeed)
    end
end
rng.CFrame = pos
end
rng:Destroy()
end))
end

function orb_spawn_norm(positted,timer,color,MagniBoost,min,max,volEx,ShakePower,volSummon)
local orb = Instance.new("Part", Char)
        orb.Anchored = true
        orb.BrickColor = color
        orb.CanCollide = false
        orb.FormFactor = 3
        orb.Name = "Ring"
        orb.Material = "Neon"
        orb.Size = Vector3.new(1, 1, 1)
        orb.Transparency = 0
        orb.TopSurface = 0
        orb.BottomSurface = 0
        local orbm = Instance.new("SpecialMesh", orb)
        orbm.MeshType = "Sphere"
orb.CFrame = positted
orbm.Name = "SizeMesh"
orbm.Scale = V3.N(1,1,1)
coroutine.wrap(function()
    while orb and orb.Parent do
        if glitchymode then
            local val = math.random(1,255)
            local color = Color3.fromRGB(val,val,val)
            orb.Color = color
        end
        swait()
    end
end)()
CFuncs["Sound"].Create("rbxassetid://183763506", orb, volSummon, 1)
sphere(2.5,"Add",orb.CFrame,V3.N(1,1,1),0.05,orb.BrickColor)
--[[for i = 0, 2 do
sphereMK(5,0.15,"Add",orb.CFrame*CFrame.Angles(math.rad(math.random(-360,360)),math.rad(math.random(-360,360)),math.rad(math.random(-360,360))),1.5,1.5,7.5,-0.015,orb.BrickColor,0)
end]]--
coroutine.resume(coroutine.create(function()
wait(timer)
CameraEnshaking(3,ShakePower)
orb.Transparency = 1
MagniDamage(orb, 3.5*MagniBoost, min,max, 0, "Normal")
sphere(5,"Add",orb.CFrame,V3.N(1,1,1),0.1*MagniBoost,orb.BrickColor)
--[[for i = 0, 4 do
sphereMK(5,0.15*MagniBoost,"Add",orb.CFrame*CFrame.Angles(math.rad(math.random(-360,360)),math.rad(math.random(-360,360)),math.rad(math.random(-360,360))),2.5,2.5,15,-0.025,orb.BrickColor,0)
end]]--
CFuncs["Sound"].Create("rbxassetid://192410089", orb, volEx, 0.7)
wait(3)
orb:Destroy()
end))
end

function orb_spawn(positted,timer)
local orb = Instance.new("Part", Char)
        orb.Anchored = true
        orb.BrickColor = BrickColor.new("White")
 
        orb.CanCollide = false
        orb.FormFactor = 3
        orb.Name = "Ring"
        orb.Material = "Neon"
        orb.Size = Vector3.new(1, 1, 1)
        orb.Transparency = 0
        orb.TopSurface = 0
        orb.BottomSurface = 0
        local orbm = Instance.new("SpecialMesh", orb)
        orbm.MeshType = "Sphere"
orb.CFrame = positted
orbm.Name = "SizeMesh"
orbm.Scale = V3.N(1,1,1)
CFuncs["Sound"].Create("rbxassetid://183763506", orb, 1.5, 1)
sphere(2.5,"Add",orb.CFrame,V3.N(1,1,1),0.025,orb.BrickColor)
coroutine.wrap(function()
    while orb and orb.Parent do
        if glitchymode then
            local val = math.random(1,255)
            local color = Color3.fromRGB(val,val,val)
            orb.Color = color
        end
        swait()
    end
end)()
for i = 0, 2 do
sphereMK(5,0.15,"Add",orb.CFrame*CFrame.Angles(math.rad(math.random(-360,360)),math.rad(math.random(-360,360)),math.rad(math.random(-360,360))),1.5,1.5,7.5,-0.015,orb.BrickColor,0)
end
 
coroutine.resume(coroutine.create(function()
wait(timer)
CameraEnshaking(3,2)
orb.Transparency = 1
MagniDamage(orb, 17.5, 10,50, 0, "Normal")
sphere(5,"Add",orb.CFrame,V3.N(1,1,1),0.5,orb.BrickColor)
for i = 0, 4 do
sphereMK(5,0.65,"Add",orb.CFrame*CFrame.Angles(math.rad(math.random(-360,360)),math.rad(math.random(-360,360)),math.rad(math.random(-360,360))),2.5,2.5,15,-0.025,orb.BrickColor,0)
end
CFuncs["Sound"].Create("rbxassetid://192410089", orb, 2, 0.7)
wait(3)
orb:Destroy()
end))
end

function scatteryourinnerglitch()
Attack = true
NeutralAnims = false
local orig=WalkSpeed
WalkSpeed=4
legAnims=false
local rot = 0
local randomrotations = math.random(1,2)
local lookv = 2.5
local power = 5
sphere(1,"Add",Root.CFrame,V3.N(1,100000,1),0.5,BrickColor.new("Royal purple"))
sphere(1,"Add",Root.CFrame,V3.N(1,1,1),0.75,BrickColor.new("Royal purple"))
for i = 0, 9 do
sphereMK(1,1.5,"Add",Root.CFrame*CFrame.Angles(math.rad(math.random(-360,360)),math.rad(math.random(-360,360)),math.rad(math.random(-360,360))),10,10,45,-0.1,BrickColor.new("Royal purple"),0)
end
local hite = Instance.new("Part", Char)
        hite.Anchored = true
        hite.CanCollide = false
        hite.FormFactor = 3
        hite.Name = "Ring"
        hite.Material = "Neon"
        hite.Size = Vector3.new(1, 1, 1)
        hite.Transparency = 1
        hite.TopSurface = 0
        hite.BottomSurface = 0
hite.CFrame = Root.CFrame*CFrame.new(0,-2.5,0)
local rem = Instance.new("Part", Char)
        rem.Anchored = true
        rem.CanCollide = false
        rem.FormFactor = 3
        rem.Name = "Ring"
        rem.Material = "Neon"
        rem.Size = Vector3.new(1, 1, 1)
        rem.Transparency = 1
        rem.TopSurface = 0
        rem.BottomSurface = 0
rem.CFrame = hite.CFrame
local rem2 = rem:Clone()
rem2.Parent = Char
rem2.CFrame = rem.CFrame*CFrame.Angles(0,math.rad(90),0)
local rem3 = rem:Clone()
rem3.Parent = Char
rem3.CFrame = rem.CFrame*CFrame.Angles(0,math.rad(180),0)
local rem4 = rem:Clone()
rem4.Parent = Char
rem4.CFrame = rem.CFrame*CFrame.Angles(0,math.rad(270),0)
hite:Destroy()
coroutine.resume(coroutine.create(function()
for i = 0, 24 do
swait(1)
if randomrotations == 1 then
rot = rot + 1
elseif randomrotations == 2 then
rot = rot - 1
end
power = power + 0.5
lookv = lookv + 7.5
rem.CFrame = rem.CFrame*CFrame.Angles(0,math.rad(rot),0)
rem2.CFrame = rem.CFrame*CFrame.Angles(0,math.rad(90),0)
rem3.CFrame = rem.CFrame*CFrame.Angles(0,math.rad(180),0)
rem4.CFrame = rem.CFrame*CFrame.Angles(0,math.rad(270),0)
orb_spawn_norm(rem.CFrame + rem.CFrame.lookVector*lookv,3,BrickColor.new("Royal purple"),power,25,75,10,power/5,7.5)
orb_spawn_norm(rem2.CFrame + rem2.CFrame.lookVector*lookv,3,BrickColor.new("Royal purple"),power,25,75,10,power/5,7.5)
orb_spawn_norm(rem3.CFrame + rem3.CFrame.lookVector*lookv,3,BrickColor.new("Royal purple"),power,25,75,10,power/5,7.5)
orb_spawn_norm(rem4.CFrame + rem4.CFrame.lookVector*lookv,3,BrickColor.new("Royal purple"),power,25,75,10,power/5,7.5)
end
end))
Attack = false
end
function yinyangi()
Attack = true
for i = 0, 2, 0.1 do
swait()
end
local bv = Instance.new("BodyVelocity")
bv.maxForce = Vector3.new(1e9, 1e9, 1e9)
bv.velocity = Root.CFrame.lookVector*175
bv.Parent = Root
for Rotations = 0, 9 do
 
for i = 0, 1, 0.5 do
swait()
bv.velocity = Root.CFrame.lookVector*175
end
 
orb_spawn(RArm.CFrame*CFrame.new(0,-1,0),2.5)
for i = 0, 1, 0.5 do
swait()
bv.velocity = Root.CFrame.lookVector*175
end
 
orb_spawn(RArm.CFrame*CFrame.new(0,-1,0),2.5)
for i = 0, 1, 0.5 do
swait()
bv.velocity = Root.CFrame.lookVector*175
end
 
orb_spawn(RArm.CFrame*CFrame.new(0,-1,0),2.5)
for i = 0, 1, 0.5 do
swait()
bv.velocity = Root.CFrame.lookVector*175
end
 
orb_spawn(RArm.CFrame*CFrame.new(0,-1,0),2.5)
end
bv:Destroy()
legAnims=true
local orig=WalkSpeed
WalkSpeed=orig
NeutralAnims = true
Hum.AutoRotate = true
Attack = false
end

function FindNearestHead(Position, Distance, SinglePlayer)
    if SinglePlayer then
        return (SinglePlayer.Torso.CFrame.p - Position).magnitude < Distance
    end
    local List = {}
    for i, v in pairs(workspace:GetChildren()) do
        if v:IsA("Model") then
            if v:findFirstChild("Head") then
                if v ~= Char then
                    if (v.Head.Position - Position).magnitude <= Distance then
                        table.insert(List, v)
                    end
                end
            end
        end
    end
    return List
end

function dmgstart(dmg,what)
    hitcon = what.Touched:connect(function(hit)
        local hum = hit.Parent:FindFirstChild("Humanoid")
        if hum and not hum:IsDescendantOf(Char) then
            hum:TakeDamage(dmg)
        end
    end)
end
 
function dmgstop()
    hitcon:disconnect()
end

function dmg(dude)
if dude.Name ~= Char then
local bgf = Instance.new("BodyGyro",dude.Head)
bgf.CFrame = bgf.CFrame * CFrame.fromEulerAnglesXYZ(math.rad(-90),0,0)
local val = Instance.new("BoolValue",dude)
val.Name = "IsHit"
local ds = coroutine.wrap(function()
local torso = dude:FindFirstChild'Torso' or dude:FindFirstChild'UpperTorso'
for i = 1, 10 do
    sphereMK(1.5,2,"Add",torso.CFrame*CFrame.Angles(math.rad(math.random(-360,360)),math.rad(math.random(-360,360)),math.rad(math.random(-360,360))),1,1,25,-.01,BrickColor.new("White"),0,true)
end
dude:WaitForChild("Head"):BreakJoints()
wait(0.5)
targetted = nil
CFuncs["Sound"].Create("rbxassetid://62339698", Char, 0.5, 0.3)
 
coroutine.resume(coroutine.create(function()
for i, v in pairs(dude:GetChildren()) do
if v:IsA("Accessory") then
v:Destroy()
end
if v:IsA("Humanoid") then
v:Destroy()
end
if v:IsA("CharacterMesh") then
v:Destroy()
end
if v:IsA("Model") then
v:Destroy()
end
if v:IsA("Part") or v:IsA("MeshPart") then
for x, o in pairs(v:GetChildren()) do
if o:IsA("Decal") then
o:Destroy()
end
end
coroutine.resume(coroutine.create(function()
v.Material = "Neon"
v.CanCollide = false
local bld = Instance.new("ParticleEmitter",v)
bld.LightEmission = 1
bld.Texture = "rbxassetid://284205403"
bld.Color = ColorSequence.new(Color3.new(1,1,1))
bld.Rate = 50
bld.Lifetime = NumberRange.new(1)
bld.Size = NumberSequence.new({NumberSequenceKeypoint.new(0,0.75,0),NumberSequenceKeypoint.new(1,0,0)})
bld.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0,0,0),NumberSequenceKeypoint.new(1,1,0)})
bld.Speed = NumberRange.new(0,0)
bld.VelocitySpread = 50000
bld.Rotation = NumberRange.new(-500,500)
bld.RotSpeed = NumberRange.new(-500,500)
        local sbs = Instance.new("BodyPosition", v)
        sbs.P = 3000
        sbs.D = 1000
        sbs.maxForce = Vector3.new(50000000000, 50000000000, 50000000000)
        sbs.position = v.Position + Vector3.new(math.random(-5,5),math.random(-5,5),math.random(-5,5))
v.Color = Color3.new(1,1,1)
coroutine.resume(coroutine.create(function()
for i = 0, 49 do
swait(1)
v.Transparency = v.Transparency + 0.02
end
CFuncs["Sound"].Create("rbxassetid://1192402877", v, 0.25, 1)
bld.Speed = NumberRange.new(1,5)
bld.Acceleration = V3.N(0,10,0)
wait(0.5)
bld.Enabled = false
wait(3)
v:Destroy()
dude:Destroy()
end))
end))
end
end
end))
end)
ds()
end
end

function Stompie()
Attack = true
NeutralAnims = false
local orig=WalkSpeed
WalkSpeed=4
legAnims=false
for i = 0, 2, 0.1 do
			local Alpha = .1
			RJ.C0 = RJ.C0:lerp(RJC0*CF.N(0,-.1,0)*CF.A(M.R(25),0,0),Alpha)
			NK.C0 = NK.C0:lerp(NKC0,Alpha)
			LH.C0 = LH.C0:lerp(LHC0*CF.N(0,.75,-.5),Alpha)
			RH.C0 = RH.C0:lerp(RHC0*CF.A(M.R(-25),0,0),Alpha)
			LS.C0 = LS.C0:lerp(LSC0*CF.A(M.R(-25),0,M.R(-15)),Alpha)
			RS.C0 = RS.C0:lerp(RSC0*CF.A(M.R(-25),0,M.R(15)),Alpha)
			swait()
end
CFuncs["Sound"].Create("rbxassetid://438666141", Root, 7.5,1)
CFuncs["Sound"].Create("rbxassetid://1208650519", Root, 7.5, 1)
CameraEnshaking(4,12)
for i, v in pairs(FindNearestHead(Torso.CFrame.p, 52.5)) do
if v:FindFirstChild('Head') then
dmg(v)
end
end
sphere(5,"Add",Root.CFrame*CFrame.new(0,-2.9,0),V3.N(0,0,0),1,BrickColor.random())
sphere(10,"Add",Root.CFrame*CFrame.new(0,-2.9,0),V3.N(0,0,0),2,BrickColor.random())
sphere(1,"Add",Root.CFrame*CFrame.new(0,-2.9,0),V3.N(100,0.1,100),0.01,BrickColor.random())
		local PlayerSize = 1
		local hitfloor,posfloor = workspace:FindPartOnRay(Ray.new(Root.CFrame.p,((CFrame.new(Root.Position,Root.Position - Vector3.new(0,1,0))).lookVector).unit * (4*PlayerSize)), Char)
		repeat swait() hitfloor,posfloor = workspace:FindPartOnRay(Ray.new(Root.CFrame.p,((CFrame.new(Root.Position,Root.Position - Vector3.new(0,1,0))).lookVector).unit * (4*PlayerSize)), Char) until hitfloor
		Sound(Root,438666141,1,7.5,false,true,true)
for i = 0, 2, 0.1 do
swait()
sphereMK(2.5,0.75,"Add",Root.CFrame*CFrame.new(math.random(-52.5,52.5),-5,math.random(-52.5,52.5))*CFrame.Angles(math.rad(90 + math.rad(math.random(-45,45))),math.rad(math.random(-45,45)),math.rad(math.random(-45,45))),2.5,2.5,25,-0.025,BrickColor.random(),0)
sphereMK(2.5,0.75,"Add",Root.CFrame*CFrame.new(math.random(-52.5,52.5),-5,math.random(-52.5,52.5))*CFrame.Angles(math.rad(90 + math.rad(math.random(-45,45))),math.rad(math.random(-45,45)),math.rad(math.random(-45,45))),2.5,2.5,25,-0.025,BrickColor.random(),0)
			local Alpha = .3
			RJ.C0 = RJ.C0:lerp(RJC0*CF.N(0,-.1,0)*CF.A(M.R(-25),0,0),Alpha)
			NK.C0 = NK.C0:lerp(NKC0,Alpha)
			LH.C0 = LH.C0:lerp(LHC0*CF.N(0,0,-.5)*CF.A(M.R(25),0,0),Alpha)
			RH.C0 = RH.C0:lerp(RHC0*CF.A(M.R(25),0,0),Alpha)
			LS.C0 = LS.C0:lerp(LSC0*CF.A(M.R(-25),0,M.R(-15)),Alpha)
			RS.C0 = RS.C0:lerp(RSC0*CF.A(M.R(-25),0,M.R(15)),Alpha)
			swait()
end
legAnims=true
WalkSpeed=orig
NeutralAnims = true
Hum.AutoRotate = true
Attack = false
end

function PixelBlockNeg(bonuspeed,FastSpeed,type,pos,x1,y1,z1,value,color,outerpos,heart,invert)
local type = type
local rng = Instance.new("Part", Char)
        rng.Anchored = true
        rng.BrickColor = color
        rng.CanCollide = false
        rng.FormFactor = 3
        rng.Name = "Ring"
        rng.Material = "Neon"
        rng.Size = Vector3.new(1, 1, 1)
        rng.Transparency = 0
        rng.TopSurface = 0
        rng.BottomSurface = 0
        rng.CFrame = pos
rng.CFrame = rng.CFrame + rng.CFrame.lookVector*outerpos
        local rngm = Instance.new("SpecialMesh", rng)
        rngm.MeshType = "Brick"
if(heart)then
    rngm.MeshType = Enum.MeshType.FileMesh
    rngm.MeshId = "rbxassetid://105992239"
    rngm.Offset = Vector3.new(0,0,-.25)
end
rngm.Scale = V3.N(x1,y1,z1)
if rainbowmode == true then
rng.Color = Color3.new(r/255,g/255,b/255)
end
local scaler2 = 0
local speeder = FastSpeed/10
if type == "Add" then
scaler2 = 1*value
elseif type == "Divide" then
scaler2 = 1/value
end
coroutine.resume(coroutine.create(function()
for i = 0,10/bonuspeed,0.1 do
swait()
if rainbowmode == true then
rng.Color = Color3.new(r/255,g/255,b/255)
end
if type == "Add" then
scaler2 = scaler2 - 0.01*value/bonuspeed
elseif type == "Divide" then
scaler2 = scaler2 - 0.01/value*bonuspeed
end
if chaosmode == true then
rng.BrickColor = BrickColor.random()
end
        if glitchymode then
            local val = math.random(1,255)
            local color = Color3.fromRGB(val,val,val)
            rng.Color = color
        end
speeder = speeder + 0.01*FastSpeed*bonuspeed/10
rng.CFrame = rng.CFrame + rng.CFrame.lookVector*speeder*bonuspeed
if(invert)then rng.CFrame = rng.CFrame - rng.CFrame.lookVector*speeder*bonuspeed else rng.CFrame = rng.CFrame + rng.CFrame.lookVector*speeder*bonuspeed end
--rng.Transparency = rng.Transparency + 0.01*bonuspeed
rngm.Scale = rngm.Scale - Vector3.new(scaler2*bonuspeed, scaler2*bonuspeed, scaler2*bonuspeed)
end
rng:Destroy()
end))
end

function InsaneStompie()
Attack = true
NeutralAnims = false
local orig=WalkSpeed
WalkSpeed=4
legAnims=false
for i = 0, 8, 0.1 do
swait()
			local Alpha = .1
			RJ.C0 = RJ.C0:lerp(RJC0*CF.N(0,-.1,0)*CF.A(M.R(25),0,0),Alpha)
			NK.C0 = NK.C0:lerp(NKC0,Alpha)
			LH.C0 = LH.C0:lerp(LHC0*CF.N(0,.75,-.5),Alpha)
			RH.C0 = RH.C0:lerp(RHC0*CF.A(M.R(-25),0,0),Alpha)
			LS.C0 = LS.C0:lerp(LSC0*CF.A(M.R(-25),0,M.R(-15)),Alpha)
			RS.C0 = RS.C0:lerp(RSC0*CF.A(M.R(-25),0,M.R(15)),Alpha)
			swait()end
CFuncs["Sound"].Create("rbxassetid://438666141", Root, 7.5,1)
CFuncs["Sound"].Create("rbxassetid://1208650519", Root, 7.5, 1)
CameraEnshaking(8,24)
for i, v in pairs(FindNearestHead(Torso.CFrame.p, 105)) do
if v:FindFirstChild('Head') then
dmg(v)
end
	end
local HCF = Root.CFrame * CF.N(0,-0.1,0) * CF.A(0,0,0)
Effect({
Color = color,
Material = Enum.Material.Neon,
Mesh = {Type = Enum.MeshType.Sphere},
CFrame = HCF,
EndPos = HCF,
Size = Vector3.new(V3.N(200,0.1,200)),
EndSize = Vector3.new(V3.N(0.05,0.1,0.05)),
Transparency = NumberRange.new(0,1),
Lifetime = 0.2,
})
CFuncs["Sound"].Create("rbxassetid://907329669", Root, 10, 1)
		local PlayerSize = 1
		local hitfloor,posfloor = workspace:FindPartOnRay(Ray.new(Root.CFrame.p,((CFrame.new(Root.Position,Root.Position - Vector3.new(0,1,0))).lookVector).unit * (4*PlayerSize)), Char)
		repeat swait() hitfloor,posfloor = workspace:FindPartOnRay(Ray.new(Root.CFrame.p,((CFrame.new(Root.Position,Root.Position - Vector3.new(0,1,0))).lookVector).unit * (4*PlayerSize)), Char) until hitfloor
for i = 0, 2, 0.1 do
			local Alpha = .3
			RJ.C0 = RJ.C0:lerp(RJC0*CF.N(0,-.1,0)*CF.A(M.R(-25),0,0),Alpha)
			NK.C0 = NK.C0:lerp(NKC0,Alpha)
			LH.C0 = LH.C0:lerp(LHC0*CF.N(0,0,-.5)*CF.A(M.R(25),0,0),Alpha)
			RH.C0 = RH.C0:lerp(RHC0*CF.A(M.R(25),0,0),Alpha)
			LS.C0 = LS.C0:lerp(LSC0*CF.A(M.R(-25),0,M.R(-15)),Alpha)
			RS.C0 = RS.C0:lerp(RSC0*CF.A(M.R(-25),0,M.R(15)),Alpha)
			swait()
end
legAnims=true
WalkSpeed=orig
NeutralAnims = true
Hum.AutoRotate = true
Attack = false
end
	
function VaporTaunt()
	Attack = true
	NeutralAnims = false
	local orig=WalkSpeed
	WalkSpeed=0
	legAnims=false
	Chat"You need to chill out.."
	for i = 0, 14, 0.1 do
		swait()
		local Alpha = .1
		RJ.C0 = RJ.C0:lerp(CF.N(-0.1,-0.1-.1*M.S(Sine/36),0.6)*CF.A(M.R(55.3+2.5*M.C(Sine/36)),M.R(0),M.R(0)),Alpha)
		LH.C0 = LH.C0:lerp(CF.N(-0.6,-1.2,-0.1)*CF.A(M.R(56.3+10*M.C(Sine/36)),M.R(0),M.R(24)),Alpha)
		RH.C0 = RH.C0:lerp(CF.N(0.9,-1.2,-0.2)*CF.A(M.R(25+5*M.C(Sine/36)),M.R(3.5),M.R(-43.9)),Alpha)
		LS.C0 = LS.C0:lerp(CF.N(-1,0.8,0)*CF.A(M.R(11.4-5*M.C(Sine/42)),M.R(-3.3),M.R(137.5)),Alpha)
		RS.C0 = RS.C0:lerp(CF.N(1.4,0.5,-0.2)*CF.A(M.R(61-5*M.C(Sine/42)),M.R(0),M.R(0)),Alpha)
		NK.C0 = NK.C0:lerp(CF.N(0,1.4,-0.3)*CF.A(M.R(-38.9-5*M.C(Sine/42)),M.R(0),M.R(0)),Alpha)
	end
	legAnims=true
	WalkSpeed=orig
	Attack = false
	NeutralAnims = true
end

	for i = 0, 1, 0.1 do
		swait()
		local Alpha = .3
		RJ.C0 = RJ.C0:lerp(CF.N(0,0,0)*CF.A(M.R(0),M.R(70.7),M.R(0)),Alpha)
		LH.C0 = LH.C0:lerp(CF.N(-0.5,-1,0)*CF.A(M.R(0),M.R(0),M.R(-14.4)),Alpha)
		RH.C0 = RH.C0:lerp(CF.N(0.6,-1,0)*CF.A(M.R(15.1),M.R(-63.2),M.R(13.5)),Alpha)
		LS.C0 = LS.C0:lerp(CF.N(-1.3,0.6,-0.1)*CF.A(M.R(0),M.R(15.9),M.R(-25.4)),Alpha)
		RS.C0 = RS.C0:lerp(CF.N(1.4,0.3,-0.2)*CF.A(M.R(0),M.R(19.3),M.R(157.1)),Alpha)
		NK.C0 = NK.C0:lerp(CF.N(0,1.5,0)*CF.A(M.R(0),M.R(-70.7),M.R(0)),Alpha)
	end

Mouse.KeyDown:connect(function(io)
	--MODES
	if(io == "1" and Mode~='Glitchy')then 
		changeMode'Glitchy'
		Torso.song.PlaybackSpeed = 1
	elseif(io == "2" and Mode~='Iniquitous')then 
		changeMode'Iniquitous'
		Torso.song.PlaybackSpeed = 1
	elseif(io == "3" and Mode~='Mythical')then 
		changeMode'Mythical'
		Torso.song.PlaybackSpeed = 1
	elseif(io == "4" and Mode~='Ruined')then 
		changeMode'Ruined'
		Torso.song.PlaybackSpeed = 1
	elseif(io == "5" and Mode~='Atramentous')then 
		changeMode'Atramentous'
		Torso.song.PlaybackSpeed = 1
	elseif(io == "6" and Mode~='Subzero')then 
		changeMode'Subzero'
		Torso.song.PlaybackSpeed = 1
	elseif(io == "7" and Mode~='Troubadour')then 
		changeMode'Troubadour'
		Torso.song.PlaybackSpeed = 1
	elseif(io == "8" and Mode~='Legendary')then 
		changeMode'Legendary'
		Torso.song.PlaybackSpeed = 0.85
	elseif(io == "9" and Mode~='Love')then 
		changeMode'Love'
		Torso.song.PlaybackSpeed = 1
	elseif(io == "t" and Mode=='Glitchy')then 
		changeMode'The Big Black'
		Torso.song.PlaybackSpeed = 1
	elseif(io == "t" and Mode=='The Big Black')then 
		changeMode'Radioactive'
		Torso.song.PlaybackSpeed = 1
	elseif(io == "t" and Mode=='Mythical')then 
		changeMode'FANTASTIC NINJA'
	elseif(io == "t" and Mode=='Iniquitous')then 
		changeMode'Solitude'
		Torso.song.PlaybackSpeed = 1
	elseif(io == "t" and Mode=='Ruined')then 
		changeMode'Sin'
	elseif(io == "t" and Mode=='Subzero')then 
		changeMode'Purity'
		Torso.song.PlaybackSpeed = 1
	elseif(io == "t" and Mode=='Atramentous')then 
		changeMode'Justice'
	elseif(io == "t" and Mode=='Troubadour')then 
		changeMode'RAINBOW'
		Torso.song.PlaybackSpeed = 1
	elseif(io == "t" and Mode=='Legendary')then 
		changeMode'CALAMITY'
		Torso.song.PlaybackSpeed = 1
	elseif(io == "c" and Mode~='Purity')then 
		changeMode'Purity'
		Torso.song.PlaybackSpeed = 1
	elseif(io == "v" and Mode~='Radioactive')then 
		changeMode'Radioactive'
		Torso.song.PlaybackSpeed = 1
	elseif(io == "0" and Mode~='Time')then 
		changeMode'Time'
		Torso.song.PlaybackSpeed = 1.2
	elseif(io == "z" and Mode=='RAINBOW')then 
		RainbowWip()
	elseif(io == "z" and Mode=='FANTASTIC NINJA')then 
		NinjasWip()
	elseif(io == "z" and Mode=='The Big Black')then 
		Wip()
	elseif(io == "z" and Mode=='Glitchy')then 
		scatteryourinnerglitch()
	elseif(io == "z" and Mode=='Ruined')then 
		Stompie()
	elseif(io == "z" and Mode=='Justice')then 
		InsaneStompie()
	elseif(io == "x" and Mode=='Justice')then 
		JusticeSkyBeams()
	elseif(io == "t" and Mode=='Love')then 
		changeMode'Lust'
	--TOGGLE MUSIC
	elseif(io == "m" and getMode(Mode))then 
		MusicMode=MusicMode+1
		if(MusicMode>3)then MusicMode=1 end
		if(MusicMode==1)then
			music:Pause()
			music.Volume=1
			music.Parent=Torso
			music:Resume()
		elseif(MusicMode==2)then
			music:Pause()
			music.Volume=1
			music.Parent=Char
			music:Resume()
		elseif(MusicMode==3)then
			music.Volume = 0
		end
	elseif(io=="b")then
		--TAUNTS
		if(vaporwaveMode and Mode=='Troubadour')then
			VaporTaunt()
		end
	end
	if(vaporwaveMode)then return end
	--ATTACKS

end)

Mouse.Button1Down:Connect(function()
    if Attack == false then
		ClickCombo()
	end
end)

WingAnims.StarG=function()
	LWP1W.C0 = LWP1W.C0:lerp(CF.N(2,-2,-1-.025*M.S(WingSine/32))*CF.A(M.R(5+10*M.C(WingSine/32)),0,M.R(0+5*M.C(WingSine/32))),.2)
	LWP2W.C0 = LWP2W.C0:lerp(CF.N(4.25,-1,-1-.05*M.S(WingSine/32))*CF.A(M.R(10+15*M.C(WingSine/32)),0,M.R(15+7.5*M.C(WingSine/32))),.2)
	LWP3W.C0 = LWP3W.C0:lerp(CF.N(6.5,.5,-1-1*M.C(WingSine/32))*CF.A(M.R(15+20*M.C(WingSine/32)),0,M.R(30+9*M.C(WingSine/32))),.2)
	
	RWP1W.C0 = RWP1W.C0:lerp(CF.N(-2,-2,-1-.025*M.S(WingSine/32))*CF.A(M.R(5+10*M.C(WingSine/32)),0,M.R(0-5*M.C(WingSine/32))),.2)
	RWP2W.C0 = RWP2W.C0:lerp(CF.N(-4.25,-1,-1-.05*M.S(WingSine/32))*CF.A(M.R(10+15*M.C(WingSine/32)),0,M.R(-15-7.5*M.C(WingSine/32))),.2)
	RWP3W.C0 = RWP3W.C0:lerp(CF.N(-6.5,.5,-1-.1*M.S(WingSine/32))*CF.A(M.R(15+20*M.C(WingSine/32)),0,M.R(-30-9*M.C(WingSine/32))),.2)
end

WingAnims.Glacial=function()
	LWP1W.C0 = LWP1W.C0:lerp(CF.N(.15,1.5,-1)*CF.A(M.R(5+10*M.C(WingSine/32)),0,M.R(60)),.2)
	LWP2W.C0 = LWP2W.C0:lerp(CF.N(.1,1.5,-1)*CF.A(M.R(10+15*M.C(WingSine/32)),0,M.R(90)),.2)
	LWP3W.C0 = LWP3W.C0:lerp(CF.N(.25,1.5,-1)*CF.A(M.R(15+20*M.C(WingSine/32)),0,M.R(120)),.2)
	
	RWP1W.C0 = RWP1W.C0:lerp(CF.N(-.15,1.5,-1)*CF.A(M.R(5+10*M.C(WingSine/32)),0,M.R(-60)),.2)
	RWP2W.C0 = RWP2W.C0:lerp(CF.N(-.1,1.5,-1)*CF.A(M.R(10+15*M.C(WingSine/32)),0,M.R(-90)),.2)
	RWP3W.C0 = RWP3W.C0:lerp(CF.N(-.25,1.5,-1)*CF.A(M.R(15+20*M.C(WingSine/32)),0,M.R(-120)),.2)
end

WingAnims.Spin1=function()
	LWP1W.C0 = LWP1W.C0:lerp(CF.N(0,1+1*M.C(WingSine/100),-1)*CF.A(0,M.R(0+2.5*M.C(WingSine/36)),M.R(0+WingSine)),.8)
	LWP2W.C0 = LWP2W.C0:lerp(CF.N(0,1+1*M.C(WingSine/100),-1)*CF.A(0,M.R(0+7.5*M.C(WingSine/32)),M.R(135+WingSine)),.8)
	LWP3W.C0 = LWP3W.C0:lerp(CF.N(0,1+1*M.C(WingSine/100),-1)*CF.A(0,M.R(0+5*M.C(WingSine/39)),M.R(225+WingSine)),.8)
	
	RWP1W.C0 = RWP1W.C0:lerp(CF.N(0,1.5-1.5*M.C(WingSine/100),-1.5)*CF.A(0,M.R(0+2.5*M.C(WingSine/36)),M.R(0-WingSine)),.8)
	RWP2W.C0 = RWP2W.C0:lerp(CF.N(0,1.5-1.5*M.C(WingSine/100),-1.5)*CF.A(0,M.R(0+7.5*M.C(WingSine/32)),M.R(135-WingSine)),.8)
	RWP3W.C0 = RWP3W.C0:lerp(CF.N(0,1.5-1.5*M.C(WingSine/100),-1.5)*CF.A(0,M.R(0+5*M.C(WingSine/39)),M.R(225-WingSine)),.8)
end

WingAnims.Enchanter=function()
	LWP1W.C0 = LWP1W.C0:lerp(CF.N(0-0.125*M.C(WingSine/99),4-0.25*M.C(WingSine/93),0.75-0.1*M.C(WingSine/115))*CF.A(M.R(175-5*M.C(WingSine/115)),M.R(0),M.R(0+2.5*M.C(WingSine/95))),.2)
	LWP2W.C0 = LWP2W.C0:lerp(CF.N(1.5-0.25*M.C(WingSine/78),3.5-0.25*M.C(WingSine/63),0.75-0.1*M.C(WingSine/125))*CF.A(M.R(175-5*M.C(WingSine/121)),M.R(0),M.R(45-5*M.C(WingSine/65))),.2)
	LWP3W.C0 = LWP3W.C0:lerp(CF.N(-1.5-0.25*M.C(WingSine/86),3.5-0.25*M.C(WingSine/73),0.75-0.1*M.C(WingSine/118))*CF.A(M.R(175-5*M.C(WingSine/118)),M.R(0),M.R(-45+5*M.C(WingSine/58))),.2)

	RWP1W.C0 = RWP1W.C0:lerp(CF.N(0-0.125*M.C(WingSine/76),-2-0.25*M.C(WingSine/66),-1)*CF.A(M.R(5-5*M.C(WingSine/104)),M.R(0),M.R(0-2.5*M.C(WingSine/87))),.2)
	RWP2W.C0 = RWP2W.C0:lerp(CF.N(-2-0.25*M.C(WingSine/94),0-0.25*M.C(WingSine/79),-1)*CF.A(M.R(5-5*M.C(WingSine/111)),M.R(0),M.R(-45+5*M.C(WingSine/54))),.2)
	RWP3W.C0 = RWP3W.C0:lerp(CF.N(2-0.25*M.C(WingSine/81),0-0.25*M.C(WingSine/74),-1)*CF.A(M.R(5-5*M.C(WingSine/109)),M.R(0),M.R(45-5*M.C(WingSine/61))),.2)
end

WingAnims.OldEnchanter=function()
	RWP1W.C0=RWP1W.C0:lerp(CF.N(-5.25,3+ 1 * M.C(WingSine / 23.5),0)*CF.A(M.R(0),M.R(0),M.R(0))*CF.A(M.R(0),M.R(0+ 20 * M.C(WingSine / 47)),M.R(135+ 10 * M.C(WingSine / 47))),.3)
	RWP2W.C0=RWP2W.C0:lerp(CF.N(0,-10 + 0.75 * M.C(WingSine / 34),0)*CF.A(M.R(0),M.R(0),M.R(0))*CF.A(M.R(0),M.R(0),M.R(0 + 10 * M.C(WingSine / 47))),.3)
	RWP3W.C0=RWP3W.C0:lerp(CF.N(5.25,3+ 1 * M.C(WingSine / 23.5),0)*CF.A(M.R(0),M.R(0),M.R(0))*CF.A(M.R(0),M.R(0+ 20 * M.C(WingSine / 47)),M.R(-135+ 10 * M.C(WingSine / 47))),.3)
	LWP1W.C0=LWP1W.C0:lerp(CF.N(-3.75,-2,0)*CF.A(M.R(0),M.R(0),M.R(0))*CF.A(M.R(0),M.R(0+ 20 * M.C(WingSine / 47)),M.R(-135+ 10 * M.C(WingSine / 47))),.3)
	LWP2W.C0=LWP2W.C0:lerp(CF.N(0,1 + 0.75 * M.C(WingSine / 34),0)*CF.A(M.R(0),M.R(0),M.R(0))*CF.A(M.R(0),M.R(0),M.R(180 + 10 * M.C(WingSine / 47))),.3)
	LWP3W.C0=LWP3W.C0:lerp(CF.N(3.75,-2,0)*CF.A(M.R(0),M.R(0),M.R(0))*CF.A(M.R(0),M.R(0+ 20 * M.C(WingSine / 47)),M.R(135+ 10 * M.C(WingSine / 47))),.3)
end
WingAnims.Spin2=function()
	LWP1W.C0 = LWP1W.C0:lerp(CF.N(0,2,-1.5+1.3*M.C(WingSine/100))*CF.A(0,M.R(0+2.5*M.C(WingSine/36)),M.R(0+WingSine)),.8)
	LWP2W.C0 = LWP2W.C0:lerp(CF.N(0,2,-1.5+1.3*M.C(WingSine/100))*CF.A(0,M.R(0+7.5*M.C(WingSine/32)),M.R(135+WingSine)),.8)
	LWP3W.C0 = LWP3W.C0:lerp(CF.N(0,2,-1.5+1.3*M.C(WingSine/100))*CF.A(0,M.R(0+5*M.C(WingSine/39)),M.R(225+WingSine)),.8)
	
	RWP1W.C0 = RWP1W.C0:lerp(CF.N(0,2.5,1.5-1.3*M.C(WingSine/100))*CF.A(0,M.R(0+2.5*M.C(WingSine/36)),M.R(0-WingSine)),.8)
	RWP2W.C0 = RWP2W.C0:lerp(CF.N(0,2.5,1.5-1.3*M.C(WingSine/100))*CF.A(0,M.R(0+7.5*M.C(WingSine/32)),M.R(135-WingSine)),.8)
	RWP3W.C0 = RWP3W.C0:lerp(CF.N(0,2.5,1.5-1.3*M.C(WingSine/100))*CF.A(0,M.R(0+5*M.C(WingSine/39)),M.R(225-WingSine)),.8)
end

WingAnims.Glitchy=function()
	LWP1W.C0 = LWP1W.C0:lerp(CF.N(0+M.RNG(-300,300)/100,1.5+M.RNG(-300,300)/100,-1)*CF.A(0,M.R(0+2.5*M.C(WingSine/36)),M.R(0+WingSine+M.RNG(-300,300)/10)),.8)
	LWP2W.C0 = LWP2W.C0:lerp(CF.N(0+M.RNG(-300,300)/100,1.5+M.RNG(-300,300)/100,-1)*CF.A(0,M.R(0+7.5*M.C(WingSine/32)),M.R(135+WingSine+M.RNG(-300,300)/10)),.8)
	LWP3W.C0 = LWP3W.C0:lerp(CF.N(0+M.RNG(-300,300)/100,1.5+M.RNG(-300,300)/100,-1)*CF.A(0,M.R(0+5*M.C(WingSine/39)),M.R(225+WingSine+M.RNG(-300,300)/10)),.8)
	
	RWP1W.C0 = RWP1W.C0:lerp(CF.N(0+M.RNG(-300,300)/100,1.5+M.RNG(-300,300)/100,-1.5)*CF.A(0,M.R(0+2.5*M.C(WingSine/36)),M.R(0-WingSine+M.RNG(-300,300)/10)),.8)
	RWP2W.C0 = RWP2W.C0:lerp(CF.N(0+M.RNG(-300,300)/100,1.5+M.RNG(-300,300)/100,-1.5)*CF.A(0,M.R(0+7.5*M.C(WingSine/32)),M.R(135-WingSine+M.RNG(-300,300)/10)),.8)
	RWP3W.C0 = RWP3W.C0:lerp(CF.N(0+M.RNG(-300,300)/100,1.5+M.RNG(-300,300)/100,-1.5)*CF.A(0,M.R(0+5*M.C(WingSine/39)),M.R(225-WingSine+M.RNG(-300,300)/10)),.8)
end

WingAnims.Ambustume=function()
	LWP1W.C0 = LWP1W.C0:lerp(CF.N(2,-2 + 0.3 * M.C(WingSine/32),-1)*CF.A(M.R(0),0,M.R(0-2.5*M.C(WingSine/32))),.2)
	LWP2W.C0 = LWP2W.C0:lerp(CF.N(4.25,-2 + 0.2 * M.C(WingSine/32),-1)*CF.A(M.R(0),0,M.R(0-5*M.C(WingSine/32))),.2)
	LWP3W.C0 = LWP3W.C0:lerp(CF.N(6.5,-2 + 0.1 * M.C(WingSine/32),-1)*CF.A(M.R(0),0,M.R(0-10*M.C(WingSine/32))),.2)
	
	RWP1W.C0 = RWP1W.C0:lerp(CF.N(-2,-2 + 0.3 * M.C(WingSine/32),-1)*CF.A(M.R(0),0,M.R(0+2.5*M.C(WingSine/32))),.2)
	RWP2W.C0 = RWP2W.C0:lerp(CF.N(-4.25,-2 + 0.2 * M.C(WingSine/32),-1)*CF.A(M.R(0),0,M.R(0+5*M.C(WingSine/32))),.2)
	RWP3W.C0 = RWP3W.C0:lerp(CF.N(-6.5,-2 + 0.1 * M.C(WingSine/32),-1)*CF.A(M.R(0),0,M.R(0+10*M.C(WingSine/32))),.2)
end

WingAnims.Chaotic=function()
	LWP1W.C0 = LWP1W.C0:lerp(CF.N(0,4-0.5*M.C(WingSine/32),1.5)*CF.A(M.R(180),M.R(0),M.R(0)),.2)
	LWP2W.C0 = LWP2W.C0:lerp(CF.N(-1.5,3.5-1*M.C(WingSine/32),1.5)*CF.A(M.R(180),M.R(0),M.R(15-6*M.S(WingSine/32))),.2)
	LWP3W.C0 = LWP3W.C0:lerp(CF.N(1.5,3.5-1*M.C(WingSine/32),1.5)*CF.A(M.R(180),M.R(0),M.R(-15+6*M.S(WingSine/32))),.2)

	RWP1W.C0 = RWP1W.C0:lerp(CF.N(0,-2-0.5*M.C(WingSine/32),-1.5)*CF.A(M.R(0),M.R(0),M.R(0)),.2)
	RWP2W.C0 = RWP2W.C0:lerp(CF.N(-1.5,-1.5-1*M.C(WingSine/32),-1.5)*CF.A(M.R(0),M.R(0),M.R(15-6*M.S(WingSine/32))),.2)
	RWP3W.C0 = RWP3W.C0:lerp(CF.N(1.5,-1.5-1*M.C(WingSine/32),-1.5)*CF.A(M.R(0),M.R(0),M.R(-15+6*M.S(WingSine/32))),.2)
end

WingAnims.Spin3=function()
	LWP1W.C0 = LWP1W.C0:lerp(CF.N(0,1+1*M.C(WingSine/100),-1.5)*CF.A(M.R(0),M.R(0+2.5*M.C(WingSine/36)),M.R(0+WingSine)),.8)
	LWP2W.C0 = LWP2W.C0:lerp(CF.N(0,1+1*M.C(WingSine/100),-1.5)*CF.A(M.R(0),M.R(0+7.5*M.C(WingSine/32)),M.R(135+WingSine)),.8)
	LWP3W.C0 = LWP3W.C0:lerp(CF.N(0,1+1*M.C(WingSine/100),-1.5)*CF.A(M.R(0),M.R(0+5*M.C(WingSine/39)),M.R(225+WingSine)),.8)
	
	RWP1W.C0 = RWP1W.C0:lerp(CF.N(0,1.5-1.5*M.C(WingSine/100),-1)*CF.A(M.R(0),M.R(0+2.5*M.C(WingSine/36)),M.R(0-WingSine)),.8)
	RWP2W.C0 = RWP2W.C0:lerp(CF.N(0,1.5-1.5*M.C(WingSine/100),-1)*CF.A(M.R(0),M.R(0+7.5*M.C(WingSine/32)),M.R(135-WingSine)),.8)
	RWP3W.C0 = RWP3W.C0:lerp(CF.N(0,1.5-1.5*M.C(WingSine/100),-1)*CF.A(M.R(0),M.R(0+5*M.C(WingSine/39)),M.R(225-WingSine)),.8)
end

WingAnims.StarG=function()
	LWP1W.C0 = LWP1W.C0:lerp(CF.N(2,-2,-1)*CF.A(M.R(5+10*M.C(WingSine/32)),0,M.R(0+5*M.C(WingSine/32))),.2)
	LWP2W.C0 = LWP2W.C0:lerp(CF.N(4.25,-1,-1)*CF.A(M.R(10+15*M.C(WingSine/32)),0,M.R(15+7.5*M.C(WingSine/32))),.2)
	LWP3W.C0 = LWP3W.C0:lerp(CF.N(6.5,.5,-1)*CF.A(M.R(15+20*M.C(WingSine/32)),0,M.R(30+9*M.C(WingSine/32))),.2)
	
	RWP1W.C0 = RWP1W.C0:lerp(CF.N(-2,-2,-1)*CF.A(M.R(5+10*M.C(WingSine/32)),0,M.R(0-5*M.C(WingSine/32))),.2)
	RWP2W.C0 = RWP2W.C0:lerp(CF.N(-4.25,-1,-1+.05*M.S(WingSine/35))*CF.A(M.R(10+15*M.C(WingSine/32)),0,M.R(-15-7.5*M.C(WingSine/32))),.2)
	RWP3W.C0 = RWP3W.C0:lerp(CF.N(-6.5,.5,-1)*CF.A(M.R(15+20*M.C(WingSine/32)),0,M.R(-30-9*M.C(WingSine/32))),.2)
end

WingAnims.StarJ=function()
	LWP1W.C0 = LWP1W.C0:lerp(CF.N(2,-2,-1)*CF.A(M.R(5+10*M.C(WingSine/64)),0,M.R(0+5*M.C(WingSine/64))),.2)
	LWP2W.C0 = LWP2W.C0:lerp(CF.N(4.25,-1,-1)*CF.A(M.R(10+15*M.C(WingSine/64)),0,M.R(15+7.5*M.C(WingSine/64))),.2)
	LWP3W.C0 = LWP3W.C0:lerp(CF.N(6.5,.5,-1)*CF.A(M.R(15+20*M.C(WingSine/64)),0,M.R(30+9*M.C(WingSine/64))),.2)
	
	RWP1W.C0 = RWP1W.C0:lerp(CF.N(-2,-2,-1)*CF.A(M.R(5+10*M.C(WingSine/64)),0,M.R(0-5*M.C(WingSine/64))),.2)
	RWP2W.C0 = RWP2W.C0:lerp(CF.N(-4.25,-1,-1+.05*M.S(WingSine/64))*CF.A(M.R(10+15*M.C(WingSine/64)),0,M.R(-15-7.5*M.C(WingSine/64))),.2)
	RWP3W.C0 = RWP3W.C0:lerp(CF.N(-6.5,.5,-1)*CF.A(M.R(15+20*M.C(WingSine/64)),0,M.R(-30-9*M.C(WingSine/64))),.2)
end

WingAnims.Cytus=function()
	LWP1W.C0 = LWP1W.C0:lerp(CF.N(.15*M.C(WingSine/32),1.5+.35*M.S(WingSine/32),-1)*CF.A(0,0,M.R(60+5*M.C(WingSine/32))),.2)
	LWP2W.C0 = LWP2W.C0:lerp(CF.N(.1*M.C(WingSine/32),1.5+.25*M.C(WingSine/32),-1)*CF.A(0,0,M.R(90+2.5*M.C(WingSine/32))),.2)
	LWP3W.C0 = LWP3W.C0:lerp(CF.N(.25*M.C(WingSine/32),1.5-.05*M.S(WingSine/32),-1)*CF.A(0,0,M.R(120-5*M.C(WingSine/32))),.2)
	
	RWP1W.C0 = RWP1W.C0:lerp(CF.N(-.15*M.C(WingSine/32),1.5-.15*M.C(WingSine/32),-1)*CF.A(0,0,M.R(-60-5*M.C(WingSine/32))),.2)
	RWP2W.C0 = RWP2W.C0:lerp(CF.N(-.1*M.C(WingSine/32),1.5+.3*M.S(WingSine/32),-1)*CF.A(0,0,M.R(-90-2.5*M.C(WingSine/32))),.2)
	RWP3W.C0 = RWP3W.C0:lerp(CF.N(-.25*M.C(WingSine/32),1.5+.15*M.S(WingSine/32),-1)*CF.A(0,0,M.R(-120+5*M.C(WingSine/32))),.2)
end

WingAnims.Aprins=function()
	LWP1W.C0 = LWP1W.C0:lerp(CF.N(0,1.5,-1)*CF.A(0,M.R(0+2.5*M.C(WingSine/36)),M.R(60+5000*M.C(WingSine/400))),.2)
	LWP2W.C0 = LWP2W.C0:lerp(CF.N(0,1.5,-1)*CF.A(0,M.R(0+7.5*M.C(WingSine/32)),M.R(90+5000*M.C(WingSine/400))),.2)
	LWP3W.C0 = LWP3W.C0:lerp(CF.N(0,1.5,-1)*CF.A(0,M.R(0+5*M.C(WingSine/39)),M.R(120+5000*M.C(WingSine/400))),.2)
	
	RWP1W.C0 = RWP1W.C0:lerp(CF.N(0,1.5,-1)*CF.A(0,M.R(0+2.5*M.C(WingSine/36)),M.R(-60+5000*M.C(WingSine/400))),.2)
	RWP2W.C0 = RWP2W.C0:lerp(CF.N(0,1.5,-1)*CF.A(0,M.R(0+7.5*M.C(WingSine/32)),M.R(-90+5000*M.C(WingSine/400))),.2)
	RWP3W.C0 = RWP3W.C0:lerp(CF.N(0,1.5,-1)*CF.A(0,M.R(0+5*M.C(WingSine/39)),M.R(-120+5000*M.C(WingSine/400))),.2)
end

WingAnims.NebG1=function()
	LWP1W.C0 = LWP1W.C0:lerp(CF.N(.15,1.5,-1)*CF.A(M.R(5+10*M.C(WingSine/32)),0,M.R(60)),.2)
	LWP2W.C0 = LWP2W.C0:lerp(CF.N(.1,1.5,-1)*CF.A(M.R(10+15*M.C(WingSine/32)),0,M.R(90)),.2)
	LWP3W.C0 = LWP3W.C0:lerp(CF.N(.25,1.5,-1)*CF.A(M.R(15+20*M.C(WingSine/32)),0,M.R(120)),.2)
	
	RWP1W.C0 = RWP1W.C0:lerp(CF.N(-.15,1.5,-1)*CF.A(M.R(5+10*M.C(WingSine/32)),0,M.R(-60)),.2)
	RWP2W.C0 = RWP2W.C0:lerp(CF.N(-.1,1.5,-1)*CF.A(M.R(10+15*M.C(WingSine/32)),0,M.R(-90)),.2)
	RWP3W.C0 = RWP3W.C0:lerp(CF.N(-.25,1.5,-1)*CF.A(M.R(15+20*M.C(WingSine/32)),0,M.R(-120)),.2)
end

WingAnims.NebG2=function(div)
	div=div or 25
	LWP1W.C0 = LWP1W.C0:lerp(CF.N(0,1.5,-1)*CF.A(0,M.R(0+2.5*M.C(WingSine/36)),M.R(0+2000*M.R(WingSine/div))),.2)
	LWP2W.C0 = LWP2W.C0:lerp(CF.N(0,1.5,-1)*CF.A(0,M.R(0+7.5*M.C(WingSine/32)),M.R(120+2000*M.R(WingSine/div))),.2)
	LWP3W.C0 = LWP3W.C0:lerp(CF.N(0,1.5,-1)*CF.A(0,M.R(0+5*M.C(WingSine/39)),M.R(-120+2000*M.R(WingSine/div))),.2)
	
	RWP1W.C0 = RWP1W.C0:lerp(CF.N(0,4.5,-1)*CF.A(0,M.R(0+2.5*M.C(WingSine/36)),M.R(0-2000*M.R(WingSine/div))),.2)
	RWP2W.C0 = RWP2W.C0:lerp(CF.N(0,4.5,-1)*CF.A(0,M.R(0+7.5*M.C(WingSine/32)),M.R(120-2000*M.R(WingSine/div))),.2)
	RWP3W.C0 = RWP3W.C0:lerp(CF.N(0,4.5,-1)*CF.A(0,M.R(0+5*M.C(WingSine/39)),M.R(-120-2000*M.R(WingSine/div))),.2)
end

WingAnims.NebG3=function(mult)
	mult=mult or 1
	LWP1W.C0 = LWP1W.C0:lerp(CF.N(0,1.5,-1)*CF.A(0,M.R(0+2.5*M.C(WingSine/36)),M.R(0+WingSine*mult)),.2)
	LWP2W.C0 = LWP2W.C0:lerp(CF.N(0,1.5,-1)*CF.A(0,M.R(0+7.5*M.C(WingSine/32)),M.R(135+WingSine*mult)),.2)
	LWP3W.C0 = LWP3W.C0:lerp(CF.N(0,1.5,-1)*CF.A(0,M.R(0+5*M.C(WingSine/39)),M.R(225+WingSine*mult)),.2)
	
	RWP1W.C0 = RWP1W.C0:lerp(CF.N(0,1.5,-1.5)*CF.A(0,M.R(0+2.5*M.C(WingSine/36)),M.R(0-WingSine*mult)),.2)
	RWP2W.C0 = RWP2W.C0:lerp(CF.N(0,1.5,-1.5)*CF.A(0,M.R(0+7.5*M.C(WingSine/32)),M.R(135-WingSine*mult)),.2)
	RWP3W.C0 = RWP3W.C0:lerp(CF.N(0,1.5,-1.5)*CF.A(0,M.R(0+5*M.C(WingSine/39)),M.R(225-WingSine*mult)),.2)
end

WingAnims.LustFrench=function()
	LWP1W.C0 = LWP1W.C0:lerp(CF.N(0,1.5,0)*CF.A(0,M.R(0+2.5*M.C(WingSine/36)),M.R(0+WingSine))*CF.A(0,M.R(90),0)*CF.N(-2,0,0),.2)
	LWP2W.C0 = LWP2W.C0:lerp(CF.N(0,1.5,0)*CF.A(0,M.R(0+7.5*M.C(WingSine/32)),M.R(135+WingSine))*CF.A(0,M.R(90),0)*CF.N(-2,0,0),.2)
	LWP3W.C0 = LWP3W.C0:lerp(CF.N(0,1.5,0)*CF.A(0,M.R(0+5*M.C(WingSine/39)),M.R(225+WingSine))*CF.A(0,M.R(90),0)*CF.N(-2,0,0),.2)
	
	RWP1W.C0 = RWP1W.C0:lerp(CF.N(0,1.5,0)*CF.A(0,M.R(0+2.5*M.C(WingSine/36)),M.R(0-WingSine))*CF.A(0,M.R(90),0)*CF.N(-2,0,0),.2)
	RWP2W.C0 = RWP2W.C0:lerp(CF.N(0,1.5,0)*CF.A(0,M.R(0+7.5*M.C(WingSine/32)),M.R(135-WingSine))*CF.A(0,M.R(90),0)*CF.N(-2,0,0),.2)
	RWP3W.C0 = RWP3W.C0:lerp(CF.N(0,1.5,0)*CF.A(0,M.R(0+5*M.C(WingSine/39)),M.R(225-WingSine))*CF.A(0,M.R(90),0)*CF.N(-2,0,0),.2)
end

if(data.User==data.Local)then
	Player.Chatted:connect(function(m)
		if(m:sub(1,3) == "/e")then m=m:sub(4) end
		if(m:sub(1,5) == "play/")then
			getMode('Troubadour').Music=Playlist[m:sub(6)] or tonumber(m:sub(6)) or 0
			music.SoundId="rbxassetid://"..getMode('Troubadour').Music;
		elseif(m:sub(1,5) == "tpos/")then
			music.TimePosition = tonumber(m:sub(6)) or 0
		elseif(m:sub(1,6) == "pitch/")then
			music.Pitch = tonumber(m:sub(7)) or 0
			getMode('Troubadour').Pitch=music.Pitch
		end
	end)
end

function Effect(data)
		GotEffect(data)
end

function sphereMKa(bonuspeed,FastSpeed,type,pos,x1,y1,z1,value,color,outerpos)
local type = type
local rng = Instance.new("Part", Char)
        rng.Anchored = true
        rng.CanCollide = false
        rng.FormFactor = 3
        rng.Name = "Ring"
        rng.Material = "Neon"
        rng.Size = Vector3.new(1, 1, 1)
        rng.Transparency = 0
        rng.TopSurface = 0
        rng.BottomSurface = 0
        rng.CFrame = pos
rng.CFrame = rng.CFrame + rng.CFrame.lookVector*outerpos
        local rngm = Instance.new("SpecialMesh", rng)
        rngm.MeshType = "Sphere"
rngm.Scale = Vector3.new(x1,y1,z1)
local scaler2 = 1
local speeder = FastSpeed
if type == "Add" then
scaler2 = 1*value
elseif type == "Divide" then
scaler2 = 1/value
end
coroutine.resume(coroutine.create(function()
for i = 0,10/bonuspeed,0.1 do
swait()
if type == "Add" then
scaler2 = scaler2 - 0.01*value/bonuspeed
elseif type == "Divide" then
scaler2 = scaler2 - 0.01/value*bonuspeed
end
speeder = speeder - 0.01*FastSpeed*bonuspeed
rng.CFrame = rng.CFrame + rng.CFrame.lookVector*speeder*bonuspeed
rng.Transparency = rng.Transparency + 0.01*bonuspeed
rngm.Scale = rngm.Scale + Vector3.new(scaler2*bonuspeed, scaler2*bonuspeed, 0)
end
rng:Destroy()
end))
end

function sphereMK(bonuspeed,FastSpeed,type,pos,x1,y1,z1,value,color,outerpos)
local type = type
local rng = Instance.new("Part", Char)
        rng.Anchored = true
        rng.BrickColor = color
        rng.CanCollide = false
        rng.FormFactor = 3
        rng.Name = "Ring"
        rng.Material = "Neon"
        rng.Size = Vector3.new(1, 1, 1)
        rng.Transparency = 0
        rng.TopSurface = 0
        rng.BottomSurface = 0
        rng.CFrame = pos
rng.CFrame = rng.CFrame + rng.CFrame.lookVector*outerpos
        local rngm = Instance.new("SpecialMesh", rng)
        rngm.MeshType = "Sphere"
rngm.Scale = Vector3.new(x1,y1,z1)
local scaler2 = 1
local speeder = FastSpeed
if type == "Add" then
scaler2 = 1*value
elseif type == "Divide" then
scaler2 = 1/value
end
coroutine.resume(coroutine.create(function()
for i = 0,10/bonuspeed,0.1 do
swait()
if type == "Add" then
scaler2 = scaler2 - 0.01*value/bonuspeed
elseif type == "Divide" then
scaler2 = scaler2 - 0.01/value*bonuspeed
end
speeder = speeder - 0.01*FastSpeed*bonuspeed
rng.CFrame = rng.CFrame + rng.CFrame.lookVector*speeder*bonuspeed
rng.Transparency = rng.Transparency + 0.01*bonuspeed
rngm.Scale = rngm.Scale + Vector3.new(scaler2*bonuspeed, scaler2*bonuspeed, 0)
end
rng:Destroy()
end))
end

coroutine.resume(coroutine.create(function()
	while true do
		swait()
		if (Mode=='Mythical') then
			
		end
	end
end))

coroutine.resume(coroutine.create(function()
	while true do
		swait()
		if (Mode=='Justice') then
local HCF = Root.CFrame * CF.N(math.random(-10,10),-4,(math.random(-10,10))) * CF.A(M.R(math.random(-20,20)),M.R(math.random(-20,20)),M.R(math.random(-20,20)))
local HCF2 = Root.CFrame * CF.N(math.random(-20,20),-4,(math.random(-20,20))) * CF.A(M.R(math.random(-180,180)),M.R(math.random(-180,180)),M.R(math.random(-180,180)))
Effect({
Color = Color3.fromRGB(242, 243, 243),
Material = Enum.Material.Neon,
Mesh = {Type = Enum.MeshType.Sphere},
CFrame = HCF2,
EndPos = HCF2* CF.N(0,10,0),
Size = Vector3.new(0.1, 2, 0.1),
EndSize = Vector3.new(0.05, 2, 0.05),
Transparency = NumberRange.new(0,1),
Lifetime = 0.3,
})
Effect({
Color = Color3.fromRGB(242, 243, 243),
Material = Enum.Material.Neon,
Mesh = {Type = Enum.MeshType.Sphere},
CFrame = HCF,
EndPos = HCF* CF.N(0,5,0),
Size = Vector3.new(0.4, 3, 0.4),
EndSize = Vector3.new(0.3, 2, 0.3),
Transparency = NumberRange.new(0,1),
Lifetime = 0.4,
})
Effect({
Color = Color3.fromRGB(242, 243, 243),
Material = Enum.Material.Neon,
Mesh = "Slash1",
CFrame = Root.CFrame* CF.N(0,-3,0) * CF.A(0,M.R(math.random(-180,180)),0),
EndPos = Root.CFrame* CF.N(0,-3,0) * CF.A(0,M.R(math.random(-180,180)),0),
Size = Vector3.new(0.01, 0.01, 0.01),
EndSize = Vector3.new(0.1, 0.01, 0.1),
Transparency = NumberRange.new(0,1),
Lifetime = 0.2,
})
		end
	end
end))

coroutine.resume(coroutine.create(function()
	while true do
		swait()
		if (Mode=='Sin') then
local HCF = Root.CFrame * CF.N(math.random(-90,90),0,(math.random(-90,90))) * CF.A(M.R(math.random(-20,20)),M.R(math.random(-20,20)),M.R(math.random(-20,20)))
Effect({
Color = Color3.fromRGB(255, 0, 0),
Material = Enum.Material.Neon,
Mesh = {Type = Enum.MeshType.Sphere},
CFrame = HCF,
EndPos = HCF* CF.N(0,10,0),
Size = Vector3.new(0.1, 2, 0.1),
EndSize = Vector3.new(0.05, 2, 0.05),
Transparency = NumberRange.new(0,1),
Lifetime = 0.2,
})
		end
	end
end))

function HeartMK(bonuspeed,FastSpeed,type,pos,x1,y1,z1,value,color,outerpos)
local type = type
local rng = Instance.new("Part", Char)
        rng.Anchored = true
        rng.BrickColor = color
        rng.CanCollide = false
        rng.FormFactor = 3
        rng.Name = "Ring"
        rng.Material = "Neon"
        rng.Size = Vector3.new(1, 1, 1)
        rng.Transparency = 0
        rng.TopSurface = 0
        rng.BottomSurface = 0
        rng.CFrame = pos
rng.CFrame = rng.CFrame + rng.CFrame.lookVector*outerpos
        local rngm = Instance.new("SpecialMesh", rng)
        rngm.MeshType = "FileMesh"
        rngm.MeshId = "rbxassetid://1717707957"
        rngm.TextureId = "http://www.roblox.com/asset/?id=269748808"
        rngm.VertexColor = Vector3.new(255,1.5,5)
rngm.Scale = Vector3.new(x1,y1,z1)
local scaler2 = 1
local speeder = FastSpeed
if type == "Add" then
scaler2 = 1*value
elseif type == "Divide" then
scaler2 = 1/value
end
coroutine.resume(coroutine.create(function()
for i = 0,10/bonuspeed,0.1 do
swait()
if type == "Add" then
scaler2 = scaler2 - 0.01*value/bonuspeed
elseif type == "Divide" then
scaler2 = scaler2 - 0.01/value*bonuspeed
end
speeder = speeder - 0.01*FastSpeed*bonuspeed
rng.CFrame = rng.CFrame + rng.CFrame.lookVector*speeder*bonuspeed
rng.Transparency = rng.Transparency + 0.01*bonuspeed
rngm.Scale = rngm.Scale + Vector3.new(scaler2*bonuspeed, scaler2*bonuspeed, 0)
end
rng:Destroy()
end))
end

function HeartMK1(bonuspeed,FastSpeed,type,pos,x1,y1,z1,value,color,outerpos)
local type = type
local rng = Instance.new("Part", Char)
        rng.Anchored = true
        rng.BrickColor = color
        rng.CanCollide = false
        rng.FormFactor = 3
        rng.Name = "Ring"
        rng.Material = "Neon"
        rng.Size = Vector3.new(1, 1, 1)
        rng.Transparency = 0
        rng.TopSurface = 0
        rng.BottomSurface = 0
        rng.CFrame = pos
rng.CFrame = rng.CFrame + rng.CFrame.lookVector*outerpos
        local rngm = Instance.new("SpecialMesh", rng)
        rngm.MeshType = "FileMesh"
        rngm.MeshId = "rbxassetid://1717708486"
        rngm.TextureId = "http://www.roblox.com/asset/?id=269748808"
        rngm.VertexColor = Vector3.new(255,1.5,5)
rngm.Scale = Vector3.new(x1,y1,z1)
local scaler2 = 1
local speeder = FastSpeed
if type == "Add" then
scaler2 = 1*value
elseif type == "Divide" then
scaler2 = 1/value
end
coroutine.resume(coroutine.create(function()
for i = 0,10/bonuspeed,0.1 do
swait()
if type == "Add" then
scaler2 = scaler2 - 0.01*value/bonuspeed
elseif type == "Divide" then
scaler2 = scaler2 - 0.01/value*bonuspeed
end
speeder = speeder - 0.01*FastSpeed*bonuspeed
rng.CFrame = rng.CFrame + rng.CFrame.lookVector*speeder*bonuspeed
rng.Transparency = rng.Transparency + 0.01*bonuspeed
rngm.Scale = rngm.Scale + Vector3.new(scaler2*bonuspeed, scaler2*bonuspeed, 0)
end
rng:Destroy()
end))
end

coroutine.resume(coroutine.create(function()
	while true do
		swait()
		if (Mode=='RAINBOW') then
Effect({
Color = Color3.new(r/255,g/255,b/255),
Material = Enum.Material.Neon,
Mesh = {Type = Enum.MeshType.Sphere},
CFrame = Root.CFrame*CF.N(M.RNG(-15,15),-3,M.RNG(-15,15)),
EndPos = Root.CFrame*CF.N(M.RNG(-15,15),-3,M.RNG(-15,15)),
Size = Vector3.new(.5,.5,.5),
EndSize = Vector3.new(.5,25,.5),
Transparency = NumberRange.new(0,1),
Lifetime = 0.25,
})
		end
	end
end))

coroutine.resume(coroutine.create(function()
	while true do
		swait()
		if (Mode=='Glitchy') then
local HCF = Root.CFrame * CF.N(math.random(-20,20),-4,(math.random(-20,20))) * CF.A(M.R(math.random(-20,20)),M.R(math.random(-20,20)),M.R(math.random(-20,20)))
Effect({
Color = color,
Material = Enum.Material.Neon,
Mesh = {Type = Enum.MeshType.Sphere},
CFrame = HCF,
EndPos = HCF* CF.N(0,10,0),
Size = Vector3.new(2,7,2),
EndSize = Vector3.new(2,12,2),
Transparency = NumberRange.new(0,1),
Lifetime = 0.2,
})
		end
	end
end))

while true do
	swait()
	ClickTimer=math.max(ClickTimer-1,0)
	if(ClickTimer<=0 and Combo~=1)then
		
		Combo=1
	end
	Sine=Sine+Change
	hue=hue+1
	if(hue>360)then hue=1 end
	local hitfloor,posfloor = workspace:FindPartOnRayWithIgnoreList(Ray.new(Root.CFrame.p,((CFrame.new(Root.Position,Root.Position - Vector3.new(0,1,0))).lookVector).unit * (4)), {Effects,Char})
	local Walking = (math.abs(Root.Velocity.x) > 1 or math.abs(Root.Velocity.z) > 1)
	local State = (Hum.PlatformStand and 'Paralyzed' or Hum.Sit and 'Sit' or (not hitfloor or hitfloor.CanCollide==false) and Root.Velocity.y < -1 and "Fall" or (not hitfloor or hitfloor.CanCollide==false) and Root.Velocity.y > 1 and "Jump" or hitfloor and Walking and "Walk" or hitfloor and "Idle")
	Hum.WalkSpeed = WalkSpeed
	local sidevec = math.clamp((Torso.Velocity*Torso.CFrame.rightVector).X+(Torso.Velocity*Torso.CFrame.rightVector).Z,-Hum.WalkSpeed,Hum.WalkSpeed)
	local forwardvec =  math.clamp((Torso.Velocity*Torso.CFrame.lookVector).X+(Torso.Velocity*Torso.CFrame.lookVector).Z,-Hum.WalkSpeed,Hum.WalkSpeed)
	local sidevelocity = sidevec/Hum.WalkSpeed
	local forwardvelocity = forwardvec/Hum.WalkSpeed
	
	local lhit,lpos = workspace:FindPartOnRayWithIgnoreList(Ray.new(LLeg.CFrame.p,((CFrame.new(LLeg.Position,LLeg.Position - Vector3.new(0,1,0))).lookVector).unit * (2)), {Effects,Char})
	local rhit,rpos = workspace:FindPartOnRayWithIgnoreList(Ray.new(RLeg.CFrame.p,((CFrame.new(RLeg.Position,RLeg.Position - Vector3.new(0,1,0))).lookVector).unit * (2)), {Effects,Char})
	if(Mode=='Troubadour' and IsVaporwave(getMode'Troubadour'.Music))then
		vaporwaveMode=true
		text.Text='Ｖａｐｏｒｗａｖｅ'
		WingAnim='NebG3'
	else
		if(Mode=='Troubadour')then
			text.Text='Troubadour'
			WingAnim=getMode'Troubadour'.WingAnim
		end
		vaporwaveMode=false
	end
	
	if(Mode~='Lust' and WingAnim and WingAnims[WingAnim])then
		WingAnims[WingAnim]()
	elseif(Mode=='Lust')then
		if(State=='Idle')then
			WingAnims.LustFrench()
		else
			WingAnims.NebG3(1)	
		end
	elseif(WingAnim and typeof(WingAnim)=='table' and WingAnims[WingAnim[1]])then
		local gay={unpack(WingAnim)};
		table.remove(gay,1)
		WingAnims[WingAnim[1]](unpack(gay))
	else
		WingAnims.NebG1()
	end
	
	if(Mode=='Troubadour' and NeutralAnims)then
		WingSine=WingSine+(0.1+music.PlaybackLoudness/300)
	else
		WingSine=WingSine+1
	end
	
	if(music)then
		if(Mode=='Troubadour')then
			local clr = Color3.fromHSV(hue/360,1,math.clamp(music.PlaybackLoudness/475,0,1))
			local clr2 = Color3.fromHSV(hue/360,1,math.clamp(music.PlaybackLoudness/950,0,1))
			text.TextColor3 = clr
			PrimaryColor = clr2
			for _,v in next, Char:GetDescendants() do
				if (v.Name == "Halo" or v.Name == "a1" or v.Name == "a2" or v.Name == "HAL") then
					v.Transparency = 5
				end
			end
			for _,v in next, Char:GetDescendants() do
				if (v.Name == "Union") then
					v.Transparency = 5
				end
			end
			for _,v in next, wingModel:GetDescendants() do
				if(v:IsA'BasePart')then
					v.Color = clr2
				elseif(v:IsA'Trail')then
					v.Enabled = true
					v.Color = ColorSequence.new(clr2)
				end
			end
			for _,v in next, Char:GetDescendants() do
				if (v.Name == "Trail2") then
					v.Enabled = false
				end
			end
		end
	end
	
	if(music)then
		if(Mode=='RAINBOW')then
			local clr = Color3.new(r/255,g/255,b/255)
			text.TextColor3 = clr
			text.TextStrokeColor3 = clr
			PrimaryColor = clr
			for _,v in next, Char:GetDescendants() do
				if (v.Name == "Halo" or v.Name == "a1" or v.Name == "a2" or v.Name == "HAL") then
					v.Transparency = 5
				end
			end
			for _,v in next, Char:GetDescendants() do
				if (v.Name == "Union") then
					v.Transparency = 5
				end
			end
			for _,v in next, wingModel:GetDescendants() do
				if(v:IsA'BasePart')then
					v.Color = clr
				elseif(v:IsA'Trail')then
					v.Color = ColorSequence.new(clr)
					v.Enabled = true
				elseif(v:IsA'ParticleEmitter')then
					v.Color = ColorSequence.new(clr)
				end
			end
			for _,v in next, Char:GetDescendants() do
				if (v.Name == "Trail2") then
					v.Enabled = false
				end
			end
			for _,v in next, Effects:GetDescendants() do
				if(v:IsA'Part')then
					v.Color = clr
				end
			end
		end
	end
	
	if(music)then
		if(Mode=='Glitchy')then
			local val = math.random(1,255)
			local clr = Color3.fromRGB(val,val,val)
			text.TextColor3 = clr
			text.TextStrokeColor3 = clr
			PrimaryColor = clr
			for _,v in next, Char:GetDescendants() do
				if (v.Name == "Ring" or v.Name == "Direction" or v.Name == "HitDirect") then
					v.Color = clr
				end
			end
			for _,v in next, Char:GetDescendants() do
				if (v.Name == "Halo" or v.Name == "a1" or v.Name == "a2" or v.Name == "HAL") then
					v.Transparency = 5
				end
			end
			for _,v in next, Char:GetDescendants() do
				if (v.Name == "Union") then
					v.Transparency = 5
				end
			end
			for _,v in next, wingModel:GetDescendants() do
				if(v:IsA'BasePart')then
					v.Color = clr
				elseif(v:IsA'Trail')then
					v.Color = ColorSequence.new(clr)
					v.Enabled = true
				elseif(v:IsA'ParticleEmitter')then
					v.Color = ColorSequence.new(clr)
				end
			end
			for _,v in next, Char:GetDescendants() do
				if (v.Name == "Trail2") then
					v.Enabled = false
				end
			end
			for _,v in next, Effects:GetDescendants() do
				if(v:IsA'Part')then
					v.Color = clr
				end
			end
		end
	end
	
	if(music)then
		if(Mode=='Time')then
			local clr = BrickColor.new("Artichoke").Color
			text.TextColor3 = clr
			text.TextStrokeColor3 = clr
			PrimaryColor = clr
			for _,v in next, Char:GetDescendants() do
				if (v.Name == "Ring" or v.Name == "Direction" or v.Name == "HitDirect") then
					v.Color = clr
				end
			end			
			for _,v in next, Char:GetDescendants() do
				if (v.Name == "Halo" or v.Name == "a1" or v.Name == "a2" or v.Name == "HAL") then
					v.Transparency = 0
				end
			end
			for _,v in next, Char:GetDescendants() do
				if (v.Name == "Union") then
					v.Transparency = 0
				end
			end
			for _,v in next, wingModel:GetDescendants() do
				if(v:IsA'BasePart')then
					v.Color = clr
				elseif(v:IsA'Trail')then
					v.Color = ColorSequence.new(clr)
				elseif(v:IsA'ParticleEmitter')then
					v.Color = ColorSequence.new(clr)
				end
			end
			for _,v in next, Char:GetDescendants() do
				if (v.Name == "Trail2") then
					v.Enabled = true
				end
			end
			for _,v in next, Effects:GetDescendants() do
				if(v:IsA'Part')then
					v.Color = clr
				end
			end
		end
	end
	
	if(music)then
		if(Mode=='FANTASTIC NINJA')then
			local val = math.random(1,255)
			local clr = Color3.fromRGB(val,val,0)
			text.TextColor3 = clr
			text.TextStrokeColor3 = clr
			PrimaryColor = clr
			for _,v in next, Char:GetDescendants() do
				if (v.Name == "Ring" or v.Name == "Direction" or v.Name == "HitDirect") then
					v.Color = clr
				end
			end
			for _,v in next, Char:GetDescendants() do
				if (v.Name == "Halo" or v.Name == "a1" or v.Name == "a2" or v.Name == "HAL") then
					v.Transparency = 5
				end
			end
			for _,v in next, Char:GetDescendants() do
				if (v.Name == "Union") then
					v.Transparency = 5
				end
			end
			for _,v in next, wingModel:GetDescendants() do
				if(v:IsA'BasePart')then
					v.Color = clr
				elseif(v:IsA'Trail')then
					v.Color = ColorSequence.new(clr)
					v.Enabled = true
				elseif(v:IsA'ParticleEmitter')then
					v.Color = ColorSequence.new(clr)
				end
			end
			for _,v in next, Char:GetDescendants() do
				if (v.Name == "Trail2") then
					v.Enabled = false
				end
			end
			for _,v in next, Effects:GetDescendants() do
				if(v:IsA'Part')then
					v.Color = clr
				end
			end
		end
	end
	
	if(music)then
		if(Mode=='Ruined')then
			local clr = Color3.fromRGB(190,104,98)
			text.TextColor3 = clr
			text.TextStrokeColor3 = clr
			PrimaryColor = clr
			for _,v in next, Char:GetDescendants() do
				if (v.Name == "Halo" or v.Name == "a1" or v.Name == "a2" or v.Name == "HAL") then
					v.Transparency = 5
				end
			end
			for _,v in next, Char:GetDescendants() do
				if (v.Name == "Ring" or v.Name == "Direction" or v.Name == "HitDirect") then
					v.Color = clr
				end
			end
			for _,v in next, Char:GetDescendants() do
				if (v.Name == "Union") then
					v.Transparency = 5
				end
			end
			for _,v in next, wingModel:GetDescendants() do
				if(v:IsA'BasePart')then
					v.Color = clr
				elseif(v:IsA'Trail')then
					v.Color = ColorSequence.new(clr)
					v.Enabled = true
				elseif(v:IsA'ParticleEmitter')then
					v.Color = ColorSequence.new(clr)
				end
			end
			for _,v in next, Char:GetDescendants() do
				if (v.Name == "Trail2") then
					v.Enabled = false
				end
			end
			for _,v in next, Effects:GetDescendants() do
				if(v:IsA'Part')then
					v.Color = clr
				end
			end
		end
	end
	
	if(music)then
		if(Mode=='Justice')then
			local clr = Color3.fromRGB(248,248,248)
			text.TextColor3 = clr
			text.TextStrokeColor3 = clr
			PrimaryColor = clr
			for _,v in next, Char:GetDescendants() do
				if (v.Name == "Union") then
					v.Transparency = 5
				end
			end
			for _,v in next, Char:GetDescendants() do
				if (v.Name == "Halo" or v.Name == "a1" or v.Name == "a2" or v.Name == "HAL") then
					v.Transparency = 5
				end
			end
			for _,v in next, Char:GetDescendants() do
				if (v.Name == "Ring" or v.Name == "Direction" or v.Name == "HitDirect") then
					v.Color = clr
				end
			end
			for _,v in next, wingModel:GetDescendants() do
				if(v:IsA'BasePart')then
					v.Color = clr
				elseif(v:IsA'Trail')then
					v.Enabled = true
					v.Color = ColorSequence.new(clr)
				elseif(v:IsA'ParticleEmitter')then
					v.Color = ColorSequence.new(clr)
				end
			end
			for _,v in next, Char:GetDescendants() do
				if (v.Name == "Trail2") then
					v.Enabled = false
				end
			end
			for _,v in next, Effects:GetDescendants() do
				if(v:IsA'Part')then
					v.Color = clr
				end
			end
		end
	end
	
	if(Mode=='The Big Black') or (Mode=='Solitude') then
		local pos = Head.Position
		local dist = (camera.CFrame.p-pos).magnitude
		local DropDist = 1
		local IneffectiveDist = 15
		local modifier = dist < DropDist and 1 or dist < IneffectiveDist and (0 - 1) / (IneffectiveDist - DropDist) * (dist - DropDist) + 1 or 0

	else
	end
	
	if(Mode=='Troubadour' and data.User==data.Local)then
	else
	end
	
	if(State == 'Idle')then
		if(Mode=='Troubadour' and NeutralAnims and not vaporwaveMode)then Change = 0.1+music.PlaybackLoudness/200 else Change = 1 end
		if(Mode=='Achromatic') or (Mode=='Achromatic')then
			local Alpha = .1
			if(NeutralAnims)then	
				RJ.C0 = RJ.C0:lerp(RJC0*CF.N(0,0+.05*M.C(Sine/32),0)*CF.A(M.R(0+1*M.S(Sine/64)),M.R(5),0),Alpha)
				NK.C0 = NK.C0:lerp(NKC0*CF.A(M.R(-10-2.5*M.S(Sine/32)),M.R(-5),0),Alpha)
				LS.C0 = LS.C0:lerp(LSC0*CF.N(0,0+.05*M.S(Sine/32),0)*CF.A(0,M.R(5+5*M.C(Sine/32)),M.R(-10-5*M.C(Sine/32))),Alpha)
				RS.C0 = RS.C0:lerp(RSC0*CF.N(0,0+.05*M.S(Sine/32),0)*CF.A(0,M.R(5-5*M.C(Sine/32)),M.R(10+5*M.C(Sine/32))),Alpha)
			end
			if(legAnims)then 
				if(NeutralAnims)then
					LH.C0 = LH.C0:lerp(LHC0*CF.N(0,0-.05*M.C(Sine/32),0),Alpha)
					RH.C0 = RH.C0:lerp(RHC0*CF.N(0,0-.05*M.C(Sine/32),0)*CF.A(0,M.R(-5),0),Alpha)
				else
					LH.C0 = LH.C0:lerp(LHC0,Alpha)
					RH.C0 = RH.C0:lerp(RHC0,Alpha)
				end
			end
		elseif(Mode=='Iniquitous')then
			local Alpha = .1
			if(NeutralAnims)then	
				RJ.C0 = RJ.C0:lerp(RJC0*CF.N(0,0+.05*M.C(Sine/32),0)*CF.A(M.R(0+3*M.S(Sine/64)),0,0),Alpha)
				if(M.RNG(1,45)==1)then
					NK.C0 = NK.C0:lerp(NKC0*CF.A(M.RRNG(-25,25),M.RRNG(-25,25),M.RRNG(-25,25)),.8)
				else
					NK.C0 = NK.C0:lerp(NKC0*CF.A(M.R(-10-2.5*M.S(Sine/32)),0,0),Alpha)
				end
				LS.C0 = LS.C0:lerp(LSC0*CF.N(.3,0+.05*M.S(Sine/32),.1)*CF.A(M.R(-35),M.R(5+2.5*M.C(Sine/32)),M.R(35-1.5*M.C(Sine/32))),Alpha)
				RS.C0 = RS.C0:lerp(RSC0*CF.N(-.3,0+.05*M.S(Sine/32),.1)*CF.A(M.R(-25),M.R(5-2.5*M.C(Sine/32)),M.R(-35+1.5*M.C(Sine/32))),Alpha)
			end
			if(legAnims)then 
				if(NeutralAnims)then
					LH.C0 = LH.C0:lerp(LHC0*CF.N(0,0-.05*M.C(Sine/32),0)*CF.A(0,0,M.R(-2.5)),Alpha)
					RH.C0 = RH.C0:lerp(RHC0*CF.N(0,0-.05*M.C(Sine/32),0)*CF.A(0,0,M.R(2.5)),Alpha)
				else
					LH.C0 = LH.C0:lerp(LHC0*CF.A(0,0,M.R(-2.5)),Alpha)
					RH.C0 = RH.C0:lerp(RHC0*CF.A(0,0,M.R(2.5)),Alpha)
				end
			end
		elseif(Mode=='Mythical')then
			local Alpha = .1
			if(NeutralAnims)then	
				GotEffect{
					Lifetime=.5;
					Mesh={Type=Enum.MeshType.Sphere};
					CFrame=LArm.CFrame*CF.N(0,-1,0)*CF.A(M.RRNG(0,360),M.RRNG(0,360),M.RRNG(0,360));
					Color=BrickColor.new'Alder'.Color;
					Transparency={.5,1};
					Material=Enum.Material.Neon;
					Size=Vector3.new(.3,2,.3);
					EndSize=Vector3.new(.1,1,.1);
				}
				RJ.C0 = RJ.C0:lerp(RJC0*CF.N(0,0+.05*M.C(Sine/32),0)*CF.A(M.R(0+1*M.S(Sine/64)),M.R(-15),0),Alpha)
				NK.C0 = NK.C0:lerp(NKC0*CF.A(M.R(-10-2.5*M.S(Sine/32)),M.R(15),0),Alpha)
				LS.C0 = LS.C0:lerp(LSC0*CF.N(.5,0+.05*M.S(Sine/32),-.5)*CF.A(M.R(15+1.5*M.C(Sine/51)),M.R(5+5*M.C(Sine/57)),M.R(85-5*M.C(Sine/46))),Alpha)
				RS.C0 = RS.C0:lerp(RSC0*CF.N(-.3,0+.05*M.S(Sine/32),.1)*CF.A(M.R(-25),M.R(5-2.5*M.C(Sine/32)),M.R(-35+1.5*M.C(Sine/32))),Alpha)
			end
			if(legAnims)then 
				if(NeutralAnims)then
					LH.C0 = LH.C0:lerp(LHC0*CF.N(0,0-.05*M.C(Sine/32),0)*CF.A(0,M.R(15),0),Alpha)
					RH.C0 = RH.C0:lerp(RHC0*CF.N(0,0-.05*M.C(Sine/32),0),Alpha)
				else
					LH.C0 = LH.C0:lerp(LHC0,Alpha)
					RH.C0 = RH.C0:lerp(RHC0,Alpha)
				end
			end
		elseif(Mode=='Ruined') or (Mode=='Glitchy') or (Mode=='Sin') then
			local Alpha = .1
			if(NeutralAnims)then	
				RJ.C0 = RJ.C0:lerp(RJC0*CF.N(0,0+.05*M.C(Sine/32),0)*CF.A(M.R(-5+1*M.S(Sine/64)),M.R(-25),0),Alpha)
				if(M.RNG(1,25)==1)then
					NK.C0 = NK.C0:lerp(NKC0*CF.A(M.RRNG(-25,25),M.RRNG(-25,25),M.RRNG(-25,25)),.8)
				else
					NK.C0 = NK.C0:lerp(NKC0*CF.A(M.R(-10-2.5*M.S(Sine/32)),M.R(35),M.R(-10))*CF.A(M.RRNG(-5,5),M.RRNG(-5,5),M.RRNG(-5,5)),Alpha)
				end
				LS.C0 = LS.C0:lerp(LSC0*CF.N(0,0+.05*M.S(Sine/32),0)*CF.A(0,M.R(5+5*M.C(Sine/32)),M.R(-10-5*M.C(Sine/32))),Alpha)
				RS.C0 = RS.C0:lerp(RSC0*CF.N(-.1,0+.05*M.S(Sine/32),0)*CF.A(M.R(175),M.R(5-2.5*M.C(Sine/32)),M.R(-25-1.5*M.C(Sine/32))),Alpha)
			end
			if(legAnims)then 
				if(NeutralAnims)then
					LH.C0 = LH.C0:lerp(LHC0*CF.N(0,0-.05*M.C(Sine/32),0)*CF.A(M.R(-10),M.R(25),0),Alpha)
					RH.C0 = RH.C0:lerp(RHC0*CF.N(0,0-.05*M.C(Sine/32),0)*CF.A(M.R(5),0,0),Alpha)
				else
					LH.C0 = LH.C0:lerp(LHC0,Alpha)
					RH.C0 = RH.C0:lerp(RHC0,Alpha)
				end
			end
		--[[elseif(Mode=='Atramentous')then
			local Alpha = .1
			if(NeutralAnims)then	
				RJ.C0 = RJ.C0:lerp(RJC0*CF.N(-.2+.4*M.C(Sine/39),.5+.2*M.C(Sine/32),0)*CF.A(M.R(-2+5*M.S(Sine/58)),M.R(-15+5*M.C(Sine/42)),0),Alpha)
				NK.C0 = NK.C0:lerp(NKC0*CF.A(M.R(-7-2.5*M.S(Sine/32)),M.R(15),0),Alpha)
				LS.C0 = LS.C0:lerp(LSC0*CF.N(0,0+.05*M.S(Sine/32),0)*CF.A(0,0,M.R(-15+5*M.S(Sine/32))),Alpha)
				RS.C0 = RS.C0:lerp(RSC0*CF.N(0,0+.05*M.S(Sine/32),0)*CF.A(0,0,M.R(15-5*M.S(Sine/32))),Alpha)
			end
			if(legAnims)then 
				if(NeutralAnims)then
					LH.C0 = LH.C0:lerp(LHC0*CF.N(0,.5,-.2)*CF.A(0,0,M.R(-5)),Alpha)
					RH.C0 = RH.C0:lerp(RHC0*CF.A(0,0,M.R(5)),Alpha)
				else
					LH.C0 = LH.C0:lerp(LHC0,Alpha)
					RH.C0 = RH.C0:lerp(RHC0,Alpha)
				end
			end]]
		elseif(Mode=='Atramentous')then
			local Alpha = .1
			if(NeutralAnims)then	
				RJ.C0 = RJ.C0:lerp(RJC0*CF.N(0,0+.05*M.C(Sine/32),0)*CF.A(M.R(-25+1*M.S(Sine/64)),0,0),Alpha)
				NK.C0 = NK.C0:lerp(NKC0*CF.A(M.R(-10-2.5*M.S(Sine/32)),M.R(-5),0),Alpha)
				LS.C0 = LS.C0:lerp(LSC0*CF.N(0,0+.05*M.S(Sine/32),0)*CF.A(M.R(25),M.R(5+5*M.C(Sine/32)),M.R(-10-5*M.C(Sine/32))),Alpha)
				RS.C0 = RS.C0:lerp(RSC0*CF.N(0,0+.05*M.S(Sine/32),0)*CF.A(M.R(25),M.R(5-5*M.C(Sine/32)),M.R(10+5*M.C(Sine/32))),Alpha)
			end
			if(legAnims)then 
				if(NeutralAnims)then
					LH.C0 = LH.C0:lerp(LHC0*CF.N(0,0-.05*M.C(Sine/32),0)*CF.A(M.R(25),0,M.R(-3)),Alpha)
					RH.C0 = RH.C0:lerp(RHC0*CF.N(0,0-.05*M.C(Sine/32),0)*CF.A(M.R(25),0,M.R(3)),Alpha)
				else
					LH.C0 = LH.C0:lerp(LHC0,Alpha)
					RH.C0 = RH.C0:lerp(RHC0,Alpha)
				end
			end
		elseif(Mode=='Subzero') or (Mode=='Purity') or (Mode=='Time') or (Mode=='RAINBOW') then
			local Alpha = .1
			if(NeutralAnims)then	
				RJ.C0 = RJ.C0:lerp(RJC0*CF.N(0,0+.05*M.C(Sine/32),0)*CF.A(0,M.R(28),0),Alpha)
				NK.C0 = NK.C0:lerp(NKC0*CF.A(M.R(-7-2.5*M.S(Sine/32)),M.R(-28),0),Alpha)
				LS.C0 = LS.C0:lerp(LSC0*CF.N(.5,-.1+.05*M.S(Sine/32),-.8)*CF.A(M.R(13),M.R(-12),M.R(104-2*M.S(Sine/36))),Alpha)
				RS.C0 = RS.C0:lerp(RSC0*CF.N(-.5,0+.05*M.S(Sine/32),-.6)*CF.A(M.R(-17),M.R(-20),M.R(-79+1*M.S(Sine/36))),Alpha)
			end
			if(legAnims)then 
				if(NeutralAnims)then
					LH.C0 = LH.C0:lerp(LHC0*CF.N(0,0-.05*M.C(Sine/32),0)*CF.A(0,0,M.R(-1)),Alpha)
					RH.C0 = RH.C0:lerp(RHC0*CF.N(0,0-.05*M.C(Sine/32),0)*CF.A(M.R(4),M.R(-28),M.R(8)),Alpha)
				else
					LH.C0 = LH.C0:lerp(LHC0,Alpha)
					RH.C0 = RH.C0:lerp(RHC0,Alpha)
				end
			end
		elseif(Mode=='Troubadour')then
			if(vaporwaveMode)then
			  	local Alpha = .1
				if(NeutralAnims)then
					RJ.C0 = RJ.C0:lerp(CF.N(0,-0.2-.1*M.S(Sine/36),0.6)*CF.A(M.R(74.3+2.5*M.C(Sine/36)),M.R(0),M.R(0)),Alpha)
					LS.C0 = LS.C0:lerp(CF.N(-1,0.8,0)*CF.A(M.R(11.4-5*M.C(Sine/42)),M.R(-3.3),M.R(137.5)),Alpha)
					RS.C0 = RS.C0:lerp(CF.N(1,0.9,-0.1)*CF.A(M.R(13.7-5*M.C(Sine/42)),M.R(7.7),M.R(-136.2)),Alpha)
					NK.C0 = NK.C0:lerp(CF.N(0,1.4,-0.3)*CF.A(M.R(-16.6-5*M.C(Sine/42)),M.R(0),M.R(0)),Alpha)
					if(legAnims)then
						LH.C0 = LH.C0:lerp(CF.N(-0.7,-1,0)*CF.A(M.R(37.2+10*M.C(Sine/36)),M.R(0),M.R(24)),Alpha)
						RH.C0 = RH.C0:lerp(CF.N(0.8,-1.1,-0.1)*CF.A(M.R(5.9+5*M.C(Sine/36)),M.R(3.5),M.R(-43.9)),Alpha)
					end
				elseif(legAnims)then
					LH.C0 = LH.C0:lerp(LHC0,Alpha)
					RH.C0 = RH.C0:lerp(RHC0,Alpha)
				end
			else
				local Alpha = .3
				if(NeutralAnims)then	
					RJ.C0 = RJ.C0:lerp(RJC0*CF.N(0,0+.05*M.C(Sine/20)+(music.PlaybackLoudness/5000),0)*CF.A(M.R(0+1*M.S(Sine/64)),M.R(35),0),Alpha)
					NK.C0 = NK.C0:lerp(NKC0*CF.A(M.R(0+1*M.S(Sine/24)),M.R(-35),0),Alpha)
					LS.C0 = LS.C0:lerp(LSC0*CF.A(0,0,M.R(-15+10*M.C(Sine/20))),Alpha)
					RS.C0 = RS.C0:lerp(RSC0*CF.A(M.R(75-(music.PlaybackLoudness/7.5)),M.R(5),M.R(35)),Alpha)
				end
				if(legAnims)then 
					if(NeutralAnims)then
						LH.C0 = LH.C0:lerp(LHC0*CF.N(0,-.05*M.C(Sine/20)-(music.PlaybackLoudness/5000),0)*CF.A(0,M.R(25),0),Alpha)
						RH.C0 = RH.C0:lerp(RHC0*CF.N(0,-.05*M.C(Sine/20)-(music.PlaybackLoudness/5000),0),Alpha)
					else
						LH.C0 = LH.C0:lerp(LHC0,Alpha)
						RH.C0 = RH.C0:lerp(RHC0,Alpha)
					end
				end
			end
		elseif(Mode=='Infectious') then
			local Alpha = .1
			if(NeutralAnims)then	
				GotEffect{
					Lifetime=.2;
					Mesh={Type=Enum.MeshType.Sphere};
					CFrame=LArm.CFrame*CF.N(0,-1,0)*CF.A(M.RRNG(0,360),M.RRNG(0,360),M.RRNG(0,360));
					Color=BrickColor.new'Dark indigo'.Color;
					Transparency={0,1};
					Material=Enum.Material.Neon;
					Size=Vector3.new(.5,1,.5);
					EndSize=Vector3.new(.1,3,.1);
				}
				GotEffect{
					Lifetime=.2;
					Mesh={Type=Enum.MeshType.Sphere};
					CFrame=RArm.CFrame*CF.N(0,-1,0)*CF.A(M.RRNG(0,360),M.RRNG(0,360),M.RRNG(0,360));
					Color=BrickColor.new'Dark indigo'.Color;
					Transparency={0,1};
					Material=Enum.Material.Neon;
					Size=Vector3.new(.5,1,.5);
					EndSize=Vector3.new(.1,3,.1);
				}
				RJ.C0 = RJ.C0:lerp(RJC0*CF.N(0,0+.05*M.C(Sine/32),0)*CF.A(M.R(0+1*M.S(Sine/64)),M.R(-15),0),Alpha)
				NK.C0 = NK.C0:lerp(NKC0*CF.A(M.R(-10-2.5*M.S(Sine/32)),M.R(15),0),Alpha)
				RS.C0 = RS.C0:lerp(RSC0*CF.N(-.5,0+.05*M.S(Sine/32),-.4)*CF.A(M.R(25),M.R(5-2.5*M.C(Sine/32)),M.R(-65+1.5*M.C(Sine/32))),Alpha)
				LS.C0 = LS.C0:lerp(LSC0*CF.N(0,0+.05*M.S(Sine/32),0)*CF.A(0,M.R(5-5*M.C(Sine/32)),M.R(-10-5*M.C(Sine/32))),Alpha)
			end
			if(legAnims)then 
				if(NeutralAnims)then
					LH.C0 = LH.C0:lerp(LHC0*CF.N(0,0-.05*M.C(Sine/32),0)*CF.A(0,M.R(15),0),Alpha)
					RH.C0 = RH.C0:lerp(RHC0*CF.N(0,0-.05*M.C(Sine/32),0),Alpha)
				else
					LH.C0 = LH.C0:lerp(LHC0,Alpha)
					RH.C0 = RH.C0:lerp(RHC0,Alpha)
				end
			end
		elseif(Mode=='FANTASTIC NINJA') then
			local Alpha = .1
			local val = math.random(1,255)
			local clr = Color3.fromRGB(val,val,0)
			if(NeutralAnims)then	
				GotEffect{
					Lifetime=.2;
					Mesh={Type=Enum.MeshType.Sphere};
					CFrame=LArm.CFrame*CF.N(0,-1,0)*CF.A(M.RRNG(0,360),M.RRNG(0,360),M.RRNG(0,360));
					Color=clr;
					Transparency={0,1};
					Material=Enum.Material.Neon;
					Size=Vector3.new(.5,1,.5);
					EndSize=Vector3.new(.1,3,.1);
				}
				GotEffect{
					Lifetime=.2;
					Mesh={Type=Enum.MeshType.Sphere};
					CFrame=RArm.CFrame*CF.N(0,-1,0)*CF.A(M.RRNG(0,360),M.RRNG(0,360),M.RRNG(0,360));
					Color=clr;
					Transparency={0,1};
					Material=Enum.Material.Neon;
					Size=Vector3.new(.5,1,.5);
					EndSize=Vector3.new(.1,3,.1);
				}
				RJ.C0 = RJ.C0:lerp(RJC0*CF.N(0,0+.05*M.C(Sine/32),0)*CF.A(M.R(0+1*M.S(Sine/64)),M.R(-15),0),Alpha)
				NK.C0 = NK.C0:lerp(NKC0*CF.A(M.R(-10-2.5*M.S(Sine/32)),M.R(15),0),Alpha)
				RS.C0 = RS.C0:lerp(RSC0*CF.N(-.5,0+.05*M.S(Sine/32),-.4)*CF.A(M.R(25),M.R(5-2.5*M.C(Sine/32)),M.R(-65+1.5*M.C(Sine/32))),Alpha)
				LS.C0 = LS.C0:lerp(LSC0*CF.N(0,0+.05*M.S(Sine/32),0)*CF.A(0,M.R(5-5*M.C(Sine/32)),M.R(-10-5*M.C(Sine/32))),Alpha)
			end
			if(legAnims)then 
				if(NeutralAnims)then
					LH.C0 = LH.C0:lerp(LHC0*CF.N(0,0-.05*M.C(Sine/32),0)*CF.A(0,M.R(15),0),Alpha)
					RH.C0 = RH.C0:lerp(RHC0*CF.N(0,0-.05*M.C(Sine/32),0),Alpha)
				else
					LH.C0 = LH.C0:lerp(LHC0,Alpha)
					RH.C0 = RH.C0:lerp(RHC0,Alpha)
				end
			end
		elseif(Mode=='Love')then
			Change = 1
			local Alpha = .6
			if(NeutralAnims)then	
			  SetTween(RJ,{C0 = CF.N(0,0 + 0.1 * math.cos(Sine/26),0)*CF.A(math.rad(0),math.rad(0 - 3 * math.cos(Sine/26)),math.rad(0 - 10 * math.sin(Sine/26)))},"Quad","Out",Alpha)
			  SetTween(LS,{C0 = CF.N(-1.15,0.4,-0.5)*CF.A(math.rad(-6.5),math.rad(13.6 + 3 * math.sin(Sine/26)),math.rad(45.8))},"Quad","Out",Alpha)
			  SetTween(RS,{C0 = CF.N(1.15,0.4,-0.5)*CF.A(math.rad(-6.5),math.rad(-13.6 + 3 * math.sin(Sine/26)),math.rad(-45.8))},"Quad","Out",Alpha)
			  SetTween(NK,{C0 = CF.N(0,1.5,-0.1)*CF.A(math.rad(-7),math.rad(0 - 5 * math.sin(Sine/26)),math.rad(0  - 5 * math.cos(Sine/26)))},"Quad","Out",Alpha)
			end
			if(legAnims)then 
				if(NeutralAnims)then
			  SetTween(LH,{C0 = CF.N(0,0 - 0.1 * math.cos(Sine/26),0)*CF.A(math.rad(0),math.rad(0 + 3 * math.cos(Sine/26)),math.rad(0 + 10 * math.sin(Sine/26))) * CF.N(-0.5,-1,0)*CF.A(math.rad(0),math.rad(0),math.rad(5))},"Quad","Out",Alpha)
			  SetTween(RH,{C0 = CF.N(0,0 - 0.1 * math.cos(Sine/26),0)*CF.A(math.rad(0),math.rad(0 + 3 * math.cos(Sine/26)),math.rad(0 + 10 * math.sin(Sine/26))) * CF.N(0.5,-1,0)*CF.A(math.rad(0),math.rad(0),math.rad(-5))},"Quad","Out",Alpha)
				else
					LH.C0 = LH.C0:lerp(LHC0,Alpha)
					RH.C0 = RH.C0:lerp(RHC0,Alpha)
				end
			end
		elseif(Mode=='The Big Black') or (Mode=='Solitude') or (Mode=='CHAOS') then
			local Alpha = .1
			if(NeutralAnims)then
				GotEffect{
					Lifetime=.5;
					Mesh={Type=Enum.MeshType.Sphere};
					CFrame=RArm.CFrame*CF.N(0,-1,0)*CF.A(M.RRNG(0,360),M.RRNG(0,360),M.RRNG(0,360));
					Color=BrickColor.new'Black'.Color;
					Transparency={0,1};
					Material=Enum.Material.Neon;
					Size=Vector3.new(.5,1,.5);
					EndSize=Vector3.new(.1,3,.1);
				}
				RJ.C0 = RJ.C0:lerp(CF.N(0,0+.05*M.C(Sine/32),0.2)*CF.A(M.R(15.5),M.R(20.8),M.R(0)),Alpha)
				LS.C0 = LS.C0:lerp(CF.N(-0.9,0.4,-0.7)*CF.A(M.R(121.8),M.R(14.6),M.R(84.8))*CF.A(M.R(0+3*M.S(Sine/32)),0,0),Alpha)
				RS.C0 = RS.C0:lerp(CF.N(1.3,0.3,-0.1)*CF.A(M.R(40+5*M.C(Sine/44)),M.R(-11.6),M.R(65.5+2.5*M.C(Sine/36))),Alpha)
				if(M.RNG(1,45)==1)then
					NK.C0 = NK.C0:lerp(NKC0*CF.A(M.RRNG(-25,25),M.RRNG(-25,25),M.RRNG(-25,25)),.8)
				else
					NK.C0 = NK.C0:lerp(CF.N(0,1.5,-0.2)*CF.A(M.R(-15.6),M.R(-20.1),M.R(-5.5))*CF.A(M.R(0+1.5*M.S(Sine/32)),0,0),Alpha)
				end
				if(legAnims)then
					LH.C0 = LH.C0:lerp(CF.N(-0.6,-1-.05*M.C(Sine/32),0.1)*CF.A(M.R(-27.6),M.R(0),M.R(13.8)),Alpha)
					RH.C0 = RH.C0:lerp(CF.N(0.6,-1.1-.05*M.C(Sine/32),-0.1)*CF.A(M.R(-16.5),M.R(-20),M.R(-5.8)),Alpha)
				end
			elseif(legAnims)then
				LH.C0 = LH.C0:lerp(LHC0,Alpha)
				RH.C0 = RH.C0:lerp(RHC0,Alpha)
			end
		elseif(Mode=='Legendary') or (Mode=='CALAMITY') or (Mode=='Radioactive') then
			local Alpha = .1
			if(NeutralAnims)then
				RJ.C0 = RJ.C0:lerp(CF.N(0,4.8+.2*M.C(Sine/24),0)*CF.A(M.R(30+5*M.S(Sine/24)),M.R(16.7),M.R(-9.4)),Alpha)
				LS.C0 = LS.C0:lerp(CF.N(-1.1,1,0.2)*CF.A(M.R(173.3+1*M.S(Sine/28)),M.R(19.9+2*M.S(Sine/28)),M.R(38.7)),Alpha)
				RS.C0 = RS.C0:lerp(CF.N(0.7,0.3,-0.6)*CF.A(M.R(46.8+1*M.S(Sine/28)),M.R(6.4+2*M.S(Sine/28)),M.R(-79.6)),Alpha)
				NK.C0 = NK.C0:lerp(CF.N(0,1.4,-0.5)*CF.A(M.R(-40-5*M.S(Sine/24)),M.R(-18.7),M.R(-3.7)),Alpha)
				if(legAnims)then
					LH.C0 = LH.C0:lerp(CF.N(-0.5,-1,0)*CF.A(M.R(1.9+7.5*M.S(Sine/24)),M.R(19.2),M.R(-5.7)),Alpha)
					RH.C0 = RH.C0:lerp(CF.N(0.4,-1,-0.8)*CF.A(M.R(-63.8+7.5*M.S(Sine/24)),M.R(-15),M.R(8.3)),Alpha)
				end
			elseif(legAnims)then
				LH.C0 = LH.C0:lerp(LHC0,Alpha)
				RH.C0 = RH.C0:lerp(RHC0,Alpha)
			end
			elseif(Mode=='Lust')then
				local Alpha = .1
				if(NeutralAnims)then
					RJ.C0 = RJ.C0:lerp(CF.N(0,0.7+.1*M.C(Sine/36),0)*CF.A(M.R(0),M.R(0),M.R(-90-2.5*M.S(Sine/36))),Alpha)
					LS.C0 = LS.C0:lerp(CF.N(-1.2,0.1,0.1)*CF.A(M.R(23),M.R(16.5),M.R(20.6)),Alpha)
					RS.C0 = RS.C0:lerp(CF.N(0.8,1,-0.4)*CF.A(M.R(-162),M.R(-11.2),M.R(-22.6)),Alpha)
					NK.C0 = NK.C0:lerp(CF.N(-0.2,1.4,0)*CF.A(M.R(0),M.R(0),M.R(48.9)),Alpha)
					if(legAnims)then
						LH.C0 = LH.C0:lerp(CF.N(-0.9,-1.1,-0.2)*CF.A(M.R(-19.3),M.R(6.5),M.R(54.3-7.5*M.S(Sine/36))),Alpha)
						RH.C0 = RH.C0:lerp(CF.N(0.4,-0.9,0)*CF.A(M.R(0),M.R(0),M.R(25.9-7.5*M.S(Sine/36))),Alpha)
					end
			elseif(legAnims)then
				LH.C0 = LH.C0:lerp(LHC0,Alpha)
				RH.C0 = RH.C0:lerp(RHC0,Alpha)
			end
			elseif(Mode=='Justice')then
				local Alpha = .1
				if(NeutralAnims)then
			RJ.C0 = RJ.C0:lerp(CF.N(0,4.8+.2*M.C(Sine/16),0)*CF.A(M.R(0),M.R(28.9),M.R(0)),Alpha)
			LS.C0 = LS.C0:lerp(CF.N(-0.8,0.3+.1*M.S(Sine/16),-0.7)*CF.A(M.R(125.4+2.5*M.S(Sine/16)),M.R(7.9),M.R(81.3)),Alpha)
			RS.C0 = RS.C0:lerp(CF.N(0.9,0.3+.1*M.S(Sine/16),-0.6)*CF.A(M.R(79.5+2.5*M.S(Sine/16)),M.R(2.9),M.R(-85.6)),Alpha)
			NK.C0 = NK.C0:lerp(CF.N(0,1.5,0)*CF.A(M.R(0),M.R(-28.9),M.R(0)),Alpha)
				if(legAnims)then
			LH.C0 = LH.C0:lerp(CF.N(-0.5,-1+.1*M.S(Sine/16),-0.1)*CF.A(M.R(-4.4),M.R(11.9),M.R(-9.2)),Alpha)
			RH.C0 = RH.C0:lerp(CF.N(0.7,-0.3+.1*M.S(Sine/16),-0.6)*CF.A(M.R(-28.3),M.R(-41.7),M.R(-9.7)),Alpha)
				end
			end
		end
	elseif(State == 'Walk')then
		if(Mode=='Radioactive') or (Mode=='CALAMITY')or (Mode=='Legendary') then
			local Alpha = .2
  			if(NeutralAnims)then
			RJ.C0 = RJ.C0:lerp(CF.N(0,4.8+.2*M.C(Sine/24),0)*CF.A(M.R(-35),M.R(0),M.R(0)),Alpha)
			LS.C0 = LS.C0:lerp(CF.N(-0.8,0.3+.1*M.S(Sine/16),-0.7)*CF.A(M.R(125.4),M.R(7.9),M.R(81.3)),Alpha)
			RS.C0 = RS.C0:lerp(CF.N(0.9,0.3+.1*M.S(Sine/16),-0.6)*CF.A(M.R(79.5),M.R(2.9),M.R(-85.6)),Alpha)
				NK.C0 = NK.C0:lerp(CF.N(0,1.5,0)*CF.A(M.R(35),M.R(0),M.R(0)),Alpha)
			end
			if(legAnims)then
			LH.C0 = LH.C0:lerp(CF.N(-.5,-1+.1*M.S(Sine/16),-0.1)*CF.A(M.R(-25.3),M.R(0),M.R(-4.7)),Alpha)
			RH.C0 = RH.C0:lerp(CF.N(.5,-0.3+.1*M.S(Sine/16),-0.6)*CF.A(M.R(-25.3),M.R(0),M.R(4.7)),Alpha)
			end
		end
			if(Mode=='Love') then
		local wsVal = 4
		local Alpha = .2
if(Walking)then Change=.5 else Change=.7 end
if(NeutralAnims)then
			SetTween(RJ,{C0 = RJC0*CF.N(0,.05+Change/4*M.C(Sine/(wsVal/2)),0)*CF.A(M.R(-(Change*20)-movement/20*M.C(Sine/(wsVal/2)))*forwardvelocity,M.R(0+5*M.C(Sine/wsVal)),M.R(-(Change*20)-movement/20*M.C(Sine/(wsVal/2)))*sidevelocity+M.R(0-1*M.C(Sine/wsVal)))},"Quad","Out",Alpha)
		    SetTween(LS,{C0 = CF.N(-1.1,0.4,-0.5)*CF.A(math.rad(-6.5),math.rad(13.6),math.rad(45.8))},"Quad","Out",Alpha)
		    SetTween(RS,{C0 = CF.N(1.2,0.3,-0.5)*CF.A(math.rad(-6.5),math.rad(-13.6),math.rad(-45.8))},"Quad","Out",Alpha)
					    SetTween(NK,{C0 = CF.N(0,1.5,-0.1)*CF.A(math.rad(-7),math.rad(0),math.rad(0))},"Quad","Out",Alpha)
					end
if(legAnims)then
			SetTween(LH,{C0 = LHC0*CF.N(0,0-movement/15*M.C(Sine/wsVal)/2,(-.1+movement/15*M.C(Sine/wsVal))*(.5+.5*forwardvelocity))*CF.A((M.R(-10*forwardvelocity+Change*5-movement*M.C(Sine/wsVal))+-(movement/10)*M.S(Sine/wsVal))*forwardvelocity,0,(M.R(Change*5-movement*M.C(Sine/wsVal))+-(movement/10)*M.S(Sine/wsVal))*(sidevec/(Hum.WalkSpeed*2)))},"Quad","Out",Alpha)
			SetTween(RH,{C0 = RHC0*CF.N(0,0+movement/15*M.C(Sine/wsVal)/2,(-.1-movement/15*M.C(Sine/wsVal))*(.5+.5*forwardvelocity))*CF.A((M.R(-10*forwardvelocity+Change*5+movement*M.C(Sine/wsVal))+(movement/10)*M.S(Sine/wsVal))*forwardvelocity,0,(M.R(Change*5+movement*M.C(Sine/wsVal))+(movement/10)*M.S(Sine/wsVal))*(sidevec/(Hum.WalkSpeed*2)))},"Quad","Out",Alpha)
				end
		end
			if(Mode=='Justice') then
		local wsVal = 4
		local Alpha = .2
if(Walking)then Change=.5 else Change=.7 end
if(NeutralAnims)then
			RJ.C0 = RJ.C0:lerp(CF.N(0,4.8+.2*M.C(Sine/16),0)*CF.A(M.R(-35),M.R(0),M.R(0)),Alpha)
			LS.C0 = LS.C0:lerp(CF.N(-0.8,0.3+.1*M.S(Sine/16),-0.7)*CF.A(M.R(125.4),M.R(7.9),M.R(81.3)),Alpha)
			RS.C0 = RS.C0:lerp(CF.N(0.9,0.3+.1*M.S(Sine/16),-0.6)*CF.A(M.R(79.5),M.R(2.9),M.R(-85.6)),Alpha)
						NK.C0 = NK.C0:lerp(CF.N(0,1.5,0)*CF.A(M.R(35),M.R(0),M.R(0)),Alpha)
						end
if(legAnims)then
			LH.C0 = LH.C0:lerp(CF.N(-.5,-1+.1*M.S(Sine/16),-0.1)*CF.A(M.R(-25.3),M.R(0),M.R(-4.7)),Alpha)
			RH.C0 = RH.C0:lerp(CF.N(.5,-0.3+.1*M.S(Sine/16),-0.6)*CF.A(M.R(-25.3),M.R(0),M.R(4.7)),Alpha)
end
			else
			local wsVal = 4
			local Alpha = .2
			if(Mode=='Subzero')then Change=.3 elseif(Mode=='The Big Black' or Mode=='RAINBOW' or Mode=='Legendary') then Change=1 else Change=.5 end
			if(NeutralAnims)then
				RJ.C0 = RJ.C0:lerp(RJC0*CF.N(0,.05+Change/4*M.C(Sine/(wsVal/2)),0)*CF.A(M.R(-(Change*20)-movement/20*M.C(Sine/(wsVal/2)))*forwardvelocity,M.R(0+5*M.C(Sine/wsVal)),M.R(-(Change*20)-movement/20*M.C(Sine/(wsVal/2)))*sidevelocity+M.R(0-1*M.C(Sine/wsVal))),Alpha)
				NK.C0 = NK.C0:lerp(NKC0,Alpha)
				LS.C0 = LS.C0:lerp(LSC0*CF.N(0,0,0)*CF.A(M.R(0+55*(movement/8)*M.S(Sine/wsVal))*forwardvelocity,0,0),Alpha)
				RS.C0 = RS.C0:lerp(RSC0*CF.N(0,0,0)*CF.A(M.R(0-55*(movement/8)*M.S(Sine/wsVal))*forwardvelocity,0,0),Alpha)
			end
			if(legAnims)then 
				LH.C0 = LH.C0:lerp(LHC0*CF.N(0,0-movement/15*M.C(Sine/wsVal)/2,(-.1+movement/15*M.C(Sine/wsVal))*(.5+.5*forwardvelocity))*CF.A((M.R(-10*forwardvelocity+Change*5-movement*M.C(Sine/wsVal))+-(movement/10)*M.S(Sine/wsVal))*forwardvelocity,0,(M.R(Change*5-movement*M.C(Sine/wsVal))+-(movement/10)*M.S(Sine/wsVal))*(sidevec/(Hum.WalkSpeed*2))),Alpha)
				RH.C0 = RH.C0:lerp(RHC0*CF.N(0,0+movement/15*M.C(Sine/wsVal)/2,(-.1-movement/15*M.C(Sine/wsVal))*(.5+.5*forwardvelocity))*CF.A((M.R(-10*forwardvelocity+Change*5+movement*M.C(Sine/wsVal))+(movement/10)*M.S(Sine/wsVal))*forwardvelocity,0,(M.R(Change*5+movement*M.C(Sine/wsVal))+(movement/10)*M.S(Sine/wsVal))*(sidevec/(Hum.WalkSpeed*2))),Alpha)
				local footstepIds = {141491460,141491460}
				if(lhit and lhit.CanCollide and footstepSounds[lhit.Material])then
					if(lhit.Material==Enum.Material.Sand and lhit.Color.r*255>=160 and lhit.Color.g*255>=160 and lhit.Color.b*255>=160)then
						footstepIds[1] = footstepSounds[Enum.Material.Snow]
					else
						footstepIds[1] = footstepSounds[lhit.Material]
					end
				end
				
				if(rhit and rhit.CanCollide and footstepSounds[rhit.Material])then
					if(rhit.Material==Enum.Material.Sand and rhit.Color.r*255>=160 and rhit.Color.g*255>=160 and rhit.Color.b*255>=160)then
						footstepIds[2] = footstepSounds[Enum.Material.Snow]
					else
						footstepIds[2] = footstepSounds[rhit.Material]
					end
				end
		
				
				if(M.C(Sine/wsVal)/2>=.2 and footsound==0 and lhit)then
					local step = Part(Effects,lhit.Color,lhit.Material,V3.N(1,.1,1),CF.N(lpos),true,false)
					step.Transparency=(footstepIds[1]==footstepSounds[Enum.Material.Snow] and 0 or 1)
					local snd = Soond(step,footstepIds[1],M.RNG(80,100)/100,3,false,true,true)
					footsound=1
					S.Debris:AddItem(step,snd.TimeLength+2)
				elseif(M.C(Sine/wsVal)/2<=-.2 and footsound==1 and rhit)then
					local step = Part(Effects,rhit.Color,rhit.Material,V3.N(1,.1,1),CF.N(rpos),true,false)
					step.Transparency=(footstepIds[2]==footstepSounds[Enum.Material.Snow] and 0 or 1)
					local snd = Soond(step,footstepIds[2],M.RNG(80,100)/100,3,false,true,true)
					footsound=0
					S.Debris:AddItem(step,snd.TimeLength+2)
				end
			end
		end
	elseif(State == 'Jump')then
		local Alpha = .1
		local idk = math.min(math.max(Root.Velocity.Y/50,-M.R(90)),M.R(90))
		if(NeutralAnims)then
			LS.C0 = LS.C0:lerp(LSC0*CF.A(M.R(-5),0,M.R(-90)),Alpha)
			RS.C0 = RS.C0:lerp(RSC0*CF.A(M.R(-5),0,M.R(90)),Alpha)
			RJ.C0 = RJ.C0:lerp(RJC0*CF.A(math.min(math.max(Root.Velocity.Y/100,-M.R(45)),M.R(45)),0,0),Alpha)
			NK.C0 = NK.C0:lerp(NKC0*CF.A(math.min(math.max(Root.Velocity.Y/100,-M.R(45)),M.R(45)),0,0),Alpha)
		end
		if(legAnims)then 
			LH.C0 = LH.C0:lerp(LHC0*CF.A(0,0,M.R(-5)),Alpha)
			RH.C0 = RH.C0:lerp(RHC0*CF.N(0,1,-1)*CF.A(M.R(-5),0,M.R(5)),Alpha)
		end
	elseif(State == 'Fall')then
		local Alpha = .1
		local idk = math.min(math.max(Root.Velocity.Y/50,-M.R(90)),M.R(90))
		if(NeutralAnims)then
			LS.C0 = LS.C0:lerp(LSC0*CF.A(M.R(-5),0,M.R(-90)+idk),Alpha)
			RS.C0 = RS.C0:lerp(RSC0*CF.A(M.R(-5),0,M.R(90)-idk),Alpha)
			RJ.C0 = RJ.C0:lerp(RJC0*CF.A(math.min(math.max(Root.Velocity.Y/100,-M.R(45)),M.R(45)),0,0),Alpha)
			NK.C0 = NK.C0:lerp(NKC0*CF.A(math.min(math.max(Root.Velocity.Y/100,-M.R(45)),M.R(45)),0,0),Alpha)
		end
		if(legAnims)then 
			LH.C0 = LH.C0:lerp(LHC0*CF.A(0,0,M.R(-5)),Alpha)
			RH.C0 = RH.C0:lerp(RHC0*CF.N(0,1,-1)*CF.A(M.R(-5),0,M.R(5)),Alpha)
		end
	elseif(State == 'Paralyzed')then
		local Alpha = .1
		if(NeutralAnims)then
			LS.C0 = LS.C0:lerp(LSC0,Alpha)
			RS.C0 = RS.C0:lerp(RSC0,Alpha)
			RJ.C0 = RJ.C0:lerp(RJC0,Alpha)
			NK.C0 = NK.C0:lerp(NKC0,Alpha)
		end
		if(legAnims)then 
			LH.C0 = LH.C0:lerp(LHC0,Alpha)
			RH.C0 = RH.C0:lerp(RHC0,Alpha)
		end
	elseif(State == 'Sit')then
		
	end
		
	if(data.User==data.Local)then
		local syncStuff={
			NeutralAnims;
			legAnims;
			{NK.C0,RJ.C0,RH.C0,RS.C0,LH.C0,LS.C0};
			{NK.C1,RJ.C1,RH.C1,RS.C1,LH.C1,LS.C1};
			Sine;
			movement;
			walking;	
			Change;
			--// OPTIONAL SYNC --
			MusicMode;
			(music and music.TimePosition or 0);
			(music and music.Pitch or 1);
			WingSine;
			getMode('Troubadour');
			Mode;
			hue;
		}
	end	
end
