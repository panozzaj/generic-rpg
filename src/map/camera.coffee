class Map.Camera
  constructor: (@mapScreen) ->

  follow: (toFollow) ->
    @following = toFollow

  update: ->
    @position = @following.screenPosition

