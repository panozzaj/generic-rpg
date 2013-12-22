class Map
  constructor: ->
    @tileString = """
      GGGGGGGGGG
      SSSSSSSSSS
      WWWWWWWWWW
      GGGGGGGGGG
    """

    @tiles = @tileString.split('\n').map (str) -> str.split('')

    window.tiles = @tiles

  height: ->
    @tiles.length

  width: ->
    @tiles[0].length
