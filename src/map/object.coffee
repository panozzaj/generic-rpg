class Map.Object
  constructor: (map, data) ->
    { @name, tileX, tileY } = data
    @tileSize = map.tileSize
    @tilePosition = { x: tileX, y: tileY }

  update: ->
    # no-op by default

  drawingData: ->
    image: @sprite
    sx: 0
    sy: 0
    sw: 16
    sh: 16
    tilePosition: @tilePosition

  talk: =>
    # no-op by default
