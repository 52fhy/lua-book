local mytable = setmetatable({ 10, 20, 30 }, {
  __tostring = function(mytable)
    sum = 0
    for k, v in pairs(mytable) do
        sum = sum + v
    end
    return sum
  end
})
print(mytable) -- 60

local mytable2 = setmetatable({}, {
  __call = function(self, arg)
	local sum = 0
	for _,v in pairs(arg) do
		sum = sum + v
	end
    print(sum)
  end
})
mytable2({10,20,30}) -- 60

local mytable3 = setmetatable({}, {
  __metatable = "no access"
})
print(getmetatable(mytable3)) -- no access
--setmetatable(mytable3, {}) -- 引发编译器报错

local mytable4 = setmetatable({}, {
	__index = function(self, key)
		return "__index"
	end
})
print(mytable4.key1) -- __index 

local _M = {
	add = function(x,y) return x+y end,
	mul = function(x,y) return x*y end,
	ver = "1.0",
}
local mytable5 = setmetatable({}, {
	__index = _M
})
print(mytable5.ver) -- 1.0 
print(mytable5.add(1,3)) -- 4 


mytable6 = setmetatable({key1 = "value1"}, {
  __newindex = function(self, key, value)
        rawset(self, key, "\""..value.."\"")

  end
})

mytable6.key1 = "new value"
mytable6.key2 = 4

print(mytable6.key1,mytable6.key2)