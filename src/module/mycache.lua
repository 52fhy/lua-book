 -- module/mycache
local cache = require "module/cache"

local _M = {}

_M.del = function(self, key)
	_M.mt[key] = nil
end

_M.new = function(self, key)
	return setmetatable(_M, {__index = cache }) --该方法需要覆写父类的，确保此处的setmetatable先执行
end

return _M