local _, addonTable = ...
local L = addonTable.GetLocale()

--	1-12	ActionButton1-12 (1)
--	13-24	ActionButton1-12 page 2 (1.2)
--	61-72	MultiBarBottomLeftButton1-12 (2)
--	49-60	MultiBarBottomRightButton1-12 (3)
--	25-36	MultiBarRightButton1-12 (4)
--	37-48	MultiBarLeftButton1-12 (5)
--	145-156	MultiBar5Button1-12 (6)
--	157-168	MultiBar6Button1-12 (7)
--	169-180	MultiBar7Button1-12 (8)

--	clear action
function Zero2Max:ActionPC(a)
	PickupAction(a)
	PutItemInBackpack()
	ClearCursor()
end

--	clear action by range
function Zero2Max:ActionPCX(a,b)
	for i = a, b do
		Zero2Max:ActionPC(i)
	end
end

--	put spell
function Zero2Max:ActionSA(a,b)
	C_Spell.PickupSpell(a)
	PlaceAction(b)
	ClearCursor()
end			

--	put spellbook
function Zero2Max:ActionSBA(a,b)
	C_SpellBook.PickupSpellBookItem(a, 0)
	PlaceAction(b)
	ClearCursor()
end

--	put macro
function Zero2Max:ActionMA(a,b)
	PickupMacro(a)
	PlaceAction(b)
	ClearCursor()
end

--	swap action
function Zero2Max:ActionWA(a,b)
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

--	find flyout location
function Zero2Max:GetSpellBookFlyout(a)
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
				if	sType.itemType == 4 then			-- flyout
--					print("flyout", j, sType.spellID, sType.actionID, sType.name)
					if 	(sType.actionID == a) then
--						print("find", j, sType.spellID, sType.actionID, sType.name)
						return j
					end
				end
			end
		end
	end
end

--//
--//	set next UI layout
--//
function Zero2Max:NextLayout()
	local info = C_EditMode.GetLayouts()
	local layout = info.layouts
	local active = info.activeLayout
	local nextlayout = active + 1
	local count = 0
	for k, v in pairs(layout) do
		count = count + 1
	end
	if nextlayout > (count + 2) then
		nextlayout = 1
	end
	if nextlayout ~= active then
		C_EditMode.SetActiveLayout(nextlayout)
	end
	print("Zero2Max:" .. "change active layout to " .. nextlayout)
end

--//
--//	check personal marco in action bar or not
--//
function Zero2Max:CheckMacroUsed(a)
--	1-12	ActionButton1-12 (1)
--	13-24	ActionButton1-12 page 2 (1.2)
--	61-72	MultiBarBottomLeftButton1-12 (2)
--	49-60	MultiBarBottomRightButton1-12 (3)
--	25-36	MultiBarRightButton1-12 (4)
--	37-48	MultiBarLeftButton1-12 (5)
--	145-156	MultiBar5Button1-12 (6)
--	157-168	MultiBar6Button1-12 (7)
--	169-180	MultiBar7Button1-12 (8)
	local found = false
	local tc = {1, 13, 61, 49, 25, 37, 145, 157, 169}
	for k, v in pairs(tc) do
		for i = 1, 12 do 
			local j = i - 1 + v
			local actionType, id, subType = GetActionInfo(j)
			if actionType == "macro" then
				local name = GetActionText(j)
				if name == a then
					found = true
				end
			end
		end
	end
	return found
end

--//
--//	show and hide
--//
function Zero2Max:ShowHide()
	if Zero2Max.display then
		Zero2Max.display = false
		Zero2Max.MainFrame:Hide()
	else
		Zero2Max.display = true
		Zero2Max.MainFrame:Show()
	end

end
