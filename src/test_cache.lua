local cache = require "module/cache"
local c = cache:new()
c:set("name", "lua")
c:set("year", 2018)
print(c:get("name"))
print(c:get("year"))

for k,v in pairs(c:getall()) do
	print(k,v)
end