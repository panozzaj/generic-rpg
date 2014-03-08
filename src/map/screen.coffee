class Map.Screen
  music: 'sad_town.mp3'

  events: ->
    blurScreen: @handleBlur

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
    @blurIntensity = 0.0

    GameEvent.trigger 'pushResponder', responder: @avatar

  destroy: ->
    _.each @events(), (handler, eventName) ->
      GameEvent.off eventName, handler

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

    @map.drawBottom context
    for object in @objects
      object.draw context
    @map.drawTop context
    context.restore()

  handleBlur: () =>
    console.log('handling blur')
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
    oldCanvasStyle = source.style.display
    source.style.display = 'none'
    glcanvas.className = source.className
    glcanvas.id = source.id
    oldSourceId = source.id
    source.id = 'old_' + source.id

    blurCanvas = setInterval =>
      # Load the background from our canvas
      texture.loadContentsOf(source)

      # Apply WebGL magic
      @blurIntensity += 0.03
      if @blurIntensity >= 0.75
        @blurIntensity = 0
        $('#' + glcanvas.id).remove()
        source.style.display = oldCanvasStyle
        source.id = oldSourceId
        GameEvent.trigger 'battle', random: true
        clearInterval blurCanvas

      glcanvas.draw(texture)
        .zoomBlur(source.width / 2, source.height / 2, @blurIntensity).update()
    , Math.floor(1000 / 40)

