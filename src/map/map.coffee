class Map.Map
  constructor: (mapScreen) ->
    tmxloader.load('src/map/data/map2.tmx')

    @tileset = tmxloader.map.tilesets[0]
    @image = new Image
    @image.src = "src/map/data/#{@tileset.src}"
    @layer = tmxloader.map.layers[0].data

  draw: (context) ->
    for y in [0...@layer.length]
      for x in [0...@layer.length]
        context.save()
        context.fillStyle = 'black'
        context.font = '30px manaspaceregular'
        context.fillText @layer[x][y], x * 64, y * 64
        context.restore()
