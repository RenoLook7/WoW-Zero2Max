local _, addonTable = ...
local L = {}
local locales = {}

function addonTable.NewLocale(name, displayName, parentName)
	local L = locales[name] or {}
	locales[name] = L
	if parentName then
		setmetatable(L, { __index = locales[parentName] } )
	end
	return L
end

function addonTable.SetLocale(name)
	if locales[name] then
		setmetatable(L, { __index = locales[name] } )
		return true
	end
	return false
end

function addonTable.GetLocale()
	return L
end

function addonTable.WipeLocales()
	table.wipe(locales)
end
