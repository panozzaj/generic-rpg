module.exports = class MapScreen

  constructor: (@game) ->

    @width = @game.canvas.width
    @height = @game.canvas.height

  update: ->
    # no-op

  draw: (context) ->
    context.save()
    context.fillStyle = "#00f"
    context.fillRect 0, 0, @width, @height
    context.restore()
