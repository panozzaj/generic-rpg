GameEvent = require 'src/game_event'
Action = require './base'
MenuAction = require 'battle/menu/action'
MenuSubaction = require 'battle/menu/subaction'
MenuTarget = require 'battle/menu/target'

module.exports = class BattleMenu extends Action
  MENU_CONTINUATIONS =
    'Attack':
      needsSubaction: false
      needsTarget:    true
    'Run':
      needsSubaction: false
      needsTarget:    false
    'Spell':
      needsSubaction: true
      needsTarget:    true

  execute: ->
    @menuStack = []
    @getAction()

    GameEvent.trigger 'pushResponder', responder: @

  destroy: ->
    GameEvent.trigger 'popResponder', responder: @

  update: ->

  draw: (context) ->
    _.each @menuStack, (menu) ->
      menu.draw context

  onkeydown: (event) ->
    @activeMenu().onkeydown event

  getAction: ->
    @menuStack.push new MenuAction
      avatar: @source
      select: @setAction

  setAction: ({ @action }) =>
    if @needsSubaction(@action)
      @getSubaction()
    else if @needsTarget(@action)
      @getTarget()
    else
      @complete()

  needsSubaction: (type) =>
    MENU_CONTINUATIONS[type].needsSubaction

  needsTarget: (type) =>
    MENU_CONTINUATIONS[type].needsTarget

  getSubaction: ->
    @menuStack.push new MenuSubaction
      spells: @source.knownSpells()
      select: @setSubaction
      cancel: @popMenu

  setSubaction: ({ @subaction }) =>
    @getTarget()

  getTarget: ->
    @menuStack.push new MenuTarget
      allies: @battle.avatars
      enemies: @battle.monsters
      select: @setTarget
      cancel: @popMenu

  setTarget: ({ @target }) =>
    @complete()

  complete: ->
    @destroy()
    GameEvent.trigger 'finishedAction'
    GameEvent.trigger 'enqueue', action:
      type: @action
      subaction: @subaction
      source: @source
      target: @target
      executeIn: 3

  popMenu: =>
    @menuStack.pop()

  activeMenu: ->
    _.last(@menuStack)
