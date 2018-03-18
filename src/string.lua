string1 = "this is string1\n"
string2 = 'this is string2\n'
print(string1)
print(string2)

string3 = [[this is string3\n]] -- 0 级正的长括号
string4 = [=[this is string4\n]=] -- 1 级正的长括号
string5 = [==[this is string5\n]==] -- 2 级正的长括号
string6 = [====[ this is string6\n[===[]===] ]====] -- 4 级正的长括号，可以包含除了本级别的反长括号外的所有内容
print(string3)
print(string4)
print(string5)
print(string6)

string7 = string3..string4
print(string7)

local string8 = "this is string8"
print(#string8)
