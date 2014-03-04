class Map.Screen
  music: 'sad_town.mp3'

  constructor: (game) ->
    @width = game.canvas.width
    @height = game.canvas.height

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

    GameEvent.trigger 'pushResponder', responder: @avatar

  onkeydown: (event) =>
    @avatar.onkeydown(event)

  update: ->
    for object in @objects
      object.update()
    @camera.update()

  draw: (context) ->
    context.save()
    { position } = @camera

    translate =
      x: _.min([_.max([-position.x + @width / 2, -(@map.tilesWide*@tileSize) + @width]), 0])
      y: _.min([_.max([-position.y + @height / 2, -(@map.tilesTall*@tileSize) + @height]), 0])

    context.translate translate.x, translate.y

    @map.draw context
    for object in @objects
      object.draw context
    context.restore()
