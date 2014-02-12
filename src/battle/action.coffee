class Battle.Action
  constructor: ({ @source, @target }) ->
    console.log @source, @target

  execute: ->
    @menu = new Battle.Menu callback: @pick

  pick: (selectedAction) ->
    GameEvent.trigger 'finishedAction', nextAction:
      type: 'attack'
      executeIn: 10

  draw: (context) ->
    @menu.draw context
