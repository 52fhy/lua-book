local tmp = {
	name = "lua",
	-- "name2" = "lua2", -- 错误的表示
	["name3"] = "lua",
	year = 2018,
	pi = 3.14159,
	lang = {"c", "java", "lua"},
	100,  -- 相当于[1] = 100，此时索引为数字。lua里数字索引是从1开始的，不是0
	[10] = 11, -- 相当于[10] = 11，此时索引为数字
}

print(tmp.name)
print(tmp["name3"])
print(tmp.year)
print(tmp.pi)
print(tmp.lang[1])
print(tmp[1])
print(tmp[10])