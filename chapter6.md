# 模块

[TOC]

@date: 2018-3-18

---

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
