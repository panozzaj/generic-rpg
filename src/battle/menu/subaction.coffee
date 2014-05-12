Menu = require 'battle/menu'

module.exports = class MenuSubaction extends Menu
  constructor: ({ @spells, @select, @cancel }) ->
    super

    @pos =
      x: 250
      y: 350
    @size =
      width: 500
      height: 200
    @currentSpell = 0

  draw: (context) ->
    @drawBackground context
    @drawActions context
    @drawCursor context

  drawActions: (context) ->
    context.save()
    context.fillStyle = 'white'
    context.font = '30px manaspaceregular'
    _.each @spells, (spell, i) =>
      context.fillText spell, @pos.x + 30, @pos.y + 50 + 40 * i
    context.restore()

  drawCursor: (context) ->
    context.drawImage @cursor, @pos.x - 10, @pos.y + 30 + 40 * @currentSpell, 30, 30

  update: ->

  onkeydown: (event) ->
    switch event.which
      when 38 # up
        @moveCursor -1
      when 40 # down
        @moveCursor 1
      #when 37 # left
      #  @moveCursor 1
      when 90 # z
        @select subaction: @spells[@currentSpell]
      when 88 # x
        @cancel @

  moveCursor: (offset) ->
    @currentSpell = (@currentSpell + @spells.length + offset) % @spells.length
