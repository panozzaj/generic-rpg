GameState = require 'src/data/game_state'

module.exports =
  'town':
    'King':
      states:
        firstContact:
          condition: ->
            not GameState.instance().get 'town.King.talked'
          dialog: "Hello there, stranger!"
          action: ->
            GameState.instance().set 'town.King.talked', true
        followUp:
          condition: ->
            GameState.instance().get 'town.King.talked'
          dialog: "Nice to see you again!"
