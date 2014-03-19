class Map.Camera
  constructor: (mapScreen) ->
    { @tileSize } = mapScreen

  follow: (toFollow) ->
    @following = toFollow

  update: ->
    @position = @following.screenPosition
    @tilePosition = @following.mapPosition

  drawBottom: (context, map) =>
    @drawTiles context, map: map, layerNames: ['bg', 'bg2', 'fg']

  drawTop: (context, map) =>
    @drawTiles context, map: map, layerNames: ['top']

  drawTiles: (context, { map, layerNames }) ->
    tileData = map.tileDataFor
      layerNames: layerNames
      xRange: [(@tilePosition.x - 9)...(@tilePosition.x + 9)] # replace with correct value
      yRange: [(@tilePosition.y - 6)...(@tilePosition.y + 6)] # replace with correct value

    _.each tileData, (tile) =>
      context.drawImage tile.image,
        tile.sx, tile.sy, tile.sw, tile.sh,
        tile.x * @tileSize, tile.y * @tileSize, @tileSize, @tileSize
