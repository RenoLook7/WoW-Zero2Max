local _, addonTable = ...
local L = addonTable.GetLocale()

function Zero2Max:DebugTestPosition(s1, s2, s3, a1, a2, a3)

		print(Zero2Max.Player.pEnRace)
		print(Zero2Max.Player.pGender)

		local function SetCase(window)
			window.picture:SetUnit("player")
			window.picture:SetPortraitZoom(1)
			window.picture:SetFacing(0)
			window.picture:SetRotation(0)
			window.picture:SetPosition(0,0,0)
			window.picture:FreezeAnimation(0,0,0)
			window.picture:SetCamDistanceScale(3)
		end

		SetCase(Zero2Max.MainFrame.windowI1)
		SetCase(Zero2Max.MainFrame.windowI2)
		SetCase(Zero2Max.MainFrame.windowI3)
		SetCase(Zero2Max.MainFrame.windowI4)

		local p1 = s1
		local p2 = s2
		local p3 = s3

		print("1:" .. p1 .. "," .. p2 .. "," .. p3)

		Zero2Max.MainFrame.windowI1.picture:SetPosition(p1, p2, p3)

		p1 = p1 + a1
		p2 = p2 + a2
		p3 = p3 + a3

		print("2:" .. p1 .. "," .. p2 .. "," .. p3)

		Zero2Max.MainFrame.windowI2.picture:SetPosition(p1, p2, p3)

		p1 = p1 + a1
		p2 = p2 + a2
		p3 = p3 + a3

		print("3:" .. p1 .. "," .. p2 .. "," .. p3)

		Zero2Max.MainFrame.windowI3.picture:SetPosition(p1, p2, p3)

		p1 = p1 + a1
		p2 = p2 + a2
		p3 = p3 + a3

		print("4:" .. p1 .. "," .. p2 .. "," .. p3)

		Zero2Max.MainFrame.windowI4.picture:SetPosition(p1, p2, p3)
end


function Zero2Max:DebugTestRotation(s1, a1)

		print(Zero2Max.Player.pEnRace)
		print(Zero2Max.Player.pGender)

		local function SetCase(window)
			window.picture:SetUnit("player")
			window.picture:SetPortraitZoom(1)
			window.picture:SetFacing(0)
			window.picture:SetRotation(0)
			window.picture:SetPosition(0,0,0)
			window.picture:FreezeAnimation(0,0,0)
			window.picture:SetCamDistanceScale(1)
		end

		SetCase(Zero2Max.MainFrame.windowI1)
		SetCase(Zero2Max.MainFrame.windowI2)
		SetCase(Zero2Max.MainFrame.windowI3)
		SetCase(Zero2Max.MainFrame.windowI4)

		local p1 = s1

		print("1:" .. p1)

		Zero2Max.MainFrame.windowI1.picture:SetRotation(math.rad(p1))

		p1 = p1 + a1

		print("2:" .. p1)

		Zero2Max.MainFrame.windowI2.picture:SetRotation(math.rad(p1))

		p1 = p1 + a1

		print("3:" .. p1)

		Zero2Max.MainFrame.windowI3.picture:SetRotation(math.rad(p1))

		p1 = p1 + a1

		print("4:" .. p1)

		Zero2Max.MainFrame.windowI4.picture:SetRotation(math.rad(p1))
end


function Zero2Max:DebugTestFacing(s1, a1)

		print(Zero2Max.Player.pEnRace)
		print(Zero2Max.Player.pGender)

		local function SetCase(window)
			window.picture:SetUnit("player")
			window.picture:SetPortraitZoom(1)
			window.picture:SetFacing(0)
			window.picture:SetRotation(0)
			window.picture:SetPosition(0,0,0)
			window.picture:FreezeAnimation(0,0,0)
			window.picture:SetCamDistanceScale(1)
		end

		SetCase(Zero2Max.MainFrame.windowI1)
		SetCase(Zero2Max.MainFrame.windowI2)
		SetCase(Zero2Max.MainFrame.windowI3)
		SetCase(Zero2Max.MainFrame.windowI4)

		local p1 = s1

		print("1:" .. p1)

		Zero2Max.MainFrame.windowI1.picture:SetFacing(math.rad(p1))

		p1 = p1 + a1

		print("2:" .. p1)

		Zero2Max.MainFrame.windowI2.picture:SetFacing(math.rad(p1))

		p1 = p1 + a1

		print("3:" .. p1)

		Zero2Max.MainFrame.windowI3.picture:SetFacing(math.rad(p1))

		p1 = p1 + a1

		print("4:" .. p1)

		Zero2Max.MainFrame.windowI4.picture:SetFacing(math.rad(p1))
end


function Zero2Max:DebugTestPortrait(a1, a2, a3, a4, a5)

		print(Zero2Max.Player.pEnRace)
		print(Zero2Max.Player.pGender)

		local function SetCase(window)
			window.picture:SetUnit("player")
			window.picture:SetPortraitZoom(0)
			window.picture:SetFacing(0)
			window.picture:SetRotation(0)
			window.picture:SetPosition(0,0,0)
			window.picture:FreezeAnimation(0,0,0)
			window.picture:SetCamDistanceScale(1)
			window.picture:UndressSlot(01)
		end

		SetCase(Zero2Max.MainFrame.windowP)

		print("1:" .. a1)
		print("2:" .. a2)
		print("3:" .. a3)
		print("4:" .. a4)
		print("5:" .. a5)

		Zero2Max.MainFrame.windowP.picture:SetCamDistanceScale(a1)
		Zero2Max.MainFrame.windowP.picture:SetFacing(math.rad(a2))
		Zero2Max.MainFrame.windowP.picture:SetPosition(a3, a4, a5)
end


function Zero2Max:DebugReset()
		Zero2Max.portraitDebugOrgS  = 1
		Zero2Max.portraitDebugSelection = 1
		Zero2Max.portraitDebugAdjS  = 0
		Zero2Max.portraitDebugAdjR  = 0
		Zero2Max.portraitDebugAdjX  = 0
		Zero2Max.portraitDebugAdjY  = 0
		Zero2Max.portraitDebugAdjZ  = 0
		Zero2Max.portraitDebugAdjMultiple = 1
		print("Debug Reset")
		local padj = {}
		padj = Zero2Max.portraitSetting2
		Zero2Max.MainFrame.windowP.picture:SetCamDistanceScale(padj[1])
		Zero2Max.MainFrame.windowP.picture:SetFacing(math.rad(padj[2]))
		Zero2Max.MainFrame.windowP.picture:SetPosition(padj[3], padj[4], padj[5])
		print("Debug:" .. padj[1] .. "," .. padj[2] .. ",(" .. padj[3] .. "," .. padj[4] .. "," .. padj[5] .. ")")
		Zero2Max.portraitDebugOrgS = padj[1]
end


function Zero2Max:DebugSelectAdj()
		Zero2Max.portraitDebugSelection = Zero2Max.portraitDebugSelection + 1
		if Zero2Max.portraitDebugSelection > 5 then
			Zero2Max.portraitDebugSelection = 1
		end
		print("DebugSelection: " .. Zero2Max.portraitDebugSelection) 
end


function Zero2Max:DebugSelectMul()
		if Zero2Max.portraitDebugAdjMultiple == 1 then
			Zero2Max.portraitDebugAdjMultiple = 2
		elseif Zero2Max.portraitDebugAdjMultiple == 2 then 
			Zero2Max.portraitDebugAdjMultiple = 5
		elseif Zero2Max.portraitDebugAdjMultiple == 5 then
			Zero2Max.portraitDebugAdjMultiple = 10
		else
			Zero2Max.portraitDebugAdjMultiple = 1
		end
		print("DebugSelection: " .. Zero2Max.portraitDebugAdjMultiple)
end


function Zero2Max:DebugIncreaseAdj()
		if Zero2Max.portraitDebugSelection == 1 then 
			Zero2Max.portraitDebugAdjS = Zero2Max.portraitDebugAdjS + (0.01 * Zero2Max.portraitDebugAdjMultiple)
		end
		if Zero2Max.portraitDebugSelection == 2 then 
			Zero2Max.portraitDebugAdjR = Zero2Max.portraitDebugAdjR + (1 * Zero2Max.portraitDebugAdjMultiple)
		end
		if Zero2Max.portraitDebugSelection == 3 then 
			Zero2Max.portraitDebugAdjX = Zero2Max.portraitDebugAdjX + (0.01 * Zero2Max.portraitDebugAdjMultiple)
		end
		if Zero2Max.portraitDebugSelection == 4 then 
			Zero2Max.portraitDebugAdjY = Zero2Max.portraitDebugAdjY + (0.01 * Zero2Max.portraitDebugAdjMultiple)
		end
		if Zero2Max.portraitDebugSelection == 5 then 
			Zero2Max.portraitDebugAdjZ = Zero2Max.portraitDebugAdjZ + (0.01 * Zero2Max.portraitDebugAdjMultiple)
		end
end


function Zero2Max:DebugDecreaseAdj()
		if Zero2Max.portraitDebugSelection == 1 then 
			Zero2Max.portraitDebugAdjS = Zero2Max.portraitDebugAdjS - (0.01 * Zero2Max.portraitDebugAdjMultiple)
		end
		if Zero2Max.portraitDebugSelection == 2 then 
			Zero2Max.portraitDebugAdjR = Zero2Max.portraitDebugAdjR - (1 * Zero2Max.portraitDebugAdjMultiple)
		end
		if Zero2Max.portraitDebugSelection == 3 then 
			Zero2Max.portraitDebugAdjX = Zero2Max.portraitDebugAdjX - (0.01 * Zero2Max.portraitDebugAdjMultiple)
		end
		if Zero2Max.portraitDebugSelection == 4 then 
			Zero2Max.portraitDebugAdjY = Zero2Max.portraitDebugAdjY - (0.01 * Zero2Max.portraitDebugAdjMultiple)
		end
		if Zero2Max.portraitDebugSelection == 5 then 
			Zero2Max.portraitDebugAdjZ = Zero2Max.portraitDebugAdjZ - (0.01 * Zero2Max.portraitDebugAdjMultiple)
		end
end


function Zero2Max:DebugAdjX()
		local ol = Zero2Max.portraitDebugOrgS
		print("Before Scale: " .. ol)
		local of = Zero2Max.MainFrame.windowP.picture:GetFacing()
		print("Before Facing: " .. math.deg(of))
		local ox, oy, oz = Zero2Max.MainFrame.windowP.picture:GetPosition()
		print("Before Prosition: " .. ox .. "," .. oy .. "," .. oz)

		if Zero2Max.portraitDebugSelection == 1 then 
			ol = ol + Zero2Max.portraitDebugAdjS
			Zero2Max.MainFrame.windowP.picture:SetCamDistanceScale(ol)
			Zero2Max.portraitDebugOrgS  = ol
		end
		if Zero2Max.portraitDebugSelection == 2 then 
			of = of + math.rad(Zero2Max.portraitDebugAdjR)
			Zero2Max.MainFrame.windowP.picture:SetFacing(of)
		end
		if Zero2Max.portraitDebugSelection == 3 then 
			ox = ox + Zero2Max.portraitDebugAdjX
			Zero2Max.MainFrame.windowP.picture:SetPosition(ox, oy, oz)
		end
		if Zero2Max.portraitDebugSelection == 4 then 
			oy = oy + Zero2Max.portraitDebugAdjY
			Zero2Max.MainFrame.windowP.picture:SetPosition(ox, oy, oz)
		end
		if Zero2Max.portraitDebugSelection == 5 then 
			oz = oz + Zero2Max.portraitDebugAdjZ
			Zero2Max.MainFrame.windowP.picture:SetPosition(ox, oy, oz)
		end

		print("After Scale: " .. ol)
		print("After Facing: " .. math.deg(of))
		print("After Prosition: " .. ox .. "," .. oy .. "," .. oz)

		Zero2Max.portraitDebugAdjS  = 0
		Zero2Max.portraitDebugAdjR  = 0
		Zero2Max.portraitDebugAdjX  = 0
		Zero2Max.portraitDebugAdjY  = 0
		Zero2Max.portraitDebugAdjZ  = 0
end


function Zero2Max:DebugStopRotate()
		if Zero2Max.portraitIsRotated then
			Zero2Max.portraitIsRotated = false
		else
			Zero2Max.portraitIsRotated = true
		end
end
