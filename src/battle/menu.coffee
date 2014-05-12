module.exports = class BattleMenu
  constructor: ->
    @cursor = new Image()
    @cursor.src = "assets/images/cursor.png"
    @cursor.size =
      width: 30
      height: 30

  drawBackground: (context) ->
    context.save()

    # background
    context.fillStyle = "#00f"
    context.fillRoundRect @pos.x, @pos.y, @size.width, @size.height, 10

    # border
    context.strokeStyle = "#fff"
    context.lineWidth = 5
    context.strokeRoundRect @pos.x, @pos.y, @size.width, @size.height, 10

    context.restore()
