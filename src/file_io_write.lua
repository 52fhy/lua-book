-- write
-- src/file_io_write.lua

local file = io.open("test_file.txt", 'w+')
io.output(file) -- 设置默认输出文件
io.write("hello lua!\nhahah") -- 把内容写到文件
io.close(file)