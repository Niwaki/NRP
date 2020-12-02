cl_weps = {}
cl_ships = {}
cl_storage = {}
cl_stweps = {}
cl_ent = {}
cl_stent = {}
cl_test = {}
cl_details = {}
maximum = 0
max2 = 0
net.Receive("int2", function()
	max2 = net.ReadFloat()
end)
net.Receive("lod", function()
	local f = net.ReadString()
	local m = net.ReadFloat()
	print(m)
	if m > 0 then
		cl_test[f] = m
	else
		cl_test[f] = nil
	end
end)
net.Receive("table", function()
	cl_weps = net.ReadTable()
end)
net.Receive("int", function()
	maximum = net.ReadFloat()
end)
net.Receive("perl", function()
	cl_stent = net.ReadTable()
end)
net.Receive("java", function()
	cl_storage = net.ReadTable()
end)
net.Receive("ship", function()
	cl_ships = net.ReadTable()
end)
net.Receive("sumka", function()
	cl_ent = net.ReadTable()
end)
net.Receive("python", function()
	cl_stweps = net.ReadTable()
end)
net.Receive("throwdet", function()
	local f = net.ReadString()
	local m = net.ReadFloat()
	print(m)
	if m > 0 then
		cl_details[f] = m
	else
		cl_details[f] = nil
	end
end)