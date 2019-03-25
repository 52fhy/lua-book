# 入门

[TOC]

@date: 2018-3-18

---




## 简介

Lua的设计目的是为了嵌入应用程序中，从而为应用程序提供灵活的扩展和定制功能。  

作为一门过程型动态语言，Lua有着如下的特性：

- 变量名没有类型，值才有类型，变量名在运行时可与任何类型的值绑定;
- 语言只提供唯一一种数据结构，称为表(table)，它混合了数组、哈希，可以用任何类型的值作为 key 和 value。提供了一致且富有表达力的表构造语法，使得 Lua 很适合描述复杂的数据;
- 函数是一等类型，支持匿名函数和正则尾递归(proper tail recursion);
- 支持词法定界(lexical scoping)和闭包(closure);
- 提供 thread 类型和结构化的协程(coroutine)机制，在此基础上可方便实现协作式多任务;
- 运行期能编译字符串形式的程序文本并载入虚拟机执行;
- 通过元表(metatable)和元方法(metamethod)提供动态元机制(dynamic metamechanism)，从而允许程序运行时根据需要改变或扩充语法设施的内定语义;
- 能方便地利用表和动态元机制实现基于原型(prototype-based)的面向对象模型;
- 从 5.1 版开始提供了完善的模块机制，从而更好地支持开发大型的应用程序;


Lua应用场景：
- 游戏开发
- 独立应用脚本
- Web 应用脚本
- 扩展和数据库插件如：MySQL Proxy 和 MySQL WorkBench
- 安全系统，如入侵检测系统

## 安装

Lua最新版本是Lua 5.3.4（截止到2018-3-18）。  

官网：http://www.lua.org/

### Linux 系统上安装

Linux & Mac上安装 Lua 安装非常简单，只需要下载源码包并在终端解压编译即可，本文使用了5.3.0版本进行安装：
```
curl -R -O http://www.lua.org/ftp/lua-5.3.0.tar.gz
tar zxf lua-5.3.0.tar.gz
cd lua-5.3.0
make linux test
make install
```

### Mac OS X 系统上安装

```
curl -R -O http://www.lua.org/ftp/lua-5.3.0.tar.gz
tar zxf lua-5.3.0.tar.gz
cd lua-5.3.0
make macosx test
make install
```

Mac 上也可以通过 homebrew 安装:
```
brew install lua
```

### Window 系统上安装 Lua

window下你可以使用一个叫"SciTE"的IDE环境来执行lua程序，下载地址为：
Github 下载地址：https://github.com/rjpcomputing/luaforwindows/releases
Google Code下载地址 : https://code.google.com/p/luaforwindows/downloads/list
双击安装后即可在该环境下编写 Lua 程序并运行。

你也可以使用 Lua 官方推荐的方法使用 LuaDist：http://luadist.org/

安装好后查看版本：
```
$ lua -v
Lua 5.1.4  Copyright (C) 1994-2008 Lua.org, PUC-Rio
```

### Lua 和 LuaJIT 的区别

Lua 非常高效，它运行得比许多其它脚本(如 Perl、Python、Ruby)都快，这点在第三方的独立测评中得到了证实。尽管如此，仍然会有人不满足，他们总觉得还不够快。LuaJIT 就是一个为了再榨出一些速度的尝试，它利用即时编译（Just-in Time）技术把 Lua 代码编译成本地机器码后交由 CPU 直接执行。  

LuaJIT 2 的测评报告表明，在数值运算、循环与函数调用、协程切换、字符串操作等许多方面它的加速效果都很显著。  

凭借着 FFI 特性，LuaJIT 2 在那些需要频繁地调用外部 C/C++ 代码的场景，也要比标准 Lua 解释器快很多。  

目前 LuaJIT 2 已经支持包括 i386、x86_64、ARM、PowerPC 以及 MIPS 等多种不同的体系结构。

LuaJIT 是采用 C 和汇编语言编写的 Lua 解释器与即时编译器。LuaJIT 被设计成全兼容标准的 Lua 5.1 语言，同时可选地支持 Lua 5.2 和 Lua 5.3 中的一些不破坏向后兼容性的有用特性。因此，标准 Lua 语言的代码可以不加修改地运行在 LuaJIT 之上。  

LuaJIT 和标准 Lua 解释器的一大区别是，LuaJIT 的执行速度，即使是其汇编编写的 Lua 解释器，也要比标准 Lua 5.1 解释器快很多，可以说是一个高效的 Lua 实现。另一个区别是，LuaJIT 支持比标准 Lua 5.1 语言更多的基本原语和特性，因此功能上也要更加强大。

LuaJIT 官网链接：http://luajit.org

### OpenResty 与 Lua、LuaJIT

自从 OpenResty 1.5.8.1 版本之后，默认捆绑的 Lua 解释器就被替换成了 LuaJIT，而不再是标准 Lua。也就是，我们安装了OpenResty也会包含Lua解释器。

OpenResty 官网链接：http://openresty.org/cn/

##  基础语法

### Hello World

我们创建一个 HelloWorld.lua 文件，代码如下:

``` lua
print("Hello World!")
```

执行以下命令:
```
$ lua HelloWorld.lua
```
输出结果为：
Hello World!

Lua也提供了交互式编程。打开命令行输入`lua`就会进入交互式编程模式:
```
$ lua
Lua 5.1.4  Copyright (C) 1994-2008 Lua.org, PUC-Rio
> print("Hello World!")
Hello World!
>
```

### 注释

两个减号是单行注释:
``` lua
--
```

多行注释:
``` lua
--[[
 多行注释
 多行注释
 --]]
```
 
### 标示符

Lua标示符以一个字母 A 到 Z 或 a 到 z 或下划线`_`开头后加上0个或多个字母，下划线，数字（0到9）。  
最好不要使用下划线加大写字母的标示符，因为Lua的保留字也是这样的。   
Lua 不允许使用特殊字符如 `@`, `$`, 和 `%` 来定义标示符。 
Lua区分大小写。

### 关键词

以下列出了 Lua 的保留关键字。保留关键字不能作为常量或变量或其他用户自定义标示符：
```
and	break	do	else
elseif	end	false	for
function	if	in	local
nil	not	or	repeat
return	then	true	until
while		
```	
一般约定，以下划线开头连接一串大写字母的名字（比如 `_VERSION` ）被保留用于 Lua 内部全局变量。  
 
 
### 变量定义

变量在使用前，必须在代码中进行声明，即创建该变量。  

Lua是动态类型语言，变量不要类型定义,只需要为变量赋值：

``` lua
name = "yjc"
year = 2018
a = true
score = 98.01
```

变量的默认值均为 `nil`。访问一个没有初始化的全局变量不会出错，只不过返回结果是：nil。当然如果你想删除一个全局变量，只需要将变量赋值为nil即可：
``` lua
score = 98.01
score = nil
```

Lua 变量作用域:
``` lua
a = 10	--全局变量
local b = 10 	--局部变量
```

Lua 中的局部变量要用`local`关键字来显式定义，不使用 local 显式定义的变量就是全局变量。就算在`if`等语句块中，只要没使用`local`关键字来显式定义，也是全局变量，这一点和别的语言不同。  

实际编程中尽量使用局部变量。


## 拓展阅读
1、http://notebook.kulchenko.com/programming/lua-good-different-bad-and-ugly-parts




