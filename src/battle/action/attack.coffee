class Battle.Action.Attack
  constructor: ({ @source, @target }) ->
    console.log @

  execute: ->
    @effectiveDamage = Math.round(@source.stats.damage * (Math.random() / 2 + 0.75))
    @target.takeDamage @effectiveDamage

    @damageDisplayTTL = 60

  update: ->
    if @damageDisplayTTL
      @damageDisplayTTL -= 1
      if @damageDisplayTTL <= 0
        GameEvent.trigger 'finishedAction'
        GameEvent.trigger 'enqueue', action:
          type: Battle.Action.Menu
          source: @source
          enemies: [@target]
          executeIn: 10

  draw: (context) ->
    if @damageDisplayTTL
      context.save()
      context.fillStyle = 'white'
      context.font = '30px manaspaceregular'
      context.globalAlpha = 0.75 * (@damageDisplayTTL / 60) + 0.25
      context.fillText @effectiveDamage, 320, 225 + @damageDisplayTTL
      context.restore()
