GameEvent = require 'src/game_event'

module.exports = class Avatar
  constructor: ({ @position, @hero }) ->
    @size =
      width: 64
      height: 64
    { @name, @stats } = @hero

    @sprite = new Image()
    @sprite.src = "assets/images/cecil-left.png"

  update: ->
    # TODO

  draw: (context) ->
    if @alive()
      if @flashTtl > 0
        @flashTtl--
      if @flashTtl > 0 && @flashTtl < 10
        context.drawImage @sprite, @position.x - 2, @position.y - 2, @size.width + 4, @size.height + 4
      else
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

  flash: (delay) ->
    @flashTtl = 10 + delay
