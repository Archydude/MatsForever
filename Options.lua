-- Mats Forever: options
-- Esc > Options > AddOns > Mats Forever.

local _, ns = ...

local category

-- The game doesn't let addons open its settings during combat, so a request then waits for the fight to end.
local openAfterCombat = false
local combatWatch = CreateFrame("Frame")
combatWatch:SetScript("OnEvent", function(self)
	self:UnregisterEvent("PLAYER_REGEN_ENABLED")
	openAfterCombat = false
	ns.OpenOptions()
end)

function ns.OpenOptions()
	if not category then return end
	if InCombatLockdown() then
		if not openAfterCombat then
			openAfterCombat = true
			combatWatch:RegisterEvent("PLAYER_REGEN_ENABLED")
			print("|cffffd100Mats Forever:|r the options open when you leave combat.")
		end
		return
	end
	Settings.OpenToCategory(category:GetID())
end

function ns.CreateOptions()
	category = Settings.RegisterVerticalLayoutCategory("Mats Forever")
	local VarType = Settings.VarType or { Boolean = "boolean" }

	local function checkbox(key, name, tooltip)
		local setting = Settings.RegisterAddOnSetting(category, "MATSFOREVER_" .. key:upper(), key, ns.db,
			VarType.Boolean, name, ns.DEFAULTS[key])
		Settings.CreateCheckbox(category, setting, tooltip)
	end

	checkbox("tooltip", "Show on tooltips",
		"Show which professions use a crafting material, and in how many recipes, on its tooltip.")
	checkbox("recipeList", "Hold Shift for recipes",
		"While you hold Shift, the tooltip lists each profession's recipes and how many of the material they take.")
	checkbox("onlyMine", "Only my professions",
		"Leave out professions this character doesn't have. Materials no profession of yours uses get no line.")

	Settings.RegisterAddOnCategory(category)
end
