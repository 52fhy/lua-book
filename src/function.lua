function maxNumber(a, b)
	if a > b then
		return a
	else
		return b
	end
end

local testFunc = maxNumber

print(testFunc(10,100));

function test1(x, y)
	return x+y;
	-- print(x+y)
	-- 后面的print如果不注释，会报错
end

function test2(x, y)
	if x > y then
		return x
	else
		return y
	end
	print("end") -- 此处的print不注释不会报错，因为return只出现在前面显式的语句块
end

function test3(x, y)
	print(x+y)
	do return end
	print(x) -- 此处的print不注释不会报错，因为return由do...end语句块包含。这一行语句永远不会执行到
end

test1(10,11)
test2(10,11)
test3(10,11)


--- 动态函数

function do_action(func, ...)
	local args = {...} or {} -- 防止为nil
	func(unpack(args, 1, table.maxn(args)))
end

local function add(x, y)
	print(x+y)
end

local function add2(x, y, z)
	print(x+y+z)
end

do_action(add, 1, 1)
do_action(add2, 1, 1, 1)

-- 定义函数 swap，实现两个变量交换值
local function swap(a, b) 
	return b, a -- 按相反顺序返回变量的值
end
print(swap(1,2))

-- 虚变量测试
local function test_var()
	return 1,2,3
end

local x,_,y = test_var()
print(x,y)
