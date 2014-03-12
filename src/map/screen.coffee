class Map.Screen
  music: 'sad_town.mp3'

  events: ->
    blurScreen: @handleBlur
    mapChange: @handleChangeMap

  constructor: (@game) ->
    _.each @events(), (handler, eventName) ->
      GameEvent.on eventName, handler

    @width = @game.canvas.width
    @height = @game.canvas.height

    @tileSize = 64

    @map = new Map.Map @
    @camera = new Map.Camera @

    @objects = []
    @avatar = new Map.Avatar @
    @objects.push(@avatar)
    @npc = new Map.NPC @
    @objects.push(@npc)
    @dialog = new Map.Dialog @
    @objects.push(@dialog)

    @camera.follow @avatar

  handleChangeMap: (e) =>
    { mapName, xPosition, yPosition } = e.attributes.trigger.properties
    @map.changeMap mapName
    @avatar.setMapPosition parseInt(xPosition), parseInt(yPosition)

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
    { position } = @camera

    translate =
      x: _.min([_.max([-position.x + @width / 2, -(@map.tilesWide*@tileSize) + @width]), 0])
      y: _.min([_.max([-position.y + @height / 2, -(@map.tilesTall*@tileSize) + @height]), 0])

    context.translate translate.x, translate.y

    @map.drawBottom context
    for object in @objects
      object.draw context
    @map.drawTop context
    context.restore()

