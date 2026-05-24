local AchievementModule = game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game.RemoteListener.Modules.AchievementUnlock
if AchievementModule == nil then return end
if not game.ReplicatedStorage:FindFirstChild("ModulesShared") then return end

local dataModule = require(game:GetService("ReplicatedStorage"):WaitForChild("ModulesShared"):WaitForChild("Achievements"))
local unlockFunc = require(AchievementModule)

-- [[ Custom Asset Image Loader ]]
local function ImageLoader(url)
    if not (writefile and getcustomasset and request) then return nil end
    local rawUrl = url:gsub("github.com", "raw.githubusercontent.com"):gsub("/blob/", "/")
    local success, response = pcall(function()
        return request({Url = rawUrl, Method = "GET"})
    end)
    
    if not success or response.StatusCode ~= 200 then return nil end

    local fileName = "LoadedImageAchievement_" .. tick() .. "_" .. math.random(100, 999) .. ".png"
    writefile(fileName, response.Body)
    return getcustomasset(fileName)
end

-- GitHub Asset URLs
local Static = "https://github.com/Francisco1692qzd/Fracture-Mode/blob/main/staticencounter.png"
local Frostbite = "https://github.com/Francisco1692qzd/Fracture-Mode/blob/main/hostbiteencounter.png"
local Frawnbush = "https://github.com/Francisco1692qzd/Fracture-Mode/blob/main/frawnbushencounter.png"
local A62 = "https://github.com/Francisco1692qzd/Fracture-Mode/blob/main/encounterA62.png"

-- Synchronous image processing
local StaticImage = ImageLoader(Static)
local FrostbiteImage = ImageLoader(Frostbite)
local frawnbushImage = ImageLoader(Frawnbush)
local A62Image = ImageLoader(A62)

-- [[ Data Module Injection ]]

dataModule["Static"] = {
    GetInfo = function()
        return {
            Title = "Statistic",
            Desc = "I hear static in my ears...",
            Reason = "Encounter Static.",
            Image = StaticImage
        }
    end
}

dataModule["Hostbite"] = {
    GetInfo = function()
        return {
            Title = "Cold to Hot.", -- Added missing comma here
            Desc = "Dude, I'm sweating...",
            Reason = "Encounter Hostbite.",
            Image = FrostbiteImage
        }
    end
}

dataModule["Frawnbush"] = {
    GetInfo = function()
        return {
            Title = "Is that...?", -- Added missing comma here
            Desc = "Oldest Ambush version but harder.",
            Reason = "Encounter Frawnbush.",
            Image = frawnbushImage
        }
    end
}

dataModule["A62"] = {
    GetInfo = function()
        return {
            Title = "What is that rainbow color coming towards here?", -- Added missing comma here
            Desc = "Eh... I think the lights are probably broken.",
            Reason = "Encounter A-62.",
            Image = A62Image
        }
    end
}

    -- unlockFunc(nil, "A62")
print("Achievements Created Successfully")
