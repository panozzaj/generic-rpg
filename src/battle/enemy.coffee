class Battle.Enemy
  constructor: ->
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
      context.drawImage @sprite, 256, 256, 64, 64

  takeDamage: (damage) ->
    @stats.hp.current -= damage
    if @stats.hp.current <= 0
      GameEvent.trigger 'die', enemy: @

  alive: ->
    @stats.hp.current > 0
