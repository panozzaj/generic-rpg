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
      action = _.find @actionList, (action) =>
        action.executeAt == @time

      if action
        if action.source.alive()
          @currentAction = action
          console.log "Executing ", @currentAction
          @currentAction.execute()
        else
          @dequeue action
      else
        @time += 1

  enqueue: (event) =>
    console.log event
    console.log event.attributes
    action = event.attributes.action
    action.executeAt = @time + action.executeIn
    action.battle = @battle

    Attack = require './attack'
    MenuAction = require './menu'
    Run = require './run'
    ScheduleTurn = require './schedule_turn'
    Spell = require './spell'
    @actionList.push new(eval(action.type))(action)

  finishedAction: (event) =>
    @dequeue @currentAction
    @currentAction = null

  dequeue: (action) =>
    @actionList.splice @actionList.indexOf(action), 1
