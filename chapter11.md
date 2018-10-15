
@date: 2018-10-15

---

版本：自2.6.0起可用。
时间复杂度：取决于执行的脚本。

使用Lua脚本的好处：

- 减少网络开销。可以将多个请求通过脚本的形式一次发送，减少网络时延。
- 原子操作。redis会将整个脚本作为一个整体执行，中间不会被其他命令插入。因此在编写脚本的过程中无需担心会出现竞态条件，无需使用事务。
- 复用。客户端发送的脚本会永久存在redis中，这样，其他客户端可以复用这一脚本而不需要使用代码完成相同的逻辑。

## 如何使用

### 基本使用

命令格式：
``` bash
EVAL script numkeys key [key ...] arg [arg ...]
```

说明：

- `script`是第一个参数，为Lua 5.1脚本。该脚本不需要定义Lua函数（也不应该）。
- 第二个参数`numkeys`指定后续参数有几个key。
- `key [key ...]`，是要操作的键，可以指定多个，在lua脚本中通过`KEYS[1]`, `KEYS[2]`获取
- `arg [arg ...]`，参数，在lua脚本中通过`ARGV[1]`, `ARGV[2]`获取。

简单实例：
``` bash
127.0.0.1:6379> eval "return ARGV[1]" 0 100 
"100"
127.0.0.1:6379> eval "return {ARGV[1],ARGV[2]}" 0 100 101
1) "100"
2) "101"
127.0.0.1:6379> eval "return {KEYS[1],KEYS[2],ARGV[1],ARGV[2]}" 2 key1 key2 first second
1) "key1"
2) "key2"
3) "first"
4) "second"

127.0.0.1:6379> eval "redis.call('SET', KEYS[1], ARGV[1]);redis.call('EXPIRE', KEYS[1], ARGV[2]); return 1;" 1 test 10 60
(integer) 1
127.0.0.1:6379> ttl test
(integer) 59
127.0.0.1:6379> get test
"10"
```

注：

- `{}`在lua里是指数据类型`table`，类似数组。
- `redis.call()`可以调用redis命令。

### 命令行里使用

如果直接使用`redis-cli`命令，格式会有点不一样：
``` bash
redis-cli --eval lua_file key1 key2 , arg1 arg2 arg3
```

注意的地方：

- eval 后面参数是lua脚本文件,`.lua`后缀
- 不用写`numkeys`，而是使用`,`隔开。注意`,`前后有空格。

示例：

incrbymul.lua
``` lua
local num = redis.call('GET', KEYS[1]);  

if not num then
	return 0;
else
	local res = num * ARGV[1]; 
	redis.call('SET',KEYS[1], res); 
	return res;
end
```

命令行运行：
``` bash
$ redis-cli --eval incrbymul.lua lua:incrbymul , 8
(integer) 0
$ redis-cli incr lua:incrbymul 
(integer) 1
$ redis-cli --eval incrbymul.lua lua:incrbymul , 8
(integer) 8
$ redis-cli --eval incrbymul.lua lua:incrbymul , 8
(integer) 64
$ redis-cli --eval incrbymul.lua lua:incrbymul , 2
(integer) 128
```

由于redis没有提供命令可以实现将一个数原子性的乘以N倍，这里我们就用Lua脚本实现了，运行过程中确保不会被其它客户端打断。

### phpredis里使用

接着上面的例子：  

incrbymul.php
``` php
<?php 

$lua = <<<EOF
local num = redis.call('GET', KEYS[1]);  

if not num then
	return 0;
else
	local res = num * ARGV[1]; 
	redis.call('SET',KEYS[1], res); 
	return res;
end

EOF;

$redis = new Redis();
$redis->connect('127.0.0.1', 6379);
$ret = $redis->eval($lua, array("lua:incrbymul", 2), 1);
echo $ret;
```

运行：
``` bash
$ redis-cli set lua:incrbymul 0
OK
$ redis-cli incr lua:incrbymul
(integer) 1
$ php incrbymul.php 
2
$ php incrbymul.php 
4
```

eval原型：
``` c
Redis::eval(string script, [array keys, long num_keys])
```
eval函数的第3个参数为KEYS个数，phpredis依据此值将KEYS和ARGV做区分。


## 参考

1、在redis中使用lua脚本让你的灵活性提高5个逼格 - 一线码农 - 博客园  
https://www.cnblogs.com/huangxincheng/p/6230129.html  
2、Redis执行Lua脚本示例 - yanghuahui - 博客园  
https://www.cnblogs.com/yanghuahui/p/3697996.html  
3、EVAL - Redis  
https://redis.io/commands/eval  
4、phpredis 执行LUA脚本的例子 - jingtan的专栏 - CSDN博客  
https://blog.csdn.net/jingtan/article/details/53392309  


