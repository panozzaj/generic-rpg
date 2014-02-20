class Battle.TargetSelector
  constructor: ({ @enemies, @allies, @select, @cancel }) ->
    @cursor = new Image()
    @cursor.src = "images/cursor.png"

    @moveLeft()

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
      when 88 # x
        @cancel @
      when 90 # z
        @select target: @selectedSide[@selectedIndex]

  moveCursor: (offset) ->
    @selectedIndex = (@selectedIndex + @selectedSide.length + offset) % @selectedSide.length
    unless @selectedSide[@selectedIndex].alive()
      @moveCursor(offset)

  moveRight: ->
    @selectedSide = @allies
    @selectedIndex = @firstEntity()

  moveLeft: ->
    @selectedSide = @enemies
    @selectedIndex = @firstEntity()

  firstEntity: ->
    @selectedIndex = _.findIndex @selectedSide, (entity) -> entity.alive()
