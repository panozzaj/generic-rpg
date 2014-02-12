class Battle.Action.Menu
  constructor: ({ @source, @target }) ->
    console.log @source, @target

  execute: ->
    @menu = new Battle.Menu callback: @pick

  pick: (selectedAction) =>
    GameEvent.trigger 'finishedAction'
    GameEvent.trigger 'enqueue', action:
      type: Battle.Action.Menu
      source: @source
      executeIn: 10

  draw: (context) ->
    @menu.draw context