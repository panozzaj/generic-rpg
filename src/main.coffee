canvas = document.getElementById "game"
context = canvas.getContext "2d"

position =
  x: 64
  y: 64
speed = 8
velocity =
  x: 0
  y: 0

tileSize = 64

drawGrid = ->
  for x in [0..canvas.width/tileSize]
    for y in [0..canvas.height/tileSize]
      context.save()
      context.strokeStyle = "#333"
      context.strokeRect x * tileSize, y * tileSize, tileSize, tileSize
      context.restore()

gameWorldUpdate = ->
  position.x += velocity.x
  position.y += velocity.y
  if position.x % tileSize == 0
    velocity.x = 0
  if position.y % tileSize == 0
    velocity.y = 0

render = ->
  context.clearRect 0, 0, canvas.width, canvas.height
  gameWorldUpdate()
  drawGrid()
  context.save()
  context.fillStyle = "#f00"
  context.fillRect position.x, position.y, tileSize, tileSize
  context.restore()

document.onkeydown = (event) ->
  switch event.which
    when 37
      velocity.x = -speed
    when 38
      velocity.y = -speed
    when 39
      velocity.x = speed
    when 40
      velocity.y = speed

setInterval ->
  render()
, 16

