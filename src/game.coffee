class Game

  constructor: ->
    @canvas = document.getElementById 'game'
    @context = @canvas.getContext '2d'
    @objects = []

    @tileSize = 64

    @avatar = new Avatar @
    @objects.push(@avatar)
    @mapScreen = new MapScreen @
    @screen = @mapScreen

    @npc = new NPC @
    @objects.push(@npc)
    @dialog = new Dialog @
    @objects.push(@dialog)

    @responderManager = new ResponderManager
    @responderManager.pushResponder(@avatar)

    GameEvent.on 'battle', @handleBattle

  run: =>
    @update()
    @draw()
    requestAnimFrame @run

  update: ->
    for object in @objects
      object.update()

  draw: ->
    @clearCanvas()
    @screen.draw @context
    for object in @objects
      object.draw @context

  clearCanvas: ->
    @context.clearRect 0, 0, @canvas.width, @canvas.height

  onkeydown: (event) =>
    @responderManager.onkeydown(event)

  handleBattle: (e) =>
    @screen = new BattleScreen @
