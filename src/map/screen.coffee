class Map.Screen
  music: 'sad_town.mp3'

  constructor: (@game) ->
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

    GameEvent.trigger 'pushResponder', responder: @avatar

    @blur()

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


  blur: () ->
    try
      glcanvas = fx.canvas()
    catch e
      console.log 'got an exception blurring'
      return

    source = @game.canvas
    srcctx = source.getContext('2d')

    # This tells glfx what to use as a source image
    texture = glcanvas.texture(source)

    # Hide the source 2D canvas and put the WebGL Canvas in its place
    source.parentNode.insertBefore(glcanvas, source)
    source.style.display = 'none'
    glcanvas.className = source.className
    glcanvas.id = source.id
    source.id = 'old_' + source.id

    setInterval ->
      # Load the background from our canvas
      texture.loadContentsOf(source)

      # Apply WebGL magic
      # leave this for now and see if we can get an effect
      glcanvas.draw(texture)
        .bulgePinch(source.width / 2, source.height / 2, source.width * 0.75, 0.12)
        .vignette(0.25, 0.74)
        .update()
    , Math.floor(1000 / 40)

