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
    @objects = _.flatten(_.map(_.values(@objectGroups), (objectGroup) -> objectGroup.objects))

  drawBottom: (context) =>
    _.each _.reject(@layers, { name: 'top' }), (layer) =>
      @drawLayer layer, context

    _.each @objects, (object) =>
      tileId = parseInt(object.gid) - 1
      tileRow = Math.floor(tileId / @tilesetColumns)
      tileColumn = tileId % @tilesetColumns
      context.drawImage @tilesetImage,
        tileColumn * @tilesetTileSize, tileRow * @tilesetTileSize,
        @tilesetTileSize, @tilesetTileSize,
        # not sure why y has off by one
        parseInt(object.x) / @tilesetTileSize * @tileSize, (parseInt(object.y) / @tilesetTileSize - 1) * @tileSize,
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
    collidableObjects = _.flatten(_.map(_.filter(_.values(@objectGroups), name: 'objects'), (objectGroup) -> objectGroup.objects))
    # not sure why y has off by one
    willCollideWithObject = _.any(collidableObjects, (object) => parseInt(object.y) / @tilesetTileSize == y + 1 && parseInt(object.x) / @tilesetTileSize == x)
    _.find(@layers, name: "fg").data[y][x] != "0" || willCollideWithObject
