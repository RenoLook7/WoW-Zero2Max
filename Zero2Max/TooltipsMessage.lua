local _, addonTable = ...
local L = addonTable.GetLocale()

Zero2Max.MainFrame.WriteMessageChar = function(self, window, text)
	local x = Zero2Max.Player
	local c = Zero2Max.COLOR
	local mtext = ""
	local color = nil
	local cstart = "|c"
	local cend = "|r"
	local nl = "\n"
	local maxlength = 0
	local cntx = 0
	local cnty = 0

	if text == nil then
		mtext = cstart .. x.pCColor .. x.pCharacter .. cend
	else
		mtext = cstart .. x.pCColor .. text .. cend
	end

	--<<fill header
	window.line.hline:SetHeight(500)
	window.line.hline:SetWidth(500)
	window.line.hline:SetSpacing(1)
	window.line.hline:SetText(mtext)
	window.line.hline:SetHeight(window.line.hline:GetStringHeight())
	window.line.hline:SetWidth(window.line.hline:GetStringWidth())

	--<<count frame size, update frame size, re-align frame
	cnty = 10 + window.line.hline:GetStringHeight() + 10
	cntx = 10 + window.line.hline:GetStringWidth() + 10
	window:SetHeight(cnty)
	window:SetWidth(cntx)
	window.line:SetHeight(cnty)
	window.line:SetWidth(cntx)
end


--//////////
--<<hearthstone
Zero2Max.MainFrame.WriteMessageStone = function(self, window)
	local x = Zero2Max.Player
	local c = Zero2Max.COLOR
	local n = Zero2Max.ITEM_NAME
	local mtext = ""
	local ltext = ""
	local rtext = ""
	local color = nil

	--<<setup header
	window.line.hline:SetText(L["Hearthstone"])

	--<<merge body message
	--	item 6948, bindLocation, 110560, 140192, 141605
	local notNew = false
	for k, v in pairs(x.pIC[1]) do
		local iID   = v[1]
		local iCnt  = v[2]
	--	local iName = C_Item.GetItemNameByID(iID)
		local iName = L[n[iID]]
		if (iCnt == 0 and iID ~= 141605)
		or (iCnt == 0 and iID == 141605 and x.pLevel > 44) then
			color = c.red
		else
			color = c.white
		end
		if (iID ~= 110560 and iID ~= 140192) then 
			mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, notNew, iName, iCnt, color)
		end
		notNew = true
		if (iID == 6948) then
			--get bind location
			mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, notNew, " - " .. L["Bind Location"], GetBindLocation())
		end
		if (iID == 110560) then 
			if PlayerHasToy(110560) then
				local questComp1 = nil
				local questComp2 = nil
				questComp1 = C_QuestLog.IsQuestFlaggedCompleted(33868)
				questComp2 = C_QuestLog.IsQuestFlaggedCompleted(34582)
				if (questComp1 == false and questComp2 == false) then 
					mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, notNew, iName, L["Undone"], c.red)
				else
					mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, notNew, iName, L["Done"], c.springgreen)
				end
			else
				mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, notNew, iName, L["Nil"], c.red)
			end
		end
		if (iID == 140192) then 
			if PlayerHasToy(140192) then
				local questComp1 = nil
				questComp1 = C_QuestLog.IsQuestFlaggedCompleted(44184)
				if (questComp1 == false) then 
					mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, notNew, iName, L["Undone"], c.red)
				else
					mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, notNew, iName, L["Done"], c.springgreen)
				end
			else
				mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, notNew, iName, L["Nil"], c.red)
			end
		end
	end

	self:AdjWin(window, mtext, ltext, rtext)
end


--//////////
--<<personal item
Zero2Max.MainFrame.WriteMessagePI = function(self, window)
	local x = Zero2Max.Player
	local c = Zero2Max.COLOR
	local n = Zero2Max.ITEM_NAME
	local mtext = ""
	local ltext = ""
	local rtext = ""
	local color = nil

	--<<setup header
	window.line.hline:SetText(L["Personal Item"])

	--<<merge body message
	mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, false, L["Toy"], x.pNumToysLearned .. " / " .. x.pNumToys)
	mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, true, L["Heirloom"], x.pNumHeirloomsKnown .. " / " .. x.pNumHeirlooms)
	mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, true, L["Appearance Set"], x.pNumAppSetsGet .. " / " .. x.pNumAppSets)
	mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, true, L["Artifact"], C_ArtifactUI.GetNumObtainedArtifacts())
	-- item 16060, 109253 + 114943, faction, 71634
--p	local ic = x.pIC[4]
--p	local ic2 = {}
--p	ic2[1] = ic[1]
--p	ic2[2] = ic[5]
--p	ic2[3] = {ic[3][1], ic[3][2] + ic[4][2]}
--p	ic2[4] = ic[6]
--p	ic2[5] = ic[2]
--p	local notNew = false
--p	for k, v in pairs(ic2) do
--p		local iID   = v[1]
--p		local iCnt  = v[2]
--p	--	local iName = C_Item.GetItemNameByID(iID)
--p		local iName = L[n[iID]]
--p		if (iID == 71634) then
--p			color = c.white
--p			local repuSta
--p			if x.pSpecRepu[2][2] == 8 then
--p				repuSta = getglobal("FACTION_STANDING_LABEL" .. x.pSpecRepu[2][2])
--p				color = c.springgreen
--p		else
--p				repuSta = (x.pSpecRepu[2][5] - x.pSpecRepu[2][3]) .. " / "
--p				repuSta = repuSta .. (x.pSpecRepu[2][4] - x.pSpecRepu[2][3]) .. " "
--p				repuSta = repuSta .. getglobal("FACTION_STANDING_LABEL" .. x.pSpecRepu[2][2])
--p			end
--p			mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, notNew, x.pSpecRepu[2][1], repuSta, color)
--p			notNew = true
--p		end
--p		if iCnt == 0 then
--p			color = c.red
--p		else
--p			color = c.white
--p		end
--p		mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, notNew, iName, iCnt, color)
--p		notNew = true
--p	end

	self:AdjWin(window, mtext, ltext, rtext)
end


--//////////
--<<equipment
Zero2Max.MainFrame.WriteMessageEq = function(self, window)
	local c = Zero2Max.COLOR
	local mtext = ""
	local ltext = ""
	local rtext = ""
	local color = nil

	--<<setup header
	window.line.hline:SetText(L["Equipment"])

	--<<merge body message
	local eslot = {} 
	eslot[1]  = {INVSLOT_HEAD, HEADSLOT}
	eslot[2]  = {INVSLOT_NECK, NECKSLOT}
	eslot[3]  = {INVSLOT_SHOULDER, SHOULDERSLOT}
	eslot[4]  = {INVSLOT_BACK, BACKSLOT}
	eslot[5]  = {INVSLOT_CHEST, CHESTSLOT}
	eslot[6]  = {INVSLOT_BODY, SHIRTSLOT}
	eslot[7]  = {INVSLOT_TABARD, TABARDSLOT}
	eslot[8]  = {INVSLOT_WRIST, WRISTSLOT}
	eslot[9]  = {INVSLOT_HAND, HANDSSLOT}
	eslot[10] = {INVSLOT_WAIST, WAISTSLOT}
	eslot[11] = {INVSLOT_LEGS, LEGSSLOT}
	eslot[12] = {INVSLOT_FEET, FEETSLOT}
	eslot[13] = {INVSLOT_FINGER1, FINGER0SLOT}
	eslot[14] = {INVSLOT_FINGER2, FINGER1SLOT}
	eslot[15] = {INVSLOT_TRINKET1, TRINKET0SLOT}
	eslot[16] = {INVSLOT_TRINKET2, TRINKET1SLOT}
	eslot[17] = {INVSLOT_MAINHAND, MAINHANDSLOT}
	eslot[18] = {INVSLOT_OFFHAND, SECONDARYHANDSLOT}

	local notNew = false
	for k, v in pairs(eslot) do
		local itemLoc = ItemLocation:CreateFromEquipmentSlot(v[1])
		if not itemLoc:IsValid() then
			mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, notNew, v[2], L["Nil"], c.red)
		else
			local cILvl = C_Item.GetCurrentItemLevel(itemLoc)
			local iLink = C_Item.GetItemLink(itemLoc)
			local iName, _, iQual = GetItemInfo(iLink)
			color = c.itemquality[iQual]
			mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, notNew, iName, cILvl, color)
		end
		notNew = true
	end

	self:AdjWin(window, mtext, ltext, rtext)
end


--//////////
--<<riding skill
Zero2Max.MainFrame.WriteMessageRiding = function(self, window)
	local x = Zero2Max.Player
	local c = Zero2Max.COLOR
	local mtext = ""
	local ltext = ""
	local rtext = ""
	local color = nil
	local cend = "|r"
	local nl = "\n"

	--<<setup header
	window.line.hline:SetText(L["Mount"])

	--<<merge body message
	color = c.white
	local mountGet
	mountGet = x.pNumMountsGet .. " / " .. x.pNumMounts
	mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, false, L["Mount"], mountGet)
	if x.pMEStatus == L["Nil"] then
		color = c.red
	end
	mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, true, L["Mount Equipment"], x.pMEStatus, color)
	color = c.white
	mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, true, L["Riding Level"], x.pRidingSkillStatus, color)
	mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, true, L["Riding Speed"], x.pRidingSpeed, color)

	self:AdjWin(window, mtext, ltext, rtext)
end


--//////////
--<<pet
Zero2Max.MainFrame.WriteMessagePet = function(self, window)
	local x = Zero2Max.Player
	local c = Zero2Max.COLOR
	local n = Zero2Max.ITEM_NAME
	local mtext = ""
	local ltext = ""
	local rtext = ""
	local color = nil
	local cend = "|r"

	--<<setup header
	window.line.hline:SetText(L["Pet"])

	--<<merge body message
	--real time get due to no information during load
	local _, numPetsOwned = C_PetJournal.GetNumPets()
	mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, false, L["Owned"], numPetsOwned)
	mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, true, L["Battle Pet Slot"], " ")
	for i = 1, 3, 1 do
		local pID = C_PetJournal.GetPetLoadOutInfo(i)
		if pID == nil then
			mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, true, " - " .. L["Battle Pet Slot"] .. i, L["Nil"], c.red)
		else
			local _, _, pLvl, _, _, _, _, pName, _, pType = C_PetJournal.GetPetInfoByPetID(pID)
			local pHP, pHPMax, _, _, pRarity = C_PetJournal.GetPetStats(pID)
			if (pLvl == nil)
			or (pName == nil)
			or (pType == nil)
			or (pHP == nil)
			or (pHPMax == nil)
			or (pRarity == nil) then
				mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, true, " - " .. L["Battle Pet Slot"] .. i, L["Nil"], c.red)
			else
				color = c.itemquality[pRarity - 1]
				local temp1 = " - " .. color .. pName .. cend
				if pHP == 0 then
					temp1 = temp1 .. " " .. c.red .. " ( " .. L["Dead"] .. " )" .. cend
				elseif pHP < pHPMax then
					temp1 = temp1 .. " " .. c.red .. " ( " .. L["Hurt"] .. " )" .. cend
				end
				local temp2 = color .. getglobal("BATTLE_PET_NAME_" .. pType) .. " " .. pLvl .. cend
				mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, true, temp1, temp2)
			end
		end
	end
	local ic = x.pIC[2]
	mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, true, L[n[ic[2][1]]], ic[2][2])

	self:AdjWin(window, mtext, ltext, rtext)
end


--//////////
--<<PvP
Zero2Max.MainFrame.WriteMessagePVP = function(self, window)
	local x = Zero2Max.Player
	local n = Zero2Max.ITEM_NAME
	local mtext = ""
	local ltext = ""
	local rtext = ""

	--<<setup header
	window.line.hline:SetText(L["Honor"])

	--<<merge body message
	mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, false, L["Honor Level"], x.pPVPLevel[1])
--p	mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, false, L["Honor Level"], x.pPVPLevel[1] .. " / " .. x.pPVPLevel[4])
	local temp = x.pPVPLevel[2] .. " / " .. x.pPVPLevel[3]
	mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, true, L["Lifetime Honor"], temp)
	-- item 137642
	local ic = x.pIC[2]
	mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, true, L[n[ic[1][1]]], ic[1][2])
	local currInfo = {}

	self:AdjWin(window, mtext, ltext, rtext)
end


--//////////
--<<guild
Zero2Max.MainFrame.WriteMessageGuild = function(self, window)
	local x = Zero2Max.Player
	local c = Zero2Max.COLOR
	local n = Zero2Max.ITEM_NAME
	local mtext = ""
	local ltext = ""
	local rtext = ""
	local color = nil
	local cend = "|r"

	--<<setup header
	window.line.hline:SetText(L["Guild"])
	if x.pGuildName ~= "" then
		window.line.hline:SetText(x.pGuildName)
	end

	--<<merge body message
	color = c.white
	local repuSta
	if x.pSpecRepu[1][2] == 8 then
		repuSta = getglobal("FACTION_STANDING_LABEL" .. x.pSpecRepu[1][2])
		color = c.springgreen
	else
		repuSta = (x.pSpecRepu[1][5] - x.pSpecRepu[1][3]) .. " / "
		repuSta = repuSta .. (x.pSpecRepu[1][4] - x.pSpecRepu[1][3]) .. " "
		repuSta = repuSta .. getglobal("FACTION_STANDING_LABEL" .. x.pSpecRepu[1][2])
	end
	mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, false, L["Reputation"], repuSta, color)
	local notNew = true
	-- item 5976, 69209, 69210
--p	local ic = x.pIC[3]
--p	color = c.white
--p	if (ic[1][2] == 0) and (ic[2][2] == 0) and (ic[3][2] == 0) then
--p		color = c.red
--p	end
--p	for k, v in pairs(ic) do
--p		local iID   = v[1]
--p		local iCnt  = v[2]
--p	--	local iName = C_Item.GetItemNameByID(iID)
--p		local iName = L[n[iID]]
--p		mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, notNew, iName, iCnt, color)
--p		notNew = true
--p	end

	local loadStart, loadEnd = C_AddOns.IsAddOnLoaded("Blizzard_GuildBankUI")
	if loadStart and loadEnd then
		local pGBMoney = GetGuildBankMoney()
		if pGBMoney == nil then
			mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, notNew, L["Guild Bank Gold"], c.yellow .. "< " .. L["No Data"] .. " >" .. cend)
		else
			mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, notNew, L["Guild Bank Gold"], BreakUpLargeNumbers(pGBMoney / 10000))
		end
	else
		mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, notNew, L["Guild Bank Gold"], c.yellow .. "< " .. L["No Data"] .. " >" .. cend)
	end

	local pGBTab = GetNumGuildBankTabs()
	if pGBTab == nil then
		mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, notNew, L["Guild Bank Tab"], c.yellow .. "< " .. L["No Data"] .. " >" .. cend)
	else
		mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, notNew, L["Guild Bank Tab"], pGBTab .. " / " .. 8)
	end

	self:AdjWin(window, mtext, ltext, rtext)
end


--//////////
--<<bag
Zero2Max.MainFrame.WriteMessageBag = function(self, window)
	local x = Zero2Max.Player
	local c = Zero2Max.COLOR
	local mtext = ""
	local ltext = ""
	local rtext = ""
	local color = nil

	--<<setup header
	window.line.hline:SetText(L["Bag"])

	--<<merge body message
	local notNew = false
	local cnt1  = 0
	local cnt2  = 0
	for k, v in pairs(x.pSlotsBackPack) do
		local name
		if k == 1 then
			name = L["Bag"]
		elseif k < 6 then
			name = L["Container"] .. k-1
		else
			name = L["Reagent Bag"]
		end
		if v[1] == 0 then
			mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, notNew, name, L["Nil"], c.red)
		else
			local name2 = C_Container.GetBagName(k-1)
			if name2 ~= nil then
				name = name2
			end
			mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, notNew, name, v[2] .. " / " .. v[1])
		end
		notNew = true
		cnt1 = cnt1 + v[1]
		cnt2 = cnt2 + v[2]
	end
	local cntbag
	if x.pBagTotal < (NUM_BAG_SLOTS + 2) then
		cntbag  = x.pBagTotal .. " / " .. NUM_BAG_SLOTS + 2
		color = c.red
	else
		cntbag  = x.pBagTotal
		color = c.white
	end
	mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, notNew, " - " .. L["Total"] .. " ( " .. cntbag .. " )", cnt2 .. " / " .. cnt1, color)

	self:AdjWin(window, mtext, ltext, rtext)
end


--//////////
--<<bank
Zero2Max.MainFrame.WriteMessageBank = function(self, window)
	local x = Zero2Max.Player
	local c = Zero2Max.COLOR
	local mtext = ""
	local ltext = ""
	local rtext = ""
	local color = nil
	local cend = "|r"
	local nl = "\n"
	local k, v

	local cnt1  = 0
	local cnt2  = 0
	local cnt3  = 0

	--<<setup header
	window.line.hline:SetText(L["Bank"])

	--<<merge body message
	notNew = false
	color = c.white
	if x.pCharBankPuchased < 6 then
		color = c.red
	end
	mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, notNew, L["Purchased Bank Tag"], color .. x.pCharBankPuchased .. " / " .. "6" .. cend)

	notNew = true
	color = c.white
	if x.pCharBank  ~= nil then
		cnt1 = 0
		cnt2 = 0
		for k, v in pairs(x.pCharBank) do
			mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, notNew, " - " .. v[3], v[2] .. " / " .. v[1])
			cnt1 = cnt1 + v[1]
			cnt2 = cnt2 + v[2]
		end
		mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, notNew, " - " .. L["Total"] .. " ( " .. x.pCharBankPuchased .. " )", cnt2 .. " / " .. cnt1)
	else
		mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, notNew, L["Bank Tag"], c.yellow .. "< " .. L["No Data"] .. " >" .. cend)
	end

	mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, true)
	if x.pAccBankPuchased == nil then
		mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, notNew, L["Warband Bank Tag"], c.yellow .. "< " .. L["No Data"] .. " >" .. cend)
	else
		color = c.white
		if x.pAccBankPuchased < 5 then
			color = c.red
		end
		mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, notNew, L["Purchased Warband Bank Tag"], color .. x.pAccBankPuchased .. " / " .. "5" .. cend)

		color = c.white
		if x.pAccBank  ~= nil then
			cnt1 = 0
			cnt2 = 0
			for k, v in pairs(x.pAccBank) do
				mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, notNew, " - " .. v[3], v[2] .. " / " .. v[1])
				cnt1 = cnt1 + v[1]
				cnt2 = cnt2 + v[2]
			end
			mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, notNew, " - " .. L["Total"] .. " ( " .. x.pAccBankPuchased .. " )", cnt2 .. " / " .. cnt1)
		else
			mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, notNew, L["Warband Bank Tag"], c.yellow .. "< " .. L["No Data"] .. " >" .. cend)
		end
	end

	self:AdjWin(window, mtext, ltext, rtext)
end


--//////////
--<<main city
Zero2Max.MainFrame.WriteMessageMainCity = function(self, window)
	local x = Zero2Max.Player
	local c = Zero2Max.COLOR
	local mtext = ""
	local ltext = ""
	local rtext = ""
	local color = nil
	local k, v
			
	--<<setup header
	window.line.hline:SetText(L["Main City"])

	--<<merge body message
	local repuSta
	for k, v in pairs(x.pMainCityRepu) do
		color = c.white
		if v[2] == 8 then
			repuSta = getglobal("FACTION_STANDING_LABEL" .. v[2])
			color = c.springgreen
		else
			repuSta = (v[5] - v[3]) .. " / "
			repuSta = repuSta .. (v[4] - v[3]) .. " "
			repuSta = repuSta .. getglobal("FACTION_STANDING_LABEL" .. v[2])
		end
		if k == 1 then
			mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, false, v[1], repuSta, color)
		else
			mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, true, v[1], repuSta, color)
		end
	end
--p	local ic = x.pIC
--p	local icTotal = 0
--p	for i = 5, 6, 1 do
--p		for j, u in pairs(ic[i]) do
--p			icTotal = icTotal + u[2]
--p		end
--p	end
--p	mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, true, L["Main City Tabard"], icTotal)

	self:AdjWin(window, mtext, ltext, rtext)
end


--//////////
--<<archaeology
Zero2Max.MainFrame.WriteMessageProfAr = function(self, window)
	local x = Zero2Max.Player
	local c = Zero2Max.COLOR
	local mtext = ""
	local ltext = ""
	local rtext = ""
	local color = nil
	local cend = "|r"
	local nl = "\n"
	local ttext = ""
	local stext = ""
	local tempskill = nil

	--<<setup header
	stext = C_TradeSkillUI.GetTradeSkillDisplayName(794)
	window.line.hline:SetText(stext)

	--<<merge body message
	tempSkill = x.pPro5
	if tempSkill == nil then
		mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, false, L["Unlearned"], " ", c.red)

		if Zero2Max.displayColor then
			local dc = Zero2Max.colorProf
			window:SetBackdropBorderColor(dc[1], dc[2], dc[3], dc[4])
			self:AdjWinColor(window, dc[5], dc[6], dc[7], dc[8])
		end

	else
		if tempSkill[4] > 0 then
			ttext = tempSkill[2] .. c.springgreen .. "+" .. tempSkill[4] .. cend
		else
			ttext = tempSkill[2]
		end
		if tempSkill[2] ~= tempSkill[3] then
			ttext = ttext .. " / " .. tempSkill[3]
		end
		if (tempSkill[2] == tempSkill[3]) and (tempSkill[2] > 0) then
			color = c.springgreen
		end
		mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, false, tempSkill[1], ttext, color)
	end

	self:AdjWin(window, mtext, ltext, rtext)
	window:Show()
end


--//////////
--<<profession 1, 2, 3, 4
Zero2Max.MainFrame.WriteMessageProf = function(self, window, prof)
	local x = Zero2Max.Player
	local c = Zero2Max.COLOR
	local mtext = ""
	local ltext = ""
	local rtext = ""
	local color = nil
	local cend = "|r"
	local nl = "\n"
	local k, v
	local ttext = ""
	local stext = ""
	local tempname = nil
	local tempskill = nil
	local tempdetail = nil
	local tempspec = nil

	if     prof == 1 then
		tempskill = x.pPro1
		tempdetail = x.pProDetail1
		tempspec = x.pProSpec1
		stext = L["Profession 1"]
		if x.pPro1 ~= nil then
			stext = x.pPro1[1]
		end
	elseif prof == 2 then
		tempskill = x.pPro2
		tempdetail = x.pProDetail2
		tempspec = x.pProSpec2
		stext = L["Profession 2"]
		if x.pPro2 ~= nil then
			stext = x.pPro2[1]
		end
	elseif prof == 3 then
		tempskill = x.pPro3
		tempdetail = x.pProDetail3
		tempspec = nil
		stext = C_TradeSkillUI.GetTradeSkillDisplayName(185)
	elseif prof == 4 then
		tempskill = x.pPro4
		tempdetail = x.pProDetail4
		tempspec = nil
		stext = C_TradeSkillUI.GetTradeSkillDisplayName(356)
	end

	--<<setup header
	window.line.hline:SetText(stext)

	--<<merge body message
	if tempskill == nil then
		mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, false, L["Unlearned"], " ", c.red)

		if Zero2Max.displayColor then
			local dc = Zero2Max.colorProf
			window:SetBackdropBorderColor(dc[1], dc[2], dc[3], dc[4])
			self:AdjWinColor(window, dc[5], dc[6], dc[7], dc[8])
		end

		self:AdjWin(window, mtext, ltext, rtext)
		window:Show()
		return
	end

	if x.pProGet then
		for k, v in pairs(tempdetail) do
			color = nil
			if v[2] == 0 then
				ttext = L["Unlearned"]
				color = c.red
			else
				if v[4] > 0 then
					ttext = v[2] .. c.springgreen .. "+" .. v[4] .. cend
				else
					ttext = v[2]
				end
				if v[2] ~= v[3] then
					ttext = ttext .. " / " ..v[3]
				else
					color = c.springgreen
				end
			end
			if k == 1 then
				mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, false, v[1], ttext, color)
			else
				mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, true, v[1], ttext, color)
			end
		end
	else
		if tempskill[4] > 0 then
			ttext = tempskill[2] .. c.springgreen .. "+" .. tempskill[4] .. cend
		else
			ttext = tempskill[2]
		end
		if tempskill[2] ~= tempskill[3] then
			ttext = ttext .. " / " .. tempskill[3]
		end
		if (tempskill[2] == tempskill[3]) and (tempskill[2] > 0) then
			color = c.springgreen
		end
		if tempskill[6] ~= nil then
			tempname = tempskill[6]
		else
			tempname = tempskill[1]
		end
		mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, false, tempname, ttext, color)
		mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, true, "< " .. L["No Data"] .. " >", " ", c.yellow)
	end

	--<<professional gear
	mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, true)
	local eslot = {} 
	eslot[1]  = {1, 20, PROF0TOOLSLOT}
	eslot[2]  = {1, 21, PROF0GEAR0SLOT}
	eslot[3]  = {1, 22, PROF0GEAR1SLOT}
	eslot[4]  = {2, 23, PROF1TOOLSLOT}
	eslot[5]  = {2, 24, PROF1GEAR0SLOT}
	eslot[6]  = {2, 25, PROF1GEAR1SLOT}
	eslot[7]  = {3, 26, COOKINGTOOLSLOT}
	eslot[8]  = {3, 27, COOKINGGEAR0SLOT}
	eslot[9]  = {4, 28, FISHINGTOOLSLOT}
--	eslot[10] = {4, 29, FISHINGGEAR0SLOT}
--	eslot[11] = {4, 30, FISHINGGEAR1SLOT}

	for k, v in pairs(eslot) do
		if prof == v[1] then
			local itemLoc = ItemLocation:CreateFromEquipmentSlot(v[2])
			if not itemLoc:IsValid() then
				mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, true, v[3], L["Nil"], c.red)
			else
				local cILvl = C_Item.GetCurrentItemLevel(itemLoc)
				local iLink = C_Item.GetItemLink(itemLoc)
				local iName, _, iQual = GetItemInfo(iLink)
				color = c.itemquality[iQual]
				mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, true, iName, cILvl, color)
			end
		end
	end

	--<<professional knowledge
	color = c.white
	if  tempskill[8] ~= nil then
		mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, true)
		for k, v in pairs(tempskill[8]) do


			if tempspec ~= nil then
				if tempspec[k] ~= nil then
					local tempspecsk = C_TradeSkillUI.GetProfessionInfoBySkillLineID(tempspec[k][1])
					local tempspecname = tempspecsk.professionName
					local tempspecstatus = tempspec[k][3] .. " / " .. tempspec[k][4]
					mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, true, tempspecname, tempspecstatus, c.white)
				end
			end


			local currInfo = C_CurrencyInfo.GetCurrencyInfo(v)
			if currInfo.quantity > 0 then
				color = c.red
			else
				color = c.white
			end
			mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, true, currInfo.name, currInfo.quantity, color)
		end
	end

	--<<special skill
	if  tempskill[7] ~= nil then
		mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, true)
		mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, true, tempskill[7], " ", c.lightgold)
	end

	--<<fish tracing
	color = c.white
	if prof == 4 then
		mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, true)
		local trackNum = C_Minimap.GetNumTrackingTypes()
		local trackFish = 0
		for i = 1, trackNum do
			local trackInfo = C_Minimap.GetTrackingInfo(i)
			if (trackInfo ~= nil) and (trackInfo.spellID ~= nil) and (trackInfo.spellID == 43308) then
				trackFish = 1
			end
		end
		local sp_name = C_Spell.GetSpellName(43308)
		if trackFish == 0 then
			mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, true, sp_name, L["Nil"], c.red)
		else
			mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, true, sp_name, L["Done"], color)
		end
	end

	self:AdjWin(window, mtext, ltext, rtext)
	window:Show()
end


--//////////
--<<empty
Zero2Max.MainFrame.WriteMessageEmpty = function(self, win1, win2, win3, win4)
	local htext = "Header"
	local mtext = ""
	local ltext = ""
	local rtext = ""
	mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, false, "Left", "Right")

	if win1 ~= nil then
		--<<setup header
		win1.line.hline:SetText(htext)
		--<<merge body message
		self:AdjWin(win1, mtext, ltext, rtext)
		win1:Hide()
	end
	if win2 ~= nil then
		--<<setup header
		win2.line.hline:SetText(htext)
		--<<merge body message
		self:AdjWin(win2, mtext, ltext, rtext)
		win2:Hide()
	end
	if win3 ~= nil then
		--<<setup header
		win3.line.hline:SetText(htext)
		--<<merge body message
		self:AdjWin(win3, mtext, ltext, rtext)
		win3:Hide()
	end
	if win4 ~= nil then
		--<<setup header
		win4.line.hline:SetText(htext)
		--<<merge body message
		self:AdjWin(win4, mtext, ltext, rtext)
		win4:Hide()
	end
end


--//////////
--<<Group 3
Zero2Max.MainFrame.WriteMessageGroup3 = function(self, window, message)
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
	local lonly = false

	if message == "currency" then
		--<<setup header
		window.line.hline:SetText(L["Currency"])

		--Resonance Crystals
		currInfo = C_CurrencyInfo.GetCurrencyInfo(2815)
		mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, false, currInfo.name, BreakUpLargeNumbers(currInfo.quantity))
		--Kej
		currInfo = C_CurrencyInfo.GetCurrencyInfo(3056)
		mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, true, currInfo.name, BreakUpLargeNumbers(currInfo.quantity))

		mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, true)

		--Dragon Isles Supplies
		currInfo = C_CurrencyInfo.GetCurrencyInfo(2003)
		mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, true, currInfo.name, BreakUpLargeNumbers(currInfo.quantity))

		mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, true)

		--Reservoir Anima
		currInfo = C_CurrencyInfo.GetCurrencyInfo(1813)
		mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, true, currInfo.name, BreakUpLargeNumbers(currInfo.quantity))
		--Grateful Offering
		currInfo = C_CurrencyInfo.GetCurrencyInfo(1885)
		mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, true, currInfo.name, BreakUpLargeNumbers(currInfo.quantity))
		--Stygia
		currInfo = C_CurrencyInfo.GetCurrencyInfo(1767)
		mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, true, currInfo.name, BreakUpLargeNumbers(currInfo.quantity))
		--Cataloged Research
		currInfo = C_CurrencyInfo.GetCurrencyInfo(1931)
		mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, true, currInfo.name, BreakUpLargeNumbers(currInfo.quantity))
		--Cyphers of the First Ones
		currInfo = C_CurrencyInfo.GetCurrencyInfo(1979)
		mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, true, currInfo.name, BreakUpLargeNumbers(currInfo.quantity))

		mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, true)

		--War Resources
		currInfo = C_CurrencyInfo.GetCurrencyInfo(1560)
		mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, true, currInfo.name, BreakUpLargeNumbers(currInfo.quantity))
		if x.pFactI == 1 then
			--7th Legion Service Medal
			currInfo = C_CurrencyInfo.GetCurrencyInfo(1717)
			mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, true, currInfo.name, BreakUpLargeNumbers(currInfo.quantity))
		else
			--Honorbound Service Medal
			currInfo = C_CurrencyInfo.GetCurrencyInfo(1716)
			mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, true, currInfo.name, BreakUpLargeNumbers(currInfo.quantity))
		end
		--Seafarer's Dubloon
		currInfo = C_CurrencyInfo.GetCurrencyInfo(1710)
		mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, true, currInfo.name, BreakUpLargeNumbers(currInfo.quantity))
		--Prismatic Manapearl
		currInfo = C_CurrencyInfo.GetCurrencyInfo(1721)
		mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, true, currInfo.name, BreakUpLargeNumbers(currInfo.quantity))

		mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, true)

		--Order Resources
		currInfo = C_CurrencyInfo.GetCurrencyInfo(1220)
		mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, true, currInfo.name, BreakUpLargeNumbers(currInfo.quantity))
		--Nethershard
		currInfo = C_CurrencyInfo.GetCurrencyInfo(1226)
		mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, true, currInfo.name, BreakUpLargeNumbers(currInfo.quantity))
		--Legionfall War Supplies
		currInfo = C_CurrencyInfo.GetCurrencyInfo(1342)
		mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, true, currInfo.name, BreakUpLargeNumbers(currInfo.quantity))
		--Veiled Argunite
		currInfo = C_CurrencyInfo.GetCurrencyInfo(1508)
		mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, true, currInfo.name, BreakUpLargeNumbers(currInfo.quantity))

		mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, true)

		--Garrison Resources
		currInfo = C_CurrencyInfo.GetCurrencyInfo(824)
		mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, true, currInfo.name, BreakUpLargeNumbers(currInfo.quantity))
		--Oil
		currInfo = C_CurrencyInfo.GetCurrencyInfo(1101)
		mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, true, currInfo.name, BreakUpLargeNumbers(currInfo.quantity))
	end


	if message == "currencyPvP" then
		--<<setup header
		window.line.hline:SetText(L["Currency PvP"])

		--Honor
		currInfo = C_CurrencyInfo.GetCurrencyInfo(1792)
		mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, false, currInfo.name, BreakUpLargeNumbers(currInfo.quantity))
		--Conquest
		currInfo = C_CurrencyInfo.GetCurrencyInfo(1602)
		mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, true, currInfo.name, BreakUpLargeNumbers(currInfo.quantity))
		--Bloody Tokens
		currInfo = C_CurrencyInfo.GetCurrencyInfo(2123)
		mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, true, currInfo.name, BreakUpLargeNumbers(currInfo.quantity))
	end


	if	(message == "renown_12") or 
		(message == "renown_11") or
		(message == "renown_10") then

		local function renownCheck(expansion)
			local mtext  = ""
			local ltext  = ""
			local rtext  = ""
			local notNew = false
			local temp   = expansion - 1
			local mFtable = C_MajorFactions.GetMajorFactionIDs(temp)
			for k, v in pairs(mFtable) do
				local majorFactions = C_MajorFactions.GetMajorFactionData(v)
				if majorFactions == nil then
					ltext = self.AddL(ltext, true, "No data")
					mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, notNew, "No data", " ")
				else
					local mFname = majorFactions.name
					local mFlvl  = majorFactions.renownLevel
					local mFEarn = majorFactions.renownReputationEarned
					local mFThre = majorFactions.renownLevelThreshold
					if C_MajorFactions.HasMaximumRenown(v) then
						mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, notNew, mFname, mFlvl, c.springgreen)
					else
						mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, notNew, mFname, "( " .. mFEarn - mFThre .. " ) " .. mFlvl)
					end
				end
				notNew = true
			end
	
			local fList = Zero2Max.EXPANSION_FRIEND[expansion]
			for k, v in pairs(fList) do
				local f1 = C_GossipInfo.GetFriendshipReputationRanks(v)
				local f2 = C_GossipInfo.GetFriendshipReputation(v)
				if f1.currentLevel == f1.maxLevel then
					mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, notNew, f2.name, f2.reaction, c.springgreen)
				else
					local tm1 = "( - " .. f2.nextThreshold - f2.standing .. " )"
					local tm2 = f1.currentLevel .. " / " .. f1.maxLevel
					local tm3 = tm1 .. " " .. tm2 .. " " .. f2.reaction
					mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, notNew, f2.name, tm3)
				end
			end
	
			local rList = Zero2Max.EXPANSION_REPUTATION[expansion]
			for k, v in pairs(rList) do
				local r1 = C_Reputation.GetFactionDataByID(v)
				local tm1 = getglobal("FACTION_STANDING_LABEL" .. r1.reaction)
				if r1.reaction == 8 then
					mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, notNew, r1.name, tm1, c.springgreen)
				else
					local tm2 = "( - " .. r1.nextReactionThreshold - r1.currentStanding .. " ) " .. tm1
					mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, notNew, r1.name, tm2, c.white)
				end
			end
			return mtext, ltext, rtext
		end
	
		if message == "renown_12" then
			--<<setup header
			window.line.hline:SetText(L["Midnight"])
			mtext, ltext, rtext = renownCheck(12)
		end
	
		if message == "renown_11" then
			--<<setup header
			window.line.hline:SetText(L["The War Within"])
			mtext, ltext, rtext = renownCheck(11)
		end
	
		if message == "renown_10" then
			--<<setup header
			window.line.hline:SetText(L["Dragonflight"])
			mtext, ltext, rtext = renownCheck(10)
		end
	end


	if message == "macro" then
		lonly = true
		--<<setup header
		window.line.hline:SetText(L["Specific Macro"])

		notNew = false
		_, macNum = GetNumMacros()
		if macNum == nil then
			mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, notNew, L["Nil"], " ")
			hl = 2
		elseif macNum == 0 then
			mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, notNew, L["Nil"], " ")
			hl = 2
		else
			for k = 1, macNum, 1 do
				--macro slots 1 through 120 are general macros
				--macro slots 121 through 138 are per-character macros
				macName, _, macBody = GetMacroInfo(120 + k)
				mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, notNew, macName, " ", c.yellow)
				notNew = true
				if Zero2Max:CheckMacroUsed(macName) then
					mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, notNew, macBody, " ")
				else
					mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, notNew, macBody, " ", c.red)
				end
			end
		end
	end


	if message == "trace" then
		--<<setup header
		window.line.hline:SetText(L["Trace"])

		notNew = false
		local trackNum = C_Minimap.GetNumTrackingTypes()
		for i = 1, trackNum do
			color = c.white
			local trackInfo = C_Minimap.GetTrackingInfo(i)
			local temp1 = trackInfo.name
			local temp2 = ""
			if trackInfo.active then
				temp2 = L["Active"]
			else
				temp2 = L["Inactive"]
				color = c.red
			end
			mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, notNew, temp1, temp2, color)
			notNew = true
		end
	end


	if message == "equipmentset" then
		lonly = true
		--<<setup header
		window.line.hline:SetText(L["Equipment Set"])

		notNew = false
		local numEquipmentSets = C_EquipmentSet.GetNumEquipmentSets()
		local equipmentSetIDs = C_EquipmentSet.GetEquipmentSetIDs()
		if numEquipmentSets == 0 then
			mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, notNew, L["Nil"], " ")
			hl = 2
		else
			for k, v in pairs(equipmentSetIDs) do
				local name, _, _, _, _, _, _, _, _ = C_EquipmentSet.GetEquipmentSetInfo(v)
				mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, notNew, name, " ")
				notNew = true
			end
		end
	end


	if message == "outfit" then
		lonly = true
		--<<setup header
		window.line.hline:SetText(L["Outfit"])

		notNew = false
		local outfitID = C_TransmogOutfitInfo.GetOutfitsInfo()
		if (outfitID == nil) or (outfitID[1] == nil) then
			mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, notNew, L["Nil"], " ")
			hl = 2
		else
			for k, v in pairs(outfitID) do
				local outfitID = v.outfitID
				local name     = v.name
				mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, notNew, name, " ")
--p				mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, notNew, k .. " " .. outfitID, name)
				notNew = true
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

	self:AdjWin(window, mtext, ltext, rtext, lonly)
	window:Show()
end


--//////////
--<<Group Profession Specific

Zero2Max.MainFrame.WriteMessageProfSpec = function(self, window, message1, message2)
	local x = Zero2Max.Player
	local y = Zero2Max.PROF_TABLE
	local c = Zero2Max.COLOR
	local mtext = ""
	local ltext = ""
	local rtext = ""
	local color = nil
	local i = nil
	local v = nil
	local newln = false			-- new line
	local hl = 1				-- highlight background and border

	local proX		= nil
	local proDetail	= nil
	local proSpe	= nil

	if message1 == 2 then
		proX		= x.pPro2
		proDetail	= x.pProDetail2 
		proSpe		= x.pProSpec2
	else
		proX		= x.pPro1
		proDetail	= x.pProDetail1 
		proSpe		= x.pProSpec1
	end

	local tempTitle	= nil
	if message1 == 2 then
		tempTitle = L["Profession 2"]
	else
		tempTitle = L["Profession 1"]
	end
	if proX ~= nil then
		local skillLine  = proX[5]
		local skillLine2 = y[skillLine][message2]
		local skillLine3 = C_TradeSkillUI.GetProfessionInfoBySkillLineID(skillLine2)
		tempTitle = skillLine3.professionName
	end
	window.line.hline:SetText(tempTitle)

	notNew = false
	if proSpe ~= nil then
		for k, v in pairs(proSpe) do
			if k == message2 then
				local temp1 = C_TradeSkillUI.GetProfessionInfoBySkillLineID(v[1])
				local temp2 = temp1.professionName
				local temp3 = v[3] .. " / " .. v[4]
				if v[3] == v[4] then
					mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, notNew, temp2, temp3, c.springgreen)
				else
					mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, notNew, temp2, temp3)
				end
				notNew = true

				for i, j in pairs(v[2]) do
					mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, notNew, j.name, " ", c.lightblue)
					for o, p in pairs(j.list) do
						local temp4 = " - " .. p[1]
						local temp5 = p[2] .. " / " .. p[3]
						if p[2] == p[3] then
							mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, notNew, temp4, temp5, c.springgreen)
						else
							mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, notNew, temp4, temp5)
						end
					end
				end
			end
		end
	end
	if mtext == "" then
		mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, false, L["Unlearned"], " ", c.red)
		if Zero2Max.displayColor then
			local dc = Zero2Max.colorProf
			window:SetBackdropBorderColor(dc[1], dc[2], dc[3], dc[4])
			self:AdjWinColor(window, dc[5], dc[6], dc[7], dc[8])
		end
	end

	self:AdjWin(window, mtext, ltext, rtext)
	window:Show()
end


--//////////
--<<Group Explore
Zero2Max.MainFrame.WriteMessageExplore = function(self, window, message)
	local c = Zero2Max.COLOR
	local mtext = ""
	local ltext = ""
	local rtext = ""
	local color = nil
	local ach_name = nil
	local ach_complete = nil
	local ach_donebyme = nil
	local ach_donecheck = nil
	local temptable = nil
	local i = nil
	local v = nil
	local newln = false			-- new line
	local hl = 1				-- highlight background and border

	window.line.hline:SetText(L[Zero2Max.AREA[message]])

	temptable = Zero2Max.EXPLORE[message]
	for i, v in pairs(temptable) do
		_, ach_name, _, ach_complete, _, _, _, _, _, _, _, _, ach_donebyme = GetAchievementInfo(v)
		if ach_donebyme then
			ach_donecheck = L["Done"]
			color = c.springgreen
		else
			ach_donecheck = L["Unexplored"]
			if ach_complete then
				color = c.white
			else
				color = c.red
			end
			hl = 0
		end
		mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, newln, ach_name, ach_donecheck, color)
		newln = true
	end

	if Zero2Max.displayColor then
		if hl == 1 then
			local dc = Zero2Max.colorExplore
			window:SetBackdropBorderColor(dc[1], dc[2], dc[3], dc[4])
			self:AdjWinColor(window, dc[5], dc[6], dc[7], dc[8])
		end
	end

	self:AdjWin(window, mtext, ltext, rtext)
	window:Show()
end


--//////////
--<<Group Lore
Zero2Max.MainFrame.WriteMessageLore = function(self, window, message)
	local x = Zero2Max.Player
	local c = Zero2Max.COLOR
	local mtext = ""
	local ltext = ""
	local rtext = ""
	local color = nil
	local ach_name = nil
	local ach_complete = nil
	local ach_donebyme = nil
	local ach_donecheck = nil
	local temptable = nil
	local i = nil
	local v = nil
	local newln = false			-- new line
	local hl = 1				-- highlight background and border

	window.line.hline:SetText(L[Zero2Max.AREA[message]])

	if x.pFactI == 1 then
		temptable = Zero2Max.QUEST_ALLIANCE[message]
	else
		temptable = Zero2Max.QUEST_HORDE[message]
	end
	for i, v in pairs(temptable) do
		_, ach_name, _, ach_complete, _, _, _, _, _, _, _, _, ach_donebyme = GetAchievementInfo(v)
		if ach_donebyme then
			ach_donecheck = L["Done"]
			color = c.springgreen
		else
			ach_donecheck = L["Undone"]
			if ach_complete then
				color = c.white
			else
				color = c.red
			end
			hl = 0
		end
		mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, newln, ach_name, ach_donecheck, color)
		newln = true
	end

	if Zero2Max.displayColor then
		if hl == 1 then
			local dc = Zero2Max.colorLore
			window:SetBackdropBorderColor(dc[1], dc[2], dc[3], dc[4])
			self:AdjWinColor(window, dc[5], dc[6], dc[7], dc[8])
		end
	end

	self:AdjWin(window, mtext, ltext, rtext)
	window:Show()
end


--//////////
--<<Group Quest
Zero2Max.MainFrame.WriteMessageQuest = function(self, window1, window2, window3)
	local x = Zero2Max.Player
	local c = Zero2Max.COLOR
	local mtext = ""
	local ltext = ""
	local rtext = ""
	local color = nil
	local temptable = nil
	local i = nil
	local v = nil

	local mtext2, ltext2, rtext2 = "", "", ""
	local mtext3, ltext3, rtext3 = "", "", ""
	local tab    = ""
	local remark = ""
	local newln  = nil

	window1.line.hline:SetText(L["Quest"] .. " 1")
	window2.line.hline:SetText(L["Quest"] .. " 2")
	window3.line.hline:SetText(L["Quest"] .. " 3")

	local info        = {}
	local questlogmax = 30
	local questlogall = {}
	local questlog    = {}
	questlog[1]       = {}
	questlog[2]       = {}
	questlog[3]       = {}
	local needQuest2  = false
	local needQuest3  = false
	local numShownEntries = nil
	local numQuests       = nil
	numShownEntries, numQuests = C_QuestLog.GetNumQuestLogEntries()
	if (numShownEntries == nil) or (numShownEntries == 0) then
		mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, false, L["Quest"], L["Nil"])
		mtext2, ltext2, rtext2 = self.AddLR(mtext2, ltext2, rtext2, false, L["Quest"], L["Nil"])
		mtext3, ltext3, rtext3 = self.AddLR(mtext3, ltext3, rtext3, false, L["Quest"], L["Nil"])
	else
		for i = 1, numShownEntries do
			info = C_QuestLog.GetInfo(i)
			if not info.isHidden then
				if i > 1 then
					if info.isHeader then
						if questlogall[#questlogall].isHeader then
							local deleteheader = table.remove(questlogall)
						end
					end
				end
				questlogall[#questlogall + 1] = info
			end
		end
		for i = 1, #questlogall do
			if     i <= questlogmax then
				questlog[1][#questlog[1] + 1] = questlogall[i]
			elseif i <= (questlogmax * 2) then
				questlog[2][#questlog[2] + 1] = questlogall[i]
				needQuest2 = true
			else
				questlog[3][#questlog[3] + 1] = questlogall[i]
				needQuest3 = true
			end
		end
		for i, v in pairs(questlog[1]) do
			if v.questID == 0 then
				color  = c.yellow
				tab    = ""
				remark = " "
			else
				color = c.white
				tab   = "   "
				remark = " "
			--	remark = "(" .. v.questID .. ")"
			end
			if mtext == "" then
				newln = false
			else
				newln = true
			end

			local isComp = C_QuestLog.IsComplete(v.questID)
			if (isComp ~= nil) and isComp then
				color = c.green
			elseif (v.frequency ~= nil) and (v.frequency > 0) then
				color = c.lightblue
			elseif v.campaignID ~= nil then
				color = c.lightgold
			end

			mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, newln, tab .. v.title, remark, color)
		end
		if  not needQuest2 then
			mtext2, ltext2, rtext2 = self.AddLR(mtext2, ltext2, rtext2, false, L["Nil"], " ")
		else
			for i, v in pairs(questlog[2]) do
				if v.questID == 0 then
					color = c.yellow
					tab   = ""
					remark = " "
				else
					color = c.white
					tab   = "   "
					remark = " "
				--	remark = "(" .. v.questID .. ")"
				end
				if mtext2 == "" then
					newln = false
				else
					newln = true
				end

				local isComp = C_QuestLog.IsComplete(v.questID)
				if (isComp ~= nil) and isComp then
					color = c.green
				elseif (v.frequency ~= nil) and (v.frequency > 0) then
					color = c.lightblue
				elseif v.campaignID ~= nil then
					color = c.lightgold
				end

				mtext2, ltext2, rtext2 = self.AddLR(mtext2, ltext2, rtext2, newln, tab .. v.title, remark, color)
			end
		end
		if  not needQuest3 then
			mtext3, ltext3, rtext3 = self.AddLR(mtext3, ltext3, rtext3, false, L["Nil"], " ")
		else
			for i, v in pairs(questlog[3]) do
				if v.questID == 0 then
					color = c.yellow
					tab   = ""
					remark = " "
				else
					color = c.white
					tab   = "   "
					remark = " "
				--	remark = "(" .. v.questID .. ")"
				end
				if mtext3 == "" then
					newln = false
				else
					newln = true
				end

				local isComp = C_QuestLog.IsComplete(v.questID)
				if (isComp ~= nil) and isComp then
					color = c.green
				elseif (v.frequency ~= nil) and (v.frequency > 0) then
					color = c.lightblue
				elseif v.campaignID ~= nil then
					color = c.lightgold
				end

				mtext3, ltext3, rtext3 = self.AddLR(mtext3, ltext3, rtext3, newln, tab .. v.title, remark, color)
			end
		end
	end

	if Zero2Max.displayColor then
		local dc = Zero2Max.colorQuest
		if ltext == L["Nil"] then
			window1:SetBackdropBorderColor(dc[1], dc[2], dc[3], dc[4])
			self:AdjWinColor(window1, dc[5], dc[6], dc[7], dc[8])
		end
		if ltext2 == L["Nil"] then
			window2:SetBackdropBorderColor(dc[1], dc[2], dc[3], dc[4])
			self:AdjWinColor(window2, dc[5], dc[6], dc[7], dc[8])
		end
		if ltext3 == L["Nil"] then
			window3:SetBackdropBorderColor(dc[1], dc[2], dc[3], dc[4])
			self:AdjWinColor(window3, dc[5], dc[6], dc[7], dc[8])
		end
	end

	self:AdjWin(window1, mtext, ltext, rtext, true)
	self:AdjWin(window2, mtext2, ltext2, rtext2, true)
	self:AdjWin(window3, mtext3, ltext3, rtext3, true)
	window1:Show()
	window2:Show()
	window3:Show()
end


--//////////
--<<Group Quest2
Zero2Max.MainFrame.WriteMessageQuest2 = function(self, w1, w2, w3, w4, w5, w6, w7, w8, w9, w10, w11, w12)
	local x = Zero2Max.Player
	local c = Zero2Max.COLOR
	local e = Zero2Max.EXPANSION_TITLE
	local mtx = {}
	local ltx = {}
	local rtx = {}
	local cend = "|r"

	w1.line.hline:SetText(L[e[12]])
	w2.line.hline:SetText(L[e[11]])
	w3.line.hline:SetText(L[e[10]])
	w4.line.hline:SetText(L[e[9]])
	w5.line.hline:SetText(L[e[8]])
	w6.line.hline:SetText(L[e[7]])
	w7.line.hline:SetText(L[e[6]])
	w8.line.hline:SetText(L[e[5]])
	w9.line.hline:SetText(L[e[4]])
	w10.line.hline:SetText(L[e[3]])
	w11.line.hline:SetText(L[e[2]])
	w12.line.hline:SetText(L[e[1]])

	local info        = {}
	local questlogall = {}
	local questlog    = { {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {} }
	local numShownEntries = nil
	local numQuests       = nil
	numShownEntries, numQuests = C_QuestLog.GetNumQuestLogEntries()
	if (numShownEntries == nil) or (numShownEntries == 0) then
		-- display message if no content
		for j = 1, 12 do
			mtx[j], ltx[j], rtx[j] = self.AddLR(mtx[j], ltx[j], rtx[j], false, L["Nil"], " ")
		end
	else

		local keepHd = nil
		local hasHd  = false

		for i = 1, numShownEntries do
			info = C_QuestLog.GetInfo(i)
			if not info.isHidden then
				if i > 1 then
					if info.isHeader then
						if questlogall[#questlogall].isHeader then
							local deleteheader = table.remove(questlogall)
						end
					end
				end
				questlogall[#questlogall + 1] = info
			end
		end
		for i = 1, #questlogall do
			local qInfo = questlogall[i]
		--	info = C_QuestLog.GetInfo(i)
		--	if info.questID == 0 then
			if qInfo.questID == 0 then
				keepHd = qInfo
				hasHd  = true
			else
			--	local qExpan = GetQuestExpansion(info.questID)
				local qExpan = GetQuestExpansion(qInfo.questID)
				if hasHd then
					questlog[qExpan + 1][#questlog[qExpan + 1] + 1] = keepHd
					keepHd = nil
					hasHd  = false
				end
			--	questlog[qExpan + 1][#questlog[qExpan + 1] + 1] = info
				questlog[qExpan + 1][#questlog[qExpan + 1] + 1] = qInfo
			end
		end
		local j = 0
		for i = 12, 1, -1 do
			j = j + 1
			mtx[j], ltx[j], rtx[j] = "", "", ""
			local newln = false
			for i, v in pairs(questlog[i]) do
				local tmess1 = v.title
				if v.questID == 0 then
					if v.campaignID ~= nil then
						tmess1 = c.lightgold .. tmess1 .. cend
					else
						tmess1 = c.yellow .. tmess1 .. cend
					end
				else
					local isComp = C_QuestLog.IsComplete(v.questID)
					if (isComp ~= nil) and isComp then
						tmess1 = c.green .. tmess1 .. cend
					elseif (v.frequency ~= nil) and (v.frequency > 0) then
						tmess1 = c.lightblue .. tmess1 .. cend
					elseif v.campaignID ~= nil then
						tmess1 = c.lightgold .. tmess1 .. cend
					end
					tmess1 = "   " .. tmess1
				end
				mtx[j], ltx[j], rtx[j] = self.AddLR(mtx[j], ltx[j], rtx[j], newln, tmess1, " ")
				newln = true
			end
			-- display message if no content
			if mtx[j] == "" then
				mtx[j], ltx[j], rtx[j] = self.AddLR(mtx[j], ltx[j], rtx[j], newln, L["Nil"], " ")
			end
		end
	end

	if Zero2Max.displayColor then
		local dc = Zero2Max.colorQuest
		if ltx[1] == L["Nil"] then
			w1:SetBackdropBorderColor(dc[1], dc[2], dc[3], dc[4])
			self:AdjWinColor(w1, dc[5], dc[6], dc[7], dc[8])
		end
		if ltx[2] == L["Nil"] then
			w2:SetBackdropBorderColor(dc[1], dc[2], dc[3], dc[4])
			self:AdjWinColor(w2, dc[5], dc[6], dc[7], dc[8])
		end
		if ltx[3] == L["Nil"] then
			w3:SetBackdropBorderColor(dc[1], dc[2], dc[3], dc[4])
			self:AdjWinColor(w3, dc[5], dc[6], dc[7], dc[8])
		end
		if ltx[4] == L["Nil"] then
			w4:SetBackdropBorderColor(dc[1], dc[2], dc[3], dc[4])
			self:AdjWinColor(w4, dc[5], dc[6], dc[7], dc[8])
		end
		if ltx[5] == L["Nil"] then
			w5:SetBackdropBorderColor(dc[1], dc[2], dc[3], dc[4])
			self:AdjWinColor(w5, dc[5], dc[6], dc[7], dc[8])
		end
		if ltx[6] == L["Nil"] then
			w6:SetBackdropBorderColor(dc[1], dc[2], dc[3], dc[4])
			self:AdjWinColor(w6, dc[5], dc[6], dc[7], dc[8])
		end
		if ltx[7] == L["Nil"] then
			w7:SetBackdropBorderColor(dc[1], dc[2], dc[3], dc[4])
			self:AdjWinColor(w7, dc[5], dc[6], dc[7], dc[8])
		end
		if ltx[8] == L["Nil"] then
			w8:SetBackdropBorderColor(dc[1], dc[2], dc[3], dc[4])
			self:AdjWinColor(w8, dc[5], dc[6], dc[7], dc[8])
		end
		if ltx[9] == L["Nil"] then
			w9:SetBackdropBorderColor(dc[1], dc[2], dc[3], dc[4])
			self:AdjWinColor(w9, dc[5], dc[6], dc[7], dc[8])
		end
		if ltx[10] == L["Nil"] then
			w10:SetBackdropBorderColor(dc[1], dc[2], dc[3], dc[4])
			self:AdjWinColor(w10, dc[5], dc[6], dc[7], dc[8])
		end
		if ltx[11] == L["Nil"] then
			w11:SetBackdropBorderColor(dc[1], dc[2], dc[3], dc[4])
			self:AdjWinColor(w11, dc[5], dc[6], dc[7], dc[8])
		end
		if ltx[12] == L["Nil"] then
			w12:SetBackdropBorderColor(dc[1], dc[2], dc[3], dc[4])
			self:AdjWinColor(w12, dc[5], dc[6], dc[7], dc[8])
		end
	end

	self:AdjWin(w1, mtx[1], ltx[1], rtx[1], true)
	self:AdjWin(w2, mtx[2], ltx[2], rtx[2], true)
	self:AdjWin(w3, mtx[3], ltx[3], rtx[3], true)
	self:AdjWin(w4, mtx[4], ltx[4], rtx[4], true)
	self:AdjWin(w5, mtx[5], ltx[5], rtx[5], true)
	self:AdjWin(w6, mtx[6], ltx[6], rtx[6], true)
	self:AdjWin(w7, mtx[7], ltx[7], rtx[7], true)
	self:AdjWin(w8, mtx[8], ltx[8], rtx[8], true)
	self:AdjWin(w9, mtx[9], ltx[9], rtx[9], true)
	self:AdjWin(w10, mtx[10], ltx[10], rtx[10], true)
	self:AdjWin(w11, mtx[11], ltx[11], rtx[11], true)
	self:AdjWin(w12, mtx[12], ltx[12], rtx[12], true)
	w1:Show()
	w2:Show()
	w3:Show()
	w4:Show()
	w5:Show()
	w6:Show()
	w7:Show()
	w8:Show()
	w9:Show()
	w10:Show()
	w11:Show()
	w12:Show()
end


--//////////
--<<Group Kill
Zero2Max.MainFrame.WriteMessageKill = function(self, window, message)
	local c = Zero2Max.COLOR
	local mtext = ""
	local ltext = ""
	local rtext = ""
	local color = nil
	local stat_cnt = nil
	local stat_name = nil
	local temptable = nil
	local i = nil
	local v = nil

	window.line.hline:SetText(L[Zero2Max.EXPANSION_TITLE[message]])

	temptable = Zero2Max.KILL[message]
	for i, v in pairs(temptable) do
		stat_cnt = GetStatistic(v)
		_, stat_name = GetAchievementInfo(v)
		if stat_cnt == "--" then
			color = c.red
		else
			color = c.springgreen
		end
		if i == 1 then
			mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, false, stat_name, stat_cnt, color)
		else
			mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, true, stat_name, stat_cnt, color)
		end
	end

	self:AdjWin(window, mtext, ltext, rtext)
	window:Show()
end


--//////////
--<<Group Follower
Zero2Max.MainFrame.WriteMessageFollower = function(self, window, message)
	local x = Zero2Max.Player
	local c = Zero2Max.COLOR
	local f = Zero2Max.FOLLOWER_TYPE
	local mtext = ""
	local ltext = ""
	local rtext = ""
	local color = nil
	local i = nil
	local v = nil

	local followerMax    = f[message][4]
	local followerMaxLvl = f[message][6]
	if (message == 3) and ((x.pEnClass == "MAGE") or (x.pEnClass == "PALADIN")) then
		  followerMax = followerMax + 1
	end
	local info           = C_Garrison.GetFollowers(f[message][1])
	local funit          = f[message][3]
	local f_show_not_get = f[message][8]
	local f_show_lvl     = f[message][9]
	local f_show_ilvl    = f[message][10]
	local followerMaxI   = f[message][7]


	window.line.hline:SetText(L[f[message][2]])

	local t1_mtext  = ""
	local t1_ltext  = ""
	local t1_rtext  = ""
	local t2_mtext  = ""
	local t2_ltext  = ""
	local t2_rtext  = ""
	local t3_mtext  = ""
	local t3_ltext  = ""
	local t3_rtext  = ""
	local t4_mtext  = ""
	local t4_ltext  = ""
	local t4_rtext  = ""
	local tempmess  = ""
	local t1_cnt    = 0
	local t2_cnt    = 0
	local t3_cnt    = 0
	local t4_cnt    = 0

	local dispName  = nil
	local getAbil   = nil
	local j         = nil
	local k         = nil
	local dispAbil  = nil
	local dispAbilC = nil
	local cend = "|r"
	local nl = "\n"
	local hl = 1

	if info == nil then
		mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, false, L["Nil"], " ")
		hl = 0
	else
		for i, v in pairs(info) do
			dispName = v.name
			if not v.isCollected then
				if f_show_not_get then
					tempmess = L["Not Yet Recruited"]
					if t4_mtext ~= "" then
						t4_mtext = t4_mtext .. nl
						t4_ltext = t4_ltext .. nl
						t4_rtext = t4_rtext .. nl
					end
					t4_mtext, t4_ltext, t4_rtext = self.AddLR(t4_mtext, t4_ltext, t4_rtext, false, dispName, tempmess, c.red)
					t4_cnt = t4_cnt + 1
				end
			else
				--<<quality
				dispName = c.itemquality[v.quality] .. dispName .. cend
				--<<status
				if v.status ~= nil then
					dispName = c.pink .. v.status .. " - " .. cend .. dispName
				end
				--<<level
				tempmess = ""
				if (not v.isTroop) and f_show_lvl then
					tempmess = v.level
					if not v.isMaxLevel then
						tempmess = tempmess .. " / " .. followerMaxLvl
					end
				end
				--<<ilevel
				if (not v.isTroop) and f_show_ilvl then
					if tempmess ~= "" then
						tempmess = " " .. tempmess
					end
					if v.iLevel ~= followerMaxI then
						tempmess = " / i" .. followerMaxI .. tempmess
					end
					tempmess = "i" .. v.iLevel .. tempmess
				end
				--<<quality2
				if tempmess ~= "" then
					tempmess = c.itemquality[v.quality] .. tempmess .. cend
				end

				if v.isTroop then
					if t3_mtext ~= "" then
						t3_mtext = t3_mtext .. nl
						t3_ltext = t3_ltext .. nl
						t3_rtext = t3_rtext .. nl
					end
					t3_mtext, t3_ltext, t3_rtext = self.AddLR(t3_mtext, t3_ltext, t3_rtext, false, dispName, tempmess)
					t3_cnt = t3_cnt + 1
				else
					--<<get ability
					if (message == 2 or message == 3 or message == 4) then
						getAbil = C_Garrison.GetFollowerAbilities(v.followerID)
						dispAbil  = ""
						dispAbilC = ""
						for j, k in pairs(getAbil) do
							if (k.isTrait and (message == 3 or message == 4))
							or (not k.isTrait and message == 2) then
								if k.isEmptySlot then
									dispAbil = dispAbil .. dispAbilC .. c.red.. k.name .. cend
								else
									dispAbil = dispAbil .. dispAbilC .. k.name
								end
								dispAbilC = " / "
							end
						end
						if dispAbil ~= "" then
							if tempmess ~= "" then
								tempmess = " " .. tempmess
							end
							tempmess = dispAbil .. tempmess
						end
					end

					if t1_mtext ~= "" then
						t1_mtext = t1_mtext .. nl
						t1_ltext = t1_ltext .. nl
						t1_rtext = t1_rtext .. nl
					end
					t1_mtext, t1_ltext, t1_rtext = self.AddLR(t1_mtext, t1_ltext, t1_rtext, false, dispName, tempmess)
					t1_cnt = t1_cnt + 1
				end

			end
		end
		if (t1_cnt + t3_cnt + t4_cnt) == 0 then
			mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, false, L["Nil"], " ")
			hl = 0
		else
			if t1_cnt > 0 then
				mtext = mtext .. t1_mtext
				ltext = ltext .. t1_ltext
				rtext = rtext .. t1_rtext
			end
			if t4_cnt > 0 then
				if mtext ~= "" then
					mtext = mtext .. nl
					ltext = ltext .. nl
					rtext = rtext .. nl
				end
				mtext = mtext .. t4_mtext
				ltext = ltext .. t4_ltext
				rtext = rtext .. t4_rtext
			end
			if t3_cnt > 0 then
				if mtext ~= "" then
					mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, true)
					mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, true, L["Troop"], " ", c.yellow)
				else
					mtext, ltext, rtext = self.AddLR(mtext, ltext, rtext, false, L["Troop"], " ", c.yellow)
				end
				mtext = mtext .. nl .. t3_mtext
				ltext = ltext .. nl .. t3_ltext
				rtext = rtext .. nl .. t3_rtext
			end
			--<<adjust header message
			if t1_cnt > 0 then
				if t1_cnt == followerMax then
					tempmess = t1_cnt
					if message == 1 then
						tempmess = "Show " .. followerMax .. " only"
					end
				else
					tempmess = t1_cnt .. " / " .. followerMax
					if message == 1 then
						tempmess = t1_cnt .. " / Show " .. followerMax .. " only"
					end
				end
				window.line.hline:SetText(L[f[message][2]] .. " " .. L[funit] .. " ( " .. tempmess .. " )")
			end

		end
	end

	if Zero2Max.displayColor then
		if hl == 0 then
			local dc = Zero2Max.colorFollower
			window:SetBackdropBorderColor(dc[1], dc[2], dc[3], dc[4])
			self:AdjWinColor(window, dc[5], dc[6], dc[7], dc[8])
		end
	end

	self:AdjWin(window, mtext, ltext, rtext)
	window:Show()
end


--//////////
--<<Spellbook
Zero2Max.MainFrame.WriteMessageSpell = function(self, window1, window2, window3, window4, window5, window6, window7, window8)
	local c = Zero2Max.COLOR
	local cend = "|r"
	local mt, lt, rt, ht = {}, {}, {}, {}
	
	local sListH  = {}
	local sList   = {}
	local sI      = 0
	local sStart  = 0
	local sEnd    = 0
	local sCnt    = 0
	local wMax    = 25

	local numTabs = C_SpellBook.GetNumSpellBookSkillLines()	
	for i = 1, numTabs, 1 do
		local sTabInfo = C_SpellBook.GetSpellBookSkillLineInfo(i)
		sTabName = sTabInfo.name
		sOffset  = sTabInfo.itemIndexOffset
		sSlot    = sTabInfo.numSpellBookItems	
		sOffSpec = sTabInfo.offSpecID
		if sOffSpec == nil then
			sI     = sI + 1
			sStart = 1
			sEnd   = 0
			sCnt   = 0
			sListH[sI] = {sTabName, sOffset, sSlot, sOffSpec, sStart, 0}
			sList[sI]  = {}
			for j = sOffset + 1, sOffset + sSlot, 1 do
				local sType              = C_SpellBook.GetSpellBookItemInfo(j, 0)
				local temp1 = sType.name

				if (sType.isPassive ~= nil) and sType.isPassive then
					temp1 = c.green .. L["Passive"] .. cend .. " " .. temp1
				end
				if sType.itemType == 4 then		-- flyout
					temp1 = c.lightblue .. L["Menu"] .. cend .. " " .. temp1
				end
				if sType.itemType == 2 then		-- future spell
					temp1 = c.red .. L["Unlearned"] .. cend .. " " .. temp1
				end

				local temp2 = ""
				if (sType.subName ~= nil) and (sType.subName ~= "") then
					temp2 = c.lightgold .. sType.subName .. cend
				end

				sCnt = sCnt + 1
				sEnd = sEnd + 1
				sList[sI][#sList[sI] + 1] = {temp1, temp2}
				if sEnd == sSlot then
					sListH[sI][6] = sEnd
				else
					if sCnt == wMax then
						sListH[sI][6] = sEnd
						sI         = sI + 1
						sListH[sI] = {sTabName, sOffset, sSlot, sOffSpec, sEnd + 1, 0}
						sList[sI]  = {}
						sCnt       = 0
					end
				end

			end
		end
	end

	for j = 1, sI, 1 do
		mt[j], lt[j], rt[j] = "", "", ""
		local notNew = false
		if (sList[j] ~= nil) and (sList[j] ~= {}) then
			for i, v in pairs(sList[j]) do
				mt[j], lt[j], rt[j] = self.AddLR(mt[j], lt[j], rt[j], notNew, v[1], v[2])
				notNew = true
			end
			if (sListH[j][5] == 1) and (sListH[j][6] == sListH[j][3]) then
				ht[j] = sListH[j][1] .. " ( " .. sListH[j][3] .. " )" 
			else
				ht[j] = sListH[j][1] .. " ( " .. sListH[j][5] .. " - " .. sListH[j][6] .. " )" 
			end
		end
	end

	for j = sI + 1, 8, 1 do
		mt[j], lt[j], rt[j] = "", "", ""
		local notNew = false
		mt[j], lt[j], rt[j] = self.AddLR(mt[j], lt[j], rt[j], notNew, "Left", "Right")
		ht[j] = "Header"
	end

	window1.line.hline:SetText(ht[1])
	window2.line.hline:SetText(ht[2])
	window3.line.hline:SetText(ht[3])
	window4.line.hline:SetText(ht[4])
	window5.line.hline:SetText(ht[5])
	window6.line.hline:SetText(ht[6])
	window7.line.hline:SetText(ht[7])
	window8.line.hline:SetText(ht[8])
	self:AdjWin(window1, mt[1], lt[1], rt[1])
	self:AdjWin(window2, mt[2], lt[2], rt[2])
	self:AdjWin(window3, mt[3], lt[3], rt[3])
	self:AdjWin(window4, mt[4], lt[4], rt[4])
	self:AdjWin(window5, mt[5], lt[5], rt[5])
	self:AdjWin(window6, mt[6], lt[6], rt[6])
	self:AdjWin(window7, mt[7], lt[7], rt[7])
	self:AdjWin(window8, mt[8], lt[8], rt[8])
	if sI >= 1 then
		window1:Show()
	else
		window1:Hide()
	end
	if sI >= 2 then
		window2:Show()
	else
		window2:Hide()
	end
	if sI >= 3 then
		window3:Show()
	else
		window3:Hide()
	end
	if sI >= 4 then
		window4:Show()
	else
		window4:Hide()
	end
	if sI >= 5 then
		window5:Show()
	else
		window5:Hide()
	end
	if sI >= 6 then
		window6:Show()
	else
		window6:Hide()
	end
	if sI >= 7 then
		window7:Show()
	else
		window7:Hide()
	end
	if sI >= 8 then
		window8:Show()
	else
		window8:Hide()
	end
end


--//////////
--<<Appearance Set
Zero2Max.MainFrame.WriteMessageAppSet = function(self, range, win1, win2, win3, win4, win5, win6, win7, win8)
	local c = Zero2Max.COLOR
	local z = Zero2Max.EXPANSION_TITLE
	local showUnColOnly = not Zero2Max.boardOpt[5][1]
	local color = nil
	local cend = "|r"
	local mt, lt, rt, ht = {}, {}, {}, {}
	local wSet = {}

	local tEnMax = 25

	local lowBar, highBar, winNum, offSet = 0, 0, 0, 0
	if     range == 1 then
		lowBar  = 0
		highBar = 3
		winNum  = 4
		offSet  = 0
	elseif range == 2 then
		lowBar  = 4
		highBar = 4
		winNum  = 1
		offSet  = 4
	elseif range == 3 then
		lowBar  = 5
		highBar = 6
		winNum  = 2
		offSet  = 5
	elseif range == 4 then
		lowBar  = 7
		highBar = 7
		winNum  = 1
		offSet  = 7
		tEnMax 	= 20		--balance window
	elseif range == 5 then
		lowBar  = 8
		highBar = 8
		winNum  = 1
		offSet  = 8
		tEnMax 	= 22		--balance window
	elseif range == 6 then
		lowBar  = 9
		highBar = 9
		winNum  = 1
		offSet  = 9
		tEnMax 	= 18		--balance window
	elseif range == 7 then
		lowBar  = 10
		highBar = 10
		winNum  = 1
		offSet  = 10
	end

	for j = 1, 12, 1 do
		mt[j], lt[j], rt[j] = "", "", ""
		local notNew = false
		mt[j], lt[j], rt[j] = self.AddLR(mt[j], lt[j], rt[j], notNew, "Left", "Right")
		ht[j] = "Header"
		wSet[j] = {}
	end

	local bSet = {}
	local aSet = C_TransmogSets.GetBaseSets()
	for i, v in pairs(aSet) do
		if (v.expansionID >= lowBar) and (v.expansionID <= highBar) then  
			if (showUnColOnly and not v.collected) or (not showUnColOnly) then
				bSet[#bSet + 1] = { v.setID, v.name, v.description, v.label, v.expansionID, v.collected, v.classMask }
			end
			local cSet = C_TransmogSets.GetVariantSets(v.setID)
			for j, u in pairs(cSet) do
				if (showUnColOnly and not u.collected) or (not showUnColOnly) then
					bSet[#bSet + 1] = { u.setID, u.name, u.description, u.label, u.expansionID, u.collected, u.classMask }
				end
			end
		end
	end

	for i, v in pairs(bSet) do
		local primApp = C_TransmogSets.GetSetPrimaryAppearances(v[1])
		local cntSet = 0
		local cntGet = 0
		for j, u in pairs(primApp) do
			if u.collected then
				cntGet = cntGet + 1
			end
			cntSet = cntSet + 1
		end
		if cntSet == cntGet then
			bSet[i][8] = cntSet
		else
			bSet[i][8] = cntGet .. " / " .. cntSet
		end
	end

	for i, v in pairs(bSet) do
		local tableID = v[5] + 1 - offSet
		wSet[tableID][#wSet[tableID] + 1] = v
	end

	local tdx = 0
	for j = 1, 8, 1 do
		tdx = tdx + 1
		--<<set table header
		if z[j + offSet] ~= nil then
			ht[tdx] = L[z[j + offSet]]
		else
			ht[tdx] = "Header"
		end
		--<<set table entry
		mt[tdx], lt[tdx], rt[tdx] = "", "", ""
		local eCnt = 0
		local notNew = false
		for i, v in pairs(wSet[j]) do
			local temp1 = v[2]
			if v[3] ~= nil then
				temp1 = temp1 .. " - " .. v[3]
			end
			if v[4] ~= nil then
				temp1 = v[4] .. " " .. temp1
			end
			local temp2 = v[8]
			if 	v[6] then
				color = c.springgreen
			else
				color = c.red
			end
			eCnt = eCnt + 1
			if eCnt > tEnMax then
				tdx = tdx + 1
				ht[tdx] = ht[tdx - 1]
				mt[tdx], lt[tdx], rt[tdx] = "", "", ""
				eCnt = 1
				notNew = false
				winNum = winNum + 1
			end
			mt[tdx], lt[tdx], rt[tdx] = self.AddLR(mt[tdx], lt[tdx], rt[tdx], notNew, temp1, temp2, color)
			notNew = true
		end
	end

	win1.line.hline:SetText(ht[1])
	win2.line.hline:SetText(ht[2])
	win3.line.hline:SetText(ht[3])
	win4.line.hline:SetText(ht[4])
	win5.line.hline:SetText(ht[5])
	win6.line.hline:SetText(ht[6])
	win7.line.hline:SetText(ht[7])
	win8.line.hline:SetText(ht[8])
	self:AdjWin(win1, mt[1], lt[1], rt[1])
	self:AdjWin(win2, mt[2], lt[2], rt[2])
	self:AdjWin(win3, mt[3], lt[3], rt[3])
	self:AdjWin(win4, mt[4], lt[4], rt[4])
	self:AdjWin(win5, mt[5], lt[5], rt[5])
	self:AdjWin(win6, mt[6], lt[6], rt[6])
	self:AdjWin(win7, mt[7], lt[7], rt[7])
	self:AdjWin(win8, mt[8], lt[8], rt[8])
	if winNum >= 1 then
		win1:Show()
	else
		win1:Hide()
	end
	if winNum >= 2 then
		win2:Show()
	else
		win2:Hide()
	end
	if winNum >= 3 then
		win3:Show()
	else
		win3:Hide()
	end
	if winNum >= 4 then
		win4:Show()
	else
		win4:Hide()
	end
	if winNum >= 5 then
		win5:Show()
	else
		win5:Hide()
	end
	if winNum >= 6 then
		win6:Show()
	else
		win6:Hide()
	end
	if winNum >= 7 then
		win7:Show()
	else
		win7:Hide()
	end
	if winNum >= 8 then
		win8:Show()
	else
		win8:Hide()
	end
end
