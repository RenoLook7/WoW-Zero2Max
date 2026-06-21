local _, addonTable = ...
local L = addonTable.GetLocale()

	--<<profession equipment
--	WriteMessageProfEq = function(self, window)
--		local c = Zero2Max.COLOR
--		local mtext = ""
--		local ltext = ""
--		local rtext = ""
--		local color = nil
				
		--<<setup header
--		window.line.hline:SetText(L["Profession Equipment"])

		--<<merge body message
--		local eslot = {} 
--		eslot[1]  = {20, PROF0TOOLSLOT}
--		eslot[2]  = {21, PROF0GEAR0SLOT}
--		eslot[3]  = {22, PROF0GEAR1SLOT}
--		eslot[4]  = {23, PROF1TOOLSLOT}
--		eslot[5]  = {24, PROF1GEAR0SLOT}
--		eslot[6]  = {25, PROF1GEAR1SLOT}
--		eslot[7]  = {26, COOKINGTOOLSLOT}
--		eslot[8]  = {27, COOKINGGEAR0SLOT}
--		eslot[9]  = {28, FISHINGTOOLSLOT}
--		eslot[10] = {29, FISHINGGEAR0SLOT}
--		eslot[11] = {30, FISHINGGEAR1SLOT}

--		local notNew = false
--		for k, v in pairs(eslot) do
--			local itemLoc = ItemLocation:CreateFromEquipmentSlot(v[1])
--			if not itemLoc:IsValid() then
--				mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, notNew, v[2], L["Nil"], c.red)
--			else
--				local cILvl = C_Item.GetCurrentItemLevel(itemLoc)
--				local iLink = C_Item.GetItemLink(itemLoc)
--				local iName, _, iQual = GetItemInfo(iLink)
--				color = c.itemquality[iQual]
--				mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, notNew, iName, cILvl, color)
--			end
--			notNew = true
--		end
--
--		self:AdjWin(window, mtext, ltext, rtext)
--		window:Show()
--	end,


--//////////
--<<Group 4
Zero2Max.MainFrame.WriteMessageGroup4 = function(self, window, message)
	local x = Zero2Max.Player
	local c = Zero2Max.COLOR
	local mtext = ""
	local ltext = ""
	local rtext = ""
	local currInfo = {}

	local k = nil
	local v = nil
	local color = nil
	local campInfo = nil
	local chapInfo = nil
	local questComp = nil
	local tempTable = {}
	local tempTable2 = {}
	local notNew = false
	local tempStatus = nil

	local macNum = nil
	local macName = nil
	local macBody = nil
	local hl = 1				-- highlight background and border


	if message == "quest_exp_10" then
		--<<setup header
		window.line.hline:SetText(L["Dragonflight"])

		notNew = false
		campInfo = C_CampaignInfo.GetCampaignInfo(165)
		mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, notNew, campInfo.name, " ", c.yellow)
		notNew = true
		tempTable = { 1289 }
		tempTable2 = { 69914 }
		for k, v in pairs(tempTable) do
			questComp = C_QuestLog.IsQuestFlaggedCompleted(tempTable2[k])
			if questComp == false then 
				tempStatus = L["Undone"]
				color = c.red
			else
				tempStatus = L["Done"]
				color = c.springgreen
			end
			chapInfo = C_CampaignInfo.GetCampaignChapterInfo(v)
			mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, notNew, " - " .. chapInfo.name, tempStatus, color)
		end

		mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, notNew)

		campInfo = C_CampaignInfo.GetCampaignInfo(169)
		mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, notNew, campInfo.name, " ", c.yellow)
		tempTable = { 1299, 1300, 1301, 1302 }
		tempTable2 = { 66001, 66124, 66057, 65794 }
		for k, v in pairs(tempTable) do
			questComp = C_QuestLog.IsQuestFlaggedCompleted(tempTable2[k])
			if questComp == false then 
				tempStatus = L["Undone"]
				color = c.red
			else
				tempStatus = L["Done"]
				color = c.springgreen
			end
			chapInfo = C_CampaignInfo.GetCampaignChapterInfo(v)
			mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, notNew, " - " .. chapInfo.name, tempStatus, color)
		end

		mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, notNew)

		campInfo = C_CampaignInfo.GetCampaignInfo(166)
		mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, notNew, campInfo.name, " ", c.yellow)
		tempTable = { 1303, 1304, 1305, 1306 }
		tempTable2 = { 65806, 66025, 66259, 66783 }
		for k, v in pairs(tempTable) do
			questComp = C_QuestLog.IsQuestFlaggedCompleted(tempTable2[k])
			if questComp == false then 
				tempStatus = L["Undone"]
				color = c.red
			else
				tempStatus = L["Done"]
				color = c.springgreen
			end
			chapInfo = C_CampaignInfo.GetCampaignChapterInfo(v)
			mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, notNew, " - " .. chapInfo.name, tempStatus, color)
		end

		mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, notNew)

		campInfo = C_CampaignInfo.GetCampaignInfo(174)
		mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, notNew, campInfo.name, " ", c.yellow)
		tempTable = { 1314, 1317, 1316, 1315 }
		tempTable2 = { 65855, 66026, 65911, 66015 }
		for k, v in pairs(tempTable) do
			questComp = C_QuestLog.IsQuestFlaggedCompleted(tempTable2[k])
			if questComp == false then 
				tempStatus = L["Undone"]
				color = c.red
			else
				tempStatus = L["Done"]
				color = c.springgreen
			end
			chapInfo = C_CampaignInfo.GetCampaignChapterInfo(v)
			mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, notNew, " - " .. chapInfo.name, tempStatus, color)
		end

	end


	if message == "quest_exp_10_artisan" then
		--<<setup header
		window.line.hline:SetText("Artisan")

		local questlist = Zero2Max.PROF_ARTI_MISS
		local qp1 = x.pPro1
		local qp1sk = 0
		if qp1 ~= nil then
			qp1sk = qp1[5]
		end
		local qp2 = x.pPro2
		local qp2sk = 0
		if qp2 ~= nil then
			qp2sk = qp2[5]
		end
		notNew = false
		if (qp1sk == 0) and (qp2sk == 0) then
			mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, notNew, L["Nil"], " ")
			hl = 2
		else
			hl = 3
			for k, v in pairs(questlist) do
				if (k == qp1sk) or (k == qp2sk) then
					local qname = C_QuestLog.GetTitleForQuestID(v)
					local qcomp = C_QuestLog.IsQuestFlaggedCompleted(v)
					if qcomp == false then 
						qcomp = L["Undone"]
						color = c.red
						hl = 1
					else
						qcomp = L["Done"]
						color = c.springgreen
					end
					mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, notNew, qname, qcomp, color)
					notNew = true
				end
			end
		end
	end


	if message == "quest_exp_11_delvecall" then
		--<<setup header
		window.line.hline:SetText("Delve Call")

		local questlist = Zero2Max.QUEST_DELVE
		notNew = false
		hl = 3
		for k, v in pairs(questlist) do
			local qname = C_QuestLog.GetTitleForQuestID(v)
			local qcomp = C_QuestLog.IsQuestFlaggedCompleted(v)
			if qcomp == false then 
				qcomp = L["Undone"]
				color = c.red
				hl = 1
			else
				qcomp = L["Done"]
				color = c.springgreen
			end
			mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, notNew, qname, qcomp, color)
			notNew = true
		end
	end


--	if message == "qe10_5" then
--		campInfo = C_CampaignInfo.GetCampaignInfo(166)
--		--<<setup header
--		window.line.hline:SetText(campInfo.name)


--		mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, notNew)

--		campInfo = C_CampaignInfo.GetCampaignInfo(166)
--		mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, notNew, campInfo.name, " ", c.yellow)

--		tempTable = { 1303, 1304, 1305 }
--		tempTable2 = { 66252, 65962, 66221 }
--		notNew = false
--		for k, v in pairs(tempTable) do
--			questComp = C_QuestLog.IsQuestFlaggedCompleted(tempTable2[k])
--			if questComp == false then 
--				tempStatus = L["Undone"]
--				color = c.red
--			else
--				tempStatus = L["Done"]
--				color = c.springgreen
--			end
--			chapInfo = C_CampaignInfo.GetCampaignChapterInfo(v)
--			mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, notNew, chapInfo.name, tempStatus, color)
--			notNew = true
--		end
--	end


	if (message == "outfitdebug1") or (message == "outfitdebug2") then

		local table1 = { 2, 3, 4, 5, 36, 37, 39, 40, }
		local table2 = { 41, 42, 62, 63	}
		local tablex = {}

		--<<setup header
		if (message == "outfitdebug1") then 
			window.line.hline:SetText(L["Outfit"] .. " 1")
			tablex = table1
		end
		if (message == "outfitdebug2") then 
			window.line.hline:SetText(L["Outfit"] .. " 2")
			tablex = table2
		end
		notNew = false

		local slottable = {
			{0,"Head"},
			{1,"ShoulderRight"},
			{2,"ShoulderLeft"},
			{3,"Back"},
			{4,"Chest"},
			{5,"Tabard"},
			{6,"Body"},
			{7,"Wrist"},
			{8,"Hand"},
			{9,"Waist"},
			{10,"Legs"},
			{11,"Feet"},
		}

		for i, j in pairs(tablex) do
			C_TransmogOutfitInfo.ChangeViewedOutfit(j)

			local OutInfo = C_TransmogOutfitInfo.GetOutfitInfo(j)
			mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, notNew, OutInfo.name, " ", c.yellow)
			notNew = true

			for k, v in pairs(slottable) do
			
				local slotInfo = C_TransmogOutfitInfo.GetViewedOutfitSlotInfo(v[1], 0, 0)
				--	0	Unassigned	
				--	1	Assigned	
				--	2	Equipped	
				--	3	Hidden	
				--	4	Disabled
				if slotInfo.displayType > 0 then
					local temp1 = " - " .. v[2]
					local temp2 = slotInfo.transmogID .. " " .. slotInfo.displayType
					mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, notNew, temp1, temp2)
					notNew = true
				end
			end
		end
	end


	if Zero2Max.displayColor then
		-- for macro, equipmentset, outfit
		if 	hl == 2 then
			local dc = Zero2Max.colorCheck
			window:SetBackdropBorderColor(dc[1], dc[2], dc[3], dc[4])
			self:AdjWinColor(window, dc[5], dc[6], dc[7], dc[8])
		end
		-- for artisan
		if 	hl == 3 then
			local dc = Zero2Max.colorExplore
			window:SetBackdropBorderColor(dc[1], dc[2], dc[3], dc[4])
			self:AdjWinColor(window, dc[5], dc[6], dc[7], dc[8])
		end
	end

	self:AdjWin(window, mtext, ltext, rtext)
	window:Show()
end
