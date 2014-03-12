class Map.Map
  constructor: (mapScreen) ->
    @changeMap 'town'
    { @tileSize } = mapScreen

  changeMap: (mapName) =>
    tmxloader.load("src/map/data/#{mapName}.tmx")

    @tileset = tmxloader.map.tilesets[0]
    @tilesetImage = new Image
    @tilesetImage.src = "src/map/data/#{@tileset.src}"
    @layers = tmxloader.map.layers

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

  isCollidable: ({ x, y }) ->
    tile = _.find(@layers, name: "fg").data[y][x]
    if tile == undefined
      false
    else if tile != "0"
      true

  isWalkable: (params) ->
    !@isCollidable(params)

  triggerAt: ({ x, y }) ->
    _.find @objectsForGroup('triggers'), (trigger) =>
      console.log x, y, trigger
      parseInt(trigger.x) / @tilesetTileSize <= x < (parseInt(trigger.x) + parseInt(trigger.width)) / @tilesetTileSize &&
      parseInt(trigger.y) / @tilesetTileSize <= y < (parseInt(trigger.y) + parseInt(trigger.height)) / @tilesetTileSize

  contents: ({ x, y }) ->
    objects = @objectsForGroup 'objects'
    match = _.find objects, (object) =>
      parseInt(object.x) / @tilesetTileSize == x && parseInt(object.y) / @tilesetTileSize == y
    match?.properties.contents

  objectsForGroup: (name) ->
    _.flatten(_.map(_.filter(_.values(@objectGroups), name: name), (objectGroup) -> objectGroup.objects))


