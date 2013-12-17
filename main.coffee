canvas = document.getElementById "game"
context = canvas.getContext "2d"

context.save()
context.fillStyle = "#f00"
context.fillRect 100, 100, 30, 30
context.restore()

document.onkeydown (event) ->
  switch event.which
    when 37 then console.log "LEFT!"
    when 38 then console.log "UP!"
    when 39 then console.log "RIGHT!"
    when 40 then console.log "DOWN!"
