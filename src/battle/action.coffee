class Battle.Action
  constructor: ({ @source, @target }) ->
    console.log @source, @target

  execute: ->
    @menu = new Battle.Menu

  draw: (context) ->
    @menu.draw context
