class Dialog
  constructor: (game) ->
    # something

  update: ->
    # something

  draw: (context) ->
    context.save()
    context.fillStyle = "#33c"
    context.fillRect 50, 50, 500, 250
    context.restore()
    context.save()
    context.fillStyle = 'white'
    context.font = '30px manaspaceregular'
    context.fillText 'Hello Simba!', 80, 110
    context.fillText 'This is your destiny...', 80, 150
    context.restore()

