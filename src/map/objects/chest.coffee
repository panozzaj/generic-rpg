GameEvent = require 'src/game_event'

MapObject = require 'map/object'

module.exports = class Chest extends MapObject

  states:
    opened:
      gid: 1702
    closed:
      initial: true
      transitions:
        open: 'opened'
      gid: 1703

  constructor: (@map, data) ->
    super

  drawingData: ->
    _.extend @map.tileDataForGid(@gid),
      tilePosition: @tilePosition

  talk: ->
    if @state == 'closed'
      if @transitionState 'open'
        GameEvent.trigger 'dialog', messages: ["You got <treasure>!"]
    else
      GameEvent.trigger 'dialog', messages: ["The chest is empty... :("]
