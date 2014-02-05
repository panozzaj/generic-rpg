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
    @damageDisplayTTL = 0
    @lastDamage = 0

  update: ->
    if @damageDisplayTTL
      @damageDisplayTTL -= 1
      if @damageDisplayTTL < 0
        @damageDisplayTTL = 0

  draw: (context) ->
    if @alive()
      context.drawImage @sprite, 256, 256, 64, 64
    if @damageDisplayTTL
      context.save()
      context.fillStyle = 'white'
      context.font = '30px manaspaceregular'
      context.globalAlpha = 0.75 * (@damageDisplayTTL / 60) + 0.25
      context.fillText @lastDamage, 320, 225 + @damageDisplayTTL
      context.restore()

  takeDamage: (damage) ->
    @stats.hp.current -= damage
    @lastDamage = damage
    @damageDisplayTTL = 60
    if @stats.hp.current <= 0
      GameEvent.trigger 'die', enemy: @

  alive: ->
    @stats.hp.current > 0
