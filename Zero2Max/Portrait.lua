local _, addonTable = ...
local L = addonTable.GetLocale()

Zero2Max.MainFrame.PortraitInitialize = function(self)
--f	self.windowP:SetWidth(200)
--f	self.windowP:SetHeight(100)
--f	--	self.windowP:SetWidth(150)
--f	--	self.windowP:SetHeight(75)
--f	self.windowP.picture:SetUnit("player")
--f	self.windowP.picture:SetPortraitZoom(1)
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
	if Zero2Max.portraitIsRotated then
		Zero2Max.portraitRotation = Zero2Max.portraitRotation + 1
		if Zero2Max.portraitRotation > 2 then
			Zero2Max.portraitRotation = 1
		end
	end

	local display_type = Zero2Max.portraitRotation			-- 1 face right, 2 face front, 3 face front from body
	self.windowP.picture:SetUnit("player")

	if display_type == 3 then 
		self.windowP.picture:SetPortraitZoom(0)
	else
		self.windowP.picture:SetPortraitZoom(1)	
	end

	self.windowP.picture:SetFacing(0)
	self.windowP.picture:SetRotation(0)
	self.windowP.picture:SetPosition(0, 0, 0)
	self.windowP.picture:SetCamDistanceScale(1)
	self.windowP.picture:Dress()
	self.windowP.picture:UndressSlot(01)

	if display_type == 2 then 
		self.windowP.picture:SetFacing(math.rad(330))
		local padj = {}
		if  Zero2Max.portraitSetting2 == nil then
			Zero2Max.portraitSetting2 = self:GetPortraitSetting2(Zero2Max.Player.pEnRace, Zero2Max.Player.pGender)
		end
		padj = Zero2Max.portraitSetting2
		self.windowP.picture:SetCamDistanceScale(padj[1])
		self.windowP.picture:SetFacing(math.rad(padj[2]))
		self.windowP.picture:SetPosition(padj[3], padj[4], padj[5])
	end

	if display_type == 3 then 
		local padj = {}
		if  Zero2Max.portraitSetting3 == nil then
			Zero2Max.portraitSetting3 = self:GetPortraitSetting3(Zero2Max.Player.pEnRace, Zero2Max.Player.pGender)
		end
		padj = Zero2Max.portraitSetting3
		self.windowP.picture:SetCamDistanceScale(padj[1])
		self.windowP.picture:SetFacing(math.rad(padj[2]))
		self.windowP.picture:SetPosition(padj[3], padj[4], padj[5])
	end

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


Zero2Max.MainFrame.GetPortraitSetting2 = function(self, race, gender)
	local defaultSetting 			= {1, 330, 0, 0, 0}
	local portraitSettingTable = {
		HumanMale 					= {1.15, 330, 0, 0.02, -0.01},			-- ok
		HumanFemale 				= {1.15, 330, 0, 0, 0.01},				-- ok
		DwarfMale 					= {1.25, 330, 0, 0.07, -0.06},			-- ok
		DwarfFemale 				= {1.25, 330, 0, -0.02, -0.02},			-- ok
		NightElfMale 				= {1.2, 330, 0, 0.12, 0.01},			-- ok
		NightElfFemale 				= {1.2, 330, 0, 0.01, 0},				-- ok
		GnomeMale 					= {1.15, 330, 0, -0.02, -0.03},			-- ok
		GnomeFemale 				= {1.15, 320, 0, 0.14, -0.04},			-- ok
		DraeneiMale 				= {1.15, 330, 0, 0.31, -0.01},			-- ok
		DraeneiFemale 				= {1.15, 330, 0, 0.01, 0},				-- ok
		WorgenMale 					= {1.15, 340, 0, 0.1, -0.02},			-- ok,x
		WorgenFemale 				= {1.15, 330, 0, 0.02, -0.04},			-- ok,x
		VoidElfMale 				= {1.15, 340, 0, 0.01, 0},				-- ok
		VoidElfFemale 				= {1.15, 330, 0, -0.05, 0.01},			-- ok
		LightforgedDraeneiMale		= {1.15, 340, 0, 0.14, -0.01},			-- ok
		LightforgedDraeneiFemale	= {1.15, 330, 0, 0.01, 0},				-- ok
		DarkIronDwarfMale 			= {1.25, 330, 0, 0.07, -0.06},			-- ok
		DarkIronDwarfFemale 		= {1.25, 330, 0, -0.02, -0.02},			-- ok
		KulTiranMale 				= {1.15, 335, 0, 0.05, -0.02},			-- ok
		KulTiranFemale 				= {1.15, 320, 0, -0.04, -0.01},			-- ok
		MechagnomeMale 				= {1, 330, 0, 0, 0},						-- to test
		MechagnomeFemale 			= {1.15, 320, 0, 0.14, -0.03},			-- ok
		PandarenMale 				= {1.5, 330, 0, 0.14, 0.01},			-- ok
		PandarenFemale 				= {1.5, 330, 0, 0.14, 0.01},			-- ok
		DracthyrMale 				= {1, 330, 0, 0.63, -0.04},				-- ok,x
		DracthyrFemale 				= {1, 330, 0, 0.63, -0.04},				-- ok,x
--
		OrcMale						= {1.15, 340, 0, 0.11, 0.04},			-- ok
		OrcFemale 					= {1.15, 325, 0, 0.07, -0.05},			-- ok
		ScourgeMale	 				= {1.35, 335, 0, 0.12, -0.05},			-- ok
		ScourgeFemale 				= {1.35, 340, 0, 0.02, 0.01},			-- ok
		TaurenMale 					= {1, 320, 0, 0.73, 0},					-- ok
		TaurenFemale 				= {1, 320, 0, 0.63, 0},					-- ok
		TrollMale 					= {1.15, 320, 0, 0.29, 0.04},			-- ok
		TrollFemale 				= {1.15, 320, 0, 0.09, -0.01},			-- ok
		BloodElfMale 				= {1.15, 340, 0, 0.01, 0},				-- ok
		BloodElfFemale 				= {1.15, 330, 0, -0.05, 0.01},			-- ok
		GoblinMale 					= {1.15, 315, 0, 0, 0.03},				-- ok
		GoblinFemale 				= {1.15, 325, 0, 0.05, -0.05},			-- ok
		NightborneMale 				= {1.15, 330, 0, 0, -0.03},				-- ok
		NightborneFemale 			= {1.15, 335, 0, 0, 0.01},				-- ok
		HighmountainTaurenMale 		= {1, 320, 0, 0.73, 0},					-- ok
		HighmountainTaurenFemale 	= {1, 320, 0, 0.63, 0},					-- ok
		MagharOrcMale 				= {1.15, 340, 0, 0.06, 0},				-- ok
		MagharOrcFemale 			= {1.15, 325, 0, 0.07, -0.05},			-- ok
		ZandalariTrollMale 			= {1.15, 335, 0, -0.02, 0.03},			-- ok
		ZandalariTrollFemale 		= {1.15, 325, 0, 0.15, 0},				-- ok
		VulperaMale 				= {1, 335, 0, 0.1, 0.02},				-- ok
		VulperaFemale 				= {1, 335, 0, 0.1, 0.02},				-- ok
	}
	
	local key = race .. gender
	if portraitSettingTable[key] == nil then
		return defaultSetting
	else
		return portraitSettingTable[key]
	end
end


Zero2Max.MainFrame.GetPortraitSetting3 = function(self, race, gender)
	local defaultSetting 			= {0.3, 0, 0, 0.02, -0.85}
	local portraitSettingTable = {
		HumanMale 					= {0.3, 0, 0, 0.02, -0.90},				-- ok
		HumanFemale 				= {0.3, 0, 0, 0.02, -0.85},				-- ok
		NightElfMale 				= {0.27, 0, 0, 0.02, -1.01},			-- ok / 0.3, 0, 0, 0.02, -1.02
		NightElfFemale 				= {0.27, 0, 0, -0.01, -1},				-- ok / 0.3, 0, 0, -0.01, -1.02
		DwarfMale 					= {0.3, 0, 0, 0.02, -0.85},
		DwarfFemale 				= {0.3, 0, 0, 0.02, -0.85},
		GnomeMale 					= {0.3, 0, 0, 0.02, -0.85},
		GnomeFemale 				= {0.3, 0, 0, 0.02, -0.85},
		DraeneiMale 				= {0.3, 0, 0, 0.02, -0.85},
		DraeneiFemale 				= {0.3, 0, 0, 0.02, -0.85},
		WorgenMale 					= {0.3, 0, 0, 0.02, -0.85},
		WorgenFemale 				= {0.3, 0, 0, 0.02, -0.85},				-- retest
		VoidElfMale 				= {0.3, 0, 0, 0.02, -0.85},
		VoidElfFemale 				= {0.3, 0, 0, 0.07, -0.84},				-- test
		LightforgedDraeneiMale 		= {0.3, 0, 0, 0.02, -0.85},
		LightforgedDraeneiFemale 	= {0.2, 0, 0, -0.02, -1},				-- ok / 0.3, 0, 0, -0.02, -1.02 / 0.23, 0, 0, -0.02, -1.02
		DarkIronDwarfMale 			= {0.3, 0, 0, 0.02, -0.85},
		DarkIronDwarfFemale 		= {0.3, 0, 0, 0.02, -0.85},
		KulTiranMale 				= {0.3, 0, 0, 0.02, -0.85},
		KulTiranFemale 				= {0.3, 0, 0, 0.02, -0.85},
		PandarenMale 				= {0.3, 0, 0, 0.02, -0.85},
		PandarenFemale 				= {0.3, 0, 0, 0.02, -0.85},
--
		OrcMale 					= {0.3, 0, 0, 0.02, -0.85},
		OrcFemale 					= {0.3, 0, 0, 0.02, -0.85},
		TrollMale 					= {0.3, 0, 0, 0.02, -0.85},
		TrollFemale 				= {0.3, 0, 0, 0.02, -0.85},
		ScourgeMale 				= {0.3, 0, 0, 0.02, -0.85},
		ScourgeFemale 				= {0.3, 0, 0, 0.02, -0.85},
		TaurenMale 					= {0.3, 0, 0, 0.02, -0.85},
		TaurenFemale 				= {0.3, 0, 0, 0.02, -0.85},
		BloodElfMale 				= {0.3, 0, 0, 0.02, -0.85},
		BloodElfFemale 				= {0.3, 0, 0, 0.02, -0.85},
		GoblinMale 					= {0.3, 0, 0, 0.02, -0.85},
		GoblinFemale 				= {0.3, 0, 0, 0.02, -0.85},
		HighmountainTaurenMale 		= {0.3, 0, 0, 0.02, -0.85},
		HighmountainTaurenFemale 	= {0.3, 0, 0, 0.02, -0.85},
		NightborneMale 				= {0.3, 0, 0, 0.02, -0.85},
		NightborneFemale 			= {0.3, 0, 0, 0.02, -0.85},
	}
	
	local key = race .. gender
	if portraitSettingTable[key] == nil then
		return defaultSetting
	else
		return portraitSettingTable[key]
	end
end
