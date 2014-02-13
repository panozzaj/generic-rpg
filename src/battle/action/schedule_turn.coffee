class Battle.Action.ScheduleTurn extends Battle.Action
  execute: ->
    switch @source.constructor.name
      when "Avatar"
        GameEvent.trigger 'enqueue', action:
          type: Battle.Action.Menu
          source: @source
          enemies: @enemies
          executeIn: 10

      when "Enemy"
        GameEvent.trigger 'enqueue', action:
          type: Battle.Action.Attack
          source: @source
          target: @enemies[0]
          enemies: @enemies
          executeIn: 10

    GameEvent.trigger 'finishedAction'
