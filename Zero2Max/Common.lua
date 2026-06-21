local _, addonTable = ...
local L = addonTable.GetLocale()

--<<function to setup window during initialize
Zero2Max.MainFrame.BuildWin = function(self, window, wintype)
	if wintype == nil then
		wintype = "message"
	end

	window:SetWidth(100)
	window:SetHeight(100)

	--<<set backdrop
	window:SetBackdrop({
		bgFile   = "Interface/Tooltips/UI-Tooltip-Background",
		edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
		tile     = true,
		tileSize = 16,
		edgeSize = 16,
		insets   = { left = 4, right = 4, top = 4, bottom = 4 }
	})
	window:SetBackdropColor(0, 0, 0, 0.6)
	window:SetBackdropBorderColor(1, 1, 1, 1)
	if (wintype == "board") or (wintype == "brick") then 
		window:SetBackdropBorderColor(0, 0, 0, 0.1)
	end

	--<<create texture, can set color background if need
	window.texture = window:CreateTexture()
	window.texture:SetPoint("TOPLEFT", window, "TOPLEFT", 4, -4)
	window.texture:SetPoint("BOTTOMRIGHT", window, "BOTTOMRIGHT", -4, 4)	
	window.texture:SetColorTexture(0, 0, 0, 0.6)
	if (wintype == "board") or (wintype == "brick") then
		window.texture:SetColorTexture(0, 0, 0, 0.02)
	end

	--<<create frame
	window.line = CreateFrame("Frame", nil, window)
	if (wintype == "header") or (wintype == "brick") then
		window.line.hline=window:CreateFontString(nil, 'OVERLAY', "Zero2Max_header_center")
		window.line.hline:SetText("Header")
		window.line.hline:SetHeight(window.line.hline:GetHeight())
		window.line.hline:SetWidth(window:GetWidth()-20)
		window.line.hline:SetPoint("TOPLEFT", window, "TOPLEFT", 10, -10)
		window.line.hline:SetPoint("TOPRIGHT", window, "TOPRIGHT", -10, -10)
	end
	if (wintype == "board") then
		window.line.lline=window:CreateFontString(nil, 'OVERLAY', "Zero2Max_board_left")
		window.line.lline:SetText("Left")
		window.line.lline:SetHeight(window.line.lline:GetHeight())
		window.line.lline:SetWidth(window.line.lline:GetWidth())
		window.line.lline:SetPoint("TOPLEFT", window, "TOPLEFT", 10, -10)

		window.line.rline=window:CreateFontString(nil, 'OVERLAY', "Zero2Max_board_right")
		window.line.rline:SetText("Right")
		window.line.rline:SetHeight(window.line.rline:GetHeight())
		window.line.rline:SetWidth(window.line.rline:GetWidth())
		window.line.rline:SetPoint("TOPRIGHT", window, "TOPRIGHT", -10, -10)
	end
	if (wintype == "message") then
		window.line.hline=window:CreateFontString(nil, 'OVERLAY', "Zero2Max_tooltip_header")
		window.line.hline:SetText("Header")
		window.line.hline:SetTextColor(1, 1, 0, 1)
		window.line.hline:SetHeight(window.line.hline:GetHeight())
		window.line.hline:SetWidth(window:GetWidth()-20)
		window.line.hline:SetPoint("TOPLEFT", window, "TOPLEFT", 10, -10)

		window.line.lline=window:CreateFontString(nil, 'OVERLAY', "Zero2Max_tooltip_left")
		window.line.lline:SetText("Left")
		window.line.lline:SetHeight(window.line.lline:GetHeight())
		window.line.lline:SetWidth(window.line.lline:GetWidth())
		window.line.lline:SetPoint("TOPLEFT", window.line.hline, "BOTTOMLEFT", 0, -20)

		window.line.rline=window:CreateFontString(nil, 'OVERLAY', "Zero2Max_tooltip_right")
		window.line.rline:SetText("Right")
		window.line.rline:SetHeight(window.line.rline:GetHeight())
		window.line.rline:SetWidth(window.line.rline:GetWidth())
		window.line.rline:SetPoint("TOPRIGHT", window.line.hline, "BOTTOMRIGHT", 0, -20)
	end
end


--<<function to setup portrait and image during initialize
Zero2Max.MainFrame.BuildPor = function(self, window, wintype)
	window:SetWidth(50)
	window:SetHeight(50)

	--<<set backdrop
	window:SetBackdrop({
		bgFile   = "Interface/Tooltips/UI-Tooltip-Background",
		edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
		tile     = true,
		tileSize = 16,
		edgeSize = 16,
		insets   = { left = 4, right = 4, top = 4, bottom = 4 }
	})
	window:SetBackdropColor(0, 0, 0, 0.6)
	window:SetBackdropBorderColor(1, 1, 1, 1)

	--<<create frame
	window.picture=CreateFrame("DressUpModel", nil, window)
	window.picture:SetPoint("TOPLEFT", window ,"TOPLEFT", 4, -4)
	window.picture:SetPoint("BOTTOMRIGHT", window ,"BOTTOMRIGHT", -4, 4)
	window.picture:SetAlpha(1)
	window:Hide()
end


--<<function to merge left text
Zero2Max.MainFrame.AddL = function(ltext, newline, lnew, color)
	local nl = "\n"
	local cend = "|r"
	if newline then
		ltext = ltext .. nl
	end
	if lnew ~= nil then
		if color == nil then
			ltext = ltext .. lnew
		else
			ltext = ltext .. color .. lnew .. cend
		end
	end
	return ltext
end


--<<function to merge left and right text
Zero2Max.MainFrame.AddLR = function(mtext, ltext, rtext, newline, lnew, rnew, color)
	local nl = "\n"
	local cend = "|r"
	if newline then
		mtext = mtext .. nl
		ltext = ltext .. nl
		rtext = rtext .. nl
	end
	if lnew ~= nil then
		if color == nil then
			mtext = mtext .. lnew .. "     " .. rnew
			ltext = ltext .. lnew
			rtext = rtext .. rnew			
		else
			mtext = mtext .. color .. lnew .. cend .. "     " .. color .. rnew .. cend
			ltext = ltext .. color .. lnew .. cend
			rtext = rtext .. color .. rnew .. cend			
		end
	end
	return mtext, ltext, rtext
end


--<<function to set text and adjust board size
Zero2Max.MainFrame.AdjBoard = function(self, window, mtext, ltext, rtext, lonly)
	local maxlength = 0
	local cntx = 0
	local cnty = 0

	--<<use merged text to count better length
	window.line.lline:SetHeight(500)
	window.line.lline:SetWidth(500)
	window.line.lline:SetSpacing(1)
	window.line.lline:SetText(mtext)
	if (lonly ~= nil) and lonly then
		-- board suppressed, count left length only
		window.line.lline:SetText(ltext)
	end
	maxlength = window.line.lline:GetStringWidth()

	--<<fill left text
	window.line.lline:SetHeight(500)
	window.line.lline:SetWidth(500)
	window.line.lline:SetSpacing(1)
	window.line.lline:SetText(ltext)
	window.line.lline:SetHeight(window.line.lline:GetStringHeight())
	window.line.lline:SetWidth(window.line.lline:GetStringWidth())

	--<<fill right text
	window.line.rline:SetHeight(500)
	window.line.rline:SetWidth(500)
	window.line.rline:SetSpacing(1)
	window.line.rline:SetText(rtext)
	window.line.rline:SetHeight(window.line.rline:GetStringHeight())
	window.line.rline:SetWidth(window.line.rline:GetStringWidth())

	--<<count frame size, update frame size
	cnty = 10 + window.line.lline:GetStringHeight() + 10
	cntx = 10 + maxlength + 10
	window:SetHeight(cnty)
	window:SetWidth(cntx)
	window.line:SetHeight(cnty)
	window.line:SetWidth(cntx)
end


--<<function to set text and adjust brick size
Zero2Max.MainFrame.AdjBrick = function(self, window, mtext)
	local cntx = 0
	local cnty = 0

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


--<<function to set text and adjust message window size
Zero2Max.MainFrame.AdjWin = function(self, window, mtext, ltext, rtext, lonly)
	local maxlength = 0
	local cntx = 0
	local cnty = 0

	--<<set header text again for correct string length
	local htext = window.line.hline:GetText()
	window.line.hline:SetWidth(500)
	window.line.hline:SetText(htext)

	--<<use merged text to count better length
	window.line.lline:SetHeight(500)
	window.line.lline:SetWidth(500)
	window.line.lline:SetSpacing(1)
	window.line.lline:SetText(mtext)
	if (lonly ~= nil) and lonly then
		-- count left length only
		window.line.lline:SetText(ltext)
	end
	maxlength = window.line.lline:GetStringWidth()
	if maxlength < window.line.hline:GetStringWidth() then
		maxlength = window.line.hline:GetStringWidth()
	end

	--<<fill left text
	window.line.lline:SetHeight(500)
	window.line.lline:SetWidth(500)
	window.line.lline:SetSpacing(1)
	window.line.lline:SetText(ltext)
	window.line.lline:SetHeight(window.line.lline:GetStringHeight())
	window.line.lline:SetWidth(window.line.lline:GetStringWidth())

	--<<fill right text
	window.line.rline:SetHeight(500)
	window.line.rline:SetWidth(500)
	window.line.rline:SetSpacing(1)
	window.line.rline:SetText(rtext)
	window.line.rline:SetHeight(window.line.rline:GetStringHeight())
	window.line.rline:SetWidth(window.line.rline:GetStringWidth())

	--<<count frame size, update frame size
	cnty = 10 + window.line.hline:GetStringHeight() + 20 + window.line.lline:GetStringHeight() + 10
	cntx = 10 + maxlength + 10
	window:SetHeight(cnty)
	window:SetWidth(cntx)
	window.line:SetHeight(cnty)
	window.line:SetWidth(cntx)
	window.line.hline:SetWidth(cntx - 20)
end


--<<function to adjust top down frame width
Zero2Max.MainFrame.AdjTopDownWin = function(self, win1, win2)
	local len1 = win1:GetWidth()
	local len2 = win2:GetWidth()
	if len1 > len2 then
		win2:SetWidth(len1)
		win2.line:SetWidth(len1)
		win2.line.hline:SetWidth(len1 - 20)
		win2.line.hline:SetPoint("TOPLEFT", win2, "TOPLEFT", 10, -10)
		win2.line.lline:SetPoint("TOPLEFT", win2.line.hline, "BOTTOMLEFT", 0, -20)
		win2.line.rline:SetPoint("TOPRIGHT", win2.line.hline, "BOTTOMRIGHT", 0, -20)
	elseif len1 < len2 then
		win1:SetWidth(len2)
		win1.line:SetWidth(len2)
		win1.line.hline:SetWidth(len2 - 20)
		win1.line.hline:SetPoint("TOPLEFT", win1, "TOPLEFT", 10, -10)
		win1.line.lline:SetPoint("TOPLEFT", win1.line.hline, "BOTTOMLEFT", 0, -20)
		win1.line.rline:SetPoint("TOPRIGHT", win1.line.hline, "BOTTOMRIGHT", 0, -20)
	end
end


--<<function to adjust all top down frame width
Zero2Max.MainFrame.AdjAllTopDownWin = function(self)
	self:AdjTopDownWin(self.windowA1, self.windowB1)
	self:AdjTopDownWin(self.windowB1, self.windowC1)
	self:AdjTopDownWin(self.windowA1, self.windowC1)
	
	self:AdjTopDownWin(self.windowA2, self.windowB2)
	self:AdjTopDownWin(self.windowB2, self.windowC2)
	self:AdjTopDownWin(self.windowA2, self.windowC2)
	
	self:AdjTopDownWin(self.windowA3, self.windowB3)
	self:AdjTopDownWin(self.windowB3, self.windowC3)
	self:AdjTopDownWin(self.windowA3, self.windowC3)
	
	self:AdjTopDownWin(self.windowA4, self.windowB4)
	self:AdjTopDownWin(self.windowB4, self.windowC4)
	self:AdjTopDownWin(self.windowA4, self.windowC4)
end


--<<function to adjust top frame width
Zero2Max.MainFrame.AdjTopWin = function(self)
	local len1 = 10 + self.windowT.line.hline:GetStringWidth() + 10
	local len2 = self.windowA1:GetWidth()
	if self.windowA2:IsShown() then
		len2 = len2 + self.windowA2:GetWidth() + 1
	end
	if self.windowA3:IsShown() then
		len2 = len2 + self.windowA3:GetWidth() + 1
	end
	if self.windowA4:IsShown() then
		len2 = len2 + self.windowA4:GetWidth() + 1
	end
	if len1 < len2 then
		self.windowT:SetWidth(len2)
		self.windowT.line:SetWidth(len2)
	else
		self.windowT:SetWidth(len1)
		self.windowT.line:SetWidth(len1)
	end
end


--<<function to adjust top down board width
Zero2Max.MainFrame.AdjTopDownBoard = function(self, win1, win2)
	local len1 = win1:GetWidth()
	local len2 = win2:GetWidth()
	if len1 > len2 then
		win2:SetWidth(len1)
		win2.line:SetWidth(len1)
		win2.line.lline:SetPoint("TOPLEFT", win2, "TOPLEFT", 10, -10)
	elseif len1 < len2 then
		win1:SetWidth(len2)
		win1.line:SetWidth(len2)
		win1.line.lline:SetPoint("TOPLEFT", win1, "TOPLEFT", 10, -10)
	end
end


--<<function to adjust all top down board width
Zero2Max.MainFrame.AdjAllTopDownBoard = function(self)
	self:AdjTopDownBoard(self.window,  self.sboard1)
	self:AdjTopDownBoard(self.sboard1, self.sboard2)
	self:AdjTopDownBoard(self.window,  self.sboard2)
end


--<<function to adjust window color
Zero2Max.MainFrame.AdjWinColor = function(self, window, bg_r, bg_g, bg_b, bg_a)
	window.texture:SetPoint("TOPLEFT", window, "TOPLEFT", 4, -4)
	window.texture:SetPoint("BOTTOMRIGHT", window, "BOTTOMRIGHT", -4, 4)	
	window.texture:SetColorTexture(bg_r, bg_g, bg_b, bg_a);
end
