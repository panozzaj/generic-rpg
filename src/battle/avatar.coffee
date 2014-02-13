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
    @name = 'Simba'
    @stats = {
      hp:
        max: 150,
        current: 150
      damage: 10
    }

  update: ->
    # TODO

  draw: (context) ->
    if @alive()
      context.drawImage @sprite, @position.x, @position.y, @size.width, @size.height

  takeDamage: (damage) ->
    @stats.hp.current -= damage
    if @stats.hp.current <= 0
      @stats.hp.current = 0
      GameEvent.trigger 'die', enemy: @

  alive: ->
    @stats.hp.current > 0
