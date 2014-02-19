class Battle.Avatar
  constructor: ({ @position, @hero }) ->
    @size =
      width: 64
      height: 64
    { @name, @stats } = @hero

    @sprite = new Image()
    @sprite.src = "images/cecil-left.png"

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

  knownSpells: ->
    [
      'Fire'
      'Fire 2'
      'Meteo'
    ]

