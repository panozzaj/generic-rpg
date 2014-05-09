module.exports = class ScreenManager
  constructor: ->
    @screens = []

  push: (screen) =>
    @screens.push screen

  pop: =>
    screen = @screens.pop()
    screen.destroy()

  activeScreen: ->
    _.last @screens
