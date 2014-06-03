GameState = require 'src/data/game_state'
GameEvent = require 'src/game_event'

dialog = (messages, cb = null) ->
  GameEvent.trigger 'dialog', { messages, cb }

module.exports =
  'town':
    'King':
      states:
        firstContact:
          condition: ->
            not GameState.instance().get 'town.King.talked'
          action: ->
            dialog [
              """
                Hello there, stranger!
                Here is the second line.
              """
              "How are you today?"
            ]
            GameState.instance().set 'town.King.talked', true
        followUp:
          condition: ->
            GameState.instance().get 'town.King.talked'
          action: ->
            dialog [
              """
                Nice to see you again!
                You are looking well.
              """
              "How is the family?"
            ]
