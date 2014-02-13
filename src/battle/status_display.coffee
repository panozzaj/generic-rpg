class Battle.StatusDisplay
  constructor: (@avatars) ->
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
    _.each @avatars, (avatar, i) ->
      statusString = "#{avatar.name} #{avatar.stats.hp.current}/#{avatar.stats.hp.max}"
      context.fillText statusString, 330, 400 + 40 * i
    context.restore()
