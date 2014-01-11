class Game

  constructor: ->
    @canvas = document.getElementById 'game'
    @context = @canvas.getContext '2d'
    @objects = []

    @tileSize = 64

    @avatar = new Avatar @
    @objects.push(@avatar)
    @mapMode = new MapScreen @
    @npc = new NPC @
    @objects.push(@npc)
    @dialog = new Dialog @
    @objects.push(@dialog)

    GameEvent.on 'pushResponder', @pushResponder
    GameEvent.on 'popResponder', @popResponder

    @responderStack = []
    GameEvent.trigger 'pushResponder', responder: @avatar

  run: =>
    @update()
    @draw()
    requestAnimFrame @run

  update: ->
    for object in @objects
      object.update()

  draw: ->
    @clearCanvas()
    @mapMode.draw @context
    for object in @objects
      object.draw @context

  clearCanvas: ->
    @context.clearRect 0, 0, @canvas.width, @canvas.height

  onkeydown: (event) =>
    _.last(@responderStack).onkeydown(event)

  pushResponder: (e) =>
    @responderStack.push(e.attributes.responder)

  popResponder: (e) =>
    if e.attributes.responder != @responderStack.pop()
      alert('popped responder but it did not match')

