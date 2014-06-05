GameState = require 'src/data/game_state'
GameEvent = require 'src/game_event'

dialog = ({ messages, prompt }) ->
  GameEvent.trigger 'dialog', { messages, prompt }

module.exports =
  'town':
    'King':
      states:
        firstContact:
          condition: ->
            not GameState.instance().get 'town.King.talked'
          action: ->
            dialog
              messages: [
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
            dialog
              messages: [
                """
                  Nice to see you again!
                  You are looking well.
                """
                """
                  How is the family?
                """
              ]
              prompt: [
                [ "Good", -> dialog messages: ["Glad to hear it!"] ]
                [ "Dead", -> dialog messages: ["Aw, shucks!"] ]
              ]

