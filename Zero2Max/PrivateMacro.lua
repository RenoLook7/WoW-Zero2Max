local _, addonTable = ...
local L = addonTable.GetLocale()

--//
--//	temp
--//
function Zero2Max:SetupMacro()
--	Zero2Max:SetupMacro6()
end

--//
--//	setup common marco
--//
function Zero2Max:SetupMacro2()
	local function PC2(a)
		local actionType, id, subType = GetActionInfo(a)
		if actionType == "macro" then
			local name = GetActionText(a)
		--	local name, icon, body = GetMacroInfo(id)
			if (name == "Z1h") or (name == "Z1a") or (name == "Z2") or (name == "Z3") or (name == "Z4") or (name == "Z5") then 
				Zero2Max:ActionPC(a)
			elseif (name == "Y1") or (name == "Y2") or (name == "Y3") or (name == "Y4") or (name == "Y5") then
				Zero2Max:ActionPC(a)
			elseif (name == "Accept") or (name == "Accept2") or (name == "Accept3") then
				Zero2Max:ActionPC(a)
			elseif (name == "F1") then
				Zero2Max:ActionPC(a)
			elseif (name == "X1") or (name == "X2") then
				Zero2Max:ActionPC(a)
			end
		end
		if actionType == "spell" then
			if (id == 360078)
			or (id == 296208)
			or (id == 251463)
			or (id == 161691)
			or (id == 431280)
			or (id == 382501)
			or (id == 382499)
			then
				Zero2Max:ActionPC(a)
			end
		end
	end
	local i = 1
--	for i = 145, 180, 1 do
--		PC2(i)
--	end

--	Zero2Max:ActionPC(25)
--	Zero2Max:ActionPC(26)

	Zero2Max:ActionMA("Accept",145)
	Zero2Max:ActionMA("Accept2",146)
	Zero2Max:ActionMA("Accept3",147)

	Zero2Max:ActionMA("Accept4",148)
	Zero2Max:ActionMA("Accept5",149)

--	Zero2Max:ActionMA("Y1",148)
	Zero2Max:ActionMA("Y1",150)
--	Zero2Max:ActionMA("Y2",149)
	Zero2Max:ActionMA("Y2",151)

--	Zero2Max:ActionSA(,150)

	Zero2Max:ActionMA("F1",169)
	Zero2Max:ActionMA("X2",170)
	Zero2Max:ActionMA("X1",171)
	Zero2Max:ActionMA("Y4",172)
	Zero2Max:ActionMA("Y5",173)

	Zero2Max:ActionSA(1231411,174)				-- eat

	Zero2Max:ActionMA("Y3",175)
	Zero2Max:ActionMA("Y6",176)
	Zero2Max:ActionMA("Y7",177)
	Zero2Max:ActionMA("Y8",178)
	Zero2Max:ActionMA("Y9",179)


	Zero2Max:ActionMA("Z2",159) 
	Zero2Max:ActionMA("Z3",158) 
	Zero2Max:ActionMA("Z4",157) 
	local a,b=UnitFactionGroup("player")
	if a=="Horde" then 
		Zero2Max:ActionMA("Z1h",160) 
	else 
		Zero2Max:ActionMA("Z1a",160) 
	end
	Zero2Max:ActionMA("Z5",161)

--	Zero2Max:ActionWA(19,23)
--	Zero2Max:ActionWA(20,24)
--	Zero2Max:ActionWA(178,180)
--	Zero2Max:ActionWA(177,179)
--	Zero2Max:ActionWA(176,178)
--	Zero2Max:ActionWA(175,177)
--	Zero2Max:ActionWA(174,176)

--	dragonriding
	Zero2Max:ActionSA(372608,121)
	Zero2Max:ActionSA(372610,122)
	Zero2Max:ActionSA(361584,123)
	Zero2Max:ActionSA(403092,124)
	Zero2Max:ActionSA(425782,125)
	Zero2Max:ActionSA(374990,126)

	print("Zero2Max:" .. "macro 2 end")

end

--//
--//	clear 1,2,3,4,7 bar
--//	setup common marco, call SetupMacro2()
--//	check spellbook and add to bar, if not skip
--//	add class common marco
--//
function Zero2Max:SetupMacroClean()
--	1-12	ActionButton1-12 (1)
--	13-24	ActionButton1-12 page 2 (1.2)
--	61-72	MultiBarBottomLeftButton1-12 (2)
--	49-60	MultiBarBottomRightButton1-12 (3)
--	25-36	MultiBarRightButton1-12 (4)
--	37-48	MultiBarLeftButton1-12 (5)
--	145-156	MultiBar5Button1-12 (6)
--	157-168	MultiBar6Button1-12 (7)
--	169-180	MultiBar7Button1-12 (8)

	local tc = {1, 61, 49, 25, 157}		--clear 1,2,3,4,7
	for k, v in pairs(tc) do
		for i = 1, 12 do 
			PickupAction(i - 1 + v)
			PutItemInBackpack()
			ClearCursor()
		end
	end

--	local barLoc = 0
--	local barLoc = 12
	local barLoc = 2
	local function nextLoc(a)
		a = a + 1
		if 		a == 13 then 	-- bar 1
				a = 61				-- bar 2
		elseif 	a == 73 then 	-- bar 2
				a = 49				-- bar 3
		elseif 	a == 61 then 	-- bar 3
				a = 25				-- bar 4
		elseif 	a == 37 then 	-- bar 4
				a = 157				-- bar 5
		elseif 	a == 49 then 	-- bar 5
				a = 999				-- end
		end
		return a
	end


	Zero2Max:SetupMacro2()


	local numTabs = C_SpellBook.GetNumSpellBookSkillLines()		
	for i = 1, numTabs, 1 do
		local sTabInfo = C_SpellBook.GetSpellBookSkillLineInfo(i)
		sTabName = sTabInfo.name
		sOffset = sTabInfo.itemIndexOffset
		sSlot = sTabInfo.numSpellBookItems	
		sOffSpec = sTabInfo.offSpecID
		if sOffSpec == nil then
			for j = sOffset + 1, sOffset + sSlot, 1 do
				local sType              = C_SpellBook.GetSpellBookItemInfo(j, 0)
				if 		(sType.isPassive ~= nil) and sType.isPassive then	-- passive
				elseif	(sType.isOffSpec ~= nil) and sType.isOffSpec then	-- offspec
				elseif	sType.itemType == 2 then							-- future spell
				elseif	sType.itemType == 3 then							-- pet spell
		--		elseif	sType.spellID ~= nil then
				elseif	sType.itemType == 4 then							-- flyout
					if	(sType.actionID == 229) or		-- skip 229(sky riding)
						(sType.actionID == 235)	or		-- skip 235(warband)
						(sType.actionID == 243) 		-- skip 243(sky riding type)
					then
						print("skip", sType.spellID, sType.actionID, sType.name)
					else
						if (sType.actionID == 224) then			-- midnight
							Zero2Max:ActionSBA(j, 150)			-- midnight
						else									-- midnight
							barLoc = nextLoc(barLoc)
							Zero2Max:ActionSBA(j, barLoc)
						end										-- midnight
						print(sType.spellID, sType.actionID, sType.name)
					end
				else
					if	(sType.spellID == 125439) or	-- skip 125439 (recovery pet) macro exist
						(sType.spellID == 460905) or 	-- skip 460905 (warband bank) macro exist
						(sType.spellID == 83958) or		-- skip 83958  (mobile bank) macro exist
						(sType.spellID == 5019) or		-- skip 5019   (shoot)
						(sType.spellID == 75) or		-- skip 75     (auto shoot)
						(sType.spellID == 6603) or		-- skip 6603   (auto attack)
						(sType.spellID == 386164) or 	-- skip 386164 (warrior stand fight)
						(sType.spellID == 386208) or 	-- skip 386208 (warrior stand defence)
						(sType.spellID == 32223) or 	-- skip 32223  (paladin Crusader Aura)
						(sType.spellID == 317920) or 	-- skip 317920 (paladin Retribution Aura)
						(sType.spellID == 465) or 		-- skip 465    (paladin Devotion Aura)
						(sType.spellID == 131347) or 	-- skip 131347 (dh Glide)
						(sType.spellID == 374990) or 	-- skip 374990 (dragonflight timelock)
						(sType.spellID == 1231411) or 	-- skip 1231411 (cook) macro exist
						(sType.spellID == 382499) or 	-- skip 1231411 (df skill) macro exist
						(sType.spellID == 382501) or 	-- skip 1231411 (df skill) macro exist
						-- druid
						(sType.spellID == 20484) or 	-- skip	macro exist
						(sType.spellID == 18960) or 	-- skip	macro exist
						(sType.spellID == 193753) or 	-- skip	macro exist
						(sType.spellID == 50769) or 	-- skip	macro exist
						(sType.spellID == 212040) or 	-- skip	macro exist
					--	(sType.spellID == 1126) or 		-- midnight
					--	(sType.spellID == 5487) or 		-- midnight
					--	(sType.spellID == 768) or 		-- midnight
					--	(sType.spellID == 783) or 		-- midnight
					--	(sType.spellID == 5215) or 		-- midnight
						-- paladin
						(sType.spellID == 391054) or 	-- skip	macro exist
						(sType.spellID == 5502) or 		-- skip	macro exist
						(sType.spellID == 7328) or 		-- skip	macro exist
						(sType.spellID == 212056) or 	-- skip	macro exist
						-- shaman
						(sType.spellID == 556) or 		-- skip	macro exist
						(sType.spellID == 6196) or 		-- skip	macro exist
						(sType.spellID == 546) or 		-- skip	macro exist
						(sType.spellID == 212048) or 	-- skip	macro exist
						(sType.spellID == 2008)  		-- skip	macro exist
					then
						print("skip", sType.spellID, sType.actionID, sType.name)
					else
						barLoc = nextLoc(barLoc)
						Zero2Max:ActionSBA(j, barLoc)
						print(sType.spellID, sType.actionID, sType.name)
					end
				end
			end
		end
	end

--	Zero2Max:ActionSA(1229376,175)
	Zero2Max:ActionSA(1231411,174)

--	rotate key
	Zero2Max:ActionSA(1229376,1)
	
	local pC, pCE = UnitClass("player")

	if	(pCE	== "ROGUE") then
		Zero2Max:ActionSA(1229376,73)				-- sub
	end
	if	(pCE	== "DRUID") then
		Zero2Max:ActionSA(1229376,73)				-- cat
		Zero2Max:ActionSA(1229376,97)				-- bear
	--	Zero2Max:ActionSA(1229376,109)				-- moonkin
	end

--	pet attack and follow
	if	(pCE	== "HUNTER") or
		(pCE	== "WARLOCK") or
		(pCE	== "DEATHKNIGHT") then
		barLoc = nextLoc(barLoc)
		Zero2Max:ActionMA("Pet Attack",barLoc)
		barLoc = nextLoc(barLoc)
		Zero2Max:ActionMA("Pet Follow",barLoc)
	end

--	class macro
	if	(pCE	== "DEATHKNIGHT") then
	--	barLoc = nextLoc(barLoc)					-- midnight
	--	Zero2Max:ActionMA("Z9DK1",barLoc)			-- midnight
		Zero2Max:ActionMA("Z9DK1",48)				-- midnight
	end
	if	(pCE	== "DRUID") then
	--	barLoc = nextLoc(barLoc)					-- midnight
	--	Zero2Max:ActionMA("Z9DR1",barLoc)			-- midnight
		Zero2Max:ActionMA("Z9DR1",48)				-- midnight
		Zero2Max:ActionSA(1126,37)					-- midnight
		Zero2Max:ActionSA(5487,163)				-- midnight
		Zero2Max:ActionSA(768,164)					-- midnight
		Zero2Max:ActionSA(5215,166)				-- midnight
	end
	if	(pCE	== "EVOKER") then
	--	barLoc = nextLoc(barLoc)					-- midnight
	--	Zero2Max:ActionMA("Z9EV1",barLoc)			-- midnight
		Zero2Max:ActionMA("Z9EV1",48)				-- midnight
	end
	if	(pCE	== "HUNTER") then
		barLoc = nextLoc(barLoc)
		Zero2Max:ActionMA("Z9HU1",barLoc)
		barLoc = nextLoc(barLoc)
		Zero2Max:ActionMA("Z9HU2",barLoc)
	end
	if	(pCE	== "MAGE") then
	--	barLoc = nextLoc(barLoc)					-- midnight
	--	Zero2Max:ActionMA("Z9MA1",barLoc)			-- midnight
		Zero2Max:ActionMA("Z9MA1",37)				-- midnight
	end
	if	(pCE	== "MONK") then
	--	barLoc = nextLoc(barLoc)					-- midnight
	--	Zero2Max:ActionMA("Z9MO1",barLoc)			-- midnight
		Zero2Max:ActionMA("Z9MO1",48)				-- midnight
	end
	if	(pCE	== "PALADIN") then
	--	barLoc = nextLoc(barLoc)					-- midnight
	--	Zero2Max:ActionMA("Z9PA1",barLoc)			-- midnight
		Zero2Max:ActionMA("Z9PA1",48)				-- midnight
	end
	if	(pCE	== "PRIEST") then
	--	barLoc = nextLoc(barLoc)					-- midnight
	--	Zero2Max:ActionMA("Z9PR1",barLoc)			-- midnight
		Zero2Max:ActionMA("Z9PR1",37)				-- midnight
	end
	if	(pCE	== "SHAMAN") then
	--	barLoc = nextLoc(barLoc)					-- midnight
	--	Zero2Max:ActionMA("Z9SH1",barLoc)			-- midnight
		Zero2Max:ActionMA("Z9SH1",48)				-- midnight
	end
	if	(pCE	== "WARLOCK") then
	--	barLoc = nextLoc(barLoc)					-- midnight
	--	Zero2Max:ActionMA("Z9WL1",barLoc)			-- midnight
		Zero2Max:ActionMA("Z9WL1",47)				-- midnight
	--	barLoc = nextLoc(barLoc)					-- midnight
	--	Zero2Max:ActionMA("Z9WL2",barLoc)			-- midnight
		Zero2Max:ActionMA("Z9WL2",37)				-- midnight
	end

	print("Zero2Max:" .. "macro clean end")

end

--//
--//	setup game paremeter
--//
function Zero2Max:SetupMacroCVar()
	local chkset = nil
	chkset = C_CVar.GetCVar("autoLootDefault")
	if chkset == "0" then
		local setc = C_CVar.SetCVar("autoLootDefault", "1")
		if setc ~= nil and setc then
			print("Zero2Max:" .. "update autoLootDefault success")
		end
	end

	chkset = C_CVar.GetCVar("enableMouseoverCast")
	if chkset == "0" then
		local setc = C_CVar.SetCVar("enableMouseoverCast", "1")
		if setc ~= nil and setc then
			print("Zero2Max:" .. "update enableMouseoverCast success")
		end
	end

	chkset = C_CVar.GetCVar("autoInteract")
	if chkset == "0" then
		local setc = C_CVar.SetCVar("autoInteract", "1")
		if setc ~= nil and setc then
			print("Zero2Max:" .. "update autoInteract success")
		end
	end

	-- GetActionBarToggles()
	local a1, a2, a3, a4, a5, a6, a7 = GetActionBarToggles()
	if a1 and a2 and a3 and a4 and a5 and a6 and a7 then
	else
		SetActionBarToggles(true, true, true, true, true, true, true)
		print("Zero2Max:" .. "updated action bar")
	end

	-- Show cooldown
	local chkset = C_CVar.GetCVar("cooldownViewerEnabled")
	if chkset == "0" then
		local setc = C_CVar.SetCVar("cooldownViewerEnabled", "1")
		if setc ~= nil and setc then
			print("Zero2Max:" .. "update cooldownViewerEnabled success")
		end
	end
end

--//
--//	set cooldown
--//
function Zero2Max:SetCooldown()
	local chkset = C_CVar.GetCVar("cooldownViewerEnabled")
	if chkset == "0" then
		local setc = C_CVar.SetCVar("cooldownViewerEnabled", "1")
	--	if setc ~= nil and setc then
	--		print("Zero2Max:" .. "turn on cooldownViewerEnabled success")
	--	end
	else
		local setc = C_CVar.SetCVar("cooldownViewerEnabled", "0")
	--	if setc ~= nil and setc then
	--		print("Zero2Max:" .. "turn off cooldownViewerEnabled success")
	--	end
	end
end

--//
--//	check spellbook for debug purpose
--//
function Zero2Max:CheckSpellBook()
	local barLoc = 0
	local function nextLoc(a)
		a = a + 1
		if 		a == 13 then 	-- bar 1
				a = 61				-- bar 2
		elseif 	a == 73 then 	-- bar 2
				a = 49				-- bar 3
		elseif 	a == 61 then 	-- bar 3
				a = 25				-- bar 4
		elseif 	a == 37 then 	-- bar 4
				a = 37				-- bar 5
		elseif 	a == 49 then 	-- bar 5
				a = 999				-- end
		end
		return a
	end
	local numTabs = C_SpellBook.GetNumSpellBookSkillLines()		
	for i = 1, numTabs, 1 do
		local sTabInfo = C_SpellBook.GetSpellBookSkillLineInfo(i)
		sTabName = sTabInfo.name
		sOffset = sTabInfo.itemIndexOffset
		sSlot = sTabInfo.numSpellBookItems	
		sOffSpec = sTabInfo.offSpecID
		if sOffSpec == nil then
			for j = sOffset + 1, sOffset + sSlot, 1 do
				local sType              = C_SpellBook.GetSpellBookItemInfo(j, 0)
				print (barLoc, j, sType.itemType, sType.isPassive, sType.isOffSpec, sType.spellID, sType.actionID, sType.name)
				
				if 		(sType.isPassive ~= nil) and sType.isPassive then	-- passive
				elseif	(sType.isOffSpec ~= nil) and sType.isOffSpec then	-- offspec
				elseif	sType.itemType == 2 then							-- future spell
				elseif	sType.itemType == 3 then							-- pet spell
		--		elseif	sType.spellID ~= nil then
				elseif	sType.itemType == 4 then							-- flyout
					if	(sType.actionID == 229)
					then
						print("skip", sType.spellID, sType.actionID, sType.name)
					else
						barLoc = nextLoc(barLoc)
	--					SBA(j, barLoc)
	--					print(sType.spellID, sType.actionID, sType.name)
					end
				else
					if	(sType.spellID == 125439) or	-- skip 125439(recovery pet)
						(sType.spellID == 460905) or 	-- skip 460905(warband bank)
						(sType.spellID == 83958) or		-- skip 83958(mobile bank)
						(sType.spellID == 5019) or		-- skip 5019(shoot)
						(sType.spellID == 6603)			-- skip 6603(auto attack)
					then
						print("skip", sType.spellID, sType.actionID, sType.name)
					else
						barLoc = nextLoc(barLoc)
	--					SA(sType.spellID, barLoc)
	--					print(sType.spellID, sType.actionID, sType.name)
					end
				end
			end
		end
	end
--	local pC, pCE = UnitClass("player")
--	if	(pCE	== "HUNTER") or
--		(pCE	== "WARLOCK") or
--		(pCE	== "DEATHKNIGHT")
--	then
--		barLoc = nextLoc(barLoc)
--		MA("Pet Attack",barLoc)
--		barLoc = nextLoc(barLoc)
--		MA("Pet Follow",barLoc)
--	end
end

--//
--//	debug - check action bar ID
--//
function Zero2Max:CheckActionBar(a)
--	1-12	ActionButton1-12 (1)
--	13-24	ActionButton1-12 page 2 (1.2)
--	61-72	MultiBarBottomLeftButton1-12 (2)
--	49-60	MultiBarBottomRightButton1-12 (3)
--	25-36	MultiBarRightButton1-12 (4)
--	37-48	MultiBarLeftButton1-12 (5)
--	145-156	MultiBar5Button1-12 (6)
--	157-168	MultiBar6Button1-12 (7)
--	169-180	MultiBar7Button1-12 (8)
	local barList =
	{
		[1]   = "Action Bar 1, ActionButton1-12",
		[13]  = "Action Bar 1.2, ActionButton1-12 page 2",
		[25]  = "Action Bar 4, MultiBarRightButton1-12",
		[37]  = "Action Bar 5, MultiBarLeftButton1-12",
		[49]  = "Action Bar 3, MultiBarBottomRightButton1-12",
		[61]  = "Action Bar 2, MultiBarBottomLeftButton1-12 ",
		[73] = "Bonus Bar 1 (Druid Cat,Rogue Stealth)",
		[85] = "Bonus Bar 2 (Druid Cat Stealth)",
		[97] = "Bonus Bar 3 (Druid Bear)",
		[109] = "Bonus Bar 4 (Druid Moonkin)",
		[121] = "Bonus Bar 5 (Dragonriding)",
		[133] = "Bonus Bar 6 (Unknown)",
		[145] = "Action Bar 6, MultiBar5Button1-12",
		[157] = "Action Bar 7, MultiBar6Button1-12",
		[169] = "Action Bar 8, MultiBar7Button1-12",
	}
--	local tc = {1, 13, 61, 49, 25, 37, 145, 157, 169}
	local tc = {}
	if a ~= nil and a == 2 then
		tc = {73, 85, 97, 109, 121, 133}
	else
		tc = {1, 13, 61, 49, 25, 37, 145, 157, 169}
	end
	for k, v in pairs(tc) do
		print(barList[v])
		for i = 1, 12 do 
			local j = i - 1 + v
			local actionType, id, subType = GetActionInfo(j)
			local spellname = nil
		--	if actionType == "spell" and id ~= nil then
		--		local spellinfo = C_SpellBook.GetSpellInfo(id)
		--		spellname = spellinfo.name
		--	end
			print(j, actionType, id, GetActionText(j), spellname)
		end
	end
end

--//
--//	setup common marco 4 (debug image purpose)
--//
function Zero2Max:SetupMacro4()
	local function DelMA()
		Zero2Max:ActionPC(151)
		Zero2Max:ActionPC(152)
		Zero2Max:ActionPC(153)
		Zero2Max:ActionPC(154)
		Zero2Max:ActionPC(155)
		Zero2Max:ActionPC(156)
	end
	local function AddMA()
		Zero2Max:ActionMA("B01",151)
		Zero2Max:ActionMA("B02",152)
		Zero2Max:ActionMA("B03",153)
		Zero2Max:ActionMA("B04",154)
		Zero2Max:ActionMA("B05",155)
		Zero2Max:ActionMA("B06",156)
	end

	local actionType, id, subType = GetActionInfo(151)
	if actionType == "macro" then
		local name = GetActionText(151)
		if (name == "B01") then
			DelMA()
		else
			AddMA()
		end
	else
		AddMA()
	end

end

--//
--//	old
--//
function Zero2Max:ExchangeBar()
--	1-12	ActionButton1-12 (1)
--	13-24	ActionButton1-12 page 2 (1.2)
--	61-72	MultiBarBottomLeftButton1-12 (2)
--	49-60	MultiBarBottomRightButton1-12 (3)
--	25-36	MultiBarRightButton1-12 (4)
--	37-48	MultiBarLeftButton1-12 (5)
--	145-156	MultiBar5Button1-12 (6)
--	157-168	MultiBar6Button1-12 (7)
--	169-180	MultiBar7Button1-12 (8)
	local function WA(a,b)
		local aHas = HasAction(a)
		local bHas = HasAction(b)
		if aHas and bHas then
			PickupAction(a)
			PlaceAction(b)
			PlaceAction(a)
		elseif aHas then
			PickupAction(a)
			PlaceAction(b)
		else
			PickupAction(b)
			PlaceAction(a)
		end
	end
	-- swap action bar 4 with 3
	local i = 1
	local j = 25 - 1
	local k = 49 - 1
	for i = 1, 12, 1 do
		WA(j+i, k+i)
	end
	-- swap action bar 7 with 4
	local j = 157 - 1
	local k = 25 - 1
	for i = 1, 12, 1 do
		WA(j+i, k+i)
	end
	-- swap action bar 5 with 7
	local j = 37 - 1
	local k = 157 - 1
	for i = 1, 12, 1 do
		WA(j+i, k+i)
	end
	
	--x 4 => 3
	--x 7 => 4
	--x 3 => 5
	--x 5 => 7
	
	-- 4 <> 3
	-- 7 <> 4
	-- 5 <> 7
	
	-- 5
	-- 3
	-- 7
	-- 4
end

--//
--//	setup common marco 3 (for cooldown viewer)
--//
function Zero2Max:SetupMacro3()
	local function PC(a)
		PickupAction(a)
		PutItemInBackpack()
		ClearCursor()
	end
	local function MA(a,b)
		PickupMacro(a)
		PlaceAction(b)
		ClearCursor()
	end
	local function SA(a,b)
		C_Spell.PickupSpell(a)
		PlaceAction(b)
		ClearCursor()
	end
	local function WA(a,b)
		local aHas = HasAction(a)
		local bHas = HasAction(b)
		if aHas and bHas then
			PickupAction(a)
			PlaceAction(b)
			PlaceAction(a)
		elseif aHas then
			PickupAction(a)
			PlaceAction(b)
		else
			PickupAction(b)
			PlaceAction(a)
		end
	end

	SA(1231411,174)
	SA(1229376,175)
	WA(155,148)
	WA(156,149)

	local chkset = C_CVar.GetCVar("cooldownViewerEnabled")
	if chkset == "0" then
		local setc = C_CVar.SetCVar("cooldownViewerEnabled", "1")
		if setc ~= nil and setc then
			print("Zero2Max:" .. "update cooldownViewerEnabled success")
		end
	end

	local info = C_EditMode.GetLayouts()
	local layout = info.layouts
	local active = info.activeLayout
	if active ~= 3 then
		C_EditMode.SetActiveLayout(3)
		print("Zero2Max:" .. "change active layout to 3")
	end

end

--//
--//	testing
--//
function Zero2Max:PutItemToBank()

	if Zero2Max.inBank then
		local bagN = NUM_BAG_SLOTS + 1
		local bagNS = C_Container.GetContainerNumSlots(bagN)
		local bagNF = C_Container.GetContainerNumFreeSlots(bagN)
	--	print("bag", bagN, bagNS, bagNF)
		for bagItem = 1, bagNS, 1
		do 
			local bagII = C_Container.GetContainerItemInfo(bagN, bagItem)
			if bagII ~= nil then
				if not bagII.isBound then
					local bagILink = C_Container.GetContainerItemLink(bagN, bagItem)
					local bagIname = GetItemInfo(bagILink)
					print("Item", bagIname)
					C_Container.UseContainerItem(bagN, bagItem)
				end
			end
		end
	else
		print("not in bank")
	end

end

function Zero2Max:CopyMoonkin()
--	local tc = {1, 13, 61, 49, 25, 37, 145, 157, 169}
	local tc = {1}
	local delta = 108
	for k, v in pairs(tc) do
		for i = 2, 12 do
			local j = i - 1 + v
			local actionType, id, subType = GetActionInfo(j)
			local spellname = nil

			print(j, actionType, id, GetActionText(j), spellname)
			if	id ~= nil
			then
				local id2 = C_Spell.GetBaseSpell(id)
				local w = j + delta
				Zero2Max:ActionSA(id2,w)
			end
		end
	end
end


function Zero2Max:CopySetup()
	local pC, pCE = UnitClass("player")
	local pEF, pF = UnitFactionGroup("player")
--	if self.pEnFaction == "Alliance" then
--	if self.pEnFaction == "Horde" then
--		self.pFactI = 1
--	else
--		self.pFactI = 2
--	end

	local specNo = C_SpecializationInfo.GetSpecialization()
	local tcfull = {}

	if	(pCE	== "ROGUE") then
		if specNo == 1 then
			tcfull =
			{
				[2] = 185311, [3] = 51723, [4] = 315496, [5] = 1329, [6] = 32645,
					[7] = 703, [8] = 1943, [9] = 1766, [10] = 408, [11] = 36554, [12] = 185565,
				[61] = 1776, [62] = 5938, [63] = 1784, [64] = 2983,
				[53] = 1247227, [54] = 385627, [55] = 360194, [56] = 381623,
				[46] = 56814, [47] = 1804,
				[164] = 1966, [165] = 1856, [166] = 2094, [167] = 5277, [168] = 31224,
				[74] = 185311, [75] = 921, [76] = 114018, [77] = 8676, [78] = 1833,
					[79] = 703, [80] = 6770, [81] = 1766, [82] = 408, [83] = 36554, [84] = 1725,
			}
		elseif specNo == 2 then
			tcfull =
			{
--				[2] = , [3] = , [4] = ,	[5] = , [6] = ,	
--					[7] = , [8] = , [9] = , [10] = , [11] = , [12] = ,
--				[61] = ,  [62] = , [63] = , [64] = , [65] = , [66] = ,
--					[67] = , [68] = , [69] = , [70] = , [71] = , [72] = ,
--				[37] = , [38] = ,
--				[164] = , [165] = , [166] = , [167] = , [168] = ,
			}
		elseif specNo == 3 then
			tcfull =
			{
--				[2] = , [3] = , [4] = ,	[5] = , [6] = ,	
--					[7] = , [8] = , [9] = , [10] = , [11] = , [12] = ,
--				[61] = ,  [62] = , [63] = , [64] = , [65] = , [66] = ,
--					[67] = , [68] = , [69] = , [70] = , [71] = , [72] = ,
--				[37] = , [38] = ,
--				[164] = , [165] = , [166] = , [167] = , [168] = ,
			}
		end
	end
	if	(pCE	== "HUNTER") then
		if specNo == 1 then
			tcfull =
			{
				[4] = 1264359, [5] = 193455, [6] = 34026,
					[7] = 217200, [8] = 19574, [9] = 147362, [10] = 187650, [11] = 186265, [12] = 19577,
				[61] = 257284, [63] = 264735, [64] = 186257,
					[69] = 209997, [70] = 61648, [71] = 272682, [72] = 272678,
				[45] = 127933, [46] = 125050,
				[163] = 1543, [164] = 5384, [165] = 195645, [166] = 781,
			}
		elseif specNo == 2 then
		elseif specNo == 3 then
		end
	end
	if	(pCE	== "WARLOCK") then
		if specNo == 1 then
		elseif specNo == 2 then
		elseif specNo == 3 then
			tcfull =
			{
				[2] = 234153, 
					[3] = 119898,
				--	[3] = 119905, [3] = 119907, 
					[4] = 116858, [5] = 29722, [6] = 348,
					[7] = 17962, [8] = 6789, [9] = 5782, [10] = 30283, [11] = 334275, [12] = 1271748,
				[61] = 1214467, [62] = 108416, [63] = 104773, [64] = 1122,
					[72] = 702,
				[166] = 111771,
			}
		end
	end
	if	(pCE	== "DEATHKNIGHT") then
		if specNo == 1 then
		elseif specNo == 2 then
			tcfull =
			{
				[2] = 49998, [3] = 194913, [4] = 207230, [5] = 49020, [6] = 49143,
					[7] = 49184, [8] = 47541, [9] = 47528, [10] = 45524, [11] = 43265, [12] = 439843,
				[61] = 51271, [62] = 47568, [63] = 48265, [64] = 49576,
					[71] = 46585, [72] = 56222,
				[53] = 279302, [54] = 49039, [55] = 48792, [56] = 207167,
					[60] = 127344,
				[165] = 51052, [166] = 48707,
			}
		elseif specNo == 3 then
		end
	end
	if	(pCE	== "EVOKER") then
		if specNo == 1 then
			tcfull =
			{
				[2] = 360995, [3] = 382411, [4] = 382266, [5] = 362969, [6] = 361469,
					[7] = 356995, [8] = 357211, [9] = 351338, [10] = 368970, [11] = 363916, [12] = 358385,
				[61] = 355913, [62] = 375087, [63] = 358267, [64] = 357210,
					[69] = 374251, [70] = 365585, [72] = 390386,
				[53] = 370553,
				[37] = 364342,
				[168] = 370665,
			}
		elseif specNo == 2 then
		elseif specNo == 3 then
		end
	end
	if	(pCE	== "MAGE") then
		if specNo == 1 then
		elseif specNo == 2 then
		elseif specNo == 3 then
			tcfull =
			{
				[2] = 414658, [3] = 157980, [4] = 1449, [5] = 199786, [6] = 44614,
					[7] = 30455, [8] = 205021, [9] = 122, [10] = 157997, [11] = 11426, [12] = 2139,
				[61] = 1248829, [62] = 55342, [63] = 1953, [64] = 84714,
					[69] = 475, [70] = 30449, [71] = 118, [72] = 80353,
				[166] = 110959, [167] = 342245, [168] = 130,
			}
		end
	end
	if	(pCE	== "MONK") then
		if specNo == 1 then
			tcfull =
			{
--				[2] = , [3] = , [4] = ,	[5] = , [6] = ,	
--					[7] = , [8] = , [9] = , [10] = , [11] = , [12] = ,
--				[61] = ,  [62] = , [63] = , [64] = , [65] = , [66] = ,
--					[67] = , [68] = , [69] = , [70] = , [71] = , [72] = ,
--				[37] = , [38] = ,
--				[164] = , [165] = , [166] = , [167] = , [168] = ,
			}
		elseif specNo == 2 then
			tcfull =
			{
--				[2] = , [3] = , [4] = ,	[5] = , [6] = ,	
--					[7] = , [8] = , [9] = , [10] = , [11] = , [12] = ,
--				[61] = ,  [62] = , [63] = , [64] = , [65] = , [66] = ,
--					[67] = , [68] = , [69] = , [70] = , [71] = , [72] = ,
--				[37] = , [38] = ,
--				[164] = , [165] = , [166] = , [167] = , [168] = ,
			}
		elseif specNo == 3 then
			tcfull =
			{
				[2] = 116670, [3] = 117952, [4] = 101546, [5] = 100780, [6] = 100784,
					[7] = 107428, [8] = 113656, [9] = 116705, [10] = 392983, [11] = 119381, [12] = 115078,
				[61] = 322109, [62] = 122470, [63] = 109132, [64] = 1249625,
					[69] = 218164, [70] = 116095, [72] = 115546,
				[47] = 126892, 
				[53] = 115203, [54] = 116844,
				[165] = 101643, [166] = 119996, [167] = 101545, [168] = 116841,
			}
		end
	end
	if	(pCE	== "PRIEST") then
		if specNo == 1 then
			tcfull =
			{
--				[2] = , [3] = , [4] = ,	[5] = , [6] = ,	
--					[7] = , [8] = , [9] = , [10] = , [11] = , [12] = ,
--				[61] = ,  [62] = , [63] = , [64] = , [65] = , [66] = ,
--					[67] = , [68] = , [69] = , [70] = , [71] = , [72] = ,
--				[37] = , [38] = ,
--				[164] = , [165] = , [166] = , [167] = , [168] = ,
			}
		elseif specNo == 2 then
			tcfull =
			{
--				[2] = , [3] = , [4] = ,	[5] = , [6] = ,	
--					[7] = , [8] = , [9] = , [10] = , [11] = , [12] = ,
--				[61] = ,  [62] = , [63] = , [64] = , [65] = , [66] = ,
--					[67] = , [68] = , [69] = , [70] = , [71] = , [72] = ,
--				[37] = , [38] = ,
--				[164] = , [165] = , [166] = , [167] = , [168] = ,
			}
		elseif specNo == 3 then
			tcfull =
			{
				[2] = 2061, [3] = 17, [4] = 263165, [5] = 15407, [6] = 8092,
					[7] = 589, [8] = 34914, [9] = 8122, [10] = 15487, [11] = 1227280, [12] = 335467,
				[61] = 32379, [62] = 10060, [63] = 19236, [64] = 47585,
					[69] = 528,
				[53] = 228260, [54] = 15286,
			--	[163] = 232698, [165] = 121536, [166] = 73325, [167] = 1706, [168] = 586,
				[165] = 121536, [166] = 73325, [167] = 1706, [168] = 586,
			}
		end
	end
	if	(pCE	== "WARRIOR") then
		if specNo == 1 then
			tcfull =
			{
				[2] = 202168, [3] = 100, [4] = 845, [5] = 12294, [6] = 772,
					[7] = 7384, [8] = 281000, [9] = 6552, [10] = 167105, [11] = 436358, [12] = 57755,
				[61] = 1464, [62] = 260708, [63] = 97462, [64] = 18499,
					[72] = 355,
				[53] = 227847, [54] = 46968, [55] = 118038, [56] = 107570, [59] = 23922, [60] = 2565,
				[37] = 6673,
				[166] = 1715, [167] = 6544, [168] = 23920,
			}
		elseif specNo == 2 then
			tcfull =
			{
--				[2] = , [3] = , [4] = ,	[5] = , [6] = ,	
--					[7] = , [8] = , [9] = , [10] = , [11] = , [12] = ,
--				[61] = ,  [62] = , [63] = , [64] = , [65] = , [66] = ,
--					[67] = , [68] = , [69] = , [70] = , [71] = , [72] = ,
--				[37] = , [38] = ,
--				[164] = , [165] = , [166] = , [167] = , [168] = ,
			}
		elseif specNo == 3 then
			tcfull =
			{
--				[2] = , [3] = , [4] = ,	[5] = , [6] = ,	
--					[7] = , [8] = , [9] = , [10] = , [11] = , [12] = ,
--				[61] = ,  [62] = , [63] = , [64] = , [65] = , [66] = ,
--					[67] = , [68] = , [69] = , [70] = , [71] = , [72] = ,
--				[37] = , [38] = ,
--				[164] = , [165] = , [166] = , [167] = , [168] = ,
			}
		end
	end
	if	(pCE	== "DEMONHUNTER") then
		if specNo == 1 then
			tcfull =
			{
				[2] = 191427, [3] = 185123, [4] = 232893, [5] = 162794, [6] = 188499,
					[7] = 198013, [8] = 258920, [9] = 183752, [10] = 179057, [11] = 207684, [12] = 370965,
				[63] = 195072, [64] = 198589,
					[72] = 185245,
				[48] = 188501,
				[168] = 198793,
			}
		elseif specNo == 2 then
			tcfull =
			{
--				[2] = , [3] = , [4] = ,	[5] = , [6] = ,	
--					[7] = , [8] = , [9] = , [10] = , [11] = , [12] = ,
--				[61] = ,  [62] = , [63] = , [64] = , [65] = , [66] = ,
--					[67] = , [68] = , [69] = , [70] = , [71] = , [72] = ,
--				[37] = , [38] = ,
--				[164] = , [165] = , [166] = , [167] = , [168] = ,
			}
		elseif specNo == 3 then
			tcfull =
			{
--				[2] = , [3] = , [4] = ,	[5] = , [6] = ,	
--					[7] = , [8] = , [9] = , [10] = , [11] = , [12] = ,
--				[61] = ,  [62] = , [63] = , [64] = , [65] = , [66] = ,
--					[67] = , [68] = , [69] = , [70] = , [71] = , [72] = ,
--				[37] = , [38] = ,
--				[164] = , [165] = , [166] = , [167] = , [168] = ,
			}
		end
	end


	if	(pCE	== "SHAMAN") then
		if specNo == 1 then
			tcfull =
			{
				[2] = 8004, [3] = 191634, [4] = 188443,	[5] = 188196, [6] = 51505,	
					[7] = 470411, [8] = 8042, [9] = 57994, [10] = 51490, [11] = 114050, [12] = 462620,
				[61] = 378081,  [62] = 198103, [63] = 2645, [64] = 108271, [72] = 32182,
				[37] = 192106, [38] = 462854,
				[164] = 192077, [165] = 192058, [166] = 51485, [167] = 58875, [168] = 79206,
			}
			if pEF == "Horde" then
				tcfull[72] = 2825
			end
		elseif specNo == 2 then
			tcfull =
			{
				[2] = 8004, [3] = 5394, [4] = 188443, [5] = 17364, [6] = 188196,
					[7] = 470057, [8] = 187874, [9] = 57994, [10] = 114051, [11] = 60103, [12] = 444995,
				[61] = 974, [62] = 1064, [63] = 2645, [64] = 108271,
					[72] = 32182,
				[37] = 192106, [38] = 462854, [39] = 318038, [40] = 33757,
				[164] = 192077, [165] = 192058, [166] = 2484, [167] = 192063, [168] = 196884,
			}
			if pEF == "Horde" then
				tcfull[72] = 2825
			end
		elseif specNo == 3 then
			tcfull =
			{
				[2] = 77472, [3] = 5394, [4] = 1064, [5] = 61295, [6] = 73920,	
					[7] = 470411, [8] = 443454, [9] = 188196, [10] = 51505, [11] = 98008, [12] = 114052,
				[61] = 974,  [62] = 198103, [63] = 2645, [64] = 108271,
					[69] = 77130, [72] = 32182,
				[37] = 192106, [38] = 462854, [39] = 52127, [40] = 382021,
				[164] = 192077, [165] = 192058, [166] = 2484, [167] = 58875, [168] = 79206,
			}
			if pEF == "Horde" then
				tcfull[72] = 2825
			end
		end
	end

	if	(pCE	== "PALADIN") then
		if specNo == 1 then
			tcfull =
			{
				[2] = 19750, [3] = 156322, [4] = 85222,	[5] = 20473, [6] = 82326,	
					[7] = 275773, [8] = 415091, [9] = 853, [10] = 200025, [11] = 375576, [12] = 115750,
				[61] = 6940,  [62] = 31884, [63] = 498, [64] = 190784, [69] = 4987, [72] = 62124,
				[53] = 31821,
				[32] = 121183,
				[165] = 642, [166] = 633, [167] = 1022, [168] = 1044,
			}
		elseif specNo == 2 then
			tcfull =
			{
				[2] = 19750, [3] = 85673, [4] = 204019,	[5] = 275779, [6] = 31935,	
					[7] = 26573, [8] = 53600, [9] = 853, [10] = 96231, [11] = 375576, [12] = 432459,
				[61] = 6940,  [63] = 62124, [64] = 190784, [69] = 213644,
				[53] = 389539, [54] = 31850, [55] = 86659,
				[32] = 121183,
				[37] = 433583,
				[165] = 642, [166] = 633, [167] = 1022, [168] = 1044,
			}
		elseif specNo == 3 then
			tcfull =
			{
				[2] = 19750, [3] = 85673, [4] = 255937,	[5] = 20271, [6] = 184575,	
					[7] = 383328, [8] = 53385, [9] = 853, [10] = 96231, [11] = 375576, [12] = 115750,
				[61] = 6940,  [63] = 403876, [64] = 190784, [72] = 62124,
				[31] = 53600, [32] = 121183,
				[165] = 642, [166] = 633, [167] = 1022, [168] = 1044,
			}
		end
	end
	if	(pCE	== "DRUID") then
		if specNo == 1 then
			tcfull =
			{
				[2] = 8936, [3] = 1233272, [4] = 78674,	[5] = 194153, [6] = 190984,	
					[7] = 8921, [8] = 93402, [9] = 78675, [10] = 339, [11] = 191034, [12] = 202770,
				[61] = 390414,  [62] = 99, [63] = 132469, [64] = 22812, 
					[69] = 2908, [71] = 2782,
				[37] = 1126,
			--	[163] = 5487, [164] = 768, [165] = 24858, [166] = 5215, [167] = 252216, [168] = 102793,
				[164] = 164862, [165] = 106898, [166] = 5215, [167] = 252216, [168] = 102793,
				[74] = 8936, [77] = 5221, [78] = 22568, [81] = 78675, [82] = 339,
				[98] = 8936, [99] = 22842, [100] = 6795, [101] = 33917, [102] = 77758, [105] = 78675, [106] = 339,
				[109] = 1229376, [110] = 8936, [111] = 1233272, [112] = 78674, [113] = 194153, [114] = 190984,	
					[115] = 8921, [116] = 93402, [117] = 78675, [118] = 339, [119] = 191034, [120] = 202770,
			}
		elseif specNo == 2 then
			tcfull =
			{
				[2] = 8936, [5] = 5176, [7] = 8921, [10] = 339, 
				[61] = 102543, [62] = 99, [63] = 22812, [64] = 77764, [69] = 2908, [71] = 2782, [72] = 29166,
				[52] = 61336,
				[163] = 5487, [164] = 768, [166] = 5215, [167] = 252216, [168] = 102793,
				[74] = 8936, [75] = 5217, [76] = 1822, [77] = 5221, [78] = 22568, [79] = 213764,
					[80] = 1079, [81] = 106839, [82] = 339, [83] = 1243807, [84] = 285381,
				[98] = 8936, [99] = 22842, [100] = 6795, [101] = 33917,
					[102] = 77758, [103] = 213764, [105] = 106839, [106] = 339,
			}
		elseif specNo == 3 then
			tcfull =
			{
				[2] = 8936, [5] = 5176, [7] = 8921, [10] = 339,
				[61] = 102558, [62] = 1261867, [63] = 22812, [64] = 77764, [69] = 2908, [71] = 2782,
				[53] = 61336, [54] = 400254, [55] = 204066,
				[163] = 5487, [164] = 768, [166] = 5215, [167] = 1850, [168] = 102793,
				[74] = 8936, [76] = 1822, [77] = 5221, [78] = 22568, [79] = 106785,
					[80] = 1079, [81] = 106839, [82] = 339, [84] = 49376,
				[98] = 8936, [99] = 22842, [100] = 6795, [101] = 33917, [102] = 77758, [103] = 106785, 
					[104] = 400254, [105] = 106839, [106] = 339, [107] = 192081, [108] = 49376,
			}
		elseif specNo == 4 then
			tcfull =
			{
				[2] = 8936, [4] = 197626, [5] = 774, [6] = 33763, [7] = 8921,
					[8] = 93402, [9] = 48438, [10] = 339, [11] = 18562, [12] = 740,
				[61] = 33891, [62] = 1261867, [63] = 22812, [64] = 106898, [69] = 102359, [71] = 88423, [72] = 29166,
				[52] = 132158, [53] = 102342, [59] = 197628, [60] = 5176,
				[163] = 5487, [164] = 768, [165] = 24858, [166] = 5215, [167] = 252216, [168] = 33786,
				[74] = 8936, [77] = 5221, [78] = 22568, [82] = 339, 
				[98] = 8936, [99] = 22842, [100] = 6795, [101] = 33917, [102] = 77758, [106] = 339,
				[109] = 1229376, [110] = 8936, [112] = 78674, [113] = 194153, [114] = 5176,
					[115] = 8921, [116] = 93402, [118] = 339, [119] = 18562,
			}
		end
	end

	if tcfull == {} then
		print("Zero2Max:" .. "setup end, no setting")
	else
		Zero2Max:ActionPCX(2,12)
		Zero2Max:ActionPCX(61,72)
		Zero2Max:ActionPCX(49,60)
		Zero2Max:ActionPCX(25,36)
		Zero2Max:ActionPCX(37,41)
		Zero2Max:ActionPCX(163,168)
		for k, v in pairs(tcfull) do
			local id2 = C_Spell.GetBaseSpell(v)
			Zero2Max:ActionSA(id2,k)
		end
		print("Zero2Max:" .. "setup end, copied")
	end


	Zero2Max:SetupMacro2()
	Zero2Max:CopySetupCommonAndClassMacro()
	Zero2Max:CopySetupFlyout()
	Zero2Max:CopySetupRace()
	Zero2Max:CopyPVPTalent()


end


function Zero2Max:CopySetupRace()
	local pR, pER, pRN = UnitRace("player")

--	Human, 1
	if pER == "Human" then
		Zero2Max:ActionSA(59752,49)
	end

--	Orc, 2
	if pER == "Orc" then
		Zero2Max:ActionSA(20572,49)
		Zero2Max:ActionSA(33697,49)
		Zero2Max:ActionSA(33702,49)
	end

--	Dwarf, 3
	if pER == "Dwarf" then
		Zero2Max:ActionSA(20594,49)
	end

--	NightElf, 4
	if pER == "NightElf" then
		Zero2Max:ActionSA(58984,49)
	end

--	Scourge, 5
	if pER == "Scourge" then
		Zero2Max:ActionSA(7744,49)
		Zero2Max:ActionSA(20577,50)
	end

--	Tauren, 6
	if pER == "Tauren" then
		Zero2Max:ActionSA(20549,49)
	end

--	Gnome, 7
	if pER == "Gnome" then
		Zero2Max:ActionSA(20589,49)
	end

--	Troll, 8
	if pER == "Troll" then
		Zero2Max:ActionSA(26297,49)
	end

--	Goblin, 9
	if pER == "Goblin" then
		Zero2Max:ActionSA(69041,49)
		Zero2Max:ActionSA(69070,50)
		Zero2Max:ActionSA(69046,25)
	end

--	BloodElf, 10
	if pER == "BloodElf" then
		Zero2Max:ActionSA(25046,49)
		Zero2Max:ActionSA(28730,49)
		Zero2Max:ActionSA(50613,49)
		Zero2Max:ActionSA(69179,49)
		Zero2Max:ActionSA(80483,49)
		Zero2Max:ActionSA(129597,49)
		Zero2Max:ActionSA(155145,49)
		Zero2Max:ActionSA(202719,49)
		Zero2Max:ActionSA(232633,49)
	end

--	Draenei, 11
	if pER == "Draenei" then
		Zero2Max:ActionSA(28880,49)
		Zero2Max:ActionSA(59542,49)
		Zero2Max:ActionSA(59543,49)
		Zero2Max:ActionSA(59544,49)
		Zero2Max:ActionSA(59545,49)
		Zero2Max:ActionSA(59547,49)
		Zero2Max:ActionSA(59548,49)
		Zero2Max:ActionSA(121093,49)
		Zero2Max:ActionSA(370626,49)
		Zero2Max:ActionSA(416250,49)
	end

--	Worgen, 22
	if pER == "Worgen" then
		Zero2Max:ActionSA(68992,49)
		Zero2Max:ActionSA(68996,25)
		Zero2Max:ActionSA(406087,26)
		Zero2Max:ActionSA(87840,27)
	end

--	Pandaren, 26
	if pER == "Pandaren" then
		Zero2Max:ActionSA(107079,49)
	end

--	Nightborne, 27
	if pER == "Nightborne" then
		Zero2Max:ActionSA(260364,49)
		Zero2Max:ActionSA(255661,25)
	end

--	HighmountainTauren, 28
	if pER == "HighmountainTauren" then
		Zero2Max:ActionSA(255654,49)
	end

--	VoidElf, 29
	if pER == "VoidElf" then
		Zero2Max:ActionSA(256948,49)
	end

--	LightforgedDraenei, 30
	if pER == "LightforgedDraenei" then
		Zero2Max:ActionSA(255647,49)
		Zero2Max:ActionSA(259930,25)
	end

--	ZandalariTroll, 31
	if pER == "ZandalariTroll" then
		Zero2Max:ActionSA(291944,49)
		Zero2Max:ActionSA(281954,50)
		Zero2Max:ActionSA(292752,25)
	end

--	KulTiran, 32
	if pER == "KulTiran" then
		Zero2Max:ActionSA(287712,49)
	end

--	DarkIronDwarf, 34
	if pER == "DarkIronDwarf" then
		Zero2Max:ActionSA(265221,49)
		Zero2Max:ActionSA(265225,25)
	end

--	Vulpera, 35
	if pER == "Vulpera" then
		Zero2Max:ActionSA(312411,49)
		Zero2Max:ActionSA(312425,50)
		Zero2Max:ActionSA(312370,25)
		Zero2Max:ActionSA(312372,26)
	end

--	MagharOrc, 36
	if pER == "MagharOrc" then
		Zero2Max:ActionSA(274738,49)
	end

--	Mechagnome, 37
	if pER == "Mechagnome" then
		Zero2Max:ActionSA(312924,49)
		Zero2Max:ActionSA(312890,25)
	end

--	Dracthyr, 70
	if pER == "Dracthyr" then
		Zero2Max:ActionSA(357214,49)
		Zero2Max:ActionSA(403216,50)
		Zero2Max:ActionSA(351239,25)
		Zero2Max:ActionSA(360022,26)
		Zero2Max:ActionSA(369536,27)
	end

--	EarthenDwarf, 84
	if pER == "EarthenDwarf" then
		Zero2Max:ActionSA(436344,49)
		Zero2Max:ActionSA(461063,50)
	end

	print("Zero2Max:" .. "setup race end")

end



function Zero2Max:CopySetupCommonAndClassMacro()
	local pC, pCE = UnitClass("player")
--	eat
	Zero2Max:ActionSA(1231411,174)

--	rotate key
	Zero2Max:ActionSA(1229376,1)
	if	(pCE	== "ROGUE") then
		Zero2Max:ActionSA(1229376,73)				-- sub
	end
	if	(pCE	== "DRUID") then
		Zero2Max:ActionSA(1229376,73)				-- cat
		Zero2Max:ActionSA(1229376,97)				-- bear
	end

--	pet attack and follow
	if	(pCE	== "HUNTER") or
		(pCE	== "WARLOCK") or
		(pCE	== "DEATHKNIGHT") then
		Zero2Max:ActionMA("Pet Attack",167)
		Zero2Max:ActionMA("Pet Follow",168)
	end

--	class macro
	if	(pCE	== "DEATHKNIGHT") then
		Zero2Max:ActionMA("Z9DK1",48)
	end
	if	(pCE	== "DRUID") then
		Zero2Max:ActionMA("Z9DR1",48)
--		Zero2Max:ActionSA(1126,37)
--		Zero2Max:ActionSA(5487,163)
--		Zero2Max:ActionSA(768,164)
--		Zero2Max:ActionSA(5215,166)
	end
	if	(pCE	== "EVOKER") then
		Zero2Max:ActionMA("Z9EV1",48)
	end
	if	(pCE	== "HUNTER") then
		Zero2Max:ActionMA("Z9HU1",2)
		Zero2Max:ActionMA("Z9HU2",3)
	end
	if	(pCE	== "MAGE") then
		Zero2Max:ActionMA("Z9MA1",37)
	end
	if	(pCE	== "MONK") then
		Zero2Max:ActionMA("Z9MO1",48)
	end
	if	(pCE	== "PALADIN") then
		Zero2Max:ActionMA("Z9PA1",48)
	end
	if	(pCE	== "PRIEST") then
		Zero2Max:ActionMA("Z9PR1",37)
	end
	if	(pCE	== "SHAMAN") then
		Zero2Max:ActionMA("Z9SH1",48)
	end
	if	(pCE	== "WARLOCK") then
		Zero2Max:ActionMA("Z9WL1",47)
		Zero2Max:ActionMA("Z9WL2",37)
	end

	print("Zero2Max:" .. "setup class macro end")

end



function Zero2Max:CopySetupFlyout()
	local pC, pCE = UnitClass("player")
	local pEF, pF = UnitFactionGroup("player")				-- "Alliance" or "Horde"
	local j = 0
	if	(pCE	== "HUNTER") then
		j = Zero2Max:GetSpellBookFlyout(9)					-- 9	summon pet
		if j ~= nil then
			Zero2Max:ActionSBA(j, 48)
		end
		j = Zero2Max:GetSpellBookFlyout(103)				-- 103	pet manage
		if j ~= nil then 
			Zero2Max:ActionSBA(j, 47)
		end
	end
	if	(pCE	== "MAGE") then
		if pEF == "Alliance" then 
			j = Zero2Max:GetSpellBookFlyout(8)				-- 8	transport (alliance)
		else
			j = Zero2Max:GetSpellBookFlyout(1)				-- 1	transport (horde)
		end
		if j ~= nil then
			Zero2Max:ActionSBA(j, 48)
		end
		if pEF == "Alliance" then 
			j = Zero2Max:GetSpellBookFlyout(12)			-- 12	transport door (alliance)
		else
			j = Zero2Max:GetSpellBookFlyout(11)			-- 11	transport door (horde)
		end
		if j ~= nil then
			Zero2Max:ActionSBA(j, 47)
		end
		j = Zero2Max:GetSpellBookFlyout(92)				-- 92	sheep change
		if j ~= nil then
			Zero2Max:ActionSBA(j, 46)
		end
	end
	if	(pCE	== "ROGUE") then
		j = Zero2Max:GetSpellBookFlyout(66)				-- 66	poison
		if j ~= nil then
			Zero2Max:ActionSBA(j, 48)
		end
	end
	if	(pCE	== "SHAMAN") then
		j = Zero2Max:GetSpellBookFlyout(106)				-- 106	frog change
		if j ~= nil then
			Zero2Max:ActionSBA(j, 47)
		end
	end
	if	(pCE	== "WARLOCK") then
		j = Zero2Max:GetSpellBookFlyout(10)				-- 10	summon demon
		if j ~= nil then
			Zero2Max:ActionSBA(j, 48)
		end
	end

	j = Zero2Max:GetSpellBookFlyout(224)					-- 224	hero road: legion
	if j ~= nil then
	--	Zero2Max:ActionSBA(j, 150)
		Zero2Max:ActionSBA(j, 152)
	end

	print("Zero2Max:" .. "setup flyout end")

end



function Zero2Max:CopyPVPTalent()
	local pC, pCE = UnitClass("player")
	local specNo = C_SpecializationInfo.GetSpecialization()

	local tcfull = {}
	tcfull["DEATHKNIGHT"] = {
		[2] = {701, 3439, 5510,},
	}
	tcfull["DEMONHUNTER"] = {
		[1] = {5523, 1218, 813,},
	}
	tcfull["DRUID"] = {
		[1] = {5646, 5604, 5515,},
		[2] = {5647, 203, 601,},
		[3] = {5648, 3750, 1237,},
		[4] = {5649, 5687, 5514,},
	}
	tcfull["EVOKER"] = {
		[1] = {5469, 5460, 5462,},
	}
	tcfull["HUNTER"] = {
		[1] = {693, 3599, 5534,},
	}
	tcfull["MAGE"] = {
		[3] = {5708, 632, 5581,},
	}
	tcfull["MONK"] = {
		[3] = {3745, 3744, 3737,},
	}
	tcfull["PALADIN"] = {
		[1] = {5676, 87, 640,},
		[2] = {5677, 91, 90,},
		[3] = {5675, 5572, 5535,},
	}
	tcfull["PRIEST"] = {
		[3] = {5568, 106, 5447,},
	}
	tcfull["ROGUE"] = {
		[1] = {3448, 5697, 830,},
	}
	tcfull["SHAMAN"] = {
		[1] = {5681, 5660, 5724,},
		[2] = {3489, 722, 5722,},
		[3] = {3755, 5704, 5437,},
	}
	tcfull["WARLOCK"] = {
		[3] = {157, 164, 5580,},
	}
	tcfull["WARRIOR"] = {
		[1] = {28, 31, 33,},
	}

	LearnPvpTalent(tcfull[pCE][specNo][1], 1)
	LearnPvpTalent(tcfull[pCE][specNo][2], 2)
	LearnPvpTalent(tcfull[pCE][specNo][3], 3)
	
	print("Zero2Max:" .. "setup pvp talent end")

end



function Zero2Max:SavePVPTalent()
	local pC, pCE = UnitClass("player")
	local specNo = C_SpecializationInfo.GetSpecialization()
	if Zero2Max_Master_DB == nil then
		Zero2Max_Master_DB = {}
	end
	if Zero2Max_Master_DB[pCE] == nil then
		Zero2Max_Master_DB[pCE] = {}
	end
	Zero2Max_Master_DB[pCE][specNo] = C_SpecializationInfo.GetAllSelectedPvpTalentIDs()

end



function Zero2Max:SaveActionBar()
	local pC, pCE = UnitClass("player")
	local specNo = C_SpecializationInfo.GetSpecialization()
	if Zero2Max_Master_DB2 == nil then
		Zero2Max_Master_DB2 = {}
	end
	if Zero2Max_Master_DB2[pCE] == nil then
		Zero2Max_Master_DB2[pCE] = {}
	end
	Zero2Max_Master_DB2[pCE][specNo] = nil
	Zero2Max_Master_DB2[pCE][specNo] = {}
--	1-12	ActionButton1-12 (1)
--	13-24	ActionButton1-12 page 2 (1.2)
--	61-72	MultiBarBottomLeftButton1-12 (2)
--	49-60	MultiBarBottomRightButton1-12 (3)
--	25-36	MultiBarRightButton1-12 (4)
--	37-48	MultiBarLeftButton1-12 (5)
--	145-156	MultiBar5Button1-12 (6)
--	157-168	MultiBar6Button1-12 (7)
--	169-180	MultiBar7Button1-12 (8)
	local barList =
	{
		[1]   = "Action Bar 1, ActionButton1-12",
		[13]  = "Action Bar 1.2, ActionButton1-12 page 2",
		[25]  = "Action Bar 4, MultiBarRightButton1-12",
		[37]  = "Action Bar 5, MultiBarLeftButton1-12",
		[49]  = "Action Bar 3, MultiBarBottomRightButton1-12",
		[61]  = "Action Bar 2, MultiBarBottomLeftButton1-12 ",
		[73] = "Bonus Bar 1 (Druid Cat,Rogue Stealth)",
		[85] = "Bonus Bar 2 (Druid Cat Stealth)",
		[97] = "Bonus Bar 3 (Druid Bear)",
		[109] = "Bonus Bar 4 (Druid Moonkin)",
		[121] = "Bonus Bar 5 (Dragonriding)",
		[133] = "Bonus Bar 6 (Unknown)",
		[145] = "Action Bar 6, MultiBar5Button1-12",
		[157] = "Action Bar 7, MultiBar6Button1-12",
		[169] = "Action Bar 8, MultiBar7Button1-12",
	}
--	local tc = {1, 13, 61, 49, 25, 37, 145, 157, 169, 73, 85, 97, 109, 121, 133}
	local tc = {1, 61, 49, 25, 37, 157, 73, 97, 109}
--	local tc = {}
--	if a ~= nil and a == 2 then
--		tc = {73, 85, 97, 109, 121, 133}
--	else
--		tc = {1, 13, 61, 49, 25, 37, 145, 157, 169}
--	end
	for k, v in pairs(tc) do
		print(barList[v])
		for i = 1, 12 do 
			local j = i - 1 + v
			local actionType, id, subType = GetActionInfo(j)
			local spellname = nil
		--	if actionType == "spell" and id ~= nil then
		--		local spellinfo = C_SpellBook.GetSpellInfo(id)
		--		spellname = spellinfo.name
		--	end
			if id ~= nil then
				if (j == 157) or (j == 158) or (j == 159) or (j == 160) or (j == 161) then
				else
					if (j == 49) or (j == 50) or (j == 51) then
					else
						if (j == 25) or (j == 26) or (j == 27) then
						else
							if (j == 1) or (j == 73) or (j == 97) then
							else
								if actionType == "spell" then
									print(j, actionType, id, GetActionText(j), spellname)
									Zero2Max_Master_DB2[pCE][specNo][j] = id
								end
							end
						end
					end 
				end
			end
		end
	end
end



function Zero2Max:SaveBoth()
	Zero2Max:SavePVPTalent()
	Zero2Max:SaveActionBar()
end



function Zero2Max:SetupBankTag()
	C_Bank.UpdateBankTabSettings(0, 6, "分頁1", 134400, 0)
	C_Bank.UpdateBankTabSettings(0, 7, "分頁2", 134400, 12)
	C_Bank.UpdateBankTabSettings(0, 8, "分頁3", 134400, 2)
	C_Bank.UpdateBankTabSettings(0, 9, "材料", 134400, 128)
	C_Bank.UpdateBankTabSettings(0, 10, "虛空倉庫1", 134400, 1)
	C_Bank.UpdateBankTabSettings(0, 11, "虛空倉庫2", 134400, 1)
end



function Zero2Max:SetupMacro5()
	Zero2Max:ActionMA("Accept4",148)
	Zero2Max:ActionMA("Accept5",149)
	Zero2Max:ActionMA("Y1",150)
	Zero2Max:ActionMA("Y2",151)
	local j = Zero2Max:GetSpellBookFlyout(224)				-- 224	hero road: legion
	if j ~= nil then
		Zero2Max:ActionSBA(j, 152)
	end
end



function Zero2Max:SetupMacro6()
--	Zero2Max:ActionMA("Y3",175)
--	Zero2Max:ActionMA("Y6",176)
--	Zero2Max:ActionMA("Y7",177)
--	Zero2Max:ActionMA("Y8",178)
--	Zero2Max:ActionMA("Y9",179)

end



--	function Zero2Max:SetupMacro7a()
--	
--		if C_TransmogOutfitInfo.HasPendingOutfitTransmogs() then
--			C_TransmogOutfitInfo.CommitAndApplyAllPending(false)
--			return
--		end
--	
--		local OutInfo = C_TransmogOutfitInfo.GetOutfitInfo(2)
--		if OutInfo.name ~= "01I" then 
--			C_TransmogOutfitInfo.CommitOutfitInfo(2,"01I",134400)
--			C_TransmogOutfitInfo.ClearAllPendingTransmogs()
--			C_TransmogOutfitInfo.SetPendingTransmog(0, 0, 0, 77344, 3)
--	--		local slottable = {
--	--			{0,"Head"},
--	--			{1,"ShoulderRight"},
--	--			{2,"ShoulderLeft"},
--	--			{3,"Back"},
--	--			{4,"Chest"},
--	--			{5,"Tabard"},
--	--			{6,"Body"},
--	--			{7,"Wrist"},
--	--			{8,"Hand"},
--	--			{9,"Waist"},
--	--			{10,"Legs"},
--	--			{11,"Feet"},
--	--		--	{12,"WeaponMainHand"},
--	--		--	{13,"WeaponOffHand"},
--	--		--	{14,"WeaponRanged"},
--	--		}
--	
--	--		Head	77344	3
--	
--	--		Body	83202	3
--	
--	--		Tabard	83203	3
--	
--	--		Back	77345	3
--	
--	--		ShoulderRight	77343	3
--	--		ShoulderLeft	77343	3
--	--		Wrist			104604	3
--	--		Hand			94331	3
--	
--	--		Chest			104602	3
--	
--	--		Legs			198608	3
--	
--	--		Waist			84223	3
--	--		Feet			104603	3
--		else
--			OutInfo = C_TransmogOutfitInfo.GetOutfitInfo(3)
--			if OutInfo.name ~= "02I" then
--				C_TransmogOutfitInfo.CommitOutfitInfo(3,"02I",134400)
--				C_TransmogOutfitInfo.ChangeViewedOutfit(3)
--				C_TransmogOutfitInfo.ClearAllPendingTransmogs()
--				C_TransmogOutfitInfo.SetPendingTransmog(6, 0, 0, 83202, 3)
--	
--			else
--				OutInfo = C_TransmogOutfitInfo.GetOutfitInfo(4)
--				if OutInfo.name ~= "03I" then
--					C_TransmogOutfitInfo.CommitOutfitInfo(4,"03I",134400)
--					C_TransmogOutfitInfo.ChangeViewedOutfit(4)
--					C_TransmogOutfitInfo.ClearAllPendingTransmogs()
--					C_TransmogOutfitInfo.SetPendingTransmog(5, 0, 0, 83203, 3)
--	
--				else
--					OutInfo = C_TransmogOutfitInfo.GetOutfitInfo(5)
--					if OutInfo.name ~= "04I" then
--						C_TransmogOutfitInfo.CommitOutfitInfo(5,"04I",134400)
--						C_TransmogOutfitInfo.ChangeViewedOutfit(5)
--						C_TransmogOutfitInfo.ClearAllPendingTransmogs()
--						C_TransmogOutfitInfo.SetPendingTransmog(3, 0, 0, 77345, 3)
--	
--					else
--						OutInfo = C_TransmogOutfitInfo.GetOutfitInfo(36)
--						if OutInfo.name ~= "05I" then
--							C_TransmogOutfitInfo.CommitOutfitInfo(36,"05I",134400)
--							C_TransmogOutfitInfo.ChangeViewedOutfit(36)
--							C_TransmogOutfitInfo.ClearAllPendingTransmogs()
--							C_TransmogOutfitInfo.SetPendingTransmog(1, 0, 0, 77343, 3)
--							C_TransmogOutfitInfo.SetPendingTransmog(2, 0, 0, 77343, 3)
--							C_TransmogOutfitInfo.SetPendingTransmog(7, 0, 0, 104604, 3)
--							C_TransmogOutfitInfo.SetPendingTransmog(8, 0, 0, 94331, 3)
--	
--						else
--							OutInfo = C_TransmogOutfitInfo.GetOutfitInfo(37)
--							if OutInfo.name ~= "06I" then
--								C_TransmogOutfitInfo.CommitOutfitInfo(37,"06I",134400)
--								C_TransmogOutfitInfo.ChangeViewedOutfit(37)
--								C_TransmogOutfitInfo.ClearAllPendingTransmogs()
--								C_TransmogOutfitInfo.SetPendingTransmog(4, 0, 0, 104602, 3)
--	
--							end
--						end
--					end
--				end
--			end
--		end
--	end

--	function Zero2Max:SetupMacro8a()
--		local pEF, pF = UnitFactionGroup("player")				-- "Alliance" or "Horde"
--		local OutInfo = C_TransmogOutfitInfo.GetOutfitInfo(39)
--		if OutInfo.name ~= "07I" then
--			C_TransmogOutfitInfo.CommitOutfitInfo(39,"07I",134400)
--			C_TransmogOutfitInfo.ChangeViewedOutfit(39)
--			C_TransmogOutfitInfo.ClearAllPendingTransmogs()
--			C_TransmogOutfitInfo.SetPendingTransmog(10, 0, 0, 198608, 3)
--	
--		else
--			OutInfo = C_TransmogOutfitInfo.GetOutfitInfo(40)
--			if OutInfo.name ~= "08I" then
--				C_TransmogOutfitInfo.CommitOutfitInfo(40,"08I",134400)
--				C_TransmogOutfitInfo.ChangeViewedOutfit(40)
--				C_TransmogOutfitInfo.ClearAllPendingTransmogs()
--				C_TransmogOutfitInfo.SetPendingTransmog(9, 0, 0, 84223, 3)
--				C_TransmogOutfitInfo.SetPendingTransmog(11, 0, 0, 104603, 3)
--	
--			else
--				OutInfo = C_TransmogOutfitInfo.GetOutfitInfo(41)
--				if OutInfo.name ~= "09R" then
--					C_TransmogOutfitInfo.CommitOutfitInfo(41,"09R",134400)
--					C_TransmogOutfitInfo.ChangeViewedOutfit(41)
--				else
--					OutInfo = C_TransmogOutfitInfo.GetOutfitInfo(42)
--					if OutInfo.name ~= "10R" then
--						C_TransmogOutfitInfo.CommitOutfitInfo(42,"10R",134400)
--						C_TransmogOutfitInfo.ChangeViewedOutfit(42)
--					else
--						OutInfo = C_TransmogOutfitInfo.GetOutfitInfo(62)
--						if OutInfo.name ~= "11G" then
--							C_TransmogOutfitInfo.CommitOutfitInfo(62,"11G",134400)
--							C_TransmogOutfitInfo.ChangeViewedOutfit(62)
--							C_TransmogOutfitInfo.SetPendingTransmog(3, 0, 0, 32835, 1)
--							C_TransmogOutfitInfo.SetPendingTransmog(5, 0, 0, 35448, 1)
--						--	C_TransmogOutfitInfo.CommitOutfitInfo(62,"11G",134400)
--						else
--							OutInfo = C_TransmogOutfitInfo.GetOutfitInfo(63)
--							if OutInfo.name ~= "12F" then
--								C_TransmogOutfitInfo.CommitOutfitInfo(63,"12F",134400)
--								C_TransmogOutfitInfo.ChangeViewedOutfit(63)
--								if pEF == "Horde" then
--									C_TransmogOutfitInfo.SetPendingTransmog(0, 0, 0, 227448, 1)
--									C_TransmogOutfitInfo.SetPendingTransmog(3, 0, 0, 100003, 1)
--									C_TransmogOutfitInfo.SetPendingTransmog(5, 0, 0, 111099, 1)
--								end
--							--	C_TransmogOutfitInfo.CommitOutfitInfo(63,"12F",134400)
--							end
--						end
--					end
--				end
--			end
--		end
--	end


--		local slottable = {
--			{0,"Head"},
--			{1,"ShoulderRight"},
--			{2,"ShoulderLeft"},
--			{3,"Back"},
--			{4,"Chest"},
--			{5,"Tabard"},
--			{6,"Body"},
--			{7,"Wrist"},
--			{8,"Hand"},
--			{9,"Waist"},
--			{10,"Legs"},
--			{11,"Feet"},
--		--	{12,"WeaponMainHand"},
--		--	{13,"WeaponOffHand"},
--		--	{14,"WeaponRanged"},
--		}

-- Hide
--		Head			77344	3
--		Body			83202	3
--		Tabard			83203	3
--		Back			77345	3
--		ShoulderRight	77343	3
--		ShoulderLeft	77343	3
--		Wrist			104604	3
--		Hand			94331	3
--		Chest			104602	3
--		Legs			198608	3
--		Waist			84223	3
--		Feet			104603	3

-- Guild 
--		Back			32835	3
--		Tabard			35448	3

-- Faction
--		Head			227448	3
--		Back			100003	3
--		Tabard			111099	3



function Zero2Max:SetupMacro7()
	if C_TransmogOutfitInfo.HasPendingOutfitTransmogs() then
		C_TransmogOutfitInfo.CommitAndApplyAllPending(false)
		return
	end

	local OutInfo = C_TransmogOutfitInfo.GetOutfitInfo(2)
	if OutInfo.name ~= "01I" then 
		C_TransmogOutfitInfo.ChangeViewedOutfit(2)
		C_TransmogOutfitInfo.CommitOutfitInfo(2,"01I",134400)
	else
		OutInfo = C_TransmogOutfitInfo.GetOutfitInfo(3)
		if OutInfo.name ~= "02I" then
			C_TransmogOutfitInfo.ChangeViewedOutfit(3)
			C_TransmogOutfitInfo.CommitOutfitInfo(3,"02I",134400)
		else
			OutInfo = C_TransmogOutfitInfo.GetOutfitInfo(4)
			if OutInfo.name ~= "03I" then
				C_TransmogOutfitInfo.ChangeViewedOutfit(4)
				C_TransmogOutfitInfo.CommitOutfitInfo(4,"03I",134400)
			else
				OutInfo = C_TransmogOutfitInfo.GetOutfitInfo(5)
				if OutInfo.name ~= "04I" then
					C_TransmogOutfitInfo.ChangeViewedOutfit(5)
					C_TransmogOutfitInfo.CommitOutfitInfo(5,"04I",134400)
				else
					OutInfo = C_TransmogOutfitInfo.GetOutfitInfo(36)
					if OutInfo.name ~= "05I" then
						C_TransmogOutfitInfo.ChangeViewedOutfit(36)
						C_TransmogOutfitInfo.CommitOutfitInfo(36,"05I",134400)
					else
						OutInfo = C_TransmogOutfitInfo.GetOutfitInfo(37)
						if OutInfo.name ~= "06I" then
							C_TransmogOutfitInfo.ChangeViewedOutfit(37)
							C_TransmogOutfitInfo.CommitOutfitInfo(37,"06I",134400)
						else
							OutInfo = C_TransmogOutfitInfo.GetOutfitInfo(39)
							if OutInfo.name ~= "07I" then
								C_TransmogOutfitInfo.ChangeViewedOutfit(39)
								C_TransmogOutfitInfo.CommitOutfitInfo(39,"07I",134400)
							else
								OutInfo = C_TransmogOutfitInfo.GetOutfitInfo(40)
								if OutInfo.name ~= "08I" then
									C_TransmogOutfitInfo.ChangeViewedOutfit(40)
									C_TransmogOutfitInfo.CommitOutfitInfo(40,"08I",134400)
								else
									OutInfo = C_TransmogOutfitInfo.GetOutfitInfo(41)
									if OutInfo.name ~= "09R" then
										C_TransmogOutfitInfo.ChangeViewedOutfit(41)
										C_TransmogOutfitInfo.CommitOutfitInfo(41,"09R",134400)
									else
										OutInfo = C_TransmogOutfitInfo.GetOutfitInfo(42)
										if OutInfo.name ~= "10R" then
											C_TransmogOutfitInfo.ChangeViewedOutfit(42)
											C_TransmogOutfitInfo.CommitOutfitInfo(42,"10R",134400)
										else
											OutInfo = C_TransmogOutfitInfo.GetOutfitInfo(62)
											if OutInfo.name ~= "11G" then
												C_TransmogOutfitInfo.ChangeViewedOutfit(62)
												C_TransmogOutfitInfo.CommitOutfitInfo(62,"11G",134400)
											else
												OutInfo = C_TransmogOutfitInfo.GetOutfitInfo(63)
												if OutInfo.name ~= "12F" then
													C_TransmogOutfitInfo.ChangeViewedOutfit(63)
													C_TransmogOutfitInfo.CommitOutfitInfo(63,"12F",134400)
												end
											end
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end
end



function Zero2Max:SetupMacro8()
	local pEF, pF = UnitFactionGroup("player")	-- "Alliance" or "Horde"
	local currOut = C_TransmogOutfitInfo.GetCurrentlyViewedOutfitID()
	C_TransmogOutfitInfo.ClearAllPendingTransmogs()
	if currOut == 2 then
		C_TransmogOutfitInfo.SetPendingTransmog(0, 0, 0, 77344, 3)
	end
	if currOut == 3 then
		C_TransmogOutfitInfo.SetPendingTransmog(6, 0, 0, 83202, 3)
	end
	if currOut == 4 then
		C_TransmogOutfitInfo.SetPendingTransmog(5, 0, 0, 83203, 3)
	end
	if currOut == 5 then
		C_TransmogOutfitInfo.SetPendingTransmog(3, 0, 0, 77345, 3)
	end
	if currOut == 36 then
		C_TransmogOutfitInfo.SetPendingTransmog(1, 0, 0, 77343, 3)
		C_TransmogOutfitInfo.SetPendingTransmog(2, 0, 0, 77343, 3)
		C_TransmogOutfitInfo.SetPendingTransmog(7, 0, 0, 104604, 3)
		C_TransmogOutfitInfo.SetPendingTransmog(8, 0, 0, 94331, 3)
	end
	if currOut == 37 then
		C_TransmogOutfitInfo.SetPendingTransmog(4, 0, 0, 104602, 3)
	end
	if currOut == 39 then
		C_TransmogOutfitInfo.SetPendingTransmog(10, 0, 0, 198608, 3)
	end
	if currOut == 40 then
		C_TransmogOutfitInfo.SetPendingTransmog(9, 0, 0, 84223, 3)
		C_TransmogOutfitInfo.SetPendingTransmog(11, 0, 0, 104603, 3)
	end
	if currOut == 62 then
		C_TransmogOutfitInfo.SetPendingTransmog(3, 0, 0, 32835, 1)
		C_TransmogOutfitInfo.SetPendingTransmog(5, 0, 0, 35448, 1)
	end
	if currOut == 63 then
		if pEF == "Horde" then
			C_TransmogOutfitInfo.SetPendingTransmog(0, 0, 0, 227448, 1)
			C_TransmogOutfitInfo.SetPendingTransmog(3, 0, 0, 100003, 1)
			C_TransmogOutfitInfo.SetPendingTransmog(5, 0, 0, 111099, 1)
		end
	end
end
