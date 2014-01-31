class Battle.Avatar
  constructor: ->
    @sprite = new Image()
    @sprite.src = "images/cecil-left.png"

  update: ->
    # TODO

  draw: (context) ->
    context.drawImage @sprite, 512, 256, 64, 64
