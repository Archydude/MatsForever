# Mats Forever: CurseForge upload sheet

What to type into each CurseForge field, ready to copy and paste. The steps for a first upload and for releasing an update are in [UPLOADING.md](../UPLOADING.md).

Update this sheet with every release: the zip, the display name and the changelog, and rewrite the description so it covers everything in the new version.

## A. Project form

**Project name**
```
Mats Forever
```

**Summary**
```
See which professions use any crafting material, and in how many recipes, right on its tooltip. Hold Shift for the recipes.
```

**Main category:** `Professions`
**Additional categories:** `Tooltip`

**License:** `MIT License`

**Logo / avatar:** `MatsForever\images\logo-v1.png` (an open golden recipe book over linen, leather, copper ore, a vial and herbs)

**Description** (paste everything between the lines)

---
```markdown
## Keep it or sell it?

Mats Forever shows on every crafting material's tooltip not just which professions use it, but **how many recipes** each one has for it, and with Shift held, **the recipes themselves** with their skill levels. You know what a material is worth to you the moment you loot it.

Example, on Linen Cloth: `Mat For: Engineering (6), Blacksmithing (3), First Aid (2), Tailoring (1)`

### Hold Shift for the recipes
Hold **Shift** while hovering a material to see each profession's recipes that use it, easiest first, with how many of the material each one takes and its **skill levels** in the recipe colors: the skill it needs (orange, for recipes learned from a recipe item), then where it turns yellow, green and grey. Your own professions show **your current skill**, and long lists there skip recipes already grey for you.

Example, on Linen Cloth, for an engineer with 72 skill:
`Engineering      72`
`    Rough Dynamite x1      30 45 60`
`    EZ-Thro Dynamite x1      100 115 122 130`

### Your professions first
Each profession shows its icon, and the ones your character has come first, in green, so you know at a glance whether a material is for you, an alt or the auction house. Turn on **Only my professions** to hide the rest.

### Every profession, every recipe
- **All professions count**, not just yours: Alchemy, Blacksmithing, Cooking, Enchanting, Engineering, First Aid, Leatherworking, Tailoring, Mining smelting, rogue Poisons, and the new Herbalism, Skinning and Fishing crafts.
- **Recipes you haven't learned count too**, so a material you've never used still tells you who wants it.
- **The recipes new to WoW Forever are included.** Peacebloom, for example, also goes into First Aid's healing potions, Cooking's Peace Tea and Herbalism's Incense Candles.

### Everywhere you see items
Bags, bank, the auction house, mail, loot windows, chat links and recipe windows, in your game's language.

### Good to know
- Made for **WoW Forever**.
- A big WoW Forever update that adds recipes may need an update here to show them.
- **/matsforever** opens the options: turn off the tooltip line or the Shift list, or show only your professions.

**Feedback and bug reports are welcome** in the comments.
```
---

**Source / Issues links:** `https://github.com/Archydude/MatsForever` and `https://github.com/Archydude/MatsForever/issues`

## B. Upload File form

**File:** `dist\MatsForever-1.3.1.zip`

**Display name**
```
Mats Forever 1.3.1
```

**Release type:** `Release`

**Game versions:** Forever `1.60.1`.

**Changelog** (paste only the newest part; paste older parts too if they never went up)
```markdown
1.3.1
- Fixed an error when opening the options during combat ("tried to call the protected function 'OpenSettingsPanel()'"). The options now open as soon as the fight ends.

1.3.0
- New: in your own professions, a long Shift recipe list leaves out the recipes that are already grey for you, so it starts at the ones that still give skill-ups. A line says how many were left out.
- A profession with up to 15 recipes for the material now lists them all, instead of 10 and "and 2 more".
```
