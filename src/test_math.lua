-- src/test_math.lua
print(math.pi) -- 3.1415926535898
print(math.pow(2,3))  -- 8
print(math.max(-1, 2, 0, 3.6, 9.1))     --  9.1
print(math.floor(3.14159))  -- 3
print(math.ceil(7.9988))    -- 8

-- math.randomseed(os.time())  -- 设置随机种子
print(math.random()) -- 0.79420629243124
print(math.random(10)) -- 7
print(math.random(10,20)) -- 16