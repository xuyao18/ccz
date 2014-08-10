require("app.script.script")
require("app.utils.log")
slaxml = require("app.utils.SLAXML.slaxml")
StoryScript = class(Script)

local starter = nil
local text = nil 
local attr = nil
local queue = nil 
local Scene = nil 
local section  = nil 
local Plot = nil 
local sonThings = nil 
local index = nil 

local storyparser = slaxml:parser({
	startElement = function(name,nsURI,nsPrefix)
        log(DEBUG,"start name"..name)       
		starter = name
        if name == "Plot" then
            Plot = {}
            index = Plot
            log(DEBUG, "index -> Plot")
            log(DEBUG, index)
        end
        if name == "Scene" then
            Scene = {}
            index = Scene
        end
        if name == "section" then
            section = {}
            index = section 
        end
        if name == "sonThings" then
            sonThings = {}
            index = sonThings 
        end
        if not index then
            log(ERROR, "Index is nil??")
            log(ERROR, Plot)
            log(ERROR, Scene)
            log(ERROR, section)
            log(ERROR, index)
        end
        index[starter] = {}
	end, -- When "<foo" or <x:foo is seen

    attribute    = function(name,value,nsURI,nsPrefix)
    	if attr == nil then
    		attr = {}
    	end
        log(DEBUG, "attr "..name.." value ".. value)       
    	table.insert(attr, {name, value})
    end, -- attribute found on current element

    closeElement = function(name,nsURI)                
        log(DEBUG,"close "..name.. " starter " .. starter) 
        if index[starter] then     
            --dump(index)
            --dump(index[starter]) 
            index[starter]['attr'] = attr
            --table.insert(index[starter], {'attr', attr})
        end
        attr = nil 
        if name == "Plot" then
            --plots = {}
            index = nil 
        end
        if name == "Scene" then
            table.insert(Plot, {"Scene", Scene})
            Scene = {}
            index = Plot
            starter = "Plot"
        end
        if name == "section" then
            log(DEBUG,"close section------>"..name.."<-------------")
            table.insert(Scene, {"section", section})
            section = {}
            index = Scene
            starter = "Scene"
        end
        if name == "sonThings" then
            table.insert(section, {"sonThings", sonThings})
            sonThings = {}
            index = section
            starter = "section"
        end
    end, -- When "</foo>" or </x:foo> or "/>" is seen

    text = function(text)  
        text = text:gsub("^%s*(.-)%s*$", "%1")
        log(DEBUG, "length of text "..#text)                    
        log(DEBUG, text)
        log(DEBUG, starter)
        log(DEBUG, "end...")
        if #text == 0 then
            return
        end
        if index then
            log(DEBUG, index[starter])
            log(DEBUG, text)
            log(DEBUG, starter)
            table.insert(index[starter], {'text', text})
            --log(DEBUG,"index  --->"..index)
        end
    end, -- text and CDATA nodes

    comment = function(content)
        log(DEBUG,"comments"..content)
    end, -- comments
    pi = function(target,content)
        log(DEBUG,"PI target"..target.." content "..content)
    end, -- processing instructions e.g. "<?yes mon?>"
})

function StoryScript:analyse(content)
	require("app.utils.xml_utils")
	parse(content, storyparser)
	return Plot
end

return StoryScript