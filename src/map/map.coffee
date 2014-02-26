class Map.Map
  constructor: (mapScreen) ->
    tmxloader.load('src/map/data/map2.tmx')

    @tileset = tmxloader.map.tilesets[0]
    @image = new Image
    @image.src = "src/map/data/#{@tileset.src}"
    @layers = tmxloader.map.layers
    { @tileSize, @tilesWide, @tilesTall } = mapScreen

    @mapTileSize = tmxloader.map.tileWidth

    # avatar @ (0,0)
    # 0..16 x
    # 0..10 y

    # avatar @ (4,4)
    # same

    # avatar @ (20, 12)
    # 12..28 x
    # 7..17  y

  draw: (context) =>
    _.each @layers, (layer) =>
      data = layer.data
      for y in [0...data.length]
        for x in [0...data.length]
          #continue unless x >= 0 && y >= 0 &&
          #x < tmxloader.map.width  &&
          #y < tmxloader.map.height

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

