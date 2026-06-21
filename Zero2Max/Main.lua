local _, addonTable = ...
local L = addonTable.GetLocale()

-- Create the main object and frame to listen to events
Zero2Max = { }
Zero2Max.frame = CreateFrame("FRAME", "Zero2Max", UIParent)
Zero2Max.frame:RegisterEvent("PLAYER_LOGIN")

-----
Zero2Max.display		= true
Zero2Max.pinWindow		= false

Zero2Max.inTrade		= false
Zero2Max.inBank			= false

Zero2Max.gapWide		= 7
Zero2Max.gapHight		= 7
Zero2Max.titleShort	= "_short"					-- "_short" or ""
--Zero2Max.titleShort = ""
Zero2Max.boardScale		= 1
Zero2Max.windowScale	= 1
Zero2Max.panelScale		= 1

Zero2Max.boardOpt = {
	[1] = true,								-- false = fold; true = unfold for mainboard
	[2] = true,								-- false = fold; true = unfold for subboard1
	[3] = true,								-- false = fold; true = unfold for subboard2
	[4] = true,								-- false = fold; true = unfold for panel list
	[5] = {true, "All", "Uncollected"}		-- true = show all; false = show uncollected only
}

Zero2Max.panelList = {
	[1]  = {"appset", "Set", ""},
	[2]  = {"kill", "Kill", ""},
	[3]  = {"explore", "Explosion", ""},
	[4]  = {"lore", "Lore", ""},
	[5]  = {"follower", "Follower", ""},
	[6]  = {"quest", "Quest", ""},
	[7]  = {"image", "Image", ""},
	[8]  = {"profspec", "Profession Specialization_s", ""},
	[9]  = {"spellbook", "Spellbook", ""},
	[10] = {"renown", "Renown", ""},
	[11] = {"gear", "Gear", ""},
	[12] = {"check", "Check", ""},
}

Zero2Max.panelList2 = {
	[1] = {"1", "1"},
	[2] = {"2", "2"},
	[3] = {"3", "3"},
	[4] = {"4", "4"},
	[5] = {"5", "5"},
	[6] = {"6", "6"},
	[7] = {"7", "7"},
}

Zero2Max.panelSelect	= "appset"
Zero2Max.displayColor	= true
Zero2Max.colorCheck		= {0.55, 0.8, 1, 1, 0, 0.4, 0.8, 0.2}
Zero2Max.colorExplore	= {0, 1, 0, 1, 0, 0.25, 0.25, 0.2}
Zero2Max.colorLore		= {0, 1, 0, 1, 0, 0.25, 0.25, 0.2}
Zero2Max.colorQuest		= {1, 0.6, 0, 1, 1, 0.4, 0, 0.2}
Zero2Max.colorFollower	= {0.6, 0.4, 0.8, 1, 0.4, 0.4, 0.6, 0.2}
Zero2Max.colorProf		= {1, 0, 0, 1, 1, 0.4, 0.4, 0.2}

Zero2Max.portraitSetting2			= nil
Zero2Max.portraitSetting3			= nil
Zero2Max.portraitIsRotated			= true
Zero2Max.portraitRotation			= 0

--d	Zero2Max.portraitDebugOrgS 			= 1
--d	Zero2Max.portraitDebugSelection		= 1		-- 1=s, 2=r, 3=x, 4=y, 5=z
--d	Zero2Max.portraitDebugAdjS  		= 0
--d	Zero2Max.portraitDebugAdjR  		= 0
--d	Zero2Max.portraitDebugAdjX  		= 0
--d	Zero2Max.portraitDebugAdjY  		= 0
--d	Zero2Max.portraitDebugAdjZ  		= 0
--d	Zero2Max.portraitDebugAdjMultiple	= 1

-----
Zero2Max.MainControl = {}

function Zero2Max.MainControl:Initialize()
	Zero2Max.MainFrame:Initialize()
    self:Update()
end

function Zero2Max.MainControl:Update()
    Zero2Max.MainFrame:SetProgress()
    Zero2Max.MainFrame:Update()
end

--
-- ON_EVENT handler. Set in the Zero2MaxDisplay XML file. Called for every event
-- and only used to attach the callback functions to their respective event.
function Zero2Max:MainOnEvent(event, ...)
    if event == "PLAYER_LOGIN" then
        self:OnPlayerLogin()
    elseif event == "PLAYER_LEVEL_UP" then
        self:OnPlayerLevelUp(select(1, ...))
    elseif event == "PLAYER_XP_UPDATE" then
        self:OnPlayerXPUpdate()
    elseif event == "PLAYER_ENTERING_WORLD" then
        self:OnPlayerEnteringWorld()
	elseif event == "TRADE_SKILL_SHOW" then
        self:OnTradeSkillShow()
	elseif event == "TRADE_SKILL_CLOSE" then
	    self:OnTradeSkillClose()
	elseif event == "BANKFRAME_OPENED" then
	    self:OnBankFrameOpened()
	elseif event == "BANKFRAME_CLOSED" then
	    self:OnBankFrameClosed()
    end
end
Zero2Max.frame:SetScript("OnEvent", function(self, ...) Zero2Max:MainOnEvent(...) end);

--
-- Registers events listeners and slash commands. Note, the callbacks for
-- the events are defined in the MainOnEvent function.
function Zero2Max:RegisterEvents(level)
    -- Register Events
    self.frame:RegisterEvent("PLAYER_LEVEL_UP");
    self.frame:RegisterEvent("PLAYER_XP_UPDATE");
    self.frame:RegisterEvent("PLAYER_ENTERING_WORLD");
	self.frame:RegisterEvent("TRADE_SKILL_SHOW");
	self.frame:RegisterEvent("TRADE_SKILL_CLOSE");
	self.frame:RegisterEvent("BANKFRAME_OPENED");
	self.frame:RegisterEvent("BANKFRAME_CLOSED");
end

--
-- Clears all registered events from the addon.
function Zero2Max:UnregisterEvents()
    self.frame:UnregisterEvent("PLAYER_LEVEL_UP");
    self.frame:UnregisterEvent("PLAYER_XP_UPDATE");
    self.frame:UnregisterEvent("PLAYER_ENTERING_WORLD");
	self.frame:UnregisterEvent("TRADE_SKILL_SHOW");
	self.frame:UnregisterEvent("TRADE_SKILL_CLOSE");
	self.frame:UnregisterEvent("BANKFRAME_OPENED");
	self.frame:UnregisterEvent("BANKFRAME_CLOSED");
end

--- PLAYER_LOGIN callback. Initializes the config, locale and c Objects.
function Zero2Max:OnPlayerLogin()
    self:RegisterEvents()
    
	addonTable.SetLocale("enUS")
	addonTable.WipeLocales() -- Removing the extra locale tables. They're just a waste of memory.
 
    Zero2Max.Player:Initialize()
    Zero2Max.MainControl:Initialize()
	Zero2Max.MainFrame:PortraitInitialize()
end

-- Disables the addon for this session. Basically, this hides all frames and
-- wipes the Zero2Max table.
function Zero2Max:Unload()
	Zero2Max.MainFrame:Hide()
    wipe(Zero2Max)
end

--------------------------------------------------------------------------------

function Zero2Max:OnPlayerLevelUp(newLevel)
    Zero2Max.Player:SyncData()
	Zero2Max.MainControl:Update()
end

function Zero2Max:OnPlayerXPUpdate()
    Zero2Max.Player:SyncData()
    Zero2Max.MainControl:Update()
end

function Zero2Max:OnPlayerEnteringWorld()
    Zero2Max.Player:SyncData()
    Zero2Max.MainControl:Update()
	Zero2Max.MainFrame.windowP:Show()
end

function Zero2Max:OnTradeSkillShow()
	Zero2Max.inTrade = true
	Zero2Max.tooltipMode = ""	
    Zero2Max.Player:SyncData()
    Zero2Max.MainControl:Update()
end

function Zero2Max:OnTradeSkillClose()
	Zero2Max.tooltipMode = ""	
    Zero2Max.Player:SyncData()
    Zero2Max.MainControl:Update()
	Zero2Max.inTrade = false
end

function Zero2Max:OnBankFrameOpened()
	Zero2Max.inBank = true
	Zero2Max.tooltipMode = ""
    Zero2Max.Player:SyncData()
    Zero2Max.MainControl:Update()
end

function Zero2Max:OnBankFrameClosed()
	Zero2Max.tooltipMode = ""
    Zero2Max.Player:SyncData()
    Zero2Max.MainControl:Update()
	Zero2Max.inBank = false
end
