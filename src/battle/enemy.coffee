class Battle.Enemy
  constructor: ->
    @position =
      x: 256
      y: 256

    @size =
      width: 64
      height: 64

    @sprite = new Image()
    @sprite.src = "images/goblin.png"
    @stats = {
      hp:
        max: 30,
        current: 30
      damage: 10
    }

  draw: (context) ->
    if @alive()
      context.drawImage @sprite, @position.x, @position.y, @size.width, @size.height

  takeDamage: (damage) ->
    @stats.hp.current -= damage
    if @stats.hp.current <= 0
      GameEvent.trigger 'die', enemy: @

  alive: ->
    @stats.hp.current > 0
