class Map.Screen
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

    @map = new Map.Map @
    @camera = new Map.Camera @

    @objects = []
    @avatar = new Map.Avatar @
    @objects.push(@avatar)
    _.map @map.npcs(), (npc) =>
      @objects.push new Map.Object.NPC(@, npc)

    @camera.follow @avatar

  handleChangeMap: (e) =>
    { mapName, xPosition, yPosition } = e.attributes.trigger.properties
    @map.changeMap mapName
    @avatar.setTilePosition parseInt(xPosition), parseInt(yPosition)

  destroy: ->
    _.each @events(), (handler, eventName) ->
      GameEvent.off eventName, handler

  onkeydown: (event) =>
    @avatar.onkeydown(event)

  update: ->
    object.update() for object in @objects
    @camera.update()

  draw: (context) ->
    context.save()
    { screenPosition } = @camera

    translate =
      x: _.min([_.max([-screenPosition.x + @width / 2, -(@map.tilesWide * @tileSize) + @width]), 0])
      y: _.min([_.max([-screenPosition.y + @height / 2, -(@map.tilesTall * @tileSize) + @height]), 0])

    context.translate translate.x, translate.y

    @camera.drawBottom context, @map
    @camera.drawObjects context, @map
    for object in @objects
      object.draw context
    @camera.drawTop context, @map
    context.restore()

    @dialog?.draw()

  handleCreateDialog: (e) =>
    @dialog = new Map.Dialog e.attributes.text
    @dialog.show()

  handleTalk: (e) =>
    _.each @objects, (object) =>
      if _.isEqual(e.attributes.facing, object.tilePosition)
        object.talk()
