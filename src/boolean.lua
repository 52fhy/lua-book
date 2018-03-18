local a = true
local b = 0
local c = nil

if a then
	print("a") -->output:a
else
	print("not a") --这个没有执行
end

if b then
	print("b") -->output:b
else
	print("not b") --这个没有执行
end

if c then
	print("c") --这个没有执行
else
	print("not c") -->output:not c
end