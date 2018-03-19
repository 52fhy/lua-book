local cache = require "module/mycache"
local c = cache:new()
c:set("name", "lua")
c:del("name")
print(c:get("name"))
