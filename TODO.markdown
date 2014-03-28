
Things that we can work on:

 - map mode

  - disable walking through NPCs

  - getting items

  - handle more than one tileset image

  - context.scale(4,4) instead of passing MapScreen#tileSize around?

  - NPC box that when you walk up to it, it opens a quick chat dialog
   - Move NPC around
   - passing text and splitting on words intelligently
   - multiple dialog boxes in a row ("conversation")
   - data driven from map file or something to generate NPCs
   - fix dialog to not be absolutely positioned at (320,240) (or whatever it is)

 - screen modes
   - menu
   - cutscene
  - party switch mechanism
  - deploy somewhere and see what things break


 - generic animation handler
  - sprite animation, etc.


 - battle mode

  - Battle.Action.Spell
    - make spells have different base damage
    - announce what spell is being cast
    - show MP cost next to name
    - subtract from MP pool
    - grey out spells that we don't have MP for

  - Battle.Action.Attack
    - make weapons have different base damage?

  - when someone is attacking or whatever, they glow or otherwise show that they are the ones initiating the attack
    - maybe actually animate?

  - add probability of missing an attack

  - refactor Menu > Submenu > Entity Selector
   - abstract dialog/menu out a little
   - moving subaction off of the action superclass

  - showing who is next in a list?
  - spritifying at some point

  - make run probabilistically succeed

 - audio
  - cache sound effects + music?
  - give different weapons and spells unique sounds

 - refactor drawing dialogs, menus, etc. to extend from a common class



 Nice-to-haves:
  - parallax scrolling of battle backgrounds

 Technical debt
  - figure out a way to get both people with a valid git repository in floobits
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
  - bull monster that only attacks players with red clothes
  - game where you try to rally the troops by conversation / motivation
  - "massively single-player online RPG"
    - only open certain quests when a certain number of all players have done X
    - "mayor of a town" -- whoever has helped the most people in an area is adored by the inhabitants


 Ecosystem improvements
  - better texture loader program
  - tmxloader.js improvement resubmission / fork

 General improvements
  - tile vs. pixel dimensions for easier translation / readability
