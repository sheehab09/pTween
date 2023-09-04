local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

local Packages = ReplicatedStorage.Packages
local Promise = require(Packages.Promise)

local pTween = {}

function pTween.new(instance, tweenInfo, properties)
    return function()
		return Promise.new(function(resolve, reject, onCancel)
			local tween = TweenService:Create(instance, tweenInfo, properties)
			
			if onCancel(function()
				tween:Cancel()
			end) then return end
			
			tween.Completed:Connect(resolve)
			tween:Play()
		end)
	end
end

return pTween
