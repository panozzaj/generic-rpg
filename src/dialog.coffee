class Dialog
  constructor: (game) ->
    @alive = false
    GameEvent.on 'dialog', @show

  update: ->
    # something

  draw: (context) ->
    if @alive
      context.save()
      context.fillStyle = "#33c"
      context.fillRect 50, 50, 500, 250
      context.restore()
      context.save()
      context.fillStyle = 'white'
      context.font = '30px manaspaceregular'
      lines = @text.split("\n")
      _.each lines, (line, i) ->
        context.fillText line, 80, 110 + 40 * i
      context.restore()

  show: (e) =>
    @alive = true
    @text = e.attributes.text
    GameEvent.trigger 'pushResponder', responder: @

  onkeydown: (event) ->
    switch event.which
      when 90 # z
        @alive = false
        GameEvent.trigger 'popResponder', responder: @

