class Battle.Action.Menu extends Battle.Action
  execute: ->
    # @menu = new Battle.Menu
    #   callback: @pick
    #   avatar: @source

    @entitySelector = new Battle.EntitySelector
      enemyPositions: _.map @enemies, (enemy) -> enemy.position
      allyPositions: _.map @allies, (ally) -> ally.position

  update: ->

  pick: (selectedAction, target) =>
    GameEvent.trigger 'finishedAction'
    GameEvent.trigger 'enqueue', action:
      type: selectedAction
      source: @source
      target: _.sample @enemies
      enemies: @enemies
      executeIn: 3

  draw: (context) ->
    # @menu.draw context
    @entitySelector.draw context
