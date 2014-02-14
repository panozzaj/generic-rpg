class Battle.Data
  constructor: ->
    @avatars = [
      new Battle.Avatar
        name: "Simba"
        position:
          x: 512
          y: 128
      new Battle.Avatar
        name: "Rafiki"
        position:
          x: 512
          y: 256
    ]
    @monsters = [
      new Battle.Enemy(position: { x: 128, y: 128 })
      new Battle.Enemy(position: { x: 128, y: 256 })
    ]

  start: ->
    _.each @avatars, (avatar) =>
      GameEvent.trigger 'enqueue', action:
        type: Battle.Action.ScheduleTurn
        source: avatar
        executeIn: 0

    _.each @monsters, (enemy) =>
      GameEvent.trigger 'enqueue', action:
        type: Battle.Action.ScheduleTurn
        source: enemy
        executeIn: 0
