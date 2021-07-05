local CreateLibrary = function()
	local Library = {}
	return (Library)
end

local TypicalUI = CreateLibrary()

function TypicalUI.MakeUI(Name)
	local ScreenGui = Instance.new("ScreenGui")
	local Main = Instance.new("Frame")
	local Top = Instance.new("TextLabel")
	local TabButtons = Instance.new("Frame")
	local TABBUTTONLIST = Instance.new("UIListLayout")
	local TABBUTTONPADDING = Instance.new("UIPadding")
	local Line = Instance.new("Frame")
	local Tabs = Instance.new("Frame")
	
	ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

	Main.Name = "Main"
	Main.Parent = ScreenGui
	Main.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	Main.BorderSizePixel = 0
	Main.Position = UDim2.new(0.204379559, 0, 0.248046875, 0)
	Main.Size = UDim2.new(0, 503, 0, 237)

	Top.Name = "Top"
	Top.Parent = Main
	Top.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
	Top.BorderSizePixel = 0
	Top.Size = UDim2.new(0, 503, 0, 37)
	Top.Font = Enum.Font.GothamSemibold
	Top.Text = "   "..Name
	Top.TextColor3 = Color3.fromRGB(255, 255, 255)
	Top.TextSize = 14.000
	Top.TextXAlignment = Enum.TextXAlignment.Left

	TabButtons.Name = "TabButtons"
	TabButtons.Parent = Main
	TabButtons.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
	TabButtons.BorderSizePixel = 0
	TabButtons.Position = UDim2.new(0, 0, 0.15611814, 0)
	TabButtons.Size = UDim2.new(0, 119, 0, 200)

	TABBUTTONLIST.Name = "TABBUTTONLIST"
	TABBUTTONLIST.Parent = TabButtons
	TABBUTTONLIST.SortOrder = Enum.SortOrder.LayoutOrder
	TABBUTTONLIST.Padding = UDim.new(0, 5)

	TABBUTTONPADDING.Name = "TABBUTTONPADDING"
	TABBUTTONPADDING.Parent = TabButtons
	TABBUTTONPADDING.PaddingBottom = UDim.new(0, 5)
	TABBUTTONPADDING.PaddingLeft = UDim.new(0, 5)
	TABBUTTONPADDING.PaddingRight = UDim.new(0, 5)
	TABBUTTONPADDING.PaddingTop = UDim.new(0, 5)

	Line.Name = "Line"
	Line.Parent = Main
	Line.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
	Line.BorderSizePixel = 0
	Line.Position = UDim2.new(0.236580521, 0, 0.15611814, 0)
	Line.Size = UDim2.new(0, 3, 0, 200)

	Tabs.Name = "Tabs"
	Tabs.Parent = Main
	Tabs.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Tabs.BackgroundTransparency = 1.000
	Tabs.Position = UDim2.new(0.242544726, 0, 0.15611814, 0)
	Tabs.Size = UDim2.new(0, 381, 0, 200)

	
	function LoadDrag()
		local UIS = game:GetService("UserInputService")
		function Drag(Frame) --Not made by Kenta so stop crying about it (Drag Script)
			dragToggle = nil
			local dragSpeed = 0
			dragInput = nil
			dragStart = nil
			local dragPos = nil
			function updateInput(input)
				local Delta = input.Position - dragStart
				local Position =
					UDim2.new(
						startPos.X.Scale,
						startPos.X.Offset + Delta.X,
						startPos.Y.Scale,
						startPos.Y.Offset + Delta.Y
					)
				game:GetService("TweenService"):Create(Frame, TweenInfo.new(0), {Position = Position}):Play()
			end
			Frame.InputBegan:Connect(
				function(input)
					if
						(input.UserInputType == Enum.UserInputType.MouseButton1 or
							input.UserInputType == Enum.UserInputType.Touch) and
							UIS:GetFocusedTextBox() == nil
					then
						dragToggle = true
						dragStart = input.Position
						startPos = Frame.Position
						input.Changed:Connect(
							function()
								if input.UserInputState == Enum.UserInputState.End then
									dragToggle = false
								end
							end
						)
					end
				end
			)
			Frame.InputChanged:Connect(
				function(input)
					if
						input.UserInputType == Enum.UserInputType.MouseMovement or
							input.UserInputType == Enum.UserInputType.Touch
					then
						dragInput = input
					end
				end
			)
			game:GetService("UserInputService").InputChanged:Connect(
			function(input)
				if input == dragInput and dragToggle then
					updateInput(input)
				end
			end
			)
		end

		Drag(Main)
	end

	LoadDrag()
	
	local Library = CreateLibrary()
	
	function Library:CreateTab(Name)
		local TabButton = Instance.new("TextButton")
		local Tab = Instance.new("ScrollingFrame")
		local TABLIST = Instance.new("UIListLayout")
		local TABPADDING = Instance.new("UIPadding")
		--[[
		Tab.Name = Name
		Tab.Parent = Tabs
		Tab.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Tab.BackgroundTransparency = 1.000
		Tab.Size = UDim2.new(0, 381, 0, 200)
		Tab.Visible = false
		--]]
		Tab.Name = Name
		Tab.Parent = Tabs
		Tab.Active = true
		Tab.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Tab.BackgroundTransparency = 1.000
		Tab.BorderSizePixel = 0
		Tab.Position = UDim2.new(0, 0, 0, 0)
		Tab.Size = UDim2.new(0, 381, 0, 200)
		Tab.CanvasSize = UDim2.new(0, 0, 3, 0)
		Tab.BottomImage = ""
		Tab.ScrollBarThickness = 5
		Tab.TopImage = ""
		Tab.Visible = false

		TABLIST.Name = "TABLIST"
		TABLIST.Parent = Tab
		TABLIST.SortOrder = Enum.SortOrder.LayoutOrder
		TABLIST.Padding = UDim.new(0, 5)

		TABPADDING.Name = "TABPADDING"
		TABPADDING.Parent = Tab
		TABPADDING.PaddingBottom = UDim.new(0, 5)
		TABPADDING.PaddingLeft = UDim.new(0, 5)
		TABPADDING.PaddingRight = UDim.new(0, 5)
		TABPADDING.PaddingTop = UDim.new(0, 5)
		
		TabButton.Name = "TabButton"
		TabButton.Parent = TabButtons
		TabButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
		TabButton.BorderSizePixel = 0
		TabButton.Position = UDim2.new(0.0420168079, 0, 0.0250000004, 0)
		TabButton.Size = UDim2.new(0, 108, 0, 32)
		TabButton.AutoButtonColor = false
		TabButton.Font = Enum.Font.Gotham
		TabButton.Text = Name
		TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
		TabButton.TextSize = 14.000
		
		TabButton.MouseButton1Down:Connect(function()
			for i,v in next, Tabs:GetChildren() do
				if v:IsA("ScrollingFrame") then
					v.Visible = false
				end
			end
			Tab.Visible = true
		end)
		
		local function Ripple()  
			local Circle = Instance.new("ImageLabel")
			local script = Instance.new('LocalScript', TabButton)
			Circle.Name = "Circle"
			Circle.Parent = script
			Circle.AnchorPoint = Vector2.new(0.5, 0.5)
			Circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Circle.BackgroundTransparency = 1.000
			Circle.Position = UDim2.new(0.5, 0, 0.5, 0)
			Circle.ZIndex = 10
			Circle.Image = "rbxassetid://266543268"
			Circle.ImageColor3 = Color3.fromRGB(0, 0, 0)
			Circle.ImageTransparency = 0.500


			local RippleColor        = Color3.fromRGB(255, 255, 255) -- RGB Color of the ripple effect, you can change it.
			local RippleTransparency = 0.8 ---------------------------- Max is 1, Min is 0
			local PixelSize          = 2000 --------------------------- The Max size of the ripple in pixels
			local TimeLength         = 0.9 ---------------------------- How long the ripple animation is
			local FadeLength         = 0.6 ---------------------------- How long it takes for the ripple to fade out

			local frame = script.Parent
			local rgb = Color3.fromRGB
			local ud2 = UDim2.new
			repeat
				wait()
			until game.Players.LocalPlayer
			local plr = game.Players.LocalPlayer
			local mouse = plr:GetMouse()

			frame.ClipsDescendants = true
			frame.AutoButtonColor = false


			function tweenInRipple(ripple)
				spawn(function()
					local TweenService = game:GetService("TweenService")
					local Part = ripple
					local Info = TweenInfo.new(
						TimeLength,
						Enum.EasingStyle.Linear,
						Enum.EasingDirection.InOut,
						0,
						false,
						0
					)
					local Goals = 
						{
							Size = ud2(0, PixelSize, 0, PixelSize);
						}
					local Tween = TweenService:Create(Part, Info, Goals)
					Tween:Play()
				end)
			end

			function fadeOutRipple(ripple)
				spawn(function()
					local TweenService = game:GetService("TweenService")
					local Part = ripple
					local Info = TweenInfo.new(
						FadeLength,
						Enum.EasingStyle.Linear,
						Enum.EasingDirection.InOut,
						0,
						false,
						0
					)
					local Goals = 
						{
							ImageTransparency = 1;
						}
					local Tween = TweenService:Create(Part, Info, Goals)
					Tween:Play()
					wait(FadeLength + 0.1)
					ripple:Destroy()
				end)
			end

			frame.MouseButton1Down:Connect(function()
				local done = false
				local ripple = script.Circle:Clone()
				ripple.Parent = frame
				ripple.ZIndex = frame.ZIndex + 1
				ripple.ImageColor3 = RippleColor
				ripple.ImageTransparency = RippleTransparency
				tweenInRipple(ripple)
				frame.MouseButton1Up:Connect(function()
					if done == false then
						done = true
						fadeOutRipple(ripple)
					end
				end)
				wait(4);
				done = true;
				fadeOutRipple(ripple) -- if it doesnt detect that it was unselected
			end)
		end --Not made by me too so stfu (Ripple Effect)
		coroutine.wrap(Ripple)()
		
		local Library = CreateLibrary()

		function Library:Button(Name, Cb)
			Cb = Cb or function() end
			local Button = Instance.new("TextButton")
			Button.Name = "Button"
			Button.Parent = Tab
			Button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
			Button.BorderSizePixel = 0
			Button.Position = UDim2.new(0.0131233595, 0, 0.0250000004, 0)
			Button.Size = UDim2.new(0, 370, 0, 32)
			Button.AutoButtonColor = false
			Button.Font = Enum.Font.Gotham
			Button.Text = Name
			Button.TextColor3 = Color3.fromRGB(255, 255, 255)
			Button.TextSize = 14.000
			
			Button.MouseButton1Down:Connect(function()
				pcall(Cb)
			end)
			local function Ripple()  
				local Circle = Instance.new("ImageLabel")
				local script = Instance.new('LocalScript', Button)
				Circle.Name = "Circle"
				Circle.Parent = script
				Circle.AnchorPoint = Vector2.new(0.5, 0.5)
				Circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Circle.BackgroundTransparency = 1.000
				Circle.Position = UDim2.new(0.5, 0, 0.5, 0)
				Circle.ZIndex = 10
				Circle.Image = "rbxassetid://266543268"
				Circle.ImageColor3 = Color3.fromRGB(0, 0, 0)
				Circle.ImageTransparency = 0.500


				local RippleColor        = Color3.fromRGB(255, 255, 255) -- RGB Color of the ripple effect, you can change it.
				local RippleTransparency = 0.8 ---------------------------- Max is 1, Min is 0
				local PixelSize          = 2000 --------------------------- The Max size of the ripple in pixels
				local TimeLength         = 0.9 ---------------------------- How long the ripple animation is
				local FadeLength         = 0.6 ---------------------------- How long it takes for the ripple to fade out

				local frame = script.Parent
				local rgb = Color3.fromRGB
				local ud2 = UDim2.new
				repeat
					wait()
				until game.Players.LocalPlayer
				local plr = game.Players.LocalPlayer
				local mouse = plr:GetMouse()

				frame.ClipsDescendants = true
				frame.AutoButtonColor = false


				function tweenInRipple(ripple)
					spawn(function()
						local TweenService = game:GetService("TweenService")
						local Part = ripple
						local Info = TweenInfo.new(
							TimeLength,
							Enum.EasingStyle.Linear,
							Enum.EasingDirection.InOut,
							0,
							false,
							0
						)
						local Goals = 
							{
								Size = ud2(0, PixelSize, 0, PixelSize);
							}
						local Tween = TweenService:Create(Part, Info, Goals)
						Tween:Play()
					end)
				end

				function fadeOutRipple(ripple)
					spawn(function()
						local TweenService = game:GetService("TweenService")
						local Part = ripple
						local Info = TweenInfo.new(
							FadeLength,
							Enum.EasingStyle.Linear,
							Enum.EasingDirection.InOut,
							0,
							false,
							0
						)
						local Goals = 
							{
								ImageTransparency = 1;
							}
						local Tween = TweenService:Create(Part, Info, Goals)
						Tween:Play()
						wait(FadeLength + 0.1)
						ripple:Destroy()
					end)
				end

				frame.MouseButton1Down:Connect(function()
					local done = false
					local ripple = script.Circle:Clone()
					ripple.Parent = frame
					ripple.ZIndex = frame.ZIndex + 1
					ripple.ImageColor3 = RippleColor
					ripple.ImageTransparency = RippleTransparency
					tweenInRipple(ripple)
					frame.MouseButton1Up:Connect(function()
						if done == false then
							done = true
							fadeOutRipple(ripple)
						end
					end)
					wait(4);
					done = true;
					fadeOutRipple(ripple) -- if it doesnt detect that it was unselected
				end)
			end --Not made by me too so stfu (Ripple Effect)
			coroutine.wrap(Ripple)()
		end

		return Library;
	end
	function Library:SetHomePage(Name)
		for _,Frame in pairs(Tabs:GetChildren()) do
			if Frame:IsA("ScrollingFrame") then
				if string.lower(Frame.Name) == string.lower(Name) then
					Frame.Visible = true
				end
			end
		end
	end
	return Library;
end

return TypicalUI;

end
