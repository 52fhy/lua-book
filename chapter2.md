# 数据类型

[TOC]

---

Lua中有8个基本类型分别为：nil、boolean、number、string、table、function、userdata、thread。  

函数 type 能够返回一个值或一个变量所属的类型：
``` lua
print(type("hello world")) -->output:string
print(type(print)) -->output:function
print(type(true)) -->output:boolean
print(type(360.0)) -->output:number
print(type(nil)) -->output:nil
```

## nil

只有值nil属于该类，表示一个无效值（在条件表达式中相当于false）。一个变量在第一次赋值前的默认值是 nil，将
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

也可以用 2 个方括号 "[[]]" 来表示"一块"字符串:
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
print(#string8)
```

## table

## function

## userdata

## thread