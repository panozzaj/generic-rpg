GameEvent = require 'src/game_event'

BattleData = require './data'
ActionManager = require './action/manager'
StatusDisplay = require './status_display'
VictoryDialog = require './victory_dialog'

module.exports = class BattleScreen
  music: 'battle.mp3'

  events: ->
    die: @handleDeath

  constructor: ({ game, party }) ->
    _.each @events(), (handler, eventName) ->
      GameEvent.on eventName, handler

    @width = game.canvas.width
    @height = game.canvas.height

    @battle = new BattleData party: party

    @actionManager = new ActionManager @battle

    @statusDisplay = new StatusDisplay @battle.avatars

    @battle.start()

  destroy: ->
    _.each @events(), (handler, eventName) ->
      GameEvent.off eventName, handler

  draw: (context) ->
    @drawBackground context
    @drawParty context
    @drawEnemies context
    @drawStatusDisplay context

    @actionManager?.currentAction?.draw? context

    @drawVictoryDialog context if @victoryDialog

  drawBackground: (context) ->
    context.save()
    context.fillStyle = "#9c9"
    context.fillRect 0, 0, @width, @height
    context.restore()

  drawParty: (context) ->
    _.each @battle.avatars, (avatar) -> avatar.draw(context)

  drawEnemies: (context) ->
    _.each @battle.monsters, (enemy) -> enemy.draw(context)

  drawStatusDisplay: (context) ->
    @statusDisplay.draw context

  drawVictoryDialog: (context) ->
    @victoryDialog.draw context

  update: ->
    @actionManager?.update()

  onkeydown: (event) ->

  handleDeath: (event) =>
    switch event.attributes.enemy.constructor.name
      when 'Avatar'
        if _.every(@battle.avatars, (avatar) -> (!avatar.alive()))
          @victoryDialog = new VictoryDialog text: "Failure!"
          @actionManager.destroy()
          @actionManager = null
      when 'Enemy'
        if _.every(@battle.monsters, (monster) -> (!monster.alive()))
          @victoryDialog = new VictoryDialog text: "Victory!"
          @actionManager.destroy()
          @actionManager = null
