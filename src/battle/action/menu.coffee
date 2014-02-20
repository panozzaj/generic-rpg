class Battle.Action.Menu extends Battle.Action
  execute: ->
    @menuStack = []
    @getAction()

    GameEvent.trigger 'pushResponder', responder: @

  destroy: ->
    GameEvent.trigger 'popResponder', responder: @

  update: ->

  draw: (context) ->
    _.each @menuStack, (menu) ->
      menu.draw context

  onkeydown: (event) ->
    @activeMenu().onkeydown event

  getAction: ->
    @menuStack.push new Battle.Menu.Action
      avatar: @source
      select: @setAction

  setAction: ({ @action }) =>
    if @action.needsSubaction
      @getSubaction()
    else if @action.needsTarget
      @getTarget()
    else
      @complete()

  getSubaction: ->
    @menuStack.push new Battle.Menu.Subaction
      spells: @source.knownSpells()
      select: @setSubaction
      cancel: @popMenu

  setSubaction: ({ @subaction }) =>
    @getTarget()

  getTarget: ->
    @menuStack.push new Battle.Menu.Target
      allies: @battle.avatars
      enemies: @battle.monsters
      select: @setTarget
      cancel: @popMenu

  setTarget: ({ @target }) =>
    @complete()

  complete: ->
    @destroy()
    GameEvent.trigger 'finishedAction'
    GameEvent.trigger 'enqueue', action:
      type: @action
      subaction: @subaction
      source: @source
      target: @target
      executeIn: 3

  popMenu: =>
    @menuStack.pop()

  activeMenu: ->
    _.last(@menuStack)

  # Attack
  #   needsSubaction: false
  #   needsTarget: true
  # Magic
  #   needsSubaction: true
  #   needsTarget: true
  # Item
  #   needsSubaction: true
  #   needsTarget: true
  # Defend
  #   needsSubaction: false
  #   needsTarget: false
  # Run
  #   needsSubaction: false
  #   needsTarget: false
