class Battle.Action.Menu extends Battle.Action
  execute: ->
    @menu = new Battle.Menu
      avatar: @source
      select: @pickedMainMenuOption

  update: ->

  pickedMainMenuOption: ({ @selectedAction }) =>
    if @selectedAction.needsSubtype
      spells = @source.knownSpells()
      @submenu = new Battle.Submenu
        spells: spells
        select: @subactionChosen
        cancel: @cancel
    else if @selectedAction.needsTarget
      @entitySelector = new Battle.EntitySelector
        enemies: @battle.monsters
        allies: @battle.avatars
        select: @targetChosen
        cancel: @cancel
    else
      GameEvent.trigger 'finishedAction'
      GameEvent.trigger 'enqueue', action:
        type: @selectedAction
        source: @source
        executeIn: 3

  targetChosen: ({ target }) =>
    @entitySelector?.destroy()
    @submenu?.destroy()
    @menu?.destroy()

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
      select: @targetChosen
      cancel: @cancel

  draw: (context) ->
    @menu?.draw context
    @submenu?.draw context
    @entitySelector?.draw context

  cancel: (submenu) =>
    if submenu == @submenu
      @submenu.destroy()
      @submenu = null
    else if submenu = @entitySelector
      @entitySelector.destroy()
      @entitySelector = null

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
