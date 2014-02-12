class Battle.Screen
  events: ->
    fight: @handleFight
    die: @handleDeath
    finishedAction: @finishedAction

  constructor: (game) ->
    @width = game.canvas.width
    @height = game.canvas.height

    @avatar = new Battle.Avatar
    @enemy = new Battle.Enemy
    @statusDisplay = new Battle.StatusDisplay @avatar

    @time = 0
    @actionList = []
    @actionList.push {
      type: 'menu'
      source: @avatar
      executeAt: @time + 10
    }
    console.log(@actionList)

    _.each @events(), (handler, eventName) ->
      GameEvent.on eventName, handler

  destroy: ->
    _.each @events(), (handler, eventName) ->
      GameEvent.off eventName, handler

  draw: (context) ->
    @drawBackground context
    @drawParty context
    @drawEnemies context
    @drawStatusDisplay context

    @currentAction?.draw context

    @drawVictoryDialog context if @victoryDialog

  drawBackground: (context) ->
    context.save()
    context.fillStyle = "#afa"
    context.fillRect 0, 0, @width, @height
    context.restore()

  drawParty: (context) ->
    @avatar.draw context

  drawEnemies: (context) ->
    @enemy.draw context

  drawStatusDisplay: (context) ->
    @statusDisplay.draw context

  drawVictoryDialog: (context) ->
    @victoryDialog.draw context

  update: ->
    unless @currentAction
      console.log "@time: #{@time}" if @time < 50
      action = _.find @actionList, (action) =>
        action.executeAt == @time

      if action
        @currentAction = new Battle.Action(action)
        @currentAction.execute()

      @time += 1 unless @currentAction

    @enemy.update()

  finishedAction: =>
    @actionList.splice @actionList.indexOf(@currentAction), 1
    @currentAction = null

  onkeydown: (event) ->

  handleFight: =>
    effectiveDamage = Math.round(@avatar.stats.damage * (Math.random() / 2 + 0.75))
    @enemy.takeDamage(effectiveDamage)

  handleDeath: (event) =>
    @victoryDialog = new Battle.VictoryDialog @

