class Battle.Action.ScheduleTurn
  constructor: ({ @source, @target, @enemies }) ->
    console.log @

  execute: ->
    GameEvent.trigger 'finishedAction'
    GameEvent.trigger 'enqueue', action:
      type: Battle.Action.Menu
      source: @source
      enemies: @enemies
      executeIn: 10
