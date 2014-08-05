Script = class()

function Script:ctor()
	self.queue = {}
	self.idx = -1 
	self.content = nil 
end

function Script:readFile(filepath)
	self.content = io.readfile(filepath)
end

function Script:getQueue()
	return self.queue	
end

function Script:getNext()
	self.idx = self.idx + 1 
	return self.queue[idx]
end

function Script:analyse()
	-- implemention to every different script reader.
end

function Script:finish()
	self.idx = -1
end