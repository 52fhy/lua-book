
-- 计算集合的并集实例
set1 = {10,40}
set2 = {10,20,30}

setmetatable(set1, {
	__add = function(self, another)
		local res = {}
		local set = {}
		
		for k,v in pairs(self) do set[v] = true end -- 防止集合元素重复
		for k,v in pairs(another) do set[v] = true end -- 防止集合元素重复
		
		for k,v in pairs(set) do table.insert(res, k) end
		
		return res
	end
})

local set3 = set1 + set2
for k,v in pairs(set3) do print(v) end