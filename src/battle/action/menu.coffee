class Battle.Action.Menu
  constructor: ({ @source, @target, @enemies }) ->
    console.log @source, @target, @enemies

  execute: ->
    @menu = new Battle.Menu callback: @pick

  update: ->

  pick: (selectedAction) =>
    GameEvent.trigger 'finishedAction'
    GameEvent.trigger 'enqueue', action:
      type: Battle.Action.Attack
      source: @source
      target: @enemies[0]
      executeIn: 10

  draw: (context) ->
    @menu.draw context
