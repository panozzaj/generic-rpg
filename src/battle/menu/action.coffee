Menu = require 'battle/menu'

module.exports = class MenuAction extends Menu

  constructor: ({ @select, @cancel }) ->
    super

    @pos =
      x: 50
      y: 350

    @size =
      width: 200
      height: 200

    @actionDescriptions = [
      { name: 'Fight', type: 'Attack' }
      { name: 'Spell', type: 'Spell'  }
      { name: 'Run',   type: 'Run'    }
    ]

    @currentAction = 0

  draw: (context) ->
    @drawBackground context
    @drawActions context
    @drawCursor context

  drawActions: (context) ->
    context.save()
    context.fillStyle = 'white'
    context.font = '30px manaspaceregular'
    _.each @actionDescriptions, (actionDescription, i) =>
      context.fillText actionDescription.name, @pos.x + 30, @pos.y + 50 + (40 * i)
    context.restore()

  drawCursor: (context) ->
    context.drawImage @cursor, 45, @pos.y + 30 + (40 * @currentAction), 30, 30

  update: ->

  onkeydown: (event) ->
    switch event.which
      when 38 # up
        @moveCursor -1
      when 40 # down
        @moveCursor 1
      when 90 # z
        @select action: @actionDescriptions[@currentAction].type

  moveCursor: (offset) ->
    @currentAction = (@currentAction + @actionDescriptions.length + offset) % @actionDescriptions.length
