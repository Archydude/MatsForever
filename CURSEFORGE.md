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
Hold **Shift** on a material to see each profession's recipes, easiest first. Each shows its **item icon**, material count and **skill levels** (orange required skill, then yellow, green and grey). Your own professions show **your skill**, color recipe names live by difficulty, mark **known recipes** with a green checkmark, and skip already-grey recipes on long lists.

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
- **/matsforever** (`/mf`, `/mats`) opens the options.

This addon was made with AI.

**Feedback and bug reports are welcome** in the comments.
```
---

**Source / Issues links:** `https://github.com/Archydude/MatsForever` and `https://github.com/Archydude/MatsForever/issues`

## B. Upload File form

**File:** `dist\MatsForever-1.5.1.zip`

**Display name**
```
Mats Forever 1.5.1
```

**Release type:** `Release`

**Game versions:** Forever `1.60.1`.

**Changelog** (paste only the newest part; paste older parts too if they never went up)
```markdown
1.5.1
- Fixed: leveling a profession updates your skill on tooltips right away, and racial or bonus skill modifiers (like Gnome Engineering) now count toward your displayed skill and recipe difficulty colors.
- Fixed: recipes unavailable on your game client are filtered out before counting "and N more" in the Shift recipe list.
- Fixed: characters with no learned professions no longer re-scan their skill list repeatedly on every tooltip hover.

1.5.0
- **Known recipes marked:** in the Shift recipe list, recipes your character already knows show a green checkmark.
- **Live recipe colors:** for your own professions, each recipe's name is colored orange, yellow, green or grey based on your current skill level.
- **Shorter slash commands:** `/mf` and `/mats` now open the options alongside `/matsforever`.
- Fixed: recipes whose yellow, green and grey skill thresholds overlap no longer repeat the same number twice.

1.4.0
- New: in the Shift recipe list, each recipe shows the icon of the item it makes, so you can spot a recipe without reading every name. Recipes that make no item, like enchants, show the recipe's own icon.
```
