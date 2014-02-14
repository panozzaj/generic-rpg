class Battle.Action.Menu extends Battle.Action
  execute: ->
    # @menu = new Battle.Menu
    #   callback: @pick
    #   avatar: @source

    @entitySelector = new Battle.EntitySelector
      enemies: @battle.monsters
      allies: @battle.avatars
      callback: @targetChosen

  update: ->

  pick: (selectedAction) =>
    GameEvent.trigger 'finishedAction'
    GameEvent.trigger 'enqueue', action:
      type: selectedAction
      source: @source
      target: _.sample @battle.monsters
      executeIn: 3

  targetChosen: ({ target }) =>
    GameEvent.trigger 'finishedAction'
    GameEvent.trigger 'enqueue', action:
      type: Battle.Action.Attack
      source: @source
      target: target
      executeIn: 3

  draw: (context) ->
    # @menu.draw context
    @entitySelector.draw context
