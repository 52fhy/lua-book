# 文件操作

[TOC]

@date: 2019-3-25 23:03:34

---

Lua I/O 库用于读取和处理文件。分为简单模式（和C一样）、完全模式。

- 简单模式（simple model）
拥有一个当前输入文件和一个当前输出文件，并且提供针对这些文件相关的操作。
- 完全模式（complete model） 
使用外部的文件句柄来实现。它以一种面对对象的形式，将所有的文件操作定义为文件句柄的方法。

对文件进行简单的读写操作时可以使用简单模式，但是对文件进行一些高级的操作简单模式则处理不了了。

## 简单模式

简单模式由`io`模块提供，主要有：

- `io.open(filename [, mode])`: 以mode模式打开一个文件
- `io.input(file)`: 设置默认输入文件为file
- `io.output(file)`: 设置默认输出文件为file
- `io.write(content)`: 在文件最后一行添加content内容
- `io.read()`:  读取文件的一行。  
参数可以是下表中的一个：
``` lua
"*n"	读取一个数字并返回它。例：file.read("*n")
"*a"	从当前位置读取整个文件。例：file.read("*a")
"*l"（默认）	读取下一行，在文件尾 (EOF) 处返回 nil。例：file.read("*l")
number	返回一个指定字符个数的字符串，或在 EOF 时返回 nil。例：file.read(5)
```
- `io.close(file)`: 关闭打开的文件file
- `io.tmpfile()`: 返回一个临时文件句柄，该文件以更新模式打开，程序结束时自动删除
- `io.type(file)`: 检测obj是否一个可用的文件句柄
- `io.flush()`: 向文件写入缓冲中的所有数据
- `io.lines(optional file name)`: 返回一个迭代函数,每次调用将获得文件中的一行内容,当到文件尾时，将返回nil,但不关闭文件

mode模式：

|模式|	描述|
| ------ | ------ |
|r|	以只读方式打开文件，该文件必须存在。|
|w|	打开只写文件，若文件存在则文件长度清为0，即该文件内容会消失。若文件不存在则建立该文件。
|a|	以附加的方式打开只写文件。若文件不存在，则会建立该文件，如果文件存在，写入的数据会被加到文件尾，即文件原先的内容会被保留。（EOF符保留）|
|r+| 以可读写方式打开文件，该文件必须存在。|
|w+| 打开可读写文件，若文件存在则文件长度清为零，即该文件内容会消失。若文件不存在则建立该文件。|
|a+| 与a类似，但此文件可读可写|
|b|	二进制模式，如果文件是二进制文件，可以加上|
|b+| 二进制模式，表示对文件既可以读也可以写|

示例：
``` lua
-- write
-- src/file_io_write.lua

local file = io.open("test_file.txt", 'w+')
io.output(file) -- 设置默认输出文件
io.write("hello lua!\nhahah") -- 把内容写到文件
io.close(file)
```
运行后查看生成的文件：
``` bash
$ cat test_file.txt
hello lua!
nhahah
```

``` lua
-- read
-- src/file_io_read.lua

local file = io.open("test_file.txt", 'r')
io.input(file) -- 设置默认输入文件

-- while true do
--     line = io.read()
--     if line == nil then
--         break;
--     end
--     print(line)
-- end

for line in io.lines() do 
    print(line)
end
io.close(file)
```

运行：
``` bash
$ luajit file_io_read.lua
hello lua!
hahah
```

## 完全模式

简单模式由`file`模块提供，主要有：

- `file:write(content)`: 在文件最后一行添加content内容
- `file:read()`:  读取文件的一行
- `file:close()`: 关闭打开的文件
- `file:seek(optional where, optional offset)`: 设置和获取当前文件位置,成功则返回最终的文件位置(按字节),失败则返回nil加错误信息。  

参数 where 值可以是:
``` lua
"set": 从文件头开始
"cur": 从当前位置开始[默认]
"end": 从文件尾开始
offset:默认为0
```
- `file:flush()`: 向文件写入缓冲中的所有数据

示例：
``` lua
-- read
-- src/file_read.lua

local file = io.open("test_file.txt", 'r')

file:seek("end", -5) -- 定位到文件倒数第 5 个位置
print(file:read("*a")) -- 从当前位置读取整个文件

file:close()  -- 关闭打开的文件
```
输出：
```
$ luajit src/file_read.lua
hahah
```