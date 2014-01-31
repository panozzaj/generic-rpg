class MapScreen
  constructor: (game) ->
    @tileSize = game.tileSize
    @width = game.canvas.width
    @height = game.canvas.height

    @map = new Map @

    @objects = []
    @avatar = new Avatar @
    @objects.push(@avatar)
    @npc = new NPC @
    @objects.push(@npc)
    @dialog = new Dialog @
    @objects.push(@dialog)

    GameEvent.trigger 'pushResponder', responder: @avatar

  onkeydown: (event) =>
    @avatar.onkeydown(event)

  update: ->
    for object in @objects
      object.update()

  draw: (context) ->
    @map.draw context
    for object in @objects
      object.draw context
