-- cache.lua

local _M = {}

_M.mt = {}

_M.set = function(self, key ,value)
	self.mt[key] = value
end

_M.get = function(self, key)
	return self.mt[key]
end

_M.getall = function(self)
	return self.mt
end

_M.new = function(self)
	return setmetatable({}, {__index = _M })
end

return _M