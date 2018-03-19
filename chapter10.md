# 面向对象编程

[TOC]

@date: 2018-3-19

---

在Lua 中，我们可以使用表和函数实现面向对象。将函数和相关的数据放置于同一个表中就形成了一个对象。  

示例：

``` lua
-- module/cache.lua

local _M = {}

_M.mt = {}

_M.set = function(self, key ,value)
	self.mt[key] = value
end

_M.get = function(self, key)
	return self.mt[key]
end

_M.getall = function(self)
	return self.mt
end

_M.new = function(self)
	return setmetatable({}, {__index = _M })
end

return _M
```

调用：
``` lua
local cache = require "module/cache"
local c = cache:new()
c:set("name", "lua")
c:set("year", 2018)
print(c:get("name"))
print(c:get("year"))

for k,v in pairs(c:getall()) do
	print(k,v)
end
```
输出：
```
lua
2018
name    lua
year    2018
```

`setmetatable` 将 `_M` 作为新建表的原型，所以在自己的表内找不到所调用方法和变量的时候，便会到 `__index` 所指定的 `_M` 类型中去寻找。

## 继承

`__index`元方法实现了在父类中查找存在的方法和变量的机制。借助这个，可以实现继承。  

还是利用上面的例子：
``` lua
 -- module/mycache
local cache = require "module/cache"

local _M = {}

_M.del = function(self, key)
	_M.mt[key] = nil
end

_M.new = function(self)
	return setmetatable(_M, {__index = cache }) --该方法需要覆写父类的，确保此处的setmetatable先执行
end

return _M
```
此处实现了删除操作。调用：
``` lua
local cache = require "module/mycache"
local c = cache:new()
c:set("name", "lua")
c:del("name")
print(c:get("name"))
```
输出：
```
nil
```



