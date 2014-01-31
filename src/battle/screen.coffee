class Battle.Screen
  constructor: (game) ->
    @width = game.canvas.width
    @height = game.canvas.height

    @avatar = new Battle.Avatar
    @enemy = new Battle.Enemy
    @menu = new Battle.Menu

  draw: (context) ->
    if @alive
      @drawBackground context
      @drawParty context
      @drawEnemies context
      @drawMenu context

  drawBackground: (context) ->
    context.save()
    context.fillStyle = "#afa"
    context.fillRect 0, 0, @width, @height
    context.restore()

  drawParty: (context) ->
    @avatar.draw context

  drawEnemies: (context) ->
    @enemy.draw context

  drawMenu: (context) ->
    @menu.draw context

  update: ->
    # TODO

  show: (e) =>
    @alive = true
    GameEvent.trigger 'pushResponder', responder: @

  onkeydown: (event) ->
    switch event.which
      when 90 # z
        @alive = false
        GameEvent.trigger 'popResponder', responder: @

