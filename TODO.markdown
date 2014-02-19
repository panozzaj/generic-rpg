
Things that we can work on:

 - battle mode

# - ability to pick enemy to target with attacks, magic, etc.
#  - can select own avatar for attacking

   - probably shouldn't be able to select a person that has been KO'ed
    - unless we are casting revive?

  - autoselect a different person to attack when the person you were going to attack is swooned

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
   - make them into a stack
   - abstract dialog/menu out a little
   - moving subaction off of the action superclass
   - add a border to dialogs/menus

  - separate the concept of a particular battle from battle.screen
   - put various things on battle instead of screen (which is mostly a container)
   - store results of the battle on an outside object
     so that battle results persist (HP loss, exp., etc.)

  - enter battle animation

  - showing who is next in a list?
  - spritifying at some point

  - run is probabilistic

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
  - bull monster that only attacks players with red clothes


