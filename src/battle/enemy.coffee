class Battle.Enemy
  constructor: ->
    @sprite = new Image()
    @sprite.src = "images/goblin.png"
    @stats = {
      hp: {
        max: 30,
        current: 30
      }
      damage: 10,
    }

  update: ->
    # TODO

  draw: (context) ->
    context.drawImage @sprite, 256, 256, 64, 64
