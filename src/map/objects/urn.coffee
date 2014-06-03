GameEvent = require 'src/game_event'

MapObject = require 'map/object'

module.exports = class Urn extends MapObject

  constructor: (@map, data) ->
    super

    @state = 'full'
    @gid = 1701

  drawingData: ->
    _.extend @map.tileDataForGid(@gid),
      tilePosition: @tilePosition

  talk: =>
    if @state == 'full'
      GameEvent.trigger 'dialog', messages: ["You see a mouse jump out of the urn."]
