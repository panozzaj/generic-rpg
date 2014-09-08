
Things that we can work on:

 - "The Quest"
  - Cut scene when you talk to the king or when the game first loads that describes the scene
  - Random battles with random monsters on the overworld
  - Dungeon that you walk to
  - A couple of items on the way that you can equip?
  - Different random monsters in the dungeon
  - Boss at the end
  - Gives you an item / sets a flag and then when you go back (or are teleported back for minimum boringness)
  - You win!

  - Talk to King

  - If first time, show cut scene (this could be an object)

  - Minimum cut scene
   - talk to king
   - he says one dialog and then moves away somewhere
    - give NPC a more generic interface
   - main character follows
   - dialog continues

  - Run through the cut scene
   - fade out
   - change map
   - fade in
   - text dialogs
   - fade out
   - change map
   - fade in

  - When done, return control to the player



 - Animation system
  - sprite animation
   - specification of show this image for 30 frames
  - damage animation
  - cut scene
   - lower: panning camera
   - lower: walking to tile
    - lower than that: move character one tile


 - map mode

  - Move NPC around
  - dialog: passing text and splitting on words intelligently?
  - loading conversations from a file instead of it being in the source
  - data driven from map file or something to generate NPCs

  - change Map.Avatar to work in terms of tiles
    - maybe as fractions of a tile?

  - getting items and being able to use them

  - handle more than one tileset image

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

  - showing who is next in a list?
  - spritifying at some point

  - make run probabilistically succeed

 - audio
  - cache sound effects + music?
  - give different weapons and spells unique sounds

 - refactor drawing dialogs, menus, etc. to extend from a common class



 Technical debt
  - add "events" declaration to easily add event handlers to objects

 Floobits-specific
  - figure out a way to get both people with a valid git repository in floobits

 Would be really sweet list
  - parallax scrolling of battle backgrounds
  - NPCs talk to each other with little speech bubbles, which you can see
  - bull monster that only attacks players with red clothes
  - game where you try to rally the troops by conversation / motivation
  - "massively single-player online RPG"
    - only open certain quests when a certain number of all players have done X
    - "mayor of a town" -- whoever has helped the most people in an area is adored by the inhabitants
  - reputation / dark/light path


 Ecosystem improvements
  - better texture loader program
  - tmxloader.js improvement resubmission / fork

 General improvements
  - tile vs. pixel dimensions for easier translation / readability

 Consider:
  - context.scale(4,4) instead of passing MapScreen#tileSize around?

