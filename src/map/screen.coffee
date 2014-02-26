class Map.Screen
  constructor: (game) ->
    @width = game.canvas.width
    @height = game.canvas.height

    @tileSize = 64
    @tilesWide = @width / @tileSize
    @tilesTall = @height / @tileSize

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
    context.translate -position.x + @width / 2, -position.y + @height / 2

    @map.draw context
    for object in @objects
      object.draw context
    context.restore()

