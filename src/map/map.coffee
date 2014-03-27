class Map.Map
  constructor: (mapScreen) ->
    @changeMap 'town'

  changeMap: (mapName) =>
    tmxloader.load("src/map/data/#{mapName}.tmx")

    @tileset = tmxloader.map.tilesets[0]
    @tilesetImage = new Image
    @tilesetImage.src = "src/map/data/#{@tileset.src}"
    @layers = tmxloader.map.layers

    @tilesetTileSize = parseInt(@tileset.tileWidth)
    @tilesWide = tmxloader.map.width
    @tilesTall = tmxloader.map.height

    @tilesetColumns = @tileset.width / @tilesetTileSize

    @objectGroups = tmxloader.map.objectgroups
    @objects = _.flatten(_.map(_.values(@objectGroups), (objectGroup) -> objectGroup.objects))

  tileDataFor: ({ layerNames, xRange, yRange }) ->
    tileData = []

    _.each layerNames, (layerName) =>
      layer = _.find @layers, name: layerName
      return unless layer

      for y in yRange
        for x in xRange
          tileId = layer.data[y][x] - 1
          tileRow = Math.floor(tileId / @tilesetColumns)
          tileColumn = tileId % @tilesetColumns

          continue if tileId == -1
          tileData.push
            image: @tilesetImage
            sx: tileColumn * @tilesetTileSize
            sy: tileRow * @tilesetTileSize
            sw: @tilesetTileSize
            sh: @tilesetTileSize
            x: x
            y: y

    tileData

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

  npcs: ->
    _.map _.filter(@objectsForGroup('objects'), type: "NPC"), (npc) =>
      npc.tileX = npc.x / @tilesetTileSize
      npc.tileY = npc.y / @tilesetTileSize
      npc

  objectsForGroup: (name) ->
    _.flatten(_.map(_.filter(_.values(@objectGroups), name: name), (objectGroup) -> objectGroup.objects))

