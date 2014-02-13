class Battle.Action.Menu extends Battle.Action
  execute: ->
    @menu = new Battle.Menu callback: @pick

  update: ->

  pick: (selectedAction) =>
    GameEvent.trigger 'finishedAction'
    GameEvent.trigger 'enqueue', action:
      type: selectedAction
      source: @source
      target: _.sample @enemies
      enemies: @enemies
      executeIn: 3

  draw: (context) ->
    @menu.draw context
