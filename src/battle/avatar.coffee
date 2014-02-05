class Battle.Avatar
  constructor: ->
    @sprite = new Image()
    @sprite.src = "images/cecil-left.png"
    @stats = {
      hp: {
        max: 150,
        current: 150
      }
      strength: 7,
      weapon: {
        damage: 10
      }
    }

  update: ->
    # TODO

  draw: (context) ->
    context.drawImage @sprite, 512, 256, 64, 64
