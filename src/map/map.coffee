class Map.Map
  constructor: (mapScreen) ->
    tmxloader.load('src/map/data/map2.tmx')

    @tileset = tmxloader.map.tilesets[0]
    @image = new Image
    @image.src = "src/map/data/#{@tileset.src}"
    @layers = tmxloader.map.layers
    { @tileSize } = mapScreen

    @tilesetTileSize = @tileset.tileWidth
    @tilesWide = tmxloader.map.width
    @tilesTall = tmxloader.map.height

    @tilesetColumns = @tileset.width / @tilesetTileSize

    @objects = tmxloader.map.objects

  draw: (context) =>
    _.each @layers, (layer) =>
      data = layer.data
      for y in [0...data.length]
        for x in [0...data.length]
          tileId = data[x][y] - 1

          tileRow = Math.floor(tileId / @tilesetColumns)
          tileColumn = tileId % @tilesetColumns

          context.save()
          context.drawImage @image,
            tileColumn * @tilesetTileSize, tileRow * @tilesetTileSize,
            @tilesetTileSize, @tilesetTileSize,
            y * @tileSize, x * @tileSize,
            @tileSize, @tileSize
          context.restore()

  isCollidable: (x, y) -> 
    console.log('isCollidable: ' + _.find(@layers, name: "fg").data[y][x] != "0")
    _.find(@layers, name: "fg").data[y][x] != "0"
    # _.any @objects, (object) ->
    #   (object.x / @tilesetTileSize == x && object.y / @tilesetTileSize == y)
