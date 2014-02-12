class Battle.Action.Run
  constructor: ({ @source, @target }) ->
    console.log @

  execute: ->
    GameEvent.trigger 'finishedAction'
    GameEvent.trigger 'popScreen'
