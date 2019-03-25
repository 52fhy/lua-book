-- read
-- src/file_io_read.lua

local file = io.open("test_file.txt", 'r')
io.input(file) -- 设置默认输入文件
while true do
    line = io.read()
    if line == nil then
        break;
    end
    print(line)
end
io.close(file)