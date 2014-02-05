class Battle.StatusDisplay
  constructor: (@avatar) ->
    @width = 400
    @height = 200
    # no-op

  draw: (context) ->
    # background
    context.save()
    context.fillStyle = "#00f"
    context.fillRect 300, 350, @width, @height
    context.restore()

    # foreground
    context.save()
    context.fillStyle = 'white'
    context.font = '30px manaspaceregular'
    statusString = "Simba #{@avatar.stats.hp.current}/#{@avatar.stats.hp.max}"
    context.fillText statusString, 330, 400
    context.restore()
