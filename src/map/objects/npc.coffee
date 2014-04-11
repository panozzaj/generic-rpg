class Map.Object.NPC extends Map.Object

  constructor: (map, data) ->
    super
    @sprite = new Image
    @sprite.src = "assets/images/king.png"

  talk: =>
    GameEvent.trigger 'dialog', text: """
      Hello Simba!
      This is your destiny...
    """
