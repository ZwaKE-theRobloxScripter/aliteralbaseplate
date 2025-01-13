local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "A Literal Baseplate",
   Icon = 0, -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
   LoadingTitle = "A Literal Baseplate",
   LoadingSubtitle = "by ZwaKE",
   Theme = "Default", -- Check https://docs.sirius.menu/rayfield/configuration/themes

   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false, -- Prevents Rayfield from warning when the script has a version mismatch with the interface

   ConfigurationSaving = {
      Enabled = false,
      FolderName = nil, -- Create a custom folder for your hub/game
      FileName = "aliteralbaseplate"
   },

   Discord = {
      Enabled = false, -- Prompt the user to join your Discord server if their executor supports it
      Invite = "noinvitelink", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ ABCD would be ABCD
      RememberJoins = true -- Set this to false to make them join the discord every time they load it up
   },

   KeySystem = true, -- Set this to true to use our key system
   KeySettings = {
      Title = "A Litreal Baseplate | Key system",
      Subtitle = "Key System",
      Note = "the key is : aliteralbaseplatelol", -- Use this to tell the user how to get a key
      FileName = "Key", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
      SaveKey = false, -- The user's key will be saved, but if you change the key, they will be unable to use your script
      GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
      Key = {"aliteralbaseplatelol"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
   }
})

    local MainTab = Window:CreateTab("Character", nil) -- Title, Image
    local MainSection = MainTab:CreateSection("Main")

Rayfield:Notify({
   Title = "Thank you for using my script!",
   Content = "Are you really reading this?",
   Duration = 4,
   Image = nil,
})

local Input = MainTab:CreateInput({
   Name = "Walkspeed",
   CurrentValue = "",
   PlaceholderText = "16",
   RemoveTextAfterFocusLost = false,
   Flag = "walkspeed",
   Callback = function(Text)
           game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = (Text)
   end,
})

local Input = MainTab:CreateInput({
   Name = "JumpPower",
   CurrentValue = "",
   PlaceholderText = "50",
   RemoveTextAfterFocusLost = false,
   Flag = "jumppower",
   Callback = function(Text)
           game.Players.LocalPlayer.Character.Humanoid.JumpPower = (Text)
   end,
})

-- Variable to track toggle state
local infiniteJumpEnabled = false
local canJump = true -- Cooldown variable

-- Create a toggle (use your existing toggle instead of creating a new one)
local toggle = MainTab:CreateToggle({
    Name = "Inf jump",
    CurrentValue = false, -- Default state
    Flag = "infjump", -- Unique identifier
    Callback = function(Value)
        infiniteJumpEnabled = Value
        print("Infinite Jump Toggle State:", infiniteJumpEnabled) -- Debugging output
    end
})

-- Detect user input
local UserInputService = game:GetService("UserInputService")

-- Player object
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

-- Set up infinite jumping
UserInputService.JumpRequest:Connect(function()
    if infiniteJumpEnabled and canJump then
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            canJump = false -- Set cooldown
            task.wait(0.1) -- Cooldown duration (adjust as needed)
            canJump = true -- Reset cooldown
        end
    end
end)

-- Handle character respawn
player.CharacterAdded:Connect(function(newCharacter)
    character = newCharacter
end)
