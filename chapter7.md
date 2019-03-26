# 常用库介绍

[TOC]

@date: 2019-3-25 23:03:27

---

## String 库

- `..` 链接两个字符串
- `string.upper(argument)` 字符串全部转为大写字母。
- `string.lower(argument)` 字符串全部转为小写字母。
- `string.len(arg)` 计算字符串长度
- `string.reverse(arg)` 字符串反转
- `string.format(...)` 返回一个类似printf的格式化字符串
- `string.byte(s [, i [, j ]])` 转换字符为整数值(可以指定某个字符，默认第一个字符)
- `string.char(arg)` 将整型数字转成字符并连接
- `string.rep(string, n)` 返回字符串string的n个拷贝
- `string.gsub(mainString, findString, replaceString, num)`
在字符串中替换,mainString为要替换的字符串， findString 为被替换的字符，replaceString 要替换的字符，num 替换次数（可以忽略，则全部替换）
- `string.find (str, substr, [init, [end]])`
在一个指定的目标字符串中搜索指定的内容(第三个参数为索引),返回其具体位置。不存在则返回 nil。
- `string.gmatch(str, pattern)`
返回一个迭代器函数，每一次调用这个函数，返回一个在字符串 str 找到的下一个符合 pattern 描述的子串。如果参数 pattern 描述的字符串没有找到，迭代函数返回nil。
- `string.match(str, pattern, init)` 
寻找源字串str中的第一个配对. 参数init可选, 指定搜寻过程的起点, 默认为1。 在成功配对时, 函数将返回配对表达式中的所有捕获结果; 如果没有设置捕获标记, 则返回整个配对字符串. 当没有成功的配对时, 返回nil。


> 注：`string.match()`、`string.gmatch()` 目前并不能被 JIT 编译，OpenResty 里应尽量使用 `ngx_lua` 模块提供的 `ngx.re.match` 等API。

## Table 库

- `table.concat (table [, sep [, start [, end]]])`
concat是concatenate(连锁, 连接)的缩写. table.concat()函数列出参数中指定table的数组部分从start位置到end位置的所有元素, 元素间以指定的分隔符(sep)隔开。
- `table.insert (table, [pos,] value)`
在table的数组部分指定位置(pos)插入值为value的一个元素. pos参数可选, 默认为数组部分末尾.
- `table.maxn (table)`
指定table中所有正数key值中最大的key值. 如果不存在key值为正数的元素, 则返回0。(**Lua5.2之后该方法已经不存在了,本文使用了自定义函数实现**)
- `table.remove (table [, pos])`
返回table数组部分位于pos位置的元素. 其后的元素会被前移. pos参数可选, 默认为table长度, 即从最后一个元素删起。
- `table.sort (table [, comp])`
对给定的table进行升序排序。

## 日期时间库

- `os.time ([table])` 如果不使用参数 table 调用 time 函数，它会返回当前的时间和日期（它表示从某一时刻到现在的秒数）。如果用 table 参数，它会返回一个数字，表示该 table 中 所描述的日期和时间（它表示从某一时刻到 table 中描述日期和时间的秒数）。
- `os.difftime (t2, t1)` 返回 t1 到 t2 的时间差，单位为秒。
- `os.date ([format [, time]])` 把一个表示日期和时间的数值，转换成更高级的表现形式。其第一个参数 format 是一个格式化字符串，描述了要返回的时间形式。第二个参数 time 就是日期和时间的数字表示，缺省时默认为当前的时间。

> 如果使用OpenResty，不建议使用Lua的标准时间函数，因为这些函数通常会引发不止一个昂贵的系统调用，同时无法为 LuaJIT JIT 编译，对性能造成较大影响。推荐使用 ngx_lua 模块提供的带缓存的时间接口，如 `ngx.today`, `ngx.time`, `ngx.utctime`, `ngx.localtime`, `ngx.now`, `ngx.http_time`，以及 `ngx.cookie_time` 等。

## 数学库

常用数学函数：  

- `math.rad(x)`  角度x转换成弧度
- `math.deg(x)`  弧度x转换成角度
- `math.max(x, ...)`  返回参数中值最大的那个数，参数必须是number型
- `math.min(x, ...)`  返回参数中值最小的那个数，参数必须是number型
- `math.random ([m [, n]])`  不传入参数时，返回 一个在区间[0,1)内均匀分布的伪随机实数；只使用一个整数参数m时，返回一个在区间[1, m]内均匀分布的伪随机整数；使用两个整数参数时，返回一个在区间[m, n]内均匀分布的伪随机整数
- `math.randomseed (x)`  为伪随机数生成器设置一个种子x，相同的种子将会生成相同的数字序列
- `math.abs(x)`  返回x的绝对值
- `math.fmod(x, y)`  返回 x对y取余数
- `math.pow(x, y)`  返回x的y次方
- `math.sqrt(x)`  返回x的算术平方根
- `math.exp(x)`  返回自然数e的x次方
- `math.log(x)`  返回x的自然对数
- `math.log10(x)`  返回以10为底，x的对数
- `math.floor(x)`  返回最大且不大于x的整数
- `math.ceil(x)`  返回最小且不小于x的整数
- `math.pi`	圆周率
- `math.sin(x)`  求弧度x的正弦值
- `math.cos(x)`  求弧度x的余弦值
- `math.tan(x)`  求弧度x的正切值
- `math.asin(x)`  求x的反正弦值
- `math.acos(x)`  求x的反余弦值
- `math.atan(x)`  求x的反正切值


示例：
``` lua
-- src/test_math.lua
print(math.pi) -- 3.1415926535898
print(math.pow(2,3))  -- 8
print(math.max(-1, 2, 0, 3.6, 9.1))     --  9.1
print(math.floor(3.14159))  -- 3
print(math.ceil(7.9988))    -- 8
```

注意：使用 `math.random()` 函数获得伪随机数时，如果不使用 `math.randomseed()` 设置伪随机数生成种子或者设置相同的伪随机数生成种子，那么得得到的伪随机数序列是一样的。示例：
``` lua
-- math.randomseed(os.time())  -- 设置随机种子
print(math.random()) -- 0.79420629243124
print(math.random(10)) -- 7
print(math.random(10,20)) -- 16
```
上面的例子里同一机器运行多次的结果是一样的，只有设置了随机的伪随机数生成种子，才能保证每次生成的随机数是不相同的。

## 参考
1、OpenResty最佳实践   
https://moonbingbing.gitbooks.io/openresty-best-practices/  
2、Lua 5.3 参考手册 - 目录  
http://www.runoob.com/manual/lua53doc/contents.html  
3、Lua 字符串 | 菜鸟教程  
http://www.runoob.com/lua/lua-strings.html  
