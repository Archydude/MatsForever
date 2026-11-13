# Changelog

## 1.3.1
- Fixed an error when opening the options during combat ("tried to call the protected function 'OpenSettingsPanel()'"). The options now open as soon as the fight ends.

## 1.3.0
- New: in your own professions, a long Shift recipe list leaves out the recipes that are already grey for you, so it starts at the ones that still give skill-ups. A line says how many were left out.
- A profession with up to 15 recipes for the material now lists them all, instead of 10 and "and 2 more".

## 1.2.0
- New: in the Shift recipe list, your own professions show your current skill at the end of their row, so you can compare it with the recipes' levels.
- Fixed: a few trainer recipes showed a required skill that didn't fit their colors, like Coarse Sharpening Stone needing 75 but turning grey at 55. Those old numbers are gone.
- Recipes that need more skill than where they turn yellow no longer list the colors you're already past when you learn them.

## 1.1.0
- The tooltip line now starts with **Mat For:** instead of "Used by:".
- New: an **Only my professions** option leaves out professions your character doesn't have. Materials none of your professions use get no line.

## 1.0.0
- First release: a crafting material's tooltip shows which professions use it and in how many recipes, like `Used by: Engineering (6), Blacksmithing (3), First Aid (2), Tailoring (1)` on Linen Cloth. Each profession shows its icon, and your own come first, in green.
- Hold **Shift** to see the recipes themselves, how many of the material each one takes, and their skill levels in the recipe colors: the skill a recipe needs (orange, for recipes learned from a recipe item), then where it turns yellow, green and grey.
- Covers every profession, including the recipes new to WoW Forever, whether or not your character has learned them.
- `/matsforever` opens the options.
