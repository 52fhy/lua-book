days = {
	"Monday",
	"Tuesday",
	"Wednesday",
	"Thursday",
	"Friday",
}

for k,v in ipairs(days) do
	print(k,v)
end

local tabFiles = {  
	[1] = "test1",  
	[6] = "test2",  
	[4] = "test3"  
}  

for k,v in pairs(tabFiles) do
	print(k,v)
end