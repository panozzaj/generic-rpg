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

  tileDataFor: ({ layerNames, xRange, yRange }) ->
    tileData = []

    _.each layerNames, (layerName) =>
      layer = _.find @layers, name: layerName
      return unless layer

      for y in yRange
        for x in xRange
          tileId = layer.data[y][x] - 1
          continue if tileId == -1

          tileData.push _.extend @tileDataForGid(tileId),
            x: x
            y: y

    tileData

  tileDataForGid: (tileId)  ->
    tileRow = Math.floor(tileId / @tilesetColumns)
    tileColumn = tileId % @tilesetColumns

    image: @tilesetImage
    sx: tileColumn * @tilesetTileSize
    sy: tileRow * @tilesetTileSize
    sw: @tilesetTileSize
    sh: @tilesetTileSize

  objectDataFor: ({ xRange, yRange }) ->
    tileData = []

    inViewport = _.filter @objectsForGroup('objects'), (object) =>
      (object.x / @tilesetTileSize) in xRange && (object.y / @tilesetTileSize) in yRange

    _.each inViewport, (object) =>
      tileId = object.gid - 1
      tileRow = Math.floor(tileId / @tilesetColumns)
      tileColumn = tileId % @tilesetColumns

      tileData.push
        image: @tilesetImage
        sx: tileColumn * @tilesetTileSize
        sy: tileRow * @tilesetTileSize
        sw: @tilesetTileSize
        sh: @tilesetTileSize
        x: object.x / @tilesetTileSize
        y: object.y / @tilesetTileSize

    tileData

  # fg is a tile layer, so it will return "0" for no-match
  # objects is an object layer, so it will return undefined for no-match
  # See *.tmx for an example
  isCollidable: ({ x, y }) ->
    fgTile = @tileAt({ x, y })
    objTile = @objectAt({ x, y })

    _.any [fgTile, objTile], (tile) => @hasContents(tile)

  isWalkable: (params) ->
    !@isCollidable(params)

  tileAt: ({ x, y }) ->
    _.find(@layers, name: "fg").data[y][x]

  triggerAt: ({ x, y }) ->
    _.find @objectsForGroup('triggers'), (trigger) =>
      parseInt(trigger.x) / @tilesetTileSize <= x < (parseInt(trigger.x) + parseInt(trigger.width)) / @tilesetTileSize &&
      parseInt(trigger.y) / @tilesetTileSize <= y < (parseInt(trigger.y) + parseInt(trigger.height)) / @tilesetTileSize

  objectAt: ({ x, y }) ->
    _.find @objectsForGroup('objects'), (object) =>
      parseInt(object.x) / @tilesetTileSize == x &&
      parseInt(object.y) / @tilesetTileSize == y

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

  treasures: ->
    _.map _.filter(@objectsForGroup('objects'), type: "Treasure"), (treasure) =>
      treasure.tileX = treasure.x / @tilesetTileSize
      treasure.tileY = treasure.y / @tilesetTileSize
      treasure.type = @treasureType(treasure.gid)
      treasure

  hasContents: (tile) -> tile != undefined && tile != "0"

  objectsForGroup: (name) ->
    _.flatten(_.map(_.filter(_.values(@objectGroups), name: name), (objectGroup) -> objectGroup.objects))

  # When CoffeeScript is evaluating this class, it wraps it in an IIFE.
  # Inside the IIFE, Map refers to the constructor for this class (Map.Map)
  # instead of the top-level namespace. As a result, we need to use window.Map.
  treasureType: (gid) ->
    switch parseInt(gid)
      when 1704 then window.Map.Object.Chest
      when 1702 then window.Map.Object.Urn

  loadObjects: =>
    objects = []
    _.map @npcs(), (npc) =>
      objects.push new window.Map.Object.NPC(@, npc)
    _.map @treasures(), (treasure) =>
      objects.push new treasure.type(@, treasure)
    objects

