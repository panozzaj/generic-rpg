class Battle.Menu

  constructor: ->
    @width = 200
    @height = 200
    @text = """
      Fight
      Magic
      Defend
      Run
    """

  draw: (context) ->
    @drawBackground context
    @drawActions context

  drawBackground: (context) ->
    context.save()
    context.fillStyle = "#00f"
    context.fillRect 50, 350, @width, @height
    context.restore()

  drawActions: (context) ->
    context.save()
    context.fillStyle = 'white'
    context.font = '30px manaspaceregular'
    lines = @text.split("\n")
    _.each lines, (line, i) ->
      context.fillText line, 80, 400 + 40 * i
    context.restore()

  update: ->
