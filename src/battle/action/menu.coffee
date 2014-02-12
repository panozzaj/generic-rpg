class Battle.Action.Menu extends Battle.Action
  execute: ->
    @menu = new Battle.Menu callback: @pick

  update: ->

  pick: (selectedAction) =>
    GameEvent.trigger 'finishedAction'
    GameEvent.trigger 'enqueue', action:
      type: selectedAction
      source: @source
      target: @enemies[0]
      executeIn: 10

  draw: (context) ->
    @menu.draw context
