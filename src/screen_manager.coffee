class ScreenManager
  constructor: ->
    @screens = []

  push: (screen) ->
    @screens.push screen
    GameEvent.trigger 'pushResponder', responder: screen

  pop: ->
    screen = @screens.pop()
    GameEvent.trigger 'popResponder', responder: screen

  activeScreen: ->
    _.last @screens

