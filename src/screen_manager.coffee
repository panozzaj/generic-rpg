class ScreenManager
  constructor: ->
    @screens = []

  push: (screen) ->
    @screens.push screen
    GameEvent.trigger 'pushResponder', responder: screen

  pop: ->
    GameEvent.trigger 'popResponder', responder: screen
    screen = @screens.pop

  activeScreen: ->
    _.last @screens
