canvas = document.getElementById "game"
context = canvas.getContext "2d"

position =
  x: 100
  y: 100
speed = 2

render = ->
  context.clearRect 0, 0, canvas.width, canvas.height
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

