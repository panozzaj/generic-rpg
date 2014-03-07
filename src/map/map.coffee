class Map.Map
  constructor: (mapScreen) ->
    tmxloader.load('src/map/data/map2.tmx')

    @tileset = tmxloader.map.tilesets[0]
    @tilesetImage = new Image
    @tilesetImage.src = "src/map/data/#{@tileset.src}"
    @layers = tmxloader.map.layers
    { @tileSize } = mapScreen

    @tilesetTileSize = @tileset.tileWidth
    @tilesWide = tmxloader.map.width
    @tilesTall = tmxloader.map.height

    @tilesetColumns = @tileset.width / @tilesetTileSize

    @objectGroups = tmxloader.map.objectgroups

  drawBottom: (context) =>
    _.each _.reject(@layers, { name: 'top' }), (layer) =>
      @drawLayer layer, context

    _.forEach @objectGroups, (objectGroup) =>
      _.each objectGroup.objects, (object) =>
        tileId = parseInt(object.gid) - 1
        tileRow = Math.floor(tileId / @tilesetColumns)
        tileColumn = tileId % @tilesetColumns
        context.drawImage @tilesetImage,
          tileColumn * @tilesetTileSize, tileRow * @tilesetTileSize,
          @tilesetTileSize, @tilesetTileSize,
          parseInt(object.y) * @tileSize, parseInt(object.x) * @tileSize,
          @tileSize, @tileSize

  drawTop: (context) =>
    _.each _.filter(@layers, { name: 'top' }), (layer) =>
      @drawLayer layer, context

  drawLayer: (layer, context) =>
    data = layer.data
    for y in [0...data.length]
      for x in [0...data.length]
        tileId = data[x][y] - 1

        tileRow = Math.floor(tileId / @tilesetColumns)
        tileColumn = tileId % @tilesetColumns

        context.drawImage @tilesetImage,
          tileColumn * @tilesetTileSize, tileRow * @tilesetTileSize,
          @tilesetTileSize, @tilesetTileSize,
          y * @tileSize, x * @tileSize,
          @tileSize, @tileSize

  isCollidable: (x, y) -> 
    _.find(@layers, name: "fg").data[y][x] != "0"
    # _.any @objects, (object) ->
    #   (object.x / @tilesetTileSize == x && object.y / @tilesetTileSize == y)
