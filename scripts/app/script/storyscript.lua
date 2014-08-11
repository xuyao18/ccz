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
local curnode = nil
local content = nil 

local storyparser = slaxml:parser({
	startElement = function(name,nsURI,nsPrefix)
        log(DEBUG,"start name"..name)       
		starter = name
        if name == "Plot" then
            Plot = {}
            index = Plot
            log(DEBUG, "index -> Plot")
            log(DEBUG, index)
        
        elseif name == "Scene" then
            Scene = {}
            index = Scene
        elseif name == "section" then
            section = {}
            index = section 
        elseif name == "sonThings" then
            sonThings = {}
            index = sonThings 
        else 
            --content = {}
            --curnode = {starter, content}
        end
	end, -- When "<foo" or <x:foo is seen

    attribute    = function(name,value,nsURI,nsPrefix)
    	if attr == nil then
    		attr = {}
    	end
        log(DEBUG, "attr "..name.." value ".. value)       
    	--table.insert(attr, {name, value})
    end, -- attribute found on current element

    closeElement = function(name,nsURI)                
        log(DEBUG,"close "..name.. " starter " .. starter) 
        if index[starter] then     
            log(DEBUG, "inserting attr")
        end
        attr = nil 
        if name == "Plot" then
            --plots = {}
            index = nil 
        
        elseif name == "Scene" then
            log(DEBUG, "scene")
            table.insert(Plot, {"Scene", Scene})
            Scene = nil
            index = Plot
            starter = "Plot"
        
        elseif name == "section" then
            log(DEBUG,"close section------>"..name.."<-------------")
            table.insert(Scene, {"section", section})
            section = nil
            index = Scene
            starter = "Scene"
        
        elseif name == "sonThings" then
            log(DEBUG, "sontings")
            table.insert(section, {"sonThings", sonThings})
            sonThings = nil
            index = section
            starter = "section"
        else
            table.insert(index , curnode)
            curnode = {}
        end
        --todo
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
            curnode = {}
            curnode['head'] = starter
            curnode['text'] = text
            --table.insert(content, {'text', text})
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