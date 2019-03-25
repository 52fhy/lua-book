-- read
-- src/file_read.lua

local file = io.open("test_file.txt", 'r')

file:seek("end", -5) -- 定位到文件倒数第 5 个位置
print(file:read("*a")) -- 从当前位置读取整个文件

file:close()  -- 关闭打开的文件