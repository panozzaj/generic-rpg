class Map.Object.Urn extends Map.Object

  constructor: (map, data) ->
    super
    # hack due to not having multiple tilesets
    @sprite = new Image
    @sprite.src = "assets/images/king.png"

  talk: =>
    GameEvent.trigger 'dialog', text: """
      Howdy, this is an urn!
    """

