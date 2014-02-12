class Battle.Action.ScheduleTurn extends Battle.Action
  execute: ->
    GameEvent.trigger 'finishedAction'
    GameEvent.trigger 'enqueue', action:
      type: Battle.Action.Menu
      source: @source
      enemies: @enemies
      executeIn: 10
