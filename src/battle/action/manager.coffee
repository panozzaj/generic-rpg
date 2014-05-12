GameEvent = require 'src/game_event'

module.exports = class ActionManager
  events: ->
    enqueue: @enqueue
    finishedAction: @finishedAction

  constructor: (@battle) ->
    _.each @events(), (handler, eventName) ->
      GameEvent.on eventName, handler

    @actionList = []
    @time = 0

  destroy: ->
    @actionList = []
    _.each @events(), (handler, eventName) ->
      GameEvent.off eventName, handler

  update: ->
    if @currentAction
      @currentAction.update?()
    else
      #console.log "@time: #{@time}" if @time < 100
      action = _.find @actionList, (action) =>
        action.executeAt == @time

      if action                  # an action this time tick?
        if action.source.alive() # only do if person is alive
          @currentAction = action
          console.log "Executing ", @currentAction
          @currentAction.execute()
        else
          @dequeue action
      else
        @time += 1

  enqueue: (event) =>
    action = event.attributes.action
    action.executeAt = @time + action.executeIn
    action.battle = @battle
    @actionList.push new action.type(action)

  finishedAction: (event) =>
    @dequeue @currentAction
    @currentAction = null

  dequeue: (action) =>
    @actionList.splice @actionList.indexOf(action), 1
