local _, addonTable = ...
local L = addonTable.GetLocale()

Zero2Max.MainFrame.PortraitInitialize = function(self)
	local pSS  = Zero2Max.portraitSetSelect
	local pSet = Zero2Max.portraitSet
	self.windowP:SetWidth(pSet[pSS][1])
	self.windowP:SetHeight(pSet[pSS][2])
	self.windowP.picture:SetUnit("player")
	self.windowP.picture:SetPortraitZoom(1)

	self.windowI1.picture:SetUnit("player")
	self.windowI1.picture:SetPortraitZoom(1)
	self.windowI2.picture:SetUnit("player")
	self.windowI2.picture:SetPortraitZoom(1)
	self.windowI3.picture:SetUnit("player")
	self.windowI3.picture:SetPortraitZoom(1)
	self.windowI4.picture:SetUnit("player")
	self.windowI4.picture:SetPortraitZoom(1)
end


Zero2Max.MainFrame.PortraitOnShow = function(self)
	local pSet    = Zero2Max.portraitSet
	local pSelect = Zero2Max.portraitSetSelect
	local lpSet   = pSet[pSelect]
	local lFacing = Zero2Max.portraitFacing
	local lMode   = Zero2Max.portraitMode

	self.windowP.picture:SetUnit("player")
	self.windowP.picture:SetPortraitZoom(1)

	self.windowP:SetWidth(lpSet[1])
	self.windowP:SetHeight(lpSet[2])
	self.windowP.picture:SetFacing(0)

	self.windowP.picture:SetPosition(lpSet[3], lpSet[4], lpSet[5])
	self.windowP.picture:SetCamDistanceScale(lpSet[6])
	if lMode == 1 then
		self.windowP.picture:Dress()
		self.windowP.picture:UndressSlot(01)
	end
	if lMode == 2 then
		self.windowP.picture:Dress()
	end
	if lMode == 3 then
		self.windowP.picture:Undress()
	end
end


Zero2Max.MainFrame.PortraitChange = function(self)
		local lColor  = "|cffffffff"
		local lColorE = "|r"
		Zero2Max.portraitSetSelect = Zero2Max.portraitSetSelect + 1
		if Zero2Max.portraitSetSelect > Zero2Max.portraitSetSelectMax then
			Zero2Max.portraitSetSelect = 1
		end
		self:AdjBrick(self.portopt2, lColor .. Zero2Max.portraitSetSelect .. lColorE)
		self.windowP:Hide()
		self.windowP:Show()
end


Zero2Max.MainFrame.PortraitMode = function(self, window, button)
	if button == "RightButton" then
		Zero2Max.portraitMode = Zero2Max.portraitMode + 1
		if Zero2Max.portraitMode > 3 then
			Zero2Max.portraitMode = 1
		end 
	end
	if button == "LeftButton" then
		Zero2Max.portraitFacing = Zero2Max.portraitFacing + 1
		if Zero2Max.portraitFacing > 3 then
			Zero2Max.portraitFacing = 1
		end
	end
	self.windowP:Hide()
	self.windowP:Show()
end


Zero2Max.MainFrame.ShowImageFace = function(self, window, opt, opt2)

	window:SetWidth(400)
	window:SetHeight(200)

	window.picture:SetPortraitZoom(1)

	window.picture:SetFacing(0)
	window.picture:SetRotation(0)
	window.picture:SetPosition(0, 0, 0)
	window.picture:SetCamDistanceScale(1)

	if opt == "left" then
		window.picture:SetFacing(math.rad(285))
	elseif opt == "right" then
		window.picture:SetFacing(0)	
	elseif opt == "center" then
		window.picture:SetFacing(math.rad(330))
	elseif opt == "back" then
		window.picture:SetFacing(math.rad(150))
	end

	window.picture:SetCamDistanceScale(1.5)

	if (opt2 ~= nil) and (opt2 == "undress") then
		window.picture:Undress()
	elseif (opt2 ~= nil) and (opt2 == "helmless") then
		window.picture:Dress()
		window.picture:UndressSlot(01)
	else
		window.picture:Dress()
	end
end


Zero2Max.MainFrame.ShowImageBody = function(self, window, opt, opt2)

	window:SetWidth(250)
	window:SetHeight(500)

	window.picture:SetPortraitZoom(0)

	window.picture:SetFacing(0)
	window.picture:SetRotation(0)
	window.picture:SetPosition(0, 0, 0)
	window.picture:SetCamDistanceScale(1)

	if opt == "left" then
		window.picture:SetFacing(math.rad(315))
	elseif opt == "right" then
		window.picture:SetFacing(math.rad(45))
	elseif opt == "center" then
		window.picture:SetFacing(0)
	elseif opt == "back" then
		window.picture:SetFacing(math.rad(180))
	end

	if opt == "back" then
		window.picture:SetCamDistanceScale(0.77)	--(0.77 pair with 0.8)
	else
		window.picture:SetCamDistanceScale(0.8)
	end

	if (opt2 ~= nil) and (opt2 == "undress") then
		window.picture:Undress()
	elseif (opt2 ~= nil) and (opt2 == "helmless") then
		window.picture:Dress()
		window.picture:UndressSlot(01)
	else
		window.picture:Dress()
	end
end
