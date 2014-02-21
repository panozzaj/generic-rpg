class Map.Map
  constructor: (mapScreen) ->
    tmxloader.load('src/map/data/map2.tmx')

    @tileset = tmxloader.map.tilesets[0]
    @image = new Image
    @image.src = "src/map/data/#{@tileset.src}"
    @layers = tmxloader.map.layers
    @tileSize = mapScreen.tileSize

  draw: (context) =>
    _.each @layers, (layer) =>
      data = layer.data
      for y in [0...data.length]
        for x in [0...data.length]
          tileId = data[x][y] - 1
          tilesWide = @tileset.width / 16

          tileRow = Math.floor(tileId / tilesWide)
          tileColumn = tileId % tilesWide

          console.log tileRow, tileColumn if @print

          context.save()
          context.drawImage @image,
            tileColumn * 16, tileRow * 16, 16, 16,
            y * @tileSize, x * @tileSize, @tileSize, @tileSize
          context.restore()
