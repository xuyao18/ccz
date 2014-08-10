INFO = 0
DEBUG = 1
WARNING = 2
ERROR = 3

logevel = INFO

function log(level, ...) 
	if level >= logevel then
		print(...)
	end
end