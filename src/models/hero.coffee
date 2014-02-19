class Model.Hero
  constructor: ({ @name }) ->
    @stats = {
      hp:
        max: 150,
        current: 150
      damage: 10
      magic: 20
    }

