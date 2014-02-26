class Map.Map
  constructor: (mapScreen) ->
    tmxloader.load('src/map/data/map2.tmx')

    @tileset = tmxloader.map.tilesets[0]
    @image = new Image
    @image.src = "src/map/data/#{@tileset.src}"
    @layers = tmxloader.map.layers
    { @tileSize, @tilesWide, @tilesTall } = mapScreen

    @mapTileSize = tmxloader.map.tileWidth

  draw: (context) =>
    _.each @layers, (layer) =>
      data = layer.data
      for y in [0...data.length]
        for x in [0...data.length]
          tileId = data[x][y] - 1
          tilesWide = @tileset.width / @mapTileSize

          tileRow = Math.floor(tileId / tilesWide)
          tileColumn = tileId % tilesWide

          console.log tileRow, tileColumn if @print

          context.save()
          context.drawImage @image,
            tileColumn * @mapTileSize, tileRow * @mapTileSize,
            @mapTileSize, @mapTileSize,
            y * @tileSize, x * @tileSize,
            @tileSize, @tileSize
          context.restore()
