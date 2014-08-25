
local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)
local RichLabel = require("app.scenes.RichLabel")


function MainScene:ctor()
     local str = "[background=dlg_bg.png] [/background][head=wsk1.png]口[/head][color=a number=998]这是一条测试数据[/color]"
--[[
str:字符串 fontSize:字体大小  rowWidth:行宽 rowSpace:行间距
--]]
    local ricLab = RichLabel.new({str=str, font="Microsoft Yahei", fontSize=12, rowWidth=230, rowSpace = -2})
    ricLab:setPosition(ccp(display.cx-200, display.height-50))
    self:addChild(ricLab)

    -- 添加事件监听函数
    local function listener(button, params)
        print(params.text, params.tag, params.number)
        if params.number == 998 then
            print("预约事件")
        end
    end
    ricLab:setClilckEventListener(listener)
end

return MainScene
