class Battle.Action.Run extends Battle.Action
  execute: ->
    GameEvent.trigger 'finishedAction'
    GameEvent.trigger 'popScreen'
