# 元表

[TOC]

@date: 2018-3-18

---

在Lua5.1语言中，元表 (metatable) 的表现行为类似于 C++ 语言中的操作符重载，类似PHP的魔术方法。Python里也有`元类(metaclass)`一说。  

通过元表，Lua有了更多的扩展特性。Lua的面向对象特性就是基于元表实现的。      

Lua 提供了两个十分重要的用来处理元表的方法，如下：

- `setmetatable(table, metatable)`：此方法用于为一个表设置元表。
- `getmetatable(table)`：此方法用于获取表的元表对象。


设置元表的方法很简单，如下：
``` lua
local mytable = {}
local mymetatable = {}
setmetatable(mytable, mymetatable)
```
上面的代码可以简写成如下的一行代码：
``` lua
local mytable = setmetatable({}, {})
```


例如我们可以重载 `__add` 元方法 (metamethod)，实现重载`+`操作符，来计算两个 Lua 数组的并集：
``` lua
-- 计算集合的并集实例
set1 = {10,40}
set2 = {10,20,30}

setmetatable(set1, {
	__add = function(self, another)
		local res = {}
		local set = {}
		
		for k,v in pairs(self) do set[v] = true end -- 防止集合元素重复
		for k,v in pairs(another) do set[v] = true end -- 防止集合元素重复
		
		for k,v in pairs(set) do table.insert(res, k) end
		
		return res
	end
})

local set3 = set1 + set2
for k,v in pairs(set3) do print(v) end 
```
输出：
```
30
20
10
40
```

类似的元方法还有：

- `__add` `+`操作
- `__sub` `-`操作 其行为类似于 `add` 操作
- `__mul` `*`操作 其行为类似于 `add` 操作
- `__div` `/`操作 其行为类似于 `add` 操作
- `__mod` `%`操作 其行为类似于 `add` 操作
- `__pow` `^`（幂）操作 其行为类似于 `add` 操作
- `__unm` 一元 `-` 操作
- `__concat` `..`（字符串连接） 操作
- `__len` `#`操作
- `__eq` `==`操作 函数 getcomphandler 定义了 Lua 怎样选择一个处理器来作比较操作，仅在两个对象类型相同且有对应操作相同的元方法时才起效
- `__lt` `<`操作
- `__le` `<=`操作

- `__index` 取下标操作用于访问 `table[key]`
- `__newindex` 赋值给指定下标 `table[key] = value`
- `__tostring` 转换成字符串
- `__call` 当 Lua 调用一个值时调用
- `__mode` 用于弱表(week table)
- `__metatable` 用于保护`metatable`不被访问

## __index 元方法

该方法实现了在表中查找键不存在时转而在元表中查找该键的功能。有两种写法：  

第一种是给 `__index` 元方法一个函数：
``` lua
local mytable = setmetatable({}, {
	__index = function(self, key)
		return "__index"
	end
})
print(mytable.key1) -- __index 
```

另一种方法是给 `__index` 元方法一个表：
``` lua
local _M = {
	add = function(x,y) return x+y end,
	mul = function(x,y) return x*y end,
	ver = "1.0",
}
local mytable = setmetatable({}, {
	__index = _M
})
print(mytable.ver) -- 1.0 
print(mytable.add(1,3)) -- 4 
```

Lua查找一个表元素时的规则，其实就是如下3个步骤:

1. 在表中查找，如果找到，返回该元素，找不到则继续
2. 判断该表是否有元表，如果没有元表，返回`nil`，有元表则继续。
3. 判断元表有没有`__index`方法，如果`__index`方法为`nil`，则返回`nil`；如果`__index`方法是一个表，则重复1、2、3；如果`__index`方法是一个函数，则返回该函数的返回值。  


通过`__index`这个方法，我们可以实现继承的特性。下节再详细讲述。

## __newindex 元方法

如果说`__index`具有PHP里`__get`的一些特性，那么`__newindex`则类似`__set`。  

以下实例使用了 rawset 函数来更新表：
``` lua
mytable = setmetatable({key1 = "value1"}, {
  __newindex = function(self, key, value)
        rawset(self, key, "\""..value.."\"")

  end
})

mytable.key1 = "new value"
mytable.key2 = 4

print(mytable.key1,mytable.key2)
```

以上实例执行输出结果为：
```
new value    "4"
```

## __tostring 元方法

如果设置了__tostring 元方法，当直接输出表时会自动调用该方法。示例：

``` lua
local mytable = setmetatable({ 10, 20, 30 }, {
  __tostring = function(mytable)
    sum = 0
    for k, v in pairs(mytable) do
        sum = sum + v
    end
    return sum
  end
})
print(mytable) -- 60
```

## __call 元方法

__call 元方法的功能类似于 C++ 中的仿函数，使得普通的表也可以被调用。

``` lua
local mytable = setmetatable({}, {
  __call = function(self, arg)
	local sum = 0
	for _,v in pairs(arg) do
		sum = sum + v
	end
    print(sum)
  end
})
mytable({10,20,30}) -- 60
```
示例里我们调用自定义的表，并给该表传了参数，最终算出了参数的和。

## __metatable 元方法

如果给表设置了 __metatable 元方法的值，getmetatable 将返回这个域的值，而调用 setmetatable将会被禁止，会直接报错。

``` lua
local mytable = setmetatable({}, {
  __metatable = "no access"
})
print(getmetatable(mytable)) -- no access
setmetatable(mytable, {}) -- 引发编译器报错
```


