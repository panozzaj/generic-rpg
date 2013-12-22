class Map
  constructor: (mapScreen) ->
    @tileString = """
      GGGGGGGGGG
      SSSSGSSSSS
      WWWWGWWWWW
      GGGGGGGGGG
      GWWWGGGGGW
      SSSSGGSSSW
      WWSGGGGSSW
    """

    @tiles = @tileString.split('\n').map (str) -> str.split('')
    @tileSize = mapScreen.tileSize

  draw: (context) ->
    for y in [0...@height()]
      for x in [0...@width()]
        context.save()
        context.fillStyle = @tileColor(@tiles[y][x])
        context.fillRect x * @tileSize, y * @tileSize, @tileSize, @tileSize
        context.restore()

  height: ->
    @tiles.length

  width: ->
    @tiles[0].length

  tileColor: (char) ->
    switch char
      when 'G' then '#0f0'
      when 'S' then '#888'
      when 'W' then '#00f'


