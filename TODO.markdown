Things that we can work on:

 - battle mode
  - some sort of generic battle mode with no functionality
   - tests switching game modes and having key handler properly working
  - boxes attacking other boxes
  - enter battle animation
  - general info on the battle (HP display, etc.)
  - spritifying at some point

 - NPC box that when you walk up to it, it opens a quick chat dialog
  - Move NPC around
  - passing text and splitting on words intelligently
  - multiple dialog boxes in a row ("conversation")
  - data driven from map file or something to generate NPCs

 - a dude moving around on a landscape
  - render background tiles with sprites
  - some sort of bounds checking on landscape (or other screens)
  - center map around dude?
  - collision
  - restrict to map boundaries
 - screen modes
#  - map
   - battle
   - menu
   - cutscene
  - party switch mechanism
  - deploy somewhere and see what things break

 Nice-to-haves:
  - parallax scrolling of map backgrounds

 Technical debt
  - figure out a way to get both people with a valid git repository in floobits
  - pairing gem so it doesn't look like one person only worked on it (shipstars-ego.gem)
  - Need to have files / folders open in floobits for them to show up?
   - basically generated files are also not working correctly?
   - add "events" declaration to easily add event handlers to objects

 Floobits-specific
  - having a tough time syncing things flawlessly
   - basically it looks like we are pulling in files from the workspace instead of using what is on disk (Vim)
   - or changes are not synced over to the workspace
   - especially when we build files?


 Would be really sweet list
  - NPCs talk to each other with little speech bubbles, which you can see
