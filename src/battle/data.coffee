class Battle.Data
  constructor: ({ @party }) ->
    @avatars = _.map @party, (hero, index) ->
      new Battle.Avatar
        hero: hero
        position:
          x: 512
          y: 128 + 128 * index
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
