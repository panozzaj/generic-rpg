class Battle.Action.Menu extends Battle.Action
  execute: ->
    # @menu = new Battle.Menu
    #   callback: @pick
    #   avatar: @source

    @entitySelector = new Battle.EntitySelector
      enemies: @enemies
      allies: @allies
      callback: @targetChosen

  update: ->

  pick: (selectedAction) =>
    GameEvent.trigger 'finishedAction'
    GameEvent.trigger 'enqueue', action:
      type: selectedAction
      source: @source
      target: _.sample @enemies
      allies: @allies
      enemies: @enemies
      executeIn: 3

  targetChosen: ({ target }) =>
    GameEvent.trigger 'finishedAction'
    GameEvent.trigger 'enqueue', action:
      type: Battle.Action.Attack
      source: @source
      target: target
      allies: @allies
      enemies: @enemies
      executeIn: 3

  draw: (context) ->
    # @menu.draw context
    @entitySelector.draw context

