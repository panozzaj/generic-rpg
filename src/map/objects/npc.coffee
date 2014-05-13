GameEvent = require 'src/game_event'

MapObject = require 'map/object'

module.exports = class NPC extends MapObject

  constructor: (map, { @data, @behavior }) ->
    super map, @data
    @sprite = new Image
    @sprite.src = "assets/images/king.png"
    @state = 'firstContact'

  talk: =>
    console.log @behavior
    GameEvent.trigger 'dialog', text: @behavior.states[@state].dialog

