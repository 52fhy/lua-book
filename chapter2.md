# 数据类型

[TOC]

@date: 2018-3-18

---

Lua中有8个基本类型分别为：nil、boolean、number、string、table、function、userdata、thread。  

函数 `type` 能够返回一个值或一个变量所属的类型：
``` lua
print(type("hello world")) -->output:string
print(type(print)) -->output:function
print(type(true)) -->output:boolean
print(type(360.0)) -->output:number
print(type(nil)) -->output:nil
```

## nil

只有值`nil`属于该类，表示一个无效值（在条件表达式中相当于false）。一个变量在第一次赋值前的默认值是 `nil`，将
nil 赋予给一个全局变量就等同于删除它。

``` lua
local num
print(num) -->output:nil

num = 100
print(num) -->output:100
```

## boolean

boolean 类型只有两个可选值：`true`和`false`，Lua 把 `false` 和 `nil` 看作是"假"，其他的都为"真"，比如 0 和空字符串就是"真"，这和C、PHP等语言不一样。

``` lua
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
```
输出：
```
a
b
not c
```

## number

Lua 默认只有一种 number 类型: double（双精度）类型，以下几种写法都被看作是 `number` 类型：
``` lua
print(type(2))
print(type(2.2))
print(type(0.2))
print(type(2e+1))
print(type(0.2e-1))
print(type(7.8263692594256e-06))
```

## string

字符串由一对双引号或单引号来表示:
```
string1 = "this is string1\n"
string2 = 'this is string2\n'
print(string1)
print(string2)
```
输出：
```
this is string1

this is string2

```
可以看出单引号里面转义字符也生效。说明Lua不区分单引号、双引号。    

也可以用 2 个方括号 "[[]]" 来表示"一块"字符串。我们把两个正的方括号（即`[[`）间插入 n 个等号定义为第 n 级正长括号:
``` lua
string3 = [[this is string3\n]] -- 0 级正的长括号
string4 = [=[this is string4\n]=] -- 1 级正的长括号
string5 = [==[this is string5\n]==] -- 2 级正的长括号
string6 = [====[ this is string6\n[===[]===] ]====] -- 4 级正的长括号，可以包含除了本级别的反长括号外的所有内容
print(string3)
print(string4)
print(string5)
print(string6)
```
输出：
```
this is string3\n
this is string4\n
this is string5\n
 this is string6\n[===[]===]
```
注意：由方括号包含的字符串，整个词法分析过程将不受分行限制，不处理任何转义符，并且忽略掉任何不同级别的长括号。    

另外，需要注意的就是：Lua的字符串是不可改变的值，不能像在 c 语言中那样直接修改字符串的某个字符，而是根据修改要求来创建一个新的字符串。Lua 也不能通过下标来访问字符串的某个字符。  

字符串使用`..`拼接：
``` lua
string7 = string3..string4
print(string7)
```  
输出：
```
this is string3\nthis is string4\n
```

在对一个数字字符串上进行算术操作时，Lua 会尝试将这个数字字符串转成一个数字:
``` bash
> print("2" + 6)
8.0
```

使用 `#` 来计算字符串的长度，放在字符串前面，如下实例：
``` lua
local string8 = "this is string8"
print(#string8) -- 输出：15
```

## table

Table 类型实现了一种抽象的“关联数组”。“关联数组”是一种具有特殊索引方式的数组，索引通常是`string`或者`number`类型，但也可以是除 `nil` 以外的任意类型的值。  

PHP程序员对此会很熟悉，因为PHP里的数组(`array`)和Table非常类似。示例：

``` lua
local tmp = {
	name = "lua",
	-- "name2" = "lua2", -- 错误的表示
	["name3"] = "lua",
	year = 2018,
	pi = 3.14159,
	lang = {"c", "java", "lua"},
	100,  -- 相当于[1] = 100，此时索引为数字。lua里数字索引是从1开始的，不是0
	-- 10 = 11, -- 错误的表示
	[10] = 11, -- 相当于[10] = 11，此时索引为数字
}

print(tmp.name)
print(tmp["name3"])
print(tmp.year)
print(tmp.pi)
print(tmp.lang[1])
print(tmp[1])
print(tmp[10])
```
输出：
```
lua
lua
2018
3.14159
c
100
11
```

在 Lua 里表的默认初始索引一般以 1 开始，而不是0，这点需要注意。   

也可以先创建一个空表，再添加数据：
``` lua
a = {}
a["key"] = "value"
```


在内部实现上，table 通常实现为一个哈希表、一个数组、或者两者的混合。具体的实现为何种形式，动态依赖于具体的 table 的键分布特点。


## function

在 Lua 中，`函数` 也是一种数据类型，函数可以存储在变量中，可以通过参数传递给其他函数，还可以作为其他函数的返回值。

``` lua
function maxNumber(a, b)
	if a > b then
		return a
	else
		return b
	end
end

local testFunc = maxNumber

print(testFunc(10,100));
```
输出：  
```
100  
```

有名函数的定义本质上是匿名函数对变量的赋值：

``` lua
function foo()
end
```

等价于：

``` lua
foo = function ()
end
```

## userdata

userdata 是一种用户自定义数据，用于表示一种由应用程序或 C/C++ 语言库所创建的类型，可以将任意 C/C++ 的任意数据类型的数据（通常是 struct 和 指针）存储到 Lua 变量中调用。


## thread

在 Lua 里，最主要的线程是协同程序（coroutine）。它跟线程（thread）差不多，拥有自己独立的栈、局部变量和指令指针，可以跟其他协同程序共享全局变量和其他大部分东西。
线程跟协程的区别：线程可以同时多个运行，而协程任意时刻只能运行一个，并且处于运行状态的协程只有被挂起（suspend）时才会暂停。

