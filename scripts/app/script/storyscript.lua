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
        log(INFO,"start name"..name)       
		starter = name
        if name == "Plot" then
            Plot = {}
            index = Plot
            log(INFO, "index -> Plot")
            log(INFO, index)
        
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
        log(INFO, "attr "..name.." value ".. value)       
    	--table.insert(attr, {name, value})
    end, -- attribute found on current element

    closeElement = function(name,nsURI)                
        log(INFO,"close "..name.. " starter " .. starter) 
        if index[starter] then     
            log(INFO, "inserting attr")
        end
        attr = nil 
        if name == "Plot" then
            --plots = {}
            index = nil 
        
        elseif name == "Scene" then
            log(INFO, "scene")
            table.insert(Plot, {"Scene", Scene})
            Scene = nil
            index = Plot
            starter = "Plot"
        
        elseif name == "section" then
            log(INFO,"close section------>"..name.."<-------------")
            table.insert(Scene, {"section", section})
            section = nil
            index = Scene
            starter = "Scene"
        
        elseif name == "sonThings" then
            log(INFO, "sontings")
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
        log(INFO, "length of text "..#text)                    
        log(INFO, text)
        log(INFO, starter)
        log(INFO, "end...")
        if #text == 0 then
            return
        end
        if index then
            log(INFO, index[starter])
            log(INFO, text)
            log(INFO, starter)
            curnode = {}
            curnode['head'] = starter
            curnode['text'] = text
            --table.insert(content, {'text', text})
        end
    end, -- text and CDATA nodes

    comment = function(content)
        log(INFO,"comments"..content)
    end, -- comments
    pi = function(target,content)
        log(INFO,"PI target"..target.." content "..content)
    end, -- processing instructions e.g. "<?yes mon?>"
})

function StoryScript:analyse(content)
	require("app.utils.xml_utils")
	parse(content, storyparser)
	return Plot
end

return StoryScript