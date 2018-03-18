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
