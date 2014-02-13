class Battle.Avatar
  constructor: ->
    @position =
      x: 512
      y: 256

    @size =
      width: 64
      height: 64

    @sprite = new Image()
    @sprite.src = "images/cecil-left.png"
    @stats = {
      hp:
        max: 150,
        current: 150
      damage: 10
    }

  update: ->
    # TODO

  draw: (context) ->
    context.drawImage @sprite, @position.x, @position.y, @size.width, @size.height

  takeDamage: (damage) ->
    @stats.hp.current -= damage

  alive: ->
    @stats.hp.current > 0
