
Things that we can work on:

 - map mode
  - a dude moving around on a landscape
   - collision
#  - scrolling
   - change maps
    - enter / exit town
    - enter building
   - some sort of bounds checking on landscape (or other screens)
   - center map around dude
   - restrict to map boundaries

  - NPC box that when you walk up to it, it opens a quick chat dialog
   - Move NPC around
   - passing text and splitting on words intelligently
   - multiple dialog boxes in a row ("conversation")
   - data driven from map file or something to generate NPCs



 - screen modes
   - menu
   - cutscene
  - party switch mechanism
  - deploy somewhere and see what things break


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

  - enter battle animation

  - showing who is next in a list?
  - spritifying at some point

  - make run probabilistically succeed

 - refactor drawing dialogs, menus, etc. to extend from a common class


 Nice-to-haves:
  - parallax scrolling of map backgrounds

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
