local _, addonTable = ...
local L = addonTable.GetLocale()

Zero2Max.Player = {
	--//////////
	pMaxLevel = _G.MAX_PLAYER_LEVEL,
	
	--//////////
	pCharacter			= nil,		-- Faction + Gender + Race + Class

	pFaction 			= nil,		-- Faction
	pEnFaction 			= nil,		-- Faction in English
	pFactI 				= nil,		-- For table use, 1 - Alliance, 2 - Horde
	pGender 			= nil,		-- Gender
	pRace 				= nil,		-- Race
	pEnRace 			= nil,		-- Race in English
	pClass				= nil,		-- Class
	pEnClass 			= nil,		-- Class in English
	pCColor 			= nil,		-- Class Color
	pCColorR 			= nil,		-- Class Color (R)
	pCColorG 			= nil,		-- Class Color (G)
	pCColorB 			= nil,		-- Class Color (B)

	pTitle 				= nil,		-- Current Title
	pGuildName 			= nil,		-- Guild Name

	pLevel 				= nil,		-- Level
	pXP 				= nil,		-- Current XP
	pXPMax 				= nil,		-- Current Level Max XP
	pXPStatus 			= nil,		-- Current XP + Current Level Max XP
	pPVPLevel 			= nil,		-- PVP Level

	pCTime 				= nil,		-- Chromie Time

	pRidingSkill 		= nil,		-- Riding Skill Level
	pRidingSkillId 		= nil,		-- Max Learnt Riding Skill ID
	pRidingSkillStatus	= nil,		-- Riding Skill Status	
	pRidingSpeed 		= nil,		-- Riding Speed
	pMEStatus 			= nil,		-- Mount Equipment Status

	pSpec 				= nil,		-- Current Specialization
	pHSpec 				= nil,		-- Current Hero Talent

--f	pHunActPets 		= nil,		-- Hunter Pets Active
--f	pHunStablePets 		= nil,		-- Hunter Pets in Stable

	pILevel 			= nil,		-- iLevel
	pILevelEquipped 	= nil,		-- iLevel equipped
	pILevelPvp 			= nil,		-- iLevel Pvp
	pILevelStatus 		= nil,		-- iLevel Status

	--//////////
	--Item Count
	pIC 				= nil,		-- Item Count Table
									-- [1] = Hearthstone
									-- [2] = PVP and Pet related
									-- [3] = Guild Tabard
									-- [4] = Miscellaneous
									-- [5] = Alliance Tabard
									-- [6] = Horde Tabard

	--//////////
	pMoney 				= nil,		-- Money on Hand

	--//////////
	pBagSlot 			= nil,		-- Bag 
	pBagTotal 			= nil,		-- Count of bag
	pBagTotalSlot 		= nil,		-- Count of all bag slot

	--//////////
	pPro1       		= nil,		-- Profession 1: base name, current skill level, max level, modifier, skill line, latest name, spec table
	pProDetail1 		= nil,
	pPro2       		= nil,		-- Profession 2: base name, current skill level, max level, modifier, skill line, latest name, spec table
	pProDetail2 		= nil,
	pPro3       		= nil,		-- Cooking; name, current skill level, max level, modifier, name2, special spell
	pProDetail3 		= nil,
	pPro4       		= nil,		-- Fishing; name, current skill level, max level, modifier, name2, special spell
	pProDetail4 		= nil,
	pPro5       		= nil,		-- Archaeology; name, current skill level, max level, modifier, name2, special spell
	pProGet     		= false,
	pProSpec1			= nil,		-- Profession 1 Specialization
	pProSpec2			= nil,		-- Profession 2 Specialization

	--//////////
	pSlotsBackPack 		= nil,		-- Backpack; slot, free slot (bagid 0-4)
	pCharBankPuchased 	= nil,
	pCharBank 			= nil,		-- Bank Tag; slot, free slot (bagid 6-11)
	pAccBankPuchased 	= nil,
	pAccBank 			= nil,		-- Warband Bank Tag; slot, free slot (bagid 12-16)

	--//////////
	pNumToys 			= nil,
	pNumToysLearned 	= nil,
	pNumHeirlooms 		= nil,
	pNumHeirloomsKnown	= nil,
	pNumMounts 			= nil,
	pNumMountsGet 		= nil,
	pNumAppSets 		= nil,
	pNumAppSetsGet 		= nil,

	--//////////
	pMainCityRepu 		= nil,		-- 7 main city
	pSpecRepu 			= nil,		-- 1 = guild, 2 = darkmoon
}
	
function Zero2Max.Player:Initialize()
    self:SyncData()
end

function Zero2Max.Player:SyncData()

	--//////////
	self.pClass, self.pEnClass = UnitClass("player")
	self.pCColorR, self.pCColorG, self.pCColorB, self.pCColor = GetClassColor(self.pEnClass)

	self.pEnFaction, self.pFaction = UnitFactionGroup("player")
	if self.pEnFaction == "Alliance" then
		self.pFactI = 1
	else
		self.pFactI = 2
	end

	local genderTable = {"Neuter or unknown", "Male", "Female"}
	self.pGender = genderTable[UnitSex("player")]
	self.pRace, self.pEnRace = UnitRace("player")

	local titleID = GetCurrentTitle("player")
	self.pTitle = ""
	if titleID ~= -1 then
		self.pTitle = GetTitleName(titleID)
	end

	local guildName, guildRankName, guildRankIndex, realm = GetGuildInfo("player")
	self.pGuildName = ""
	if guildName ~= nil then
		self.pGuildName = guildName
	end

	self.pCharacter = self.pFaction .. " " .. L[self.pGender] .. " " .. self.pRace .. " " .. self.pClass
	if (titleID ~= -1) and (self.pTitle ~= nil) then
		self.pCharacter = self.pCharacter .. " <" .. self.pTitle .. ">"
	end

	--//////////
	self.pLevel = UnitLevel("player")

	self.pXP = UnitXP("player")
	self.pXPMax = UnitXPMax("player")
	self.pXPStatus = floor((self.pXP/self.pXPMax)*100+0.9) .. "% ( " .. self.pXP .. " / " .. self.pXPMax .. " )"	

	--//////////
	local playerCTimeID = UnitChromieTimeID("player")
	local cTimeInfo = C_ChromieTime.GetChromieTimeExpansionOption(playerCTimeID)
	if cTimeInfo == nil then
		self.pCTime = L["Nil"]
	else
		self.pCTime = cTimeInfo.name
	end

	--//////////
	self.pPVPLevel = {}
	self.pPVPLevel[1] = UnitHonorLevel("player")
	self.pPVPLevel[2] = UnitHonor("player")
	self.pPVPLevel[3] = UnitHonorMax("player")
	self.pPVPLevel[4] = C_PvP.GetNextHonorLevelForReward(self.pPVPLevel[1])

	--//////////
	local playerIsKnownMasterRiding     = IsSpellKnown(90265) -- Level 40
	local playerIsKnownExpertRiding     = IsSpellKnown(34090) -- Level 30
	local playerIsKnownJourneymanRiding = IsSpellKnown(33391) -- Level 20
	local playerIsKnownApprenticeRiding = IsSpellKnown(33388) -- Level 10
	if playerIsKnownMasterRiding then
		self.pRidingSkill   = 4
		self.pRidingSkillId = 90265
		self.pRidingSpeed   = "310%"
	elseif playerIsKnownExpertRiding then
		self.pRidingSkill   = 3
		self.pRidingSkillId = 34090
		self.pRidingSpeed   = "150%"
	elseif playerIsKnownJourneymanRiding then
		self.pRidingSkill   = 2
		self.pRidingSkillId = 33391
		self.pRidingSpeed   = "100%"
	elseif playerIsKnownApprenticeRiding then
		self.pRidingSkill   = 1
		self.pRidingSkillId = 33388
		self.pRidingSpeed   = "60%"
	else
		self.pRidingSkill   = 0
		self.pRidingSkillId = 0
		self.pRidingSpeed   = "0%"
	end
	if self.pRidingSkill > 0 then
		local name = C_Spell.GetSpellName(self.pRidingSkillId)
		self.pRidingSkillStatus = self.pRidingSkill .. " - " .. name
	else
		self.pRidingSkillStatus = self.pRidingSkill .. " - " .. L["Nil"]
	end

	-- Mount Equipment
	local playerMEUnlockLevel = C_MountJournal.GetMountEquipmentUnlockLevel()
	local playerMEAppliedItemID = C_MountJournal.GetAppliedMountEquipmentID()
	if self.pLevel < playerMEUnlockLevel then
		self.pMEStatus = L["Not Yet Can Use"]
	elseif playerMEAppliedItemID == nil then
		self.pMEStatus = L["Nil"]
	else
		self.pMEStatus = L["Have"]
	end
	--f [future development] show Mount Equipment name if can --

	--//////////
	local currentSpec = GetSpecialization()
	self.pSpec = currentSpec and select(2, GetSpecializationInfo(currentSpec)) or L["Nil"]

	self.pHSpec = ""
	local currentHero = C_ClassTalents.GetActiveHeroTalentSpec()
	if currentHero ~= nil then
		local activeHeroConfigID = C_ClassTalents.GetActiveConfigID()
		local subHeroTreeInfo = C_Traits.GetSubTreeInfo(activeHeroConfigID, currentHero)
		self.pHSpec = subHeroTreeInfo.name
	end

	--//////////
--f	if self.pEnClass == "HUNTER" then
--f		self.pHunActPets = C_StableInfo.GetNumActivePets
--f		self.pHunStablePets = C_StableInfo.GetNumStablePets
--f	end

	--//////////
	self.pILevel, self.pILevelEquipped, self.pILevelPvp = GetAverageItemLevel()
	self.pILevelStatus = math.floor(self.pILevel)
	if math.floor(self.pILevel) ~= math.floor(self.pILevelEquipped) then
		self.pILevelStatus = self.pILevelStatus .. " (" .. L["Equipped"] .. " " .. math.floor(self.pILevelEquipped) .. ")"
	end
	if math.floor(self.pILevel) ~= math.floor(self.pILevelPvp) then
		self.pILevelStatus = self.pILevelStatus .. " (" .. "PvP" .. " " .. math.floor(self.pILevelPvp) .. ")"
	end

	--//////////
	local ic_result = {}
	local ic_table  = Zero2Max.ITEM_COUNT
	for k, v in pairs(ic_table) do
		ic_result[k] = {}
		for j, u in pairs(v) do
			ic_result[k][j] = {u, GetItemCount(u,true,nil,true)}
		end
	end
	self.pIC = ic_result

	--//////////
	self.pMoney = GetMoney()
	
	--//////////
	local playerBagSlot0 = C_Container.GetContainerNumSlots(0)
	local playerBagSlot1 = C_Container.GetContainerNumSlots(1)
	local playerBagSlot2 = C_Container.GetContainerNumSlots(2) 
	local playerBagSlot3 = C_Container.GetContainerNumSlots(3)
	local playerBagSlot4 = C_Container.GetContainerNumSlots(4)
	local playerBagSlot5 = C_Container.GetContainerNumSlots(5)
	self.pBagSlot = {playerBagSlot0, playerBagSlot1, playerBagSlot2, playerBagSlot3, playerBagSlot4, playerBagSlot5}
	self.pBagTotal = 0
	self.pBagTotalSlot = 0
	local pBag_i
	for pBag_i = 1,6,1 
	do 
		if self.pBagSlot[pBag_i] > 0 then
			self.pBagTotal = self.pBagTotal + 1
			self.pBagTotalSlot = self.pBagTotalSlot + self.pBagSlot[pBag_i]
		end
	end

	--//////////
	local prof_prof1, prof_prof2, prof_archaeology, prof_fishing, prof_cooking = GetProfessions()
	local prof_prof1_skline = nil
	local prof_prof2_skline = nil
	local prof_cook_skline  = nil
	local prof_fish_skline  = nil
	local prof_name, prof_icon, prof_skillLevel, prof_maxSkillLevel, prof_numAbilities, prof_spelloffset, prof_skillLine, prof_skillModifier, prof_specializationIndex, prof_specializationOffset, prof_name2

	if prof_prof1 ~= nil then
	    prof_name, prof_icon, prof_skillLevel, prof_maxSkillLevel, prof_numAbilities, prof_spelloffset, prof_skillLine, prof_skillModifier, prof_specializationIndex, prof_specializationOffset, prof_name2 = GetProfessionInfo(prof_prof1)
		prof_prof1_skline = prof_skillLine
		self.pPro1 = { prof_name, prof_skillLevel, prof_maxSkillLevel, prof_skillModifier, prof_skillLine, prof_name2 }
		self.pPro1[8] = Zero2Max.PROF_KNOW[prof_prof1_skline]
	end

	if prof_prof2 ~= nil then
	    prof_name, prof_icon, prof_skillLevel, prof_maxSkillLevel, prof_numAbilities, prof_spelloffset, prof_skillLine, prof_skillModifier, prof_specializationIndex, prof_specializationOffset, prof_name2 = GetProfessionInfo(prof_prof2)
		prof_prof2_skline = prof_skillLine
		self.pPro2 = { prof_name, prof_skillLevel, prof_maxSkillLevel, prof_skillModifier, prof_skillLine, prof_name2 }
		self.pPro2[8] = Zero2Max.PROF_KNOW[prof_prof2_skline]
	end

	local spellIsKnown
	local spellName

	if (prof_prof1_skline == 202) or (prof_prof2_skline == 202) then
		spellName = "None"
		spellIsKnown = IsSpellKnown(20219) --spell=20219/gnomish-engineer
		if spellIsKnown then
			spellName = C_Spell.GetSpellName(20219)
		end
		spellIsKnown = IsSpellKnown(20222) --spell=20222/goblin-engineer
		if spellIsKnown then
			spellName = C_Spell.GetSpellName(20222)
		end
		if (prof_prof1_skline == 202) then
			self.pPro1[7] = spellName
		else
			self.pPro2[7] = spellName
		end
	end

	if (prof_prof1_skline == 171) or (prof_prof2_skline == 171) then
		spellName = "None"
		spellIsKnown = IsSpellKnown(28677) --spell=28677/elixir-master
		if spellIsKnown then
			spellName = C_Spell.GetSpellName(28677)
		end
		spellIsKnown = IsSpellKnown(28675) --spell=28675/potion-master
		if spellIsKnown then
			spellName = C_Spell.GetSpellName(28675)
		end
		spellIsKnown = IsSpellKnown(28672) --spell=28672/transmutation-master
		if spellIsKnown then
			spellName = C_Spell.GetSpellName(28672)
		end
		if (prof_prof1_skline == 171) then
			self.pPro1[7] = spellName
		else
			self.pPro2[7] = spellName
		end
	end

	if (prof_prof1_skline == 197) or (prof_prof2_skline == 197) then
		spellName = "None"
		spellIsKnown = IsSpellKnown(59390) --spell=59390/cloth-scavenging
		if spellIsKnown then
			spellName = C_Spell.GetSpellName(59390)
		end
		spellIsKnown = IsSpellKnown(343634) --spell=343634/shadowlands-cloth-scavenging
		if spellIsKnown then
			spellName = C_Spell.GetSpellName(343634)
		end
		spellIsKnown = IsSpellKnown(392396) --spell=392396/dragon-isles-cloth-scavenging
		if spellIsKnown then
			spellName = C_Spell.GetSpellName(392396)
		end
		if (prof_prof1_skline == 197) then
			self.pPro1[7] = spellName
		else
			self.pPro2[7] = spellName
		end
	end

	if prof_cooking ~= nil then
	    prof_name, prof_icon, prof_skillLevel, prof_maxSkillLevel, prof_numAbilities, prof_spelloffset, prof_skillLine, prof_skillModifier, prof_specializationIndex, prof_specializationOffset, prof_name2 = GetProfessionInfo(prof_cooking)
		prof_cook_skline = prof_skillLine
		self.pPro3 = {prof_name, prof_skillLevel, prof_maxSkillLevel, prof_skillModifier, prof_specializationIndex, prof_name2}	
	end

	if prof_fishing ~= nil then
	    prof_name, prof_icon, prof_skillLevel, prof_maxSkillLevel, prof_numAbilities, prof_spelloffset, prof_skillLine, prof_skillModifier, prof_specializationIndex, prof_specializationOffset, prof_name2 = GetProfessionInfo(prof_fishing)
		prof_fish_skline = prof_skillLine
		self.pPro4 = {prof_name, prof_skillLevel, prof_maxSkillLevel, prof_skillModifier, prof_specializationIndex, prof_name2}
	end

	if prof_archaeology ~= nil then
	    prof_name, prof_icon, prof_skillLevel, prof_maxSkillLevel, prof_numAbilities, prof_spelloffset, prof_skillLine, prof_skillModifier, prof_specializationIndex, prof_specializationOffset, prof_name2 = GetProfessionInfo(prof_archaeology)
		self.pPro5 = {prof_name, prof_skillLevel, prof_maxSkillLevel, prof_skillModifier, prof_specializationIndex, prof_name2}
	end

	self.pProDetail1, self.pProDetail2, self.pProDetail3, self.pProDetail4 = Zero2Max.Player.colprof(prof_prof1_skline, prof_prof2_skline, prof_cook_skline, prof_fish_skline)

	self.pProSpec1, self.pProSpec2 = Zero2Max.Player.colprofspec(prof_prof1_skline, prof_prof2_skline)

	if Zero2Max.inTrade then
		self.pProGet = true
	end

	--//////////
	self.pSlotsBackPack = {}
	local pb1 = 0
	local pb2 = 0
	local pba, pbb, pbc
	for pb1 = BACKPACK_CONTAINER, NUM_BAG_SLOTS + 1, 1
	do 
		pba = C_Container.GetContainerNumSlots(pb1)
		pbb = C_Container.GetContainerNumFreeSlots(pb1)
		pb2 = pb2 + 1
		self.pSlotsBackPack[pb2] = {pba, pbb}
	end


	self.pCharBankPuchased = C_Bank.FetchNumPurchasedBankTabs(0)

	if Zero2Max.inBank then
		if C_Bank.CanUseBank(0) then
			if self.pCharBankPuchased > 0 then
				self.pCharBank = {}
				pb2 = 0
				for pb1 = 6, 6 + self.pCharBankPuchased - 1, 1
				do
					pba = C_Container.GetContainerNumSlots(pb1)
					pbb = C_Container.GetContainerNumFreeSlots(pb1)
					pb2 = pb2 + 1
					self.pCharBank[pb2] = {pba, pbb}
				end

				local purchasedBankTabData = C_Bank.FetchPurchasedBankTabData(0)
				for pb2 = 1, self.pCharBankPuchased, 1
				do
					self.pCharBank[pb2][3] = purchasedBankTabData[pb2].name
				end
			end
		end

		if C_Bank.CanUseBank(2) then
			self.pAccBankPuchased = C_Bank.FetchNumPurchasedBankTabs(2)
			if self.pAccBankPuchased > 0 then
				self.pAccBank = {}
				pb2 = 0
				for pb1 = 12, 12 + self.pAccBankPuchased - 1, 1
				do
					pba = C_Container.GetContainerNumSlots(pb1)
					pbb = C_Container.GetContainerNumFreeSlots(pb1)
					pb2 = pb2 + 1
					self.pAccBank[pb2] = {pba, pbb}
				end

				local purchasedBankTabData = C_Bank.FetchPurchasedBankTabData(2)
				for pb2 = 1, self.pAccBankPuchased, 1
				do
					self.pAccBank[pb2][3] = purchasedBankTabData[pb2].name
				end
			end
		end
	end

	--//////////
	self.pNumToys           = C_ToyBox.GetNumTotalDisplayedToys()
	self.pNumToysLearned    = C_ToyBox.GetNumLearnedDisplayedToys()

	self.pNumHeirlooms      = C_Heirloom.GetNumHeirlooms()
	self.pNumHeirloomsKnown = C_Heirloom.GetNumKnownHeirlooms()

	local numMounts = C_MountJournal.GetMountIDs()
	local numMountsCnt = 0
	local numMountsGet = 0
	for k, v in pairs(numMounts) do
		local _, _, _, _, _, _, _, _, _, mountHide, mountGet = C_MountJournal.GetMountInfoByID(v)
		if (mountHide == nil) or not mountHide then
			numMountsCnt = numMountsCnt + 1
			if (mountGet ~= nil) and mountGet then
				numMountsGet = numMountsGet + 1
			end
		end
	end
	self.pNumMounts         = numMountsCnt
	self.pNumMountsGet      = numMountsGet

	self.pNumAppSetsGet, self.pNumAppSets = C_TransmogSets.GetFullBaseSetsCounts()

	--//////////
	local rname, rdesc, standID, bMin, bMax, bVal, atWar, canWar, isHeader, isCollapsed, hasRep, isWatched, isChild, factID, hasBonus, canBeLFGBonus
	self.pMainCityRepu = {}
	for k, v in pairs(Zero2Max.REPU_MAIN_CITY[self.pFactI]) do
		local fi = C_Reputation.GetFactionDataByID(v)
		self.pMainCityRepu[k] = {fi.name, fi.reaction, fi.currentReactionThreshold, fi.nextReactionThreshold, fi.currentStanding}
	end

	self.pSpecRepu = {}
	for k, v in pairs(Zero2Max.REPU_SPECIAL) do
		local fi = C_Reputation.GetFactionDataByID(v)
		self.pSpecRepu[k] = {fi.name, fi.reaction, fi.currentReactionThreshold, fi.nextReactionThreshold, fi.currentStanding}
	end

end


function Zero2Max.Player.colprof(p1, p2, p3, p4)
	local resp1   = {}
	local resp2   = {}
	local resp3   = {}
	local resp4   = {}
	local chktbl  = {}
	local chktbl2 = {}
	local skillLineDisplayName, skillLineRank, skillLineMaxRank, skillLineModifier, parentSkillLineID
	local skillLine
	local k, v
	if p1 ~= nil then
		chktbl = Zero2Max.PROF_TABLE[p1]
		for k, v in pairs(chktbl) do
			skillLine = C_TradeSkillUI.GetProfessionInfoBySkillLineID(v)
			if skillLine ~= nil then
				resp1[k] = {skillLine.professionName, skillLine.skillLevel, skillLine.maxSkillLevel, skillLine.skillModifier}
			else
				resp1[k] = {"", "", "", ""}
			end
		end
	else
		resp1 = nil
	end

	if p2 ~= nil then
		chktbl = Zero2Max.PROF_TABLE[p2]
		for k, v in pairs(chktbl) do
			skillLine = C_TradeSkillUI.GetProfessionInfoBySkillLineID(v)
			if skillLine ~= nil then
				resp2[k] = {skillLine.professionName, skillLine.skillLevel, skillLine.maxSkillLevel, skillLine.skillModifier}
			else
				resp2[k] = {"", "", "", ""}
			end
		end
	else
		resp2 = nil
	end

	if p3 ~= nil then
		chktbl  = Zero2Max.PROF_COOK
		chktbl2 = Zero2Max.PROF_COOK_SUBGROUP
		for k, v in pairs(chktbl) do
			skillLine = C_TradeSkillUI.GetProfessionInfoBySkillLineID(v)
			if skillLine ~= nil then
				resp3[k] = {skillLine.professionName, skillLine.skillLevel, skillLine.maxSkillLevel, skillLine.skillModifier}
				if chktbl2[k] then
					resp3[k][1] = " - " .. resp3[k][1]
				end
			else
				resp3[k] = {"", "", "", ""}
			end
		end		
	else
		resp3 = nil
	end

	if p4 ~= nil then
		chktbl = Zero2Max.PROF_FISH
		for k, v in pairs(chktbl) do
			skillLine = C_TradeSkillUI.GetProfessionInfoBySkillLineID(v)
			if skillLine ~= nil then
				resp4[k] = {skillLine.professionName, skillLine.skillLevel, skillLine.maxSkillLevel, skillLine.skillModifier}
			else
				resp4[k] = {"", "", "", ""}
			end
		end		
	else
		resp4 = nil
	end

	return resp1, resp2, resp3, resp4
end


function Zero2Max.Player.colprofspec(p1, p2)
	local resp1   = {}
	local resp2   = {}
	local chktbl  = {}
	local k, v
	if p1 ~= nil then
		chktbl = Zero2Max.PROF_TABLE[p1]
		for k, v in pairs(chktbl) do
			if k < 4 then
				local psS = 0
				local psA = 0
				local psR = {}
				psR[1] = v
				psR[2] = {}
			
				--get ConfigID
				local psConf = C_ProfSpecs.GetConfigIDForSkillLine(v)
				if psConf > 0 then

					local psT = {}
					--get SpecTabIDs
					local psSTab = C_ProfSpecs.GetSpecTabIDsForSkillLine(v)
					for i, j in pairs(psSTab) do
						psT[i] = {}
						--get tab name
						psTinfo = C_ProfSpecs.GetTabInfo(j)
						psT[i].name = psTinfo.name

						--get root path
						psTroot = C_ProfSpecs.GetRootPathForTab(j)
						local psN = {}
						psN[1] = psTroot
						--get rest path
						local psChild = C_ProfSpecs.GetChildrenForPath(psTroot)
						for m, n in pairs(psChild) do
							psN[#psN + 1] = n
						end

						local getList = {}
						--get note info
						for o, p in pairs(psN) do
							psNodeinfo = C_Traits.GetNodeInfo(psConf, p)
							psEntid    = C_Traits.GetEntryInfo(psConf, psNodeinfo.entryIDs[1])
							local psSpend = psNodeinfo.currentRank
							if psSpend ~= 0 then
								psSpend = psSpend -1
							end
							local psMax = psNodeinfo.maxRanks
							psMax = psMax - 1
							psDefid    = C_Traits.GetDefinitionInfo(psEntid.definitionID)
							psName     = psDefid.overrideName
							getList[o] = {psName, psSpend, psMax}
							psS = psS + psSpend
							psA = psA + psMax
						end
						psT[i].list = getList
					end
					psR[2] = psT
					psR[3] = psS
					psR[4] = psA
					resp1[k] = {}
					resp1[k] = psR
				end
			end
		end
	else
		resp1 = nil
	end

	if p2 ~= nil then
		chktbl = Zero2Max.PROF_TABLE[p2]
		for k, v in pairs(chktbl) do
			if k < 4 then
				local psS = 0
				local psA = 0
				local psR = {}
				psR[1] = v
				psR[2] = {}
			
				--get ConfigID
				local psConf = C_ProfSpecs.GetConfigIDForSkillLine(v)
				if psConf > 0 then

					local psT = {}
					--get SpecTabIDs
					local psSTab = C_ProfSpecs.GetSpecTabIDsForSkillLine(v)
					for i, j in pairs(psSTab) do
						psT[i] = {}
						--get tab name
						psTinfo = C_ProfSpecs.GetTabInfo(j)
						psT[i].name = psTinfo.name

						--get root path
						psTroot = C_ProfSpecs.GetRootPathForTab(j)
						local psN = {}
						psN[1] = psTroot
						--get rest path
						local psChild = C_ProfSpecs.GetChildrenForPath(psTroot)
						for m, n in pairs(psChild) do
							psN[#psN + 1] = n
						end

						local getList = {}
						--get note info
						for o, p in pairs(psN) do
							psNodeinfo = C_Traits.GetNodeInfo(psConf, p)
							psEntid    = C_Traits.GetEntryInfo(psConf, psNodeinfo.entryIDs[1])
							local psSpend = psNodeinfo.currentRank
							if psSpend ~= 0 then
								psSpend = psSpend -1
							end
							local psMax = psNodeinfo.maxRanks
							psMax = psMax - 1
							psDefid    = C_Traits.GetDefinitionInfo(psEntid.definitionID)
							psName     = psDefid.overrideName
							getList[o] = {psName, psSpend, psMax}
							psS = psS + psSpend
							psA = psA + psMax
						end
						psT[i].list = getList
					end
					psR[2] = psT
					psR[3] = psS
					psR[4] = psA
					resp2[k] = {}
					resp2[k] = psR
				end
			end
		end
	else
		resp2 = nil
	end

	return resp1, resp2
end


-- Convert a lua table into a lua syntactically correct string
function Zero2Max.Player.table_to_string(tbl)
    local result = "{"
    for k, v in pairs(tbl) do
        -- Check the key type (ignore any numerical keys - assume its an array)
        if type(k) == "string" then
            result = result.."[\""..k.."\"]".."="
        end

        -- Check the value type
        if type(v) == "table" then
            result = result..table_to_string(v)
        elseif type(v) == "boolean" then
            result = result..tostring(v)
        else
            result = result.."\""..v.."\""
        end
        result = result..","
    end
    -- Remove leading commas from the result
    if result ~= "" then
        result = result:sub(1, result:len()-1)
    end
    return result.."}"
end
