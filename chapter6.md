# 模块

[TOC]

@date: 2018-3-18

---

## 模块

从Lua5.1开始，Lua添加了对模块和包的支持。  

Lua 的模块是由变量、函数等已知元素组成的 table，因此创建一个模块很简单，就是创建一个table，然后把需要导出的常量、函数放入其中，最后返回这个 table 就行。   

示例：  

mymodule.lua

``` lua
local _M = {}

_M.VERSION = "1.0"

_M.getName = function()
	return "get"
end

return _M
```

使用`require`即可引入模块：
``` lua
local m = require "mymodule"
print(m.VERSION)
print(m.getName())
```

输出：
```
1.0
get
```

## 点号与冒号操作符的区别

看下面示例代码：
``` lua
local str = "abcde"
print("case 1:", str:sub(1, 2))
print("case 2:", str.sub(str, 1, 2))
```
输出：
```
case 1: ab
case 2: ab
```

冒号操作会带入一个 `self` 参数，用来代表 `自己` 。而点号操作，只是内容的展开，需要手动传入`self` 参数。  

在函数定义时，使用冒号将默认接收一个 `self` 参数，而使用点号则需要显式传入 `self` 参数。  

示例：
``` lua
mytable = {}
mytable.func1 = function(self, name)
	self.name = name
end

mytable:func2 = function(name)
	self.name = name
end
```
这里的`func1`和`func2`是等价的。

