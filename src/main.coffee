canvas = document.getElementById "game"
context = canvas.getContext "2d"

position =
  x: 64
  y: 64
speed = 16

tileSize = 32

drawGrid = ->
  for x in [0..canvas.width/tileSize]
    for y in [0..canvas.height/tileSize]
      context.save()
      context.strokeStyle = "#333"
      context.strokeRect x * tileSize, y * tileSize, tileSize, tileSize
      context.restore()

render = ->
  context.clearRect 0, 0, canvas.width, canvas.height
  drawGrid()
  context.save()
  context.fillStyle = "#f00"
  context.fillRect position.x, position.y, 32, 32
  context.restore()

document.onkeydown = (event) ->
  switch event.which
    when 37
      position.x -= speed
    when 38
      position.y -= speed
    when 39
      position.x += speed
    when 40
      position.y += speed

setInterval ->
  render()
, 16

