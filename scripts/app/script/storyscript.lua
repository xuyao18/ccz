require("app.script.script")
slaxml = require("app.utils.SLAXML.slaxml")
StoryScript = class(Script)

local starter = nil
local text = nil 
local attr = nil
local queue = nil 
local scrits = nil

local storyparser = slaxml:parser({
	startElement = function(name,nsURI,nsPrefix)
        print("start name"..name)       
		starter = name
	end, -- When "<foo" or <x:foo is seen

    attribute    = function(name,value,nsURI,nsPrefix)
    	if attr == nil then
    		attr = {}
    	end
        print("attr "..name.." value ".. value)       
    	table.insert(attr, {name, value})
    end, -- attribute found on current element

    closeElement = function(name,nsURI)                
        print("close "..name)       
    	if scrits == nil then 
    		scrits = {}
    	end
    	table.insert(scrits, {starter, attr})
    end, -- When "</foo>" or </x:foo> or "/>" is seen

    text = function(text)                      
        print("text "..text)       
    	if attr == nil then
    		attr = {}
    	end
    	attr.text = text
    end, -- text and CDATA nodes

    comment = function(content)
        print("comments"..content)
    end, -- comments
    pi = function(target,content)
        print("PI target"..target.." content "..content)
    end, -- processing instructions e.g. "<?yes mon?>"
})

function StoryScript:analyse(content)
	require("app.utils.xml_utils")
    dump(storyparser)
	tabs = parse(content, storyparser)
	return tabs
end

return StoryScript