class Battle.Enemy
  constructor: ->
    @sprite = new Image()
    @sprite.src = "images/goblin.png"

  update: ->
    # TODO

  draw: (context) ->
    context.drawImage @sprite, 256, 256, 64, 64
