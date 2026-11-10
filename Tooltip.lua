-- Mats Forever: the tooltip lines
--
--   Mat For: [icon] Engineering (6), [icon] First Aid (2)
--
-- The character's own professions come first, in green; an option hides the others. Holding Shift lists each profession's recipes
-- with how many of the material they take and their skill levels, easiest first, and the character's
-- own skill next to each of their professions:
--
--   Engineering                        72
--   Rough Copper Bomb x2          60 75 90
--
-- in the recipe colors: the skill it needs (orange, only when the game data has it), then where it turns
-- yellow, green and grey.

local _, ns = ...

local MAX_RECIPES = 10 -- per profession in the Shift list; the rest are counted in one line
local MAX_HIDDEN_ALL = 5 -- a profession with at most this many past MAX_RECIPES shows them all instead

local LABEL = "|cffffd100Mat For:|r "
local MINE_COLOR = "|cff40ff40%s|r"
local OTHER_COLOR = "|cffffffff%s|r"
local GREY = { 0.6, 0.6, 0.6 }
local COUNT_COLOR = "|cff66ccffx%d|r" -- light blue: not one of the skill colors, the profession green or the label gold
local ICON = "|T%d:0|t " -- 0: as tall as the text
local SKILL_COLORS = { "|cffff8040%d|r", "|cffffff00%d|r", "|cff40bf40%d|r", "|cff808080%d|r" } -- orange, yellow, green, grey

---------------------------------------------------------------------------
-- Reading the data
---------------------------------------------------------------------------

-- item ID -> { { prof = id, recipes = { { spell, count, required, yellow, grey }, ... } }, ... }, read from
-- the data on first hover. required is 0 when the game data doesn't have it.
local parsed = {}

local function usesOf(item)
	local cached = parsed[item]
	if cached ~= nil then return cached end
	local text = ns.REAGENTS[item]
	if not text then
		parsed[item] = false
		return false
	end
	local uses = {}
	for prof, list in text:gmatch("(%d+):([^;]+)") do
		local recipes = {}
		for spell, count, required, yellow, grey in list:gmatch("(%d+)%.(%d+)%.(%d+)%.(%d+)%.(%d+)") do
			recipes[#recipes + 1] = { tonumber(spell), tonumber(count), tonumber(required), tonumber(yellow), tonumber(grey) }
		end
		uses[#uses + 1] = { prof = tonumber(prof), recipes = recipes }
	end
	parsed[item] = uses
	return uses
end

-- The professions to show: the character's first, then the ones with the most recipes. With the
-- "only my professions" option, just the character's.
local function shownUses(uses)
	local list = {}
	for _, use in ipairs(uses) do
		if not ns.db.onlyMine or ns.IsMyProfession(use.prof) then list[#list + 1] = use end
	end
	table.sort(list, function(a, b)
		local ma, mb = ns.IsMyProfession(a.prof), ns.IsMyProfession(b.prof)
		if ma ~= mb then return ma end
		if #a.recipes ~= #b.recipes then return #a.recipes > #b.recipes end
		return ns.ProfessionName(a.prof) < ns.ProfessionName(b.prof)
	end)
	return list
end

local function spellName(id)
	if C_Spell and C_Spell.GetSpellName then return C_Spell.GetSpellName(id) end
	return (GetSpellInfo(id))
end

-- "30 60 75 90" in the recipe colors. Green is halfway between yellow and grey, like the game works it out.
-- Some Forever recipes need more skill than where they turn yellow (or green); those colors are already
-- behind the player when they learn it, so they're left out: "225 230 240" is learned at 225, yellow
-- right away, green at 230. One that is already grey when learned shows only its required skill, in grey.
local function skillLevels(recipe)
	local required, yellow, grey = recipe[3], recipe[4], recipe[5]
	if grey > 0 and required >= grey then return SKILL_COLORS[4]:format(required) end
	local green = math.floor((yellow + grey) / 2)
	local parts = {}
	if required > 0 then parts[#parts + 1] = SKILL_COLORS[1]:format(required) end
	if grey > 0 then
		if yellow > required then parts[#parts + 1] = SKILL_COLORS[2]:format(yellow) end
		if green > required then parts[#parts + 1] = SKILL_COLORS[3]:format(green) end
		parts[#parts + 1] = SKILL_COLORS[4]:format(grey)
	end
	return table.concat(parts, " ")
end

-- The profession's icon and name, the name in green when it's one of the character's.
local function coloredName(prof)
	local icon = ns.PROFESSION_ICONS[prof]
	local name = (ns.IsMyProfession(prof) and MINE_COLOR or OTHER_COLOR):format(ns.ProfessionName(prof))
	return icon and ICON:format(icon) .. name or name
end

---------------------------------------------------------------------------
-- Adding the lines
---------------------------------------------------------------------------

local function addSummary(tooltip, uses)
	local parts = {}
	for i, use in ipairs(uses) do
		parts[i] = coloredName(use.prof) .. " (" .. #use.recipes .. ")"
	end
	tooltip:AddLine(LABEL .. table.concat(parts, ", "), 1, 1, 1, true)
end

-- Whether a list this long is cut short. "and 2 more" would take a line too, so short overflows
-- are listed in full.
local function tooLong(count)
	return count > MAX_RECIPES + MAX_HIDDEN_ALL
end

-- The recipes to list for one profession, and how many grey ones were left out. A long list in one
-- of the character's professions starts at the recipes that still give skill-ups; when every
-- recipe is grey, it's listed as it is.
local function recipesToList(recipes, skill)
	if not (skill and skill > 0 and tooLong(#recipes)) then return recipes, 0 end
	local list = {}
	for _, recipe in ipairs(recipes) do
		local grey = recipe[5]
		if grey == 0 or grey > skill then list[#list + 1] = recipe end
	end
	if #list == 0 then return recipes, 0 end
	return list, #recipes - #list
end

local function addRecipeList(tooltip, uses)
	tooltip:AddLine(" ")
	tooltip:AddLine(LABEL)
	for _, use in ipairs(uses) do
		local skill = ns.MySkill(use.prof)
		if skill and skill > 0 then
			-- The character's own skill on the right, above the recipes' skill levels.
			tooltip:AddDoubleLine(coloredName(use.prof), MINE_COLOR:format(skill))
		else
			tooltip:AddLine(coloredName(use.prof))
		end
		local recipes, greyLeftOut = recipesToList(use.recipes, skill)
		if greyLeftOut > 0 then
			local text = greyLeftOut == 1 and "    1 grey recipe left out" or ("    %d grey recipes left out"):format(greyLeftOut)
			tooltip:AddLine(text, unpack(GREY))
		end
		local shown = 0
		local limit = tooLong(#recipes) and MAX_RECIPES or #recipes
		for _, recipe in ipairs(recipes) do
			if shown == limit then break end
			local name = spellName(recipe[1])
			if name then
				tooltip:AddDoubleLine("    " .. name .. " " .. COUNT_COLOR:format(recipe[2]), skillLevels(recipe),
					1, 1, 1, 1, 1, 1)
				shown = shown + 1
			end
		end
		local more = #recipes - shown
		if more > 0 then
			tooltip:AddLine(("    and %d more"):format(more), unpack(GREY))
		end
	end
end

local function addLines(tooltip, item)
	local uses = usesOf(item)
	if not uses then return false end
	uses = shownUses(uses)
	if #uses == 0 then return false end
	if ns.db.recipeList and IsShiftKeyDown() then
		addRecipeList(tooltip, uses)
	else
		addSummary(tooltip, uses)
	end
	return true
end

---------------------------------------------------------------------------
-- Hooking item tooltips
---------------------------------------------------------------------------

-- Tooltips that already got their lines, until they're cleared. Some tooltips report the same item
-- twice while it loads.
local done = setmetatable({}, { __mode = "k" })
local watched = setmetatable({}, { __mode = "k" })

local function watch(tooltip)
	if watched[tooltip] then return end
	watched[tooltip] = true
	local function reset() done[tooltip] = nil end
	pcall(tooltip.HookScript, tooltip, "OnTooltipCleared", reset)
	pcall(tooltip.HookScript, tooltip, "OnHide", reset)
end

-- The tooltip showing a material, so pressing or letting go of Shift can redraw it.
local shownOn

-- Returns true when lines were added.
local function onItem(tooltip, id)
	if not (ns.db and ns.db.tooltip) then return end
	if not ns.Readable(id) or type(id) ~= "number" or not tooltip.AddLine then return end
	watch(tooltip)
	if done[tooltip] == id then return end
	done[tooltip] = id
	if addLines(tooltip, id) then
		shownOn = tooltip
		return true
	end
end

local function itemID(link)
	return link and tonumber(link:match("item:(%d+)"))
end

if TooltipDataProcessor and TooltipDataProcessor.AddTooltipPostCall and Enum.TooltipDataType then
	TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Item, function(tooltip, data)
		onItem(tooltip, data and data.id)
	end)
else
	local function onSetItem(tooltip)
		local ok, _, link = pcall(tooltip.GetItem, tooltip)
		if ok and onItem(tooltip, itemID(link)) then tooltip:Show() end
	end
	for _, tooltip in ipairs({ GameTooltip, ItemRefTooltip }) do
		if tooltip then tooltip:HookScript("OnTooltipSetItem", onSetItem) end
	end
end

---------------------------------------------------------------------------
-- Redrawing when Shift is pressed or let go
---------------------------------------------------------------------------

local function redraw(tooltip)
	if tooltip.RefreshData then
		tooltip:RefreshData()
		return
	end
	-- Older tooltips: ask what the mouse is over to show its tooltip again.
	local owner = tooltip:GetOwner()
	local onEnter = owner and owner.GetScript and owner:GetScript("OnEnter")
	if onEnter and owner:IsMouseOver() then onEnter(owner) end
end

local shiftWatch = CreateFrame("Frame")
shiftWatch:RegisterEvent("MODIFIER_STATE_CHANGED")
shiftWatch:SetScript("OnEvent", function(_, _, key)
	if not (ns.db and ns.db.tooltip and ns.db.recipeList) then return end
	if key ~= "LSHIFT" and key ~= "RSHIFT" then return end
	local tooltip = shownOn
	if not (tooltip and tooltip:IsShown() and done[tooltip]) then return end
	done[tooltip] = nil
	redraw(tooltip)
end)
