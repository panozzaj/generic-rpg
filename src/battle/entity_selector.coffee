class Battle.EntitySelector
  constructor: ({ @enemyPositions, @allyPositions }) ->
    @cursor = new Image()
    @cursor.src = "images/cursor.png"

    @pointingAt = 'enemies'

    @selectedIndex = 0

    GameEvent.trigger 'pushResponder', responder: @

  destroy: ->
    GameEvent.trigger 'popResponder', responder: @

    # picked enemy 0
    # picked avatar 3
    # picked all enemies

  draw: (context) ->
    position = @selectedSide()[@selectedIndex]
    context.drawImage @cursor, position.x - 40, position.y + 20, 30, 30

  selectedSide: ->
    if @pointingAt == 'enemies' then @enemyPositions else @allyPositions

  onkeydown: (event) ->
    switch event.which
      when 38 # up
        @moveCursor -1
      when 40 # down
        @moveCursor 1
      when 39 # right
        @moveRight()
      when 37 # left
        @moveLeft()
      when 90 # z
        @performCurrentAction()

  moveCursor: (offset) ->
    @selectedIndex = (@selectedIndex + @selectedSide().length + offset) % @selectedSide().length

  moveRight: ->
    @pointingAt = 'allies'
    @selectedIndex = 0

  moveLeft: ->
    @pointingAt = 'enemies'
    @selectedIndex = 0

