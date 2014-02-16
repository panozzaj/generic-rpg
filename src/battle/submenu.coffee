class Battle.Submenu
  constructor: ({ @callback, @spells }) ->
    @pos =
      x: 250
      y: 350
    @size =
      width: 500
      height: 200
    @currentSpell = 0
    @cursor = new Image()
    @cursor.src = "images/cursor.png"
    GameEvent.trigger 'pushResponder', responder: @

  destroy: ->
    GameEvent.trigger 'popResponder', responder: @

  actionType: ->
    @spells[@currentSpell].type

  draw: (context) ->
    @drawBackground context
    @drawActions context
    @drawCursor context

  drawBackground: (context) ->
    context.save()
    context.fillStyle = "#00f"
    context.fillRect @pos.x, @pos.y, @size.width, @size.height
    context.restore()

  drawActions: (context) ->
    context.save()
    context.fillStyle = 'white'
    context.font = '30px manaspaceregular'
    _.each @spells, (spell, i) =>
      context.fillText spell, @pos.x + 30, @pos.y + 50 + 40 * i
    context.restore()

  drawCursor: (context) ->
    context.drawImage @cursor, @pos.x - 10, @pos.y + 30 + 40 * @currentSpell, 30, 30

  update: ->

  onkeydown: (event) ->
    switch event.which
      when 38 # up
        @moveCursor -1
      when 40 # down
        @moveCursor 1
      #when 37 # left
      #  @moveCursor 1
      when 90 # z
        @performcurrentSpell()
      when 88 # x
        console.log 'go back to parent menu'

  moveCursor: (offset) ->
    @currentSpell = (@currentSpell + @spells.length + offset) % @spells.length

  performcurrentSpell: ->
    @destroy()
    @callback @actionType()

