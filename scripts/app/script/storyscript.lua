require("script")
slaxml = require("app.utils.SLAXML")
StoryScript = class(Script)

local starter = nil
local text = nil 
local attr = nil
local queue = nil 
local scrits = nil
local storyparser = slaxml:parser{
	startElement = function(name,nsURI,nsPrefix)       
		starter = name
	end, -- When "<foo" or <x:foo is seen

    attribute    = function(name,value,nsURI,nsPrefix)
    	if attr == nil then
    		attr = {}
    	end
    	table.insert(attr, {name, value})
    end, -- attribute found on current element

    closeElement = function(name,nsURI)                
    	if scrits == nil then 
    		scrits = {}
    	end
    	table.insert(scrits, {starter, attr)
    end, -- When "</foo>" or </x:foo> or "/>" is seen

    text         = function(text)                      
    	if attr == nil then
    		attr = {}
    	end
    	attr.text = text
    end, -- text and CDATA nodes

    comment      = function(content)                   end, -- comments
    pi           = function(target,content)            end, -- processing instructions e.g. "<?yes mon?>"
}

function StoryScript:analyse()
	xml = require("app.utils.xml_utils")
	tabs = xml.parse(self.content, self.storyparser)
	return tabs
end
