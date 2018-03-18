# 函数

[TOC]

@date: 2018-3-18

---

在 Lua 中，函数 也是一种数据类型，函数可以存储在变量中，可以通过参数传递给其他函数，还可以作为其他函数的返回值。

## 函数定义

函数定义格式：
``` lua
function function_name (arc) -- arc 表示参数列表，函数的参数列表可以为空
	-- nody
end
```
支持使用`local`定义为局部作用域的函数。  

>由于函数定义本质上就是变量赋值，而变量的定义总是应放置在变量使用之前，所以函数的定义也需要放置在函数调用之前。  


由于函数定义等价于变量赋值，我们也可以把函数名替换为某个 Lua 表的某个字段，例如：
``` lua
function foo.bar(a, b, c)
	-- body ...
end
```
对于此种形式的函数定义，不能再使用 `local` 修饰符了，因为不存在定义新的局部变量了。  

## 函数参数

支持固定参数和变长参数。固定参数很好理解，变长参数则是使用`...`定义的：
``` lua
function function_name (...)
	local args = {...} or {} 
end
```

注意：在调用函数的时候，如果实参和形参个数不一样的时候：
- 实参缺少，则使用nil代替
- 实参大于形参，则忽略


>LuaJIT 2 尚不能 JIT 编译这种变长参数的用法，只能解释执行。

Lua函数的参数大部分是按值传递的。值传递就是调用函数时，实参把它的值通过赋值运算传递给形参，然后形参的改变和实参就没有关系了。  

当函数参数是 `table` 类型时，传递进来的是实际参数的引用，此时在函数内部对该 table 所做的修改，会直接对调用者所传递的实际参数生效。

## 函数返回值

Lua可以返回多个值，这点和Python、Go类似，不同于C、PHP等语言。返回多个值时，值之间用“,”隔开。

``` lua
local function swap(a, b) 
	return b, a -- 按相反顺序返回变量的值
end
print(swap(1,2))
```
输出：
```
2	1
```

注意：在调用函数的时候，如果返回值的个数和接收返回值的变量的个数不一致时：
- 返回值缺少，则使用nil代替
- 返回值个数大于接收变量的个数，则忽略  

当一个方法返回多个值时，有些返回值有时候用不到，要是声明很多变量来一一接收，显然不太合适 。Lua 提供了一个虚变量(dummy variable)，以单个下划线（“_”） 来命名，用它来丢弃不需要的数值，仅仅起到占位的作用。这点和Go用法一致。
``` lua
local function test_var()
	return 1,2,3
end

local x,_,y = test_var()
print(x,y) -- 1	3
```

## 函数动态调用

函数动态调用是指：调用回调函数，并把一个数组参数作为回调函数的参数。  

主要用到了`unpack`函数和可变参数。  

示例：
``` lua
function do_action(func, ...)
	local args = {...} or {} -- 防止为nil
	func(unpack(args, 1, table.maxn(args))) -- 如果实参中确定没有nil空洞（nil值被夹在非空值之间），可以只写第一个参数 
end

local function add(x, y)
	print(x+y)
end

local function add2(x, y, z)
	print(x+y+z)
end

do_action(add, 1, 1)
do_action(add2, 1, 1, 1)
```

输出：
```
2
3
```

>`unpack` 内建函数还不能为 LuaJIT 所 JIT 编译，因此这种用法总是会被解释执行。

