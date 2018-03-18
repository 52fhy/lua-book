# 控制语句

[TOC]

@date: 2018-3-18

---

Lua 语言提供的控制结构有 `if-else`，`while`，`repeat`，`for`，并提供 `break`、`return` 关键字来满足更丰富的需求。不支持`switch`、`continue`。 

Lua 提供的控制语句部分特征类似Shell和Python：

- 语句都以`end`结束
- `if`后面都有`then`
- 没有花括号`{}`
- 循环结构`while`、`for`表达式后面都有关键字`do`; python里是用的`:`

##  if-else

单个 if 分支 型:
``` lua
a = 10
if a > 0 then
	print(a)
end
```

两个分支 if-else 型：
``` lua
a = 10
b = 11
if a > b then
	print(a)
else
	print(b)
end
```

多个分支 if-elseif-else 型：
``` lua
a = 10
b = 11
if a > b then
	print(a)
elseif a < b then
	print(b)
else
	print(a)
end
```

与 C 语言的不同之处是 `else` 与 `if` 是连在一起的，若将 `else` 与 `if` 写成 `else if` 则相当于在`else` 里嵌套另一个 `if`语句。


## while

Lua 跟其他常见语言一样，提供了 `while` 控制结构，语法上也没有什么特别的。但是没有提供 `do-while` 型的控制结构，但是提供了功能相当的 `repeat`。 

``` lua
sum = 0
i = 0
while i<=100 do
	sum = sum + i
	i = i + 1;
end
print(sum) -- 5050
```

>注意：Lua 并没有像许多其他语言那样提供类似 `continue` 这样的控制语句用来跳过当前循环。

再看看 `repeat` 的用法：
``` lua
sum = 0
i = 0
repeat
	sum = sum + i
	i = i + 1;
until i>100
print(sum) -- 5050
```

## for

for有两种结构：数字 for（numeric for） 和范型 for（generic for）。

数字 for 类似C语言的用法；范型 for 类似Python里的`for...in`用法。

### for 数字型

数字型 for 的语法如下：
``` lua
for var = begin, finish, step do
	--body
end
```

需要关注以下几点： 

- `var` 从 `begin` 变化到 `finish`，每次变化都以 `step` 作为步长递增 `var`
- `begin`、`finish`、`step` 三个表达式只会在循环开始时执行一次 
- 第三个表达式 `step`是可选的，默认为 `1`
- 控制变量 `var` 的作用域仅在 `for` 循环内，需要在外面控制，则需将值赋给一个新的变量 
- 循环过程中不要改变控制变量的值，那样会带来不可预知的影响

示例：
``` lua
sum = 0
for i=0,100,1 do
	sum = sum + i
end
print(sum) -- 5050
```

### for 泛型

Lua 编程语言中泛型for循环语法格式:
``` lua
-- 打印数组a的所有值  
for i,v in ipairs(a) do 
	print(v) 
end  
```

`i`是数组索引值，`v`是对应索引的数组元素值。`ipairs`是`Lua`提供的一个迭代器函数，用来迭代数组。

示例：
``` lua
days = {
	"Monday",
	"Tuesday",
	"Wednesday",
	"Thursday",
	"Friday",
}

for k,v in ipairs(days) do
	print(k,v)
end
```
输出：
```
1       Monday
2       Tuesday
3       Wednesday
4       Thursday
5       Friday
```

>ipairs以及pairs 的不同:
pairs可以遍历表中所有的key，并且除了迭代器本身以及遍历表本身还可以返回nil; 但是ipairs则不能返回nil，只能返回数字0，如果值遇到nil则直接跳出循环退出。

示例：
``` lua
local tabFiles = {  
	[1] = "test1",  
	[6] = "test2",  
	[4] = "test3"  
}  

for k,v in ipairs(tabFiles) do
	print(k,v)
end
```
输出：
```
1       test1
``` 
`ipairs`遍历时，当key=2时候value就是nil，所以直接跳出循环。    

如果换成`pairs`，则全部输出:
```
1       test1
6       test2
4       test3
```

>值得一提的是，在 LuaJIT 2.1 中， `ipairs()` 内建函数是可以被 `JIT` 编译的，而 `pairs()` 则只能被解释执行。


## break
语句 `break` 用来终止 `while` 、 repeat 和 for 三种循环的执行，并跳出当前循环体， 继续执行当前循环之后的语句。

## return

`return` 主要用于从函数中返回结果，或者用于简单的结束一个函数的执行。  

需要注意的是： return 只能写在语句块的最后，一旦执行了 return 语句，该语句之后的所有语句都不会再执行。  

若要写在函数中间，则只能写在一个显式的语句块内，否则会报错：
``` lua
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
```

所以，有时候为了调试方便，我们可以想在某个函数的中间提前 return ，以进行控制流的短路，此时我们可以将 return 放在一个 `do...end` 代码块中。


