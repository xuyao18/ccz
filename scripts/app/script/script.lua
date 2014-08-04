Script = class()

function Script:ctor()
	self.queue = {}
	self.idx = 0
	self.content = nil 
end

function Script:readFile(filepath)
	self.content = io.readfile(filepath)
end

function Script:getQueue()
	return self.queue	
end

function Script:getNext()
	return self.queue[idx],self.idx++
end

function Script:analyse()
	-- implemention to every different script reader.
end

function Script:finish()
	self.idx = -1
end