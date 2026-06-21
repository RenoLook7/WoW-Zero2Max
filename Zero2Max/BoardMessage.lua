local _, addonTable = ...
local L = addonTable.GetLocale()

Zero2Max.MainFrame.SetProgress = function(self)
	local x = Zero2Max.Player
	local c = Zero2Max.COLOR
	local opt = Zero2Max.boardOpt
	local mtext = ""
	local ltext = ""
	local rtext = ""
	local temp1 = ""
	local temp2 = ""
	local color = nil
	local cend = "|r"
	local nl = "\n"

	defcolor = c.white		
	color = c.yellow

	if opt[1] then
	--<<body message
		-- level
		temp1 = L["Level"] .. ": "
		temp2 = color .. x.pLevel .. " " .. x.pSpec .. cend
		mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, false, temp1, temp2)
		if x.pHSpec ~= "" then 
			temp2 = color .. x.pHSpec .. cend
			mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, true, " ", temp2)
		end
		-- experience
--		if x.pLevel ~= x.pMaxLevel then
		if x.pLevel ~= 90 then
			temp1 = L["XP"] .. ": "
			temp2 = color .. floor((x.pXP/x.pXPMax)*100+0.9) .. "% ( " .. x.pXP - x.pXPMax .. " )" .. cend
			mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, true, temp1, temp2)
		end
		-- item level
		temp1 = L["Item Level_s"] .. ": "
		temp2 = color .. x.pILevelStatus .. cend
		mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, true, temp1, temp2)
		-- chromie time
		if x.pLevel < 70 then
			temp1 = L["Chromie Time_s"] .. ": "
			temp2 = color .. x.pCTime .. cend
			mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, true, temp1, temp2)
		end
		-- heartstone
		temp1 = L["Hearthstone"] .. ": "
		temp2 = color .. GetBindLocation() .. cend
		mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, true, temp1, temp2)
		-- gold
		temp1 = L["Gold"] .. ": "
		temp2 = color .. BreakUpLargeNumbers(x.pMoney / 10000) .. cend
		mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, true, temp1, temp2)
		-- quest
		local numShownEntries, numQuests = C_QuestLog.GetNumQuestLogEntries()
--p		local maxNumQuestsCanAccept = C_QuestLog.GetMaxNumQuestsCanAccept()
		temp1 = L["Quest"] .. ": "
		temp2 = color .. numQuests .. cend
--p		temp2 = color .. numQuests .. " / " .. maxNumQuestsCanAccept .. cend
		mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, true, temp1, temp2)
		-- talent
		temp1 = ""
		temp2 = ""
		if x.pLevel >= 10 then
			local hasUnspentPoints, numClassPoints, numSpecPoints = C_ClassTalents.HasUnspentTalentPoints()
			if hasUnspentPoints ~= nil then
				temp1 = L["Talent"] .. ": "
				local alert = color
				if numClassPoints > 0 then
					alert = c.red
				end
				temp2 = self.AddL(temp2, false, numClassPoints, alert)
				temp2 = self.AddL(temp2, false, " / ", color)
				alert = color
				if numSpecPoints > 0 then
					alert = c.red
				end
				temp2 = self.AddL(temp2, false, numSpecPoints, alert)
			end
			if x.pLevel >= 20 then
				local pvpTalCnt = 0
				local maxPvpTal = 1
				if x.pLevel >= 30 then
					maxPvpTal = maxPvpTal + 1
				end
				if x.pLevel >= 40 then
					maxPvpTal = maxPvpTal + 1
				end
				for i = 1, 3, 1 do
					local slot = C_SpecializationInfo.GetPvpTalentSlotInfo(i)
					if slot ~= nil then
						if slot.selectedTalentID ~= nil then
							pvpTalCnt = pvpTalCnt + 1
						end
					end
				end
				local alert = color
				if pvpTalCnt < maxPvpTal then
					alert = c.red
				end
				temp2 = self.AddL(temp2, false, " / ", color)
				temp2 = self.AddL(temp2, false, maxPvpTal - pvpTalCnt, alert)
			end
			if x.pLevel > 70 then
				temp2 = self.AddL(temp2, false, " / ", color)
				local activeHero = C_ClassTalents.GetActiveHeroTalentSpec()
				if activeHero ~= nil then
					local hasUnspentPointsHero, numHeroPoints = C_ClassTalents.HasUnspentHeroTalentPoints()
					if hasUnspentPointsHero ~= nil then
						local alert = color
						if numHeroPoints > 0 then
							alert = c.red
						end
						temp2 = self.AddL(temp2, false, numHeroPoints, alert)
					end
				else
					temp2 = self.AddL(temp2, false, x.pLevel - 70, c.red)
				end
			end
		end
		if temp1 ~= nil then
			mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, true, temp1, temp2)
		end
		-- mail alert
		if HasNewMail() then
			mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, true, "** " .. L["New Mail"] .. " **", " ", c.lightblue)
		end
	else
		mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, false, L["Character"], " ")
	end
	self:AdjBoard(self.window, mtext, ltext, rtext, not(opt[1]))

	--//////////
	mtext = ""
	ltext = ""
	rtext = ""
	if opt[2] then
		if (x.pPro1 == nil) and  (x.pPro2 == nil) and  (x.pPro3 == nil) and  (x.pPro4 == nil) and  (x.pPro5 == nil) then 
			temp1 = L["Profession"] .. ": "
			temp2 = c.red .. L["Nil"] .. cend
			mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, false, temp1, temp2)
		else
			-- show 5 professionals
			mtext, ltext, rtext = self:FormatProf(mtext, ltext, rtext, x.pPro1, L["Profession 1"], false, color)
			mtext, ltext, rtext = self:FormatProf(mtext, ltext, rtext, x.pPro2, L["Profession 2"], true, color)
			mtext, ltext, rtext = self:FormatProf(mtext, ltext, rtext, x.pPro3, C_TradeSkillUI.GetTradeSkillDisplayName(185), true, color)
			mtext, ltext, rtext = self:FormatProf(mtext, ltext, rtext, x.pPro4, C_TradeSkillUI.GetTradeSkillDisplayName(356), true, color)
			mtext, ltext, rtext = self:FormatProf(mtext, ltext, rtext, x.pPro5, C_TradeSkillUI.GetTradeSkillDisplayName(794), true, color)
			-- trace fish and lumber
			local trackNum = C_Minimap.GetNumTrackingTypes()
			local trackFish = 0
			local trackLumber = 0
			for i = 1, trackNum do
				local trackInfo = C_Minimap.GetTrackingInfo(i)
				if (trackInfo ~= nil) and (trackInfo.spellID ~= nil) and (trackInfo.spellID == 43308) then
					trackFish = 1
				end
				if (trackInfo ~= nil) and (trackInfo.spellID ~= nil) and (trackInfo.spellID == 1256697) then
					trackLumber = 1
				end
			end
			if trackFish == 0 then
				local sp_name = C_Spell.GetSpellName(43308)
				mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, true, sp_name .. ": " .. L["Nil"], " ", c.red)
			end
			if trackLumber == 0 then
				local sp_name = C_Spell.GetSpellName(1256697)
				mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, true, sp_name .. ": " .. L["Nil"], " ", c.red)
			end
		end
	else
		mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, false, L["Profession"], " ")
	end
	self:AdjBoard(self.sboard1, mtext, ltext, rtext, not(opt[2]))

	--//////////
	mtext = ""
	ltext = ""
	rtext = ""
	if opt[3] then
		-- show covenant
		local covName = L["Nil"]
		local covData = {}
		local covActive = C_Covenants.GetActiveCovenantID()
		if covActive ~= nil then
			if covActive > 0 then
				covData = C_Covenants.GetCovenantData(covActive)
				covName = covData.name .. " " .. C_CovenantSanctumUI.GetRenownLevel()
--p				covName = covData.name .. " " .. C_CovenantSanctumUI.GetRenownLevel() .. " (" .. C_Garrison.GetNumFollowers(123) .. ")"
			end
		end
		temp1 = L["Covenant"] .. ": "
		temp2 = color .. covName .. cend
		mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, false, temp1, temp2)
	else
		mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, false, L["Other"], " ")
	end
	self:AdjBoard(self.sboard2, mtext, ltext, rtext, not(opt[3]))

	self:AdjAllTopDownBoard()
end

--<<
Zero2Max.MainFrame.FormatProf = function(self, mtext, ltext, rtext, tempSkill, defaultName, newLine, defaultColor)
	local c = Zero2Max.COLOR
	local tempStatus = nil
	local tempName = defaultName
	local lnew = ""
	local rnew = ""

	if tempSkill == nil then
		tempStatus = L["Unlearned"]
		lnew = defaultName .. ": "
		rnew = c.red .. tempStatus .. cend
		mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, newLine, lnew, rnew)
	else
		if tempSkill[6] ~= nil then
			tempName = tempSkill[6]
		end
		lnew = tempName .. ": "
		if tempSkill[2] ~= tempSkill[3] then
			rnew = self.AddL(rnew, false, tempSkill[2], defaultColor)
		else
			rnew = self.AddL(rnew, false, tempSkill[2], c.springgreen)
		end
		if tempSkill[4] > 0 then
			tempStatus = "+" .. tempSkill[4]
			rnew = self.AddL(rnew, false, tempStatus, c.springgreen)
		end
		if tempSkill[2] ~= tempSkill[3] then
			tempStatus = " / " .. tempSkill[3]
			rnew = self.AddL(rnew, false, tempStatus, defaultColor)
		end
		mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, newLine, lnew, rnew)	
	end
	return mtext, ltext, rtext
end
