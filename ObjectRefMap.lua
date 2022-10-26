local createInstanceCopy = require(script.Parent.createInstanceCopy)

local ObjectRefMap = {}

function ObjectRefMap.fromModel(model)
	local newModel = Instance.new("Model")

	local alreadyHasAHumanoid = false
	local clonedPrimaryPart
	local dataModel = {}
	local map = {}
	if not model:IsA("Model") then
		local clone = createInstanceCopy(model)
		if clone then
			clone.Parent = newModel

			if clone:IsA("BasePart") then
				map[model] = clone
				if not clonedPrimaryPart then
					clonedPrimaryPart = clone
				end
			elseif model:IsA("Humanoid") then
				if alreadyHasAHumanoid then
					clone:Destroy()
				else
					alreadyHasAHumanoid = true
				end
			end
		end
	end
	for _, object in ipairs(model:GetDescendants()) do
		local clone = createInstanceCopy(object)
		if clone then
			clone.Parent = newModel

			if clone:IsA("BasePart") then
				map[object] = clone
				if not clonedPrimaryPart and object == model.PrimaryPart then
					clonedPrimaryPart = clone
				end
			elseif object:IsA("Humanoid") then
				if alreadyHasAHumanoid then
					clone:Destroy()
				else
					alreadyHasAHumanoid = true
				end
			end
		end
	end
	newModel.PrimaryPart = clonedPrimaryPart

	dataModel.map = map
	dataModel.rbx = newModel
	dataModel.worldModel = model

	return dataModel
end

return ObjectRefMap
