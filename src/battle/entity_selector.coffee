class Battle.EntitySelector
  constructor: ({ @enemies, @allies, @callback }) ->
    @cursor = new Image()
    @cursor.src = "images/cursor.png"

    @selectedIndex = 0
    @selectedSide = @enemies

    GameEvent.trigger 'pushResponder', responder: @

  destroy: ->
    GameEvent.trigger 'popResponder', responder: @

    # picked enemy 0
    # picked avatar 3
    # picked all enemies

  draw: (context) ->
    entity = @selectedSide[@selectedIndex]
    context.drawImage @cursor, entity.position.x - 40, entity.position.y + 20, 30, 30

  selectedSide: ->
    if @pointingAt == 'enemies' then @enemies else @allies

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
        @selectEntity()

  moveCursor: (offset) ->
    @selectedIndex = (@selectedIndex + @selectedSide.length + offset) % @selectedSide.length

  moveRight: ->
    @selectedSide = @allies
    @selectedIndex = 0

  moveLeft: ->
    @selectedSide = @enemies
    @selectedIndex = 0

  selectEntity: ->
    @callback target: @selectedSide[@selectedIndex]
    @destroy()

