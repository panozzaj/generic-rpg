module.exports = class Camera
  constructor: (mapScreen) ->
    { @tileSize } = mapScreen

    # plus ones here are for one tile of buffer when we move around
    @halfTilesWide = mapScreen.tilesWide / 2 + 1
    @halfTilesTall = mapScreen.tilesTall / 2 + 1

  follow: (toFollow) ->
    @following = toFollow

  update: ->
    { @tilePosition, @screenPosition } = @following

  drawBottom: (context, map) =>
    @drawTiles context, map: map, layerNames: ['bg', 'bg2', 'fg']

  drawObjects: (context, map, objects) =>
    x1 = @calcCenter(@tilePosition.x, @halfTilesWide, map.tilesWide - 1)
    y1 = @calcCenter(@tilePosition.y, @halfTilesTall, map.tilesTall - 1)

    xRange = [(x1 - @halfTilesWide)..(x1 + @halfTilesWide)]
    yRange = [(y1 - @halfTilesTall)..(y1 + @halfTilesTall)]

    _(objects).filter (object) ->
      object.tilePosition.x in xRange && object.tilePosition.y in yRange
    .each (object) =>
      { image, sx, sy, sw, sh, tilePosition, screenPosition } = object.drawingData()
      if tilePosition
        { x, y } = tilePosition
        context.drawImage image, sx, sy, sw, sh,
          x * @tileSize, y * @tileSize, @tileSize, @tileSize
      else
        { x, y } = screenPosition
        context.drawImage image, sx, sy, sw, sh,
          x, y, @tileSize, @tileSize

  drawTop: (context, map) =>
    @drawTiles context, map: map, layerNames: ['top']

  drawTiles: (context, { map, layerNames, objectLayers }) ->
    x1 = @calcCenter(@tilePosition.x, @halfTilesWide, map.tilesWide - 1)
    y1 = @calcCenter(@tilePosition.y, @halfTilesTall, map.tilesTall - 1)

    tileData = map.tileDataFor
      layerNames: layerNames
      xRange: [(x1 - @halfTilesWide)..(x1 + @halfTilesWide)]
      yRange: [(y1 - @halfTilesTall)..(y1 + @halfTilesTall)]

    _.each tileData, (tile) =>
      context.drawImage tile.image,
        tile.sx, tile.sy, tile.sw, tile.sh,
        tile.x * @tileSize, tile.y * @tileSize, @tileSize, @tileSize

  calcCenter: (input, offset, max) ->
    if input < offset
      offset
    else if input > max - offset
      max - offset
    else
      input

  test: ->
    console.log @calcCenter(0,  9, 31) == 9  || throw "fail"
    console.log @calcCenter(10, 9, 31) == 10 || throw "fail"
    console.log @calcCenter(31, 9, 31) == 22 || throw "fail"

    console.log @calcCenter(0,  6, 31) == 6  || throw "fail"
    console.log @calcCenter(10, 6, 31) == 10 || throw "fail"
    console.log @calcCenter(31, 6, 31) == 25 || throw "fail"

    console.log @calcCenter(0,  6, 63) == 6  || throw "fail"
    console.log @calcCenter(10, 6, 63) == 10 || throw "fail"
    console.log @calcCenter(31, 6, 63) == 31 || throw "fail"
    console.log @calcCenter(63, 6, 63) == 57 || throw "fail"
