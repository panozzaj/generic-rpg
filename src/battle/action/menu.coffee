class Battle.Action.Menu extends Battle.Action
  execute: ->
    @menu = new Battle.Menu
      callback: @pickedMainMenuOption
      avatar: @source

  update: ->

  pickedMainMenuOption: (@selectedAction) =>
    if @selectedAction.needsSubtype
      spells = @source.knownSpells()
      @submenu = new Battle.Submenu
        spells: spells
        callback: @subactionChosen
    else if @selectedAction.needsTarget
      @entitySelector = new Battle.EntitySelector
        enemies: @battle.monsters
        allies: @battle.avatars
        callback: @targetChosen
    else
      GameEvent.trigger 'finishedAction'
      GameEvent.trigger 'enqueue', action:
        type: @selectedAction
        source: @source
        executeIn: 3

  targetChosen: ({ target }) =>
    GameEvent.trigger 'finishedAction'
    GameEvent.trigger 'enqueue', action:
      type: @selectedAction
      subaction: @subaction
      source: @source
      target: target
      executeIn: 3

  subactionChosen: ({ @subaction }) =>
    @entitySelector = new Battle.EntitySelector
      enemies: @battle.monsters
      allies: @battle.avatars
      callback: @targetChosen

  draw: (context) ->
    @menu?.draw context
    @submenu?.draw context
    @entitySelector?.draw context

  # Attack
  #   needsSubtype: false
  #   needsTarget: true
  # Magic
  #   needsSubtype: true
  #   needsTarget: true
  # Item
  #   needsSubtype: true
  #   needsTarget: true
  # Defend
  #   needsSubtype: false
  #   needsTarget: false
  # Run
  #   needsSubtype: false
  #   needsTarget: false
