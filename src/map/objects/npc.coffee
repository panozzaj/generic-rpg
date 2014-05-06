class Map.Object.NPC extends Map.Object

  states:
    firstContact:
      initial: true
      transitions:
        talk: 'followUp'
      dialog: "Hello there, stranger!"
    followUp:
      dialog: "Nice to see you again!"
      transitions:
        talk: 'followUp'

  constructor: (map, data) ->
    super
    @sprite = new Image
    @sprite.src = "assets/images/king.png"

  talk: =>
    GameEvent.trigger 'dialog', text: @states[@state].dialog
    @transitionState 'talk'
