class ScreenManager
  constructor: ->
    @screens = []

    GameEvent.on 'popScreen', @pop

  push: (screen) =>
    @screens.push screen
    GameEvent.trigger 'pushResponder', responder: screen
    GameEvent.trigger 'playMusic', music: @activeScreen().music

  pop: =>
    screen = @screens.pop()
    screen.destroy()
    GameEvent.trigger 'popResponder', responder: screen
    GameEvent.trigger 'playMusic', music: @activeScreen().music

  activeScreen: ->
    _.last @screens
