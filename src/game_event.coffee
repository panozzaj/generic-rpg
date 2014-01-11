class GameEvent

  @trigger: (type, params={}) ->
    ev = new Event(type)
    ev.attributes = params
    window.dispatchEvent ev

  @on: (type, cb) ->
    window.addEventListener type, cb

  @off: (type, cb) ->
    window.removeEventListener type, cb
