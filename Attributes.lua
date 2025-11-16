local Attributes = {}
Attributes.__index = Attributes

function Attributes.Bind(Object: Instance)
	local Proxy = { Object = Object }

	return setmetatable(Proxy, {
		__index = function(self, Key)
			local ClassValue = Attributes[Key]
			if ClassValue then return ClassValue end

			local Object = rawget(self, "Object")

			local Value = Object[Key]
			if Value ~= nil then return Value end

			return Object:GetAttribute(Key)
		end,

		__newindex = function(self, Key, Value)
			rawget(self, "Object"):SetAttribute(Key, Value)
		end,
	})
end

return Attributes
