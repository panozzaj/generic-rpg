GameEvent = require 'src/game_event'
Map = require './map'
Camera = require './camera'
Avatar = require './avatar'
Dialog = require './dialog'

class CollisionManager

  events: ->
    move: @move

  constructor: (@map, @objects) ->

    _.each @events(), (handler, eventName) ->
      GameEvent.on eventName, handler

  move: (e) =>

    { newPosition, movePromise } = e.attributes

    if @map.isWalkable(newPosition) #and not _.any(@objects, (obj) -> obj.tilePosition is newPosition)
      movePromise.resolve()
    else
      movePromise.reject()

module.exports = class MapScreen
  music: 'sad_town.mp3'

  events: ->
    blurScreen: @handleBlur
    mapChange: @handleChangeMap
    dialog: @handleCreateDialog
    talk: @handleTalk

  constructor: (@game) ->
    _.each @events(), (handler, eventName) ->
      GameEvent.on eventName, handler

    @width = @game.canvas.width
    @height = @game.canvas.height

    @tileSize = 64

    @tilesWide = @width / @tileSize
    @tilesTall = @height / @tileSize

    @map = new Map 'town'
    @map.tileSize = @tileSize
    @camera = new Camera @

    @objects = @map.loadObjects()

    @avatar = new Avatar @map

    @camera.follow @avatar

    @collisionManager = new CollisionManager(@map, @objects)

  handleChangeMap: (e) =>
    { mapName, xPosition, yPosition } = e.attributes.trigger.properties
    @map = new Map mapName
    @map.tileSize = @tileSize
    @avatar.setTilePosition parseInt(xPosition), parseInt(yPosition)
    @objects = @map.loadObjects()

  destroy: ->
    _.each @events(), (handler, eventName) ->
      GameEvent.off eventName, handler

  onkeydown: (event) =>
    @avatar.onkeydown(event)

  update: ->
    object.update() for object in @objects
    @avatar.update()
    @camera.update()

    @dialog?.update()

  draw: (context) ->
    context.save()
    { screenPosition } = @camera

    translate =
      x: _.min([_.max([-screenPosition.x + @width / 2, -(@map.tilesWide * @tileSize) + @width]), 0])
      y: _.min([_.max([-screenPosition.y + @height / 2, -(@map.tilesTall * @tileSize) + @height]), 0])

    context.translate translate.x, translate.y

    @camera.drawBottom context, @map
    @camera.drawObjects context, @map, @objects
    @avatar.draw context
    @camera.drawTop context, @map
    context.restore()

    @dialog?.draw()

  handleCreateDialog: (e) =>
    @dialog = new Dialog e.attributes
    @dialog.show()

  handleTalk: (e) =>
    _.each @objects, (object) =>
      if _.isEqual(e.attributes.facing, object.tilePosition)
        object.talk()
