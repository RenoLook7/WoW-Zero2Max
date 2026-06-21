local _, addonTable = ...
local L = addonTable.GetLocale()

Zero2Max.MainFrame = 
{

    --- Called when the frame first loads
    Initialize = function(self)

		local lColor  = "|cffffffff"
		local lColorE = "|r"

		local gapW = Zero2Max.gapWide
		local gapH = Zero2Max.gapHight
		local titleS = Zero2Max.titleShort

        if Zero2Max_Board ~= nil then
		
			--<<create main board
            self.window = Zero2Max_Board
			self:BuildWin(self.window, "board")

			self:Update()

			self.window:SetScript("OnEnter", function() self:ShowSomething(self.window, "common") end)
            self.window:SetScript("OnLeave", function() self:HideSomething(self.window, "common") end)
			self.window:SetScript("OnMouseUp", function(_, button) self:ClickBoard(self.window, button) end)

			--<<create sub board
			self.sboard1 = CreateFrame("Frame", nil, self.window, "BackdropTemplate")
			self:BuildWin(self.sboard1, "board")
			self.sboard1:SetPoint("TOPLEFT", self.window, "BOTTOMLEFT", 0, -1 + gapH)
			self.sboard1:SetScript("OnEnter", function() self:ShowSomething(self.sboard1, "prof") end)
            self.sboard1:SetScript("OnLeave", function() self:HideSomething(self.sboard1, "prof") end)
			self.sboard1:SetScript("OnMouseUp", function(_, button) self:ClickBoard(self.sboard1, button) end)

			self.sboard2 = CreateFrame("Frame", nil, self.window, "BackdropTemplate")
			self:BuildWin(self.sboard2, "board")
			self.sboard2:SetPoint("TOPLEFT", self.sboard1, "BOTTOMLEFT", 0, -1 + gapH)
			self.sboard2:SetScript("OnEnter", function() self:ShowSomething(self.sboard2, "other") end)
            self.sboard2:SetScript("OnLeave", function() self:HideSomething(self.sboard2, "other") end)
			self.sboard2:SetScript("OnMouseUp", function(_, button) self:ClickBoard(self.sboard2, button) end)

			-- ============================================================================================== --
			--<<create option button
			local bO = Zero2Max.boardOpt
			self.boardopt1 = CreateFrame("Frame", nil, self.window, "BackdropTemplate")
			self:BuildWin(self.boardopt1, "brick")
			self.boardopt1:SetPoint("TOPRIGHT", self.window, "TOPLEFT", -1 + gapW, 0)
			self.boardopt1:SetScript("OnEnter", function(_, button) self:ClickOption(self.boardopt1, "boardopt", 1) end)
			self:AdjBrick(self.boardopt1, lColor .. "-" .. lColorE)

			self.boardopt2 = CreateFrame("Frame", nil, self.window, "BackdropTemplate")
			self:BuildWin(self.boardopt2, "brick")
			self.boardopt2:SetPoint("TOPRIGHT", self.sboard1, "TOPLEFT", -1 + gapW, 0)
			self.boardopt2:SetScript("OnEnter", function(_, button) self:ClickOption(self.boardopt2, "boardopt", 2) end)
			self:AdjBrick(self.boardopt2, lColor .. "-" .. lColorE)

			self.boardopt3 = CreateFrame("Frame", nil, self.window, "BackdropTemplate")
			self:BuildWin(self.boardopt3, "brick")
			self.boardopt3:SetPoint("TOPRIGHT", self.sboard2, "TOPLEFT", -1 + gapW, 0)
			self.boardopt3:SetScript("OnEnter", function(_, button) self:ClickOption(self.boardopt3, "boardopt", 3) end)
			self:AdjBrick(self.boardopt3, lColor .. "-" .. lColorE)

			self.boardopt4 = CreateFrame("Frame", nil, self.window, "BackdropTemplate")
			self:BuildWin(self.boardopt4, "brick")
			self.boardopt4:SetPoint("BOTTOMRIGHT", self.window, "TOPLEFT", -1 + gapW, 1 - gapH)
			self.boardopt4:SetScript("OnEnter", function(_, button) self:ClickOption(self.boardopt4, "panelopt", 4) end)
			self:AdjBrick(self.boardopt4, lColor .. "<" .. lColorE)

			-- ============================================================================================== --
			--<<create first level panel
			local pL = Zero2Max.panelList
			self.panelA1 = Zero2Max_Panel
			self:BuildWin(self.panelA1, "brick")
			self.panelA1:SetPoint("BOTTOMLEFT", self.window, "TOPLEFT", 0, 1 - gapH)
			self.panelA1:SetScript("OnEnter", function(_, button) self:ClickOption(self.panelA1, "selectpanel", 1) end)
			self:AdjBrick(self.panelA1, lColor .. L[pL[1][2] .. titleS] .. pL[1][3] .. lColorE)

			self.panelA2 = CreateFrame("Frame", nil, self.panelA1, "BackdropTemplate")
			self:BuildWin(self.panelA2, "brick")
			self.panelA2:SetPoint("TOPLEFT", self.panelA1, "TOPRIGHT", 1 - gapW, 0)
			self.panelA2:SetScript("OnEnter", function(_, button) self:ClickOption(self.panelA2, "selectpanel", 2) end)
			self:AdjBrick(self.panelA2, lColor .. L[pL[2][2] .. titleS] .. pL[2][3] .. lColorE)

			self.panelA3 = CreateFrame("Frame", nil, self.panelA1, "BackdropTemplate")
			self:BuildWin(self.panelA3, "brick")
			self.panelA3:SetPoint("TOPLEFT", self.panelA2, "TOPRIGHT", 1 - gapW, 0)
			self.panelA3:SetScript("OnEnter", function(_, button) self:ClickOption(self.panelA3, "selectpanel", 3) end)
			self:AdjBrick(self.panelA3, lColor .. L[pL[3][2] .. titleS] .. pL[3][3] .. lColorE)

			self.panelA4 = CreateFrame("Frame", nil, self.panelA1, "BackdropTemplate")
			self:BuildWin(self.panelA4, "brick")
			self.panelA4:SetPoint("TOPLEFT", self.panelA3, "TOPRIGHT", 1 - gapW, 0)
			self.panelA4:SetScript("OnEnter", function(_, button) self:ClickOption(self.panelA4, "selectpanel", 4) end)
			self:AdjBrick(self.panelA4, lColor .. L[pL[4][2] .. titleS] .. pL[4][3] .. lColorE)

			self.panelA5 = CreateFrame("Frame", nil, self.panelA1, "BackdropTemplate")
			self:BuildWin(self.panelA5, "brick")
			self.panelA5:SetPoint("TOPLEFT", self.panelA4, "TOPRIGHT", 1 - gapW, 0)
			self.panelA5:SetScript("OnEnter", function(_, button) self:ClickOption(self.panelA5, "selectpanel", 5) end)
			self:AdjBrick(self.panelA5, lColor .. L[pL[5][2] .. titleS] .. pL[5][3] .. lColorE)

			self.panelA6 = CreateFrame("Frame", nil, self.panelA1, "BackdropTemplate")
			self:BuildWin(self.panelA6, "brick")
			self.panelA6:SetPoint("TOPLEFT", self.panelA5, "TOPRIGHT", 1 - gapW, 0)
			self.panelA6:SetScript("OnEnter", function(_, button) self:ClickOption(self.panelA6, "selectpanel", 6) end)
			self:AdjBrick(self.panelA6, lColor .. L[pL[6][2] .. titleS] .. pL[6][3] .. lColorE)

			self.panelA7 = CreateFrame("Frame", nil, self.panelA1, "BackdropTemplate")
			self:BuildWin(self.panelA7, "brick")
			self.panelA7:SetPoint("TOPLEFT", self.panelA6, "TOPRIGHT", 1 - gapW, 0)
			self.panelA7:SetScript("OnEnter", function(_, button) self:ClickOption(self.panelA7, "selectpanel", 7) end)
			self:AdjBrick(self.panelA7, lColor .. L[pL[7][2] .. titleS] .. pL[7][3] .. lColorE)

			self.panelA8 = CreateFrame("Frame", nil, self.panelA1, "BackdropTemplate")
			self:BuildWin(self.panelA8, "brick")
			self.panelA8:SetPoint("TOPLEFT", self.panelA7, "TOPRIGHT", 1 - gapW, 0)
			self.panelA8:SetScript("OnEnter", function(_, button) self:ClickOption(self.panelA8, "selectpanel", 8) end)
			self:AdjBrick(self.panelA8, lColor .. L[pL[8][2] .. titleS] .. pL[8][3] .. lColorE)

			self.panelA9 = CreateFrame("Frame", nil, self.panelA1, "BackdropTemplate")
			self:BuildWin(self.panelA9, "brick")
			self.panelA9:SetPoint("TOPLEFT", self.panelA8, "TOPRIGHT", 1 - gapW, 0)
			self.panelA9:SetScript("OnEnter", function() self:ShowSomething(self.panelA9, pL[9][1]) end)
			self.panelA9:SetScript("OnLeave", function() self:HideSomething(self.panelA9, pL[9][1]) end)
			self.panelA9:SetScript("OnMouseUp", function(_, button) self:ClickBoard(self.panelA9, button) end)
			self:AdjBrick(self.panelA9, lColor .. L[pL[9][2] .. titleS] .. pL[9][3] .. lColorE)

			self.panelA10 = CreateFrame("Frame", nil, self.panelA1, "BackdropTemplate")
			self:BuildWin(self.panelA10, "brick")
			self.panelA10:SetPoint("TOPLEFT", self.panelA9, "TOPRIGHT", 1 - gapW, 0)
			self.panelA10:SetScript("OnEnter", function() self:ShowSomething(self.panelA10, pL[10][1]) end)
			self.panelA10:SetScript("OnLeave", function() self:HideSomething(self.panelA10, pL[10][1]) end)
			self.panelA10:SetScript("OnMouseUp", function(_, button) self:ClickBoard(self.panelA10, button) end)
			self:AdjBrick(self.panelA10, lColor .. L[pL[10][2] .. titleS] .. pL[10][3] .. lColorE)

			self.panelA11 = CreateFrame("Frame", nil, self.panelA1, "BackdropTemplate")
			self:BuildWin(self.panelA11, "brick")
			self.panelA11:SetPoint("TOPLEFT", self.panelA10, "TOPRIGHT", 1 - gapW, 0)
			self.panelA11:SetScript("OnEnter", function() self:ShowSomething(self.panelA11, pL[11][1]) end)
			self.panelA11:SetScript("OnLeave", function() self:HideSomething(self.panelA11, pL[11][1]) end)
			self.panelA11:SetScript("OnMouseUp", function(_, button) self:ClickBoard(self.panelA11, button) end)
			self:AdjBrick(self.panelA11, lColor .. L[pL[11][2] .. titleS] .. pL[11][3] .. lColorE)

			self.panelA12 = CreateFrame("Frame", nil, self.panelA1, "BackdropTemplate")
			self:BuildWin(self.panelA12, "brick")
			self.panelA12:SetPoint("TOPLEFT", self.panelA11, "TOPRIGHT", 1 - gapW, 0)
			self.panelA12:SetScript("OnEnter", function() self:ShowSomething(self.panelA12, pL[12][1]) end)
			self.panelA12:SetScript("OnLeave", function() self:HideSomething(self.panelA12, pL[12][1]) end)
			self.panelA12:SetScript("OnMouseUp", function(_, button) self:ClickBoard(self.panelA12, button) end)
			self:AdjBrick(self.panelA12, lColor .. L[pL[12][2] .. titleS] .. pL[12][3] .. lColorE)

			--<< reorder panel sequence
			self.panelA7:SetPoint("TOPLEFT", self.panelA5, "TOPRIGHT", 1 - gapW, 0)
			self.panelA6:SetPoint("TOPLEFT", self.panelA12, "TOPRIGHT", 1 - gapW, 0)
			-->>

			--<<create second level panel
			local pL2 = Zero2Max.panelList2
			self.panelB1 = CreateFrame("Frame", nil, self.panelA1, "BackdropTemplate")
			self:BuildWin(self.panelB1, "brick")
			self.panelB1:SetPoint("BOTTOMLEFT", self.panelA1, "TOPLEFT", 0, 1 - gapH)
			self.panelB1:SetScript("OnEnter", function() self:ShowSomething(self.panelB1, pL2[1][1]) end)
			self.panelB1:SetScript("OnLeave", function() self:HideSomething(self.panelB1, pL2[1][1]) end)
			self.panelB1:SetScript("OnMouseUp", function(_, button) self:ClickBoard(self.panelB1, button) end)
			self:AdjBrick(self.panelB1, lColor .. pL2[1][2] .. lColorE)

			self.panelB2 = CreateFrame("Frame", nil, self.panelA1, "BackdropTemplate")
			self:BuildWin(self.panelB2, "brick")
			self.panelB2:SetPoint("TOPLEFT", self.panelB1, "TOPRIGHT", 1 - gapW, 0)
			self.panelB2:SetScript("OnEnter", function() self:ShowSomething(self.panelB2, pL2[2][1]) end)
			self.panelB2:SetScript("OnLeave", function() self:HideSomething(self.panelB2, pL2[2][1]) end)
			self.panelB2:SetScript("OnMouseUp", function(_, button) self:ClickBoard(self.panelB2, button) end)
			self:AdjBrick(self.panelB2, lColor .. pL2[2][2] .. lColorE)

			self.panelB3 = CreateFrame("Frame", nil, self.panelA1, "BackdropTemplate")
			self:BuildWin(self.panelB3, "brick")
			self.panelB3:SetPoint("TOPLEFT", self.panelB2, "TOPRIGHT", 1 - gapW, 0)
			self.panelB3:SetScript("OnEnter", function() self:ShowSomething(self.panelB3, pL2[3][1]) end)
			self.panelB3:SetScript("OnLeave", function() self:HideSomething(self.panelB3, pL2[3][1]) end)
			self.panelB3:SetScript("OnMouseUp", function(_, button) self:ClickBoard(self.panelB3, button) end)
			self:AdjBrick(self.panelB3, lColor .. pL2[3][2] .. lColorE)

			self.panelB4 = CreateFrame("Frame", nil, self.panelA1, "BackdropTemplate")
			self:BuildWin(self.panelB4, "brick")
			self.panelB4:SetPoint("TOPLEFT", self.panelB3, "TOPRIGHT", 1 - gapW, 0)
			self.panelB4:SetScript("OnEnter", function() self:ShowSomething(self.panelB4, pL2[4][1]) end)
			self.panelB4:SetScript("OnLeave", function() self:HideSomething(self.panelB4, pL2[4][1]) end)
			self.panelB4:SetScript("OnMouseUp", function(_, button) self:ClickBoard(self.panelB4, button) end)
			self:AdjBrick(self.panelB4, lColor .. pL2[4][2] .. lColorE)

			self.panelB5 = CreateFrame("Frame", nil, self.panelA1, "BackdropTemplate")
			self:BuildWin(self.panelB5, "brick")
			self.panelB5:SetPoint("TOPLEFT", self.panelB4, "TOPRIGHT", 1 - gapW, 0)
			self.panelB5:SetScript("OnEnter", function() self:ShowSomething(self.panelB5, pL2[5][1]) end)
			self.panelB5:SetScript("OnLeave", function() self:HideSomething(self.panelB5, pL2[5][1]) end)
			self.panelB5:SetScript("OnMouseUp", function(_, button) self:ClickBoard(self.panelB5, button) end)
			self:AdjBrick(self.panelB5, lColor .. pL2[5][2] .. lColorE)

			self.panelB6 = CreateFrame("Frame", nil, self.panelA1, "BackdropTemplate")
			self:BuildWin(self.panelB6, "brick")
			self.panelB6:SetPoint("TOPLEFT", self.panelB5, "TOPRIGHT", 1 - gapW, 0)
			self.panelB6:SetScript("OnEnter", function() self:ShowSomething(self.panelB6, pL2[6][1]) end)
			self.panelB6:SetScript("OnLeave", function() self:HideSomething(self.panelB6, pL2[6][1]) end)
			self.panelB6:SetScript("OnMouseUp", function(_, button) self:ClickBoard(self.panelB6, button) end)
			self:AdjBrick(self.panelB6, lColor .. pL2[6][2] .. lColorE)

			self.panelB7 = CreateFrame("Frame", nil, self.panelA1, "BackdropTemplate")
			self:BuildWin(self.panelB7, "brick")
			self.panelB7:SetPoint("TOPLEFT", self.panelB6, "TOPRIGHT", 1 - gapW, 0)
			self.panelB7:SetScript("OnEnter", function() self:ShowSomething(self.panelB7, pL2[7][1]) end)
			self.panelB7:SetScript("OnLeave", function() self:HideSomething(self.panelB7, pL2[7][1]) end)
			self.panelB7:SetScript("OnMouseUp", function(_, button) self:ClickBoard(self.panelB7, button) end)
			self:AdjBrick(self.panelB7, lColor .. pL2[7][2] .. lColorE)

			--<<create second level panel option
			self.panelBopt = CreateFrame("Frame", nil, self.panelA1, "BackdropTemplate")
			self:BuildWin(self.panelBopt, "brick")
			self.panelBopt:SetPoint("TOPLEFT", self.panelB7, "TOPRIGHT", 1 - gapW, 0)
			self.panelBopt:SetScript("OnEnter", function(_, button) self:ClickOption(self.panelBopt, "2panelopt", 5) end)
			self:AdjBrick(self.panelBopt, lColor .. L[bO[5][2] .. titleS] .. lColorE)

			-- ============================================================================================== --
			--<<create tooltips windows
			self.windowA1 = Zero2Max_Window
			self:BuildWin(self.windowA1)
			self.windowA1:SetPoint("TOPLEFT", self.window, "TOPRIGHT", 1, -38)

			self.windowA2 = CreateFrame("Frame", nil, self.windowA1, "BackdropTemplate")
			self:BuildWin(self.windowA2)
			self.windowA2:SetPoint("TOPLEFT", self.windowA1, "TOPRIGHT", 1, 0)

			self.windowA3 = CreateFrame("Frame", nil, self.windowA1, "BackdropTemplate")
			self:BuildWin(self.windowA3)
			self.windowA3:SetPoint("TOPLEFT", self.windowA2, "TOPRIGHT", 1, 0)

			self.windowA4 = CreateFrame("Frame", nil, self.windowA1, "BackdropTemplate")
			self:BuildWin(self.windowA4)
			self.windowA4:SetPoint("TOPLEFT", self.windowA3, "TOPRIGHT", 1, 0)

			self.windowB1 = CreateFrame("Frame", nil, self.windowA1, "BackdropTemplate")
			self:BuildWin(self.windowB1)
			self.windowB1:SetPoint("TOPLEFT", self.windowA1, "BOTTOMLEFT", 0, -1)

			self.windowB2 = CreateFrame("Frame", nil, self.windowA1, "BackdropTemplate")
			self:BuildWin(self.windowB2)
			self.windowB2:SetPoint("TOPLEFT", self.windowA2, "BOTTOMLEFT", 0, -1)

			self.windowB3 = CreateFrame("Frame", nil, self.windowA1, "BackdropTemplate")
			self:BuildWin(self.windowB3)
			self.windowB3:SetPoint("TOPLEFT", self.windowA3, "BOTTOMLEFT", 0, -1)

			self.windowB4 = CreateFrame("Frame", nil, self.windowA1, "BackdropTemplate")
			self:BuildWin(self.windowB4)
			self.windowB4:SetPoint("TOPLEFT", self.windowA4, "BOTTOMLEFT", 0, -1)

			self.windowC1 = CreateFrame("Frame", nil, self.windowA1, "BackdropTemplate")
			self:BuildWin(self.windowC1)
			self.windowC1:SetPoint("TOPLEFT", self.windowB1, "BOTTOMLEFT", 0, -1)

			self.windowC2 = CreateFrame("Frame", nil, self.windowA1, "BackdropTemplate")
			self:BuildWin(self.windowC2)
			self.windowC2:SetPoint("TOPLEFT", self.windowB2, "BOTTOMLEFT", 0, -1)

			self.windowC3 = CreateFrame("Frame", nil, self.windowA1, "BackdropTemplate")
			self:BuildWin(self.windowC3)
			self.windowC3:SetPoint("TOPLEFT", self.windowB3, "BOTTOMLEFT", 0, -1)

			self.windowC4 = CreateFrame("Frame", nil, self.windowA1, "BackdropTemplate")
			self:BuildWin(self.windowC4)
			self.windowC4:SetPoint("TOPLEFT", self.windowB4, "BOTTOMLEFT", 0, -1)

			--<<create tooltips header board
			self.windowT = CreateFrame("Frame", nil, self.windowA1, "BackdropTemplate")
			self:BuildWin(self.windowT, "header")
			self.windowT:SetPoint("BOTTOMLEFT", self.windowA1, "TOPLEFT", 0, 1)

			-- ============================================================================================== --
			--<<create portrait
			self.windowP = Zero2Max_Portrait
--f			self:BuildPor(self.windowP, "face")
--f			self.windowP:SetPoint("TOPLEFT", self.sboard2, "BOTTOMLEFT", 0, -1 + gapH)
--f			self.windowP:SetScript("OnShow", function() self:PortraitOnShow(self.windowP) end)

--d			self.windowP1 = CreateFrame("Frame", nil, self.windowP, "BackdropTemplate")
--d			self:BuildPor(self.windowP1, "face")
--d			self.windowP1:SetPoint("TOPRIGHT", self.windowP, "TOPRIGHT", 0, 0)
--d			self.windowP1:SetWidth(120)
--d			self.windowP1:SetHeight(110)
--d			self.windowP1:Show()

--d			self.windowP2 = CreateFrame("Frame", nil, self.windowP, "BackdropTemplate")
--d			self:BuildPor(self.windowP2, "face")
--d			self.windowP2:SetPoint("TOPLEFT", self.windowP, "TOPLEFT", 0, 0)
--d			self.windowP2:SetWidth(210)
--d			self.windowP2:SetHeight(50)
--d			self.windowP2:Show()

			-- ============================================================================================== --
			--<<create image
			self.windowI1 = Zero2Max_Image
			self:BuildPor(self.windowI1, "big")
			self.windowI1:SetPoint("TOPLEFT", self.window, "TOPRIGHT", 1, 0)

			self.windowI2 = CreateFrame("Frame", nil, self.windowI1, "BackdropTemplate")
			self:BuildPor(self.windowI2, "big")
			self.windowI2:SetPoint("TOPLEFT", self.windowI1, "TOPRIGHT", 1, 0)

			self.windowI3 = CreateFrame("Frame", nil, self.windowI1, "BackdropTemplate")
			self:BuildPor(self.windowI3, "big")
			self.windowI3:SetPoint("TOPLEFT", self.windowI2, "TOPRIGHT", 1, 0)

			self.windowI4 = CreateFrame("Frame", nil, self.windowI1, "BackdropTemplate")
			self:BuildPor(self.windowI4, "big")
			self.windowI4:SetPoint("TOPLEFT", self.windowI3, "TOPRIGHT", 1, 0)
			
			-- ============================================================================================== --
		--<< relink to reposition windows
--f			self.windowP:SetPoint("BOTTOMLEFT", self.window, "TOPLEFT", 0, 1)
--f			self.window:SetPoint("TOPLEFT", self.windowP, "BOTTOMLEFT", 40, -1 + gapH)
--f			self.boardopt4:SetPoint("BOTTOMLEFT", self.window, "BOTTOMRIGHT", -1 + gapW + 50, 0)
--f			self.panelA1:SetPoint("TOPLEFT", self.boardopt4, "TOPRIGHT", -1 + gapW, 0)
		-->>
			-- ============================================================================================== --
        end
    end,

    --<<show all
    Show = function(self)
        Zero2Max_Board:Show()
		Zero2Max_Window:Hide()
		if Zero2Max.boardOpt[4] then
--f			Zero2Max_Portrait:Hide()
			Zero2Max_Panel:Show()
		else
			Zero2Max_Panel:Hide()
--f			Zero2Max_Portrait:Show()
		end
		Zero2Max_Image:Hide()
    end,

    --<<hide all
    Hide = function(self)
        Zero2Max_Board:Hide()
		Zero2Max_Window:Hide()
		Zero2Max_Panel:Hide()
		Zero2Max_Portrait:Hide()
		Zero2Max_Image:Hide()
    end,

    ShowSomething = function(self, window, mode)
		window:SetBackdropBorderColor(1, 0.75, 0, 1)
		if ((mode == "1") or (mode == "2") or (mode == "3") or (mode == "4") or (mode == "5") or (mode == "6") or (mode == "7")) and (Zero2Max.panelSelect == "image") then
			Zero2Max_Window:Hide()
--f			Zero2Max_Portrait:Hide()
			self:ShowImage(window, mode)
		else
			Zero2Max_Image:Hide()
--f			Zero2Max_Portrait:Hide()
			self:ShowTooltip(window, mode)
		end
	end,

    HideSomething = function(self, window, mode)
		window:SetBackdropBorderColor(0, 0, 0, 0.1)
		if ((mode == "1") or (mode == "2") or (mode == "3") or (mode == "4") or (mode == "5") or (mode == "6") or (mode == "7")) and (Zero2Max.panelSelect == "image") then
			self:HideImage(window, mode)
--f			if not Zero2Max.pinWindow then
--f				Zero2Max_Portrait:Show()
--f			end
		else
			self:HideTooltip(window, mode)
--f			if not Zero2Max.pinWindow then
--f				Zero2Max_Portrait:Show()
--f			end
		end
	end,

    --<<display message windows
    ShowTooltip = function(self, window, mode)

		if (mode == "1") or 
		   (mode == "2") or 
		   (mode == "3") or 
		   (mode == "4") or 
		   (mode == "5") or
		   (mode == "6") or
		   (mode == "7")
		   then
			mode = Zero2Max.panelSelect .. mode
		end

		self.windowA1:SetBackdropBorderColor(1, 1, 1, 1)
		self.windowA2:SetBackdropBorderColor(1, 1, 1, 1)
		self.windowA3:SetBackdropBorderColor(1, 1, 1, 1)
		self.windowA4:SetBackdropBorderColor(1, 1, 1, 1)
		self.windowB1:SetBackdropBorderColor(1, 1, 1, 1)
		self.windowB2:SetBackdropBorderColor(1, 1, 1, 1)
		self.windowB3:SetBackdropBorderColor(1, 1, 1, 1)
		self.windowB4:SetBackdropBorderColor(1, 1, 1, 1)
		self.windowC1:SetBackdropBorderColor(1, 1, 1, 1)
		self.windowC2:SetBackdropBorderColor(1, 1, 1, 1)
		self.windowC3:SetBackdropBorderColor(1, 1, 1, 1)
		self.windowC4:SetBackdropBorderColor(1, 1, 1, 1)
		self:AdjWinColor(self.windowA1, 0, 0, 0, 0.6)
		self:AdjWinColor(self.windowA2, 0, 0, 0, 0.6)
		self:AdjWinColor(self.windowA3, 0, 0, 0, 0.6)
		self:AdjWinColor(self.windowA4, 0, 0, 0, 0.6)
		self:AdjWinColor(self.windowB1, 0, 0, 0, 0.6)
		self:AdjWinColor(self.windowB2, 0, 0, 0, 0.6)
		self:AdjWinColor(self.windowB3, 0, 0, 0, 0.6)
		self:AdjWinColor(self.windowB4, 0, 0, 0, 0.6)
		self:AdjWinColor(self.windowC1, 0, 0, 0, 0.6)
		self:AdjWinColor(self.windowC2, 0, 0, 0, 0.6)
		self:AdjWinColor(self.windowC3, 0, 0, 0, 0.6)
		self:AdjWinColor(self.windowC4, 0, 0, 0, 0.6)

		if     mode == "prof" then
			self:WriteMessageProf(self.windowA1, 1)
			self:WriteMessageProf(self.windowA2, 2)
			self:WriteMessageProf(self.windowA3, 3)
			self:WriteMessageProf(self.windowA4, 4)
			self:WriteMessageEmpty(self.windowB1)
			self:WriteMessageEmpty(self.windowB2)
			self:WriteMessageEmpty(self.windowB3)
			self:WriteMessageProfAr(self.windowB4)
			self:WriteMessageEmpty(self.windowC1)
			self:WriteMessageEmpty(self.windowC2)
			self:WriteMessageEmpty(self.windowC3)
			self:WriteMessageEmpty(self.windowC4)
			self:WriteMessageChar(self.windowT, L["Profession"])
			self:AdjAllTopDownWin()
			self:AdjTopWin()
		elseif mode == "other" then
			self:WriteMessageGroup3(self.windowA1, "currency")
			self:WriteMessageGroup3(self.windowA2, "currencyPvP")
			self:WriteMessageEmpty(self.windowA3)
--p			self:WriteMessageGroup3(self.windowA3, "quest_exp_10_artisan")
			self:WriteMessageEmpty(self.windowA4)
			self:WriteMessageEmpty(self.windowB1)
			self:WriteMessageEmpty(self.windowB2)
			self:WriteMessageEmpty(self.windowB3)
--p			self:WriteMessageGroup3(self.windowB3, "quest_exp_11_delvecall")
			self:WriteMessageEmpty(self.windowB4)
			self:WriteMessageEmpty(self.windowC1)
			self:WriteMessageEmpty(self.windowC2)
			self:WriteMessageEmpty(self.windowC3)
			self:WriteMessageEmpty(self.windowC4)
			self:WriteMessageChar(self.windowT)
			self:AdjAllTopDownWin()
			self:AdjTopWin()		
		elseif mode == "explore1" then
			self:WriteMessageExplore(self.windowA1, 1)
			self:WriteMessageExplore(self.windowA2, 2)
			self:WriteMessageExplore(self.windowA3, 3)
			self:WriteMessageExplore(self.windowB1, 4)
			self:WriteMessageExplore(self.windowB2, 5)
			self:WriteMessageExplore(self.windowB3, 6)
			self:WriteMessageExplore(self.windowC3, 7)
			self:WriteMessageEmpty(self.windowA4)
			self:WriteMessageEmpty(self.windowB4)
			self:WriteMessageEmpty(self.windowC1, self.windowC2, self.windowC4)
			self:WriteMessageChar(self.windowT, L["Explosion"] .. " 1")
			self:AdjAllTopDownWin()
			self:AdjTopWin()
		elseif mode == "explore2" then
			self:WriteMessageExplore(self.windowA1, 8)
			self:WriteMessageExplore(self.windowA2, 9)
			self:WriteMessageExplore(self.windowA3, 10)
			self:WriteMessageExplore(self.windowB1, 11)
			self:WriteMessageExplore(self.windowB2, 12)
			self:WriteMessageEmpty(self.windowA4)			
			self:WriteMessageEmpty(self.windowB3, self.windowB4)
			self:WriteMessageEmpty(self.windowC1, self.windowC2, self.windowC3, self.windowC4)
			self:WriteMessageChar(self.windowT, L["Explosion"] .. " 2")
			self:AdjAllTopDownWin()
			self:AdjTopWin()
		elseif mode == "lore" then
			self:WriteMessageLore(self.windowA1, 1)
			self:WriteMessageLore(self.windowA2, 2)
			self:WriteMessageLore(self.windowA3, 3)
			self:WriteMessageLore(self.windowA4, 4)
			self:WriteMessageLore(self.windowB1, 5)
			self:WriteMessageLore(self.windowB2, 6)
			self:WriteMessageLore(self.windowB3, 7)
			self:WriteMessageLore(self.windowB4, 8)
			self:WriteMessageLore(self.windowC3, 9)
			self:WriteMessageLore(self.windowC4, 10)
			self:WriteMessageEmpty(self.windowC1, self.windowC2)
			self:WriteMessageChar(self.windowT, L["Lore"])
			self:AdjAllTopDownWin()
			self:AdjTopWin()
		elseif mode == "lore1" then
			self:WriteMessageLore(self.windowA1, 1)
			self:WriteMessageLore(self.windowA2, 2)
			self:WriteMessageLore(self.windowA3, 3)
			self:WriteMessageLore(self.windowB1, 4)
			self:WriteMessageLore(self.windowB2, 5)
			self:WriteMessageLore(self.windowB3, 6)
			self:WriteMessageEmpty(self.windowA4)
			self:WriteMessageEmpty(self.windowB4)
			self:WriteMessageEmpty(self.windowC1, self.windowC2, self.windowC3, self.windowC4)
			self:WriteMessageChar(self.windowT, L["Lore"] .. " 1")
			self:AdjAllTopDownWin()
			self:AdjTopWin()
		elseif mode == "lore2" then
			self:WriteMessageLore(self.windowA1, 7)
			self:WriteMessageLore(self.windowA2, 8)
			self:WriteMessageLore(self.windowA3, 9)
			self:WriteMessageLore(self.windowB1, 10)
			self:WriteMessageEmpty(self.windowA4)
			self:WriteMessageEmpty(self.windowB2, self.windowB3, self.windowB4)
			self:WriteMessageEmpty(self.windowC1, self.windowC2, self.windowC3, self.windowC4)
			self:WriteMessageChar(self.windowT, L["Lore"] .. " 2")
			self:AdjAllTopDownWin()
			self:AdjTopWin()
		elseif mode == "quest1" then
			self:WriteMessageQuest(self.windowA1, self.windowA2, self.windowA3)
			self:WriteMessageEmpty(self.windowA4)
			self:WriteMessageEmpty(self.windowB1, self.windowB2, self.windowB3, self.windowB4)
			self:WriteMessageEmpty(self.windowC1, self.windowC2, self.windowC3, self.windowC4)
			self:WriteMessageChar(self.windowT, L["Quest by Log"])
			self:AdjAllTopDownWin()
			self:AdjTopWin()
		elseif mode == "quest2" then
			self:WriteMessageQuest2(self.windowA1, self.windowA2, self.windowA3, self.windowA4,
                                    self.windowB1, self.windowB2, self.windowB3, self.windowB4,
                                    self.windowC1, self.windowC2, self.windowC3, self.windowC4)
			self:WriteMessageChar(self.windowT, L["Quest by Expansion"])
			self:AdjAllTopDownWin()
			self:AdjTopWin()
		elseif mode == "follower1" then
			self:WriteMessageFollower(self.windowA1, 1)
			self:WriteMessageFollower(self.windowA2, 2)
			self:WriteMessageEmpty(self.windowA3, self.windowA4)
			self:WriteMessageEmpty(self.windowB1, self.windowB2, self.windowB3, self.windowB4)
			self:WriteMessageEmpty(self.windowC1, self.windowC2, self.windowC3, self.windowC4)
			self:WriteMessageChar(self.windowT, L["Follower"] .. " 1")
			self:AdjAllTopDownWin()
			self:AdjTopWin()
		elseif mode == "follower2" then
			self:WriteMessageFollower(self.windowA1, 3)
			self:WriteMessageFollower(self.windowB1, 4)
			self:WriteMessageFollower(self.windowA2, 5)
			self:WriteMessageEmpty(self.windowA3, self.windowA4)
			self:WriteMessageEmpty(self.windowB2, self.windowB3, self.windowB4)
			self:WriteMessageEmpty(self.windowC1, self.windowC2, self.windowC3, self.windowC4)
			self:WriteMessageChar(self.windowT, L["Follower"] .. " 2")
			self:AdjAllTopDownWin()
			self:AdjTopWin()
		elseif mode == "spellbook" then
			self:WriteMessageSpell(self.windowA1, self.windowA2, self.windowA3, self.windowA4,
                                   self.windowB1, self.windowB2, self.windowB3, self.windowB4)
			self:WriteMessageEmpty(self.windowC1, self.windowC2, self.windowC3, self.windowC4)
			self:WriteMessageChar(self.windowT, L["Spellbook"])
			self:AdjAllTopDownWin()
			self:AdjTopWin()
		elseif mode == "kill1" then
			self:WriteMessageKill(self.windowA1, 1)
			self:WriteMessageKill(self.windowB1, 2)
			self:WriteMessageKill(self.windowA2, 3)
			self:WriteMessageEmpty(self.windowA3, self.windowA4)
			self:WriteMessageEmpty(self.windowB2, self.windowB3, self.windowB4)
			self:WriteMessageEmpty(self.windowC1, self.windowC2, self.windowC3, self.windowC4)
			self:WriteMessageChar(self.windowT, L["Kill"] .. " 1")
			self:AdjAllTopDownWin()
			self:AdjTopWin()
		elseif mode == "kill2" then
			self:WriteMessageKill(self.windowA1, 4)
			self:WriteMessageKill(self.windowA2, 5)
			self:WriteMessageEmpty(self.windowA3, self.windowA4)
			self:WriteMessageEmpty(self.windowB1, self.windowB2, self.windowB3, self.windowB4)
			self:WriteMessageEmpty(self.windowC1, self.windowC2, self.windowC3, self.windowC4)
			self:WriteMessageChar(self.windowT, L["Kill"] .. " 2")
			self:AdjAllTopDownWin()
			self:AdjTopWin()
		elseif mode == "kill3" then
			self:WriteMessageKill(self.windowA1, 6)
			self:WriteMessageKill(self.windowA2, 7)
			self:WriteMessageEmpty(self.windowA3, self.windowA4)
			self:WriteMessageEmpty(self.windowB1, self.windowB2, self.windowB3, self.windowB4)
			self:WriteMessageEmpty(self.windowC1, self.windowC2, self.windowC3, self.windowC4)
			self:WriteMessageChar(self.windowT, L["Kill"] .. " 3")
			self:AdjAllTopDownWin()
			self:AdjTopWin()
		elseif mode == "kill4" then
			self:WriteMessageKill(self.windowA1, 8)
			self:WriteMessageKill(self.windowA2, 9)
			self:WriteMessageEmpty(self.windowA3, self.windowA4)
			self:WriteMessageEmpty(self.windowB1, self.windowB2, self.windowB3, self.windowB4)
			self:WriteMessageEmpty(self.windowC1, self.windowC2, self.windowC3, self.windowC4)
			self:WriteMessageChar(self.windowT, L["Kill"] .. " 4")
			self:AdjAllTopDownWin()
			self:AdjTopWin()
		elseif mode == "appset1" then
			self:WriteMessageAppSet(1, self.windowA1, self.windowA2, self.windowB1, self.windowB2,
                                       self.windowA3, self.windowA4, self.windowB3, self.windowB4)
			self:WriteMessageEmpty(self.windowC1, self.windowC2, self.windowC3, self.windowC4)
			self:WriteMessageChar(self.windowT, L["Appearance Set"] .. " 1")
			self:AdjAllTopDownWin()
			self:AdjTopWin()
		elseif mode == "appset2" then
			self:WriteMessageAppSet(2, self.windowA1, self.windowA2, self.windowA3, self.windowB1,
                                       self.windowB2, self.windowB3, self.windowA4, self.windowB4)
			self:WriteMessageEmpty(self.windowC1, self.windowC2, self.windowC3, self.windowC4)
			self:WriteMessageChar(self.windowT, L["Appearance Set"] .. " 2")
			self:AdjAllTopDownWin()
			self:AdjTopWin()
		elseif mode == "appset3" then
			self:WriteMessageAppSet(3, self.windowA1, self.windowA2, self.windowA3, self.windowB1,
                                       self.windowB2, self.windowB3, self.windowA4, self.windowB4)
			self:WriteMessageEmpty(self.windowC1, self.windowC2, self.windowC3, self.windowC4)
			self:WriteMessageChar(self.windowT, L["Appearance Set"] .. " 3")
			self:AdjAllTopDownWin()
			self:AdjTopWin()
		elseif mode == "appset4" then
			self:WriteMessageAppSet(4, self.windowA1, self.windowA2, self.windowA3, self.windowB1,
                                       self.windowB2, self.windowB3, self.windowA4, self.windowB4)
			self:WriteMessageEmpty(self.windowC1, self.windowC2, self.windowC3, self.windowC4)
			self:WriteMessageChar(self.windowT, L["Appearance Set"] .. " 4")
			self:AdjAllTopDownWin()
			self:AdjTopWin()
		elseif mode == "appset5" then
			self:WriteMessageAppSet(5, self.windowA1, self.windowA2, self.windowA3, self.windowB1,
                                       self.windowB2, self.windowB3, self.windowA4, self.windowB4)
			self:WriteMessageEmpty(self.windowC1, self.windowC2, self.windowC3, self.windowC4)
			self:WriteMessageChar(self.windowT, L["Appearance Set"] .. " 5")
			self:AdjAllTopDownWin()
			self:AdjTopWin()
		elseif mode == "appset6" then
			self:WriteMessageAppSet(6, self.windowA1, self.windowA2, self.windowA3, self.windowB1,
                                       self.windowB2, self.windowB3, self.windowA4, self.windowB4)
			self:WriteMessageEmpty(self.windowC1, self.windowC2, self.windowC3, self.windowC4)
			self:WriteMessageChar(self.windowT, L["Appearance Set"] .. " 6")
			self:AdjAllTopDownWin()
			self:AdjTopWin()
		elseif mode == "appset7" then
			self:WriteMessageAppSet(7, self.windowA1, self.windowA2, self.windowA3, self.windowB1,
                                       self.windowB2, self.windowB3, self.windowA4, self.windowB4)
			self:WriteMessageEmpty(self.windowC1, self.windowC2, self.windowC3, self.windowC4)
			self:WriteMessageChar(self.windowT, L["Appearance Set"] .. " 7")
			self:AdjAllTopDownWin()
			self:AdjTopWin()
		elseif mode == "check" then
			self:WriteMessageGroup3(self.windowA1, "trace")
			self:WriteMessageGroup3(self.windowA2, "macro")
			self:WriteMessageGroup3(self.windowA3, "equipmentset")
			self:WriteMessageGroup3(self.windowA4, "outfit")
--p			self:WriteMessageGroup3(self.windowB2, "outfitdebug1")
--p			self:WriteMessageGroup3(self.windowB3, "outfitdebug2")
--p			self:WriteMessageEmpty(self.windowB1, self.windowB4)
			self:WriteMessageEmpty(self.windowB1, self.windowB2, self.windowB3, self.windowB4)
			self:WriteMessageEmpty(self.windowC1, self.windowC2, self.windowC3, self.windowC4)
			self:WriteMessageChar(self.windowT, L["Check"])
			self:AdjAllTopDownWin()
			self:AdjTopWin()
		elseif mode == "profspec1" then
			self:WriteMessageProfSpec(self.windowA1, 1, 1)
			self:WriteMessageProfSpec(self.windowA2, 1, 2)
			self:WriteMessageProfSpec(self.windowA3, 1, 3)
			self:WriteMessageEmpty(self.windowA4)
			self:WriteMessageEmpty(self.windowB1, self.windowB2, self.windowB3, self.windowB4)
			self:WriteMessageEmpty(self.windowC1, self.windowC2, self.windowC3, self.windowC4)
			self:WriteMessageChar(self.windowT, L["Profession Specialization"] .. " 1")
			self:AdjAllTopDownWin()
			self:AdjTopWin()
		elseif mode == "profspec2" then
			self:WriteMessageProfSpec(self.windowA1, 2, 1)
			self:WriteMessageProfSpec(self.windowA2, 2, 2)
			self:WriteMessageProfSpec(self.windowA3, 2, 3)
			self:WriteMessageEmpty(self.windowA4)
			self:WriteMessageEmpty(self.windowB1, self.windowB2, self.windowB3, self.windowB4)
			self:WriteMessageEmpty(self.windowC1, self.windowC2, self.windowC3, self.windowC4)
			self:WriteMessageChar(self.windowT, L["Profession Specialization"] .. " 2")
			self:AdjAllTopDownWin()
			self:AdjTopWin()
		elseif mode == "renown" then
			self:WriteMessageGroup3(self.windowA1, "renown_12")
			self:WriteMessageGroup3(self.windowA2, "renown_11")
			self:WriteMessageGroup3(self.windowA3, "renown_10")
			self:WriteMessageEmpty(self.windowA4)
			self:WriteMessageEmpty(self.windowB1, self.windowB2, self.windowB3, self.windowB4)
			self:WriteMessageEmpty(self.windowC1, self.windowC2, self.windowC3, self.windowC4)
			self:WriteMessageChar(self.windowT, L["Renown"])
			self:AdjAllTopDownWin()
			self:AdjTopWin()
		elseif mode == "gear" then
			self:WriteMessageEq(self.windowA1)
			self:WriteMessageEmpty(self.windowA2, self.windowA3, self.windowA4)
			self:WriteMessageEmpty(self.windowB1, self.windowB2, self.windowB3, self.windowB4)
			self:WriteMessageEmpty(self.windowC1, self.windowC2, self.windowC3, self.windowC4)
			self:WriteMessageChar(self.windowT, L["Gear"])
			self:AdjAllTopDownWin()
			self:AdjTopWin()
		else
			self:WriteMessageStone(self.windowA1)
			self:WriteMessagePI(self.windowA2)
			self:WriteMessageBag(self.windowA3)
			self:WriteMessageGuild(self.windowA4)
			self:WriteMessageRiding(self.windowB1)
			self:WriteMessagePVP(self.windowB2)
			self:WriteMessageBank(self.windowB3)
			self:WriteMessageMainCity(self.windowB4)
			self:WriteMessagePet(self.windowC1)
			self:WriteMessageEmpty(self.windowC2)
			self:WriteMessageEmpty(self.windowC3)
			self:WriteMessageEmpty(self.windowC4)
			self:WriteMessageChar(self.windowT)
			self.windowA1:Show()
			self.windowA2:Show()
			self.windowA3:Show()
			self.windowA4:Show()
			self.windowB1:Show()
			self.windowB2:Show()
			self.windowB3:Show()
			self.windowB4:Show()
			self.windowC1:Show()
			self:AdjAllTopDownWin()
			self:AdjTopWin()
		end
		
		Zero2Max_Window:Show()
    end,

    --<<hide tooltips windows
    HideTooltip = function(self, window, mode)
		if not Zero2Max.pinWindow then
			Zero2Max_Window:Hide()
		end
    end,

    --<<display image windows
	ShowImage = function(self, window, mode)
		if (mode == "1") or  (mode == "2") or (mode == "3") then
			self.windowI3:SetPoint("TOPLEFT", self.windowI1, "BOTTOMLEFT", 1, 0)
			local opt = "dress"
			if mode == "3" then
				opt = "undress"
			end
			if mode == "2" then
				opt = "helmless"
			end
			self.windowI1:Show()
			self:ShowImageFace(self.windowI1, "left", opt)
			self.windowI2:Show()
			self:ShowImageFace(self.windowI2, "center", opt)
			self.windowI3:Show()
			self:ShowImageFace(self.windowI3, "right", opt)
			self.windowI4:Show()
			self:ShowImageFace(self.windowI4, "back", opt)
		end
		if (mode == "4") or  (mode == "5") or (mode == "6") then
			self.windowI3:SetPoint("TOPLEFT", self.windowI2, "TOPRIGHT", 1, 0)
			local opt = "dress"
			if mode == "6" then
				opt = "undress"
			end
			if mode == "5" then
				opt = "helmless"
			end
			self.windowI1:Show()
			self:ShowImageBody(self.windowI1, "left", opt)
			self.windowI2:Show()
			self:ShowImageBody(self.windowI2, "center", opt)
			self.windowI3:Show()
			self:ShowImageBody(self.windowI3, "right", opt)
			self.windowI4:Show()
			self:ShowImageBody(self.windowI4, "back", opt)
		end
	end,

    --<<hide image windows
	HideImage = function(self, window, mode)
--		window:SetBackdropBorderColor(0, 0, 0, 0.1)
		if not Zero2Max.pinWindow then
			Zero2Max_Image:Hide()
		end
	end,


--p TempClick = function(self, window, button)
--p		Zero2Max:SetupMacro2()
--p end,
--p
--p	TempClick2 = function(self, window, button)
--p		Zero2Max:SetupMacroClean()
--p end,
--p
--p	TempClick3 = function(self, window, button)
--p		Zero2Max:SetupMacro()
--p	end,


    --<<update data or pin tooltips window
		--// right click -> refresh data
		--// left click  -> pin/unpin tooltips window
    ClickBoard = function(self, window, button)
		if button == "RightButton" then
			Zero2Max.Player:SyncData()
			Zero2Max.MainControl:Update()
		end
		if button == "LeftButton" then
			if Zero2Max.pinWindow then
				Zero2Max.pinWindow = false
			else
				Zero2Max.pinWindow = true
			end
		end
    end,

    --<<fold / unfold subboard window
    ClickOption = function(self, window, option1, option2)
		local lColor  = "|cffffffff"
		local lColorE = "|r"
		local gapH = Zero2Max.gapHight
		local titleS = Zero2Max.titleShort

		-- for mainboard, subboard1/2
		if option1 == "boardopt" then
			if Zero2Max.boardOpt[option2] then
				Zero2Max.boardOpt[option2] = false
				self:AdjBrick(window, lColor .. "+" .. lColorE)
			else
				Zero2Max.boardOpt[option2] = true
				self:AdjBrick(window, lColor .. "-" .. lColorE)
			end
			Zero2Max.MainControl:Update()
		end

		-- for panel show/hide
		if option1 == "panelopt" then
			if Zero2Max.boardOpt[option2] then
				Zero2Max.boardOpt[option2] = false
				self:AdjBrick(window, lColor .. ">" .. lColorE)
				Zero2Max_Panel:Hide()
--f				Zero2Max_Portrait:Show()
				self.windowP:Show()
			else
				Zero2Max.boardOpt[option2] = true
				self:AdjBrick(window, lColor .. "<" .. lColorE)
				Zero2Max_Panel:Show()
--f				Zero2Max_Portrait:Hide()
				self.windowP:Hide()
			end
		end

		-- for second panel option
		if option1 == "2panelopt" then
			if Zero2Max.boardOpt[option2][1] then
				Zero2Max.boardOpt[option2][1] = false
				self:AdjBrick(window, lColor .. L[Zero2Max.boardOpt[option2][3] .. titleS] .. lColorE)
			else
				Zero2Max.boardOpt[option2][1] = true
				self:AdjBrick(window, lColor .. L[Zero2Max.boardOpt[option2][2] .. titleS] .. lColorE)
			end
		end

		if option1 == "selectpanel" then

			self.panelA1:SetBackdropBorderColor(0, 0, 0, 0.1)
			self:AdjWinColor(self.panelA1, 0, 0, 0, 0.02)
			self.panelA2:SetBackdropBorderColor(0, 0, 0, 0.1)
			self:AdjWinColor(self.panelA2, 0, 0, 0, 0.02)
			self.panelA3:SetBackdropBorderColor(0, 0, 0, 0.1)
			self:AdjWinColor(self.panelA3, 0, 0, 0, 0.02)
			self.panelA4:SetBackdropBorderColor(0, 0, 0, 0.1)
			self:AdjWinColor(self.panelA4, 0, 0, 0, 0.02)
			self.panelA5:SetBackdropBorderColor(0, 0, 0, 0.1)
			self:AdjWinColor(self.panelA5, 0, 0, 0, 0.02)
			self.panelA6:SetBackdropBorderColor(0, 0, 0, 0.1)
			self:AdjWinColor(self.panelA6, 0, 0, 0, 0.02)
			self.panelA7:SetBackdropBorderColor(0, 0, 0, 0.1)
			self:AdjWinColor(self.panelA7, 0, 0, 0, 0.02)
			self.panelA8:SetBackdropBorderColor(0, 0, 0, 0.1)
			self:AdjWinColor(self.panelA8, 0, 0, 0, 0.02)

			window:SetBackdropBorderColor(0, 1, 1, 1)
			self:AdjWinColor(window, 0, 0.44, 0.871, 0.2)

			self.panelB1:SetPoint("BOTTOMLEFT", window, "TOPLEFT", 0, 1 - gapH)
			self.panelB1:Hide()									-- -------------------------
			self.panelB2:Hide()									-- -------------------------
			self.panelB3:Hide()									-- -------------------------
			self.panelB4:Hide()									-- -------------------------
			self.panelB5:Hide()									-- -------------------------
			self.panelB6:Hide()									-- -------------------------
			self.panelB7:Hide()									-- -------------------------
			self.panelBopt:Hide()								-- -------------------------
			if option2 == 1 then
				Zero2Max.panelSelect = "appset"
				self.panelB1:Show()								-- -------------------------
				self.panelB2:Show()								-- -------------------------
				self.panelB3:Show()								-- -------------------------
				self.panelB4:Show()								-- -------------------------
				self.panelB5:Show()								-- -------------------------
				self.panelB6:Show()								-- -------------------------
				self.panelB7:Show()								-- -------------------------
				self.panelBopt:Show()							-- -------------------------
			end
			if option2 == 2 then
				Zero2Max.panelSelect = "kill"
				self.panelB1:Show()								-- -------------------------
				self.panelB2:Show()								-- -------------------------
				self.panelB3:Show()								-- -------------------------
				self.panelB4:Show()								-- -------------------------
			end
			if option2 == 3 then
				Zero2Max.panelSelect = "explore"
				self.panelB1:Show()								-- -------------------------
				self.panelB2:Show()								-- -------------------------
			end
			if option2 == 4 then
				Zero2Max.panelSelect = "lore"
				self.panelB1:Show()								-- -------------------------
				self.panelB2:Show()								-- -------------------------
			end
			if option2 == 5 then
				Zero2Max.panelSelect = "follower"
				self.panelB1:Show()								-- -------------------------
				self.panelB2:Show()								-- -------------------------
			end
			if option2 == 6 then
				Zero2Max.panelSelect = "quest"
				self.panelB1:Show()								-- -------------------------
				self.panelB2:Show()								-- -------------------------
			end
			if option2 == 7 then
				Zero2Max.panelSelect = "image"
				self.panelB1:Show()								-- -------------------------
				self.panelB2:Show()								-- -------------------------
				self.panelB3:Show()								-- -------------------------
				self.panelB4:Show()								-- -------------------------
				self.panelB5:Show()								-- -------------------------
				self.panelB6:Show()								-- -------------------------
			end
			if option2 == 8 then
				Zero2Max.panelSelect = "profspec"
				self.panelB1:Show()								-- -------------------------
				self.panelB2:Show()								-- -------------------------
			end
		end
    end,

    -- Update the positions
    Update = function(self)
		if Zero2Max.display == true then
			Zero2Max_Board:Show()
			Zero2Max_Board:SetScale(Zero2Max.boardScale)
			Zero2Max_Window:Hide()
			Zero2Max_Window:SetScale(Zero2Max.windowScale)
			Zero2Max_Panel:SetScale(Zero2Max.panelScale)
			if Zero2Max.boardOpt[4] then 
				Zero2Max_Panel:Show()
--f				Zero2Max_Portrait:Hide()
			else
				Zero2Max_Panel:Hide()
--f				Zero2Max_Portrait:Show()
--f				if Zero2Max.MainFrame.windowP ~= nil then
--f					Zero2Max.MainFrame.windowP.picture:Show()
--f				end
			end
			Zero2Max_Image:Hide()
        else
			Zero2Max_Board:Hide()
			Zero2Max_Window:Hide()
			Zero2Max_Panel:Hide()
			Zero2Max_Portrait:Hide()
			Zero2Max_Image:Hide()
        end
    end,
    
    -- Called each time an event is fired.
    OnEvent = function(self)
        return true
    end,
}
