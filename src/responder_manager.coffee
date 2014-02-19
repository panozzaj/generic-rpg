class ResponderManager
  constructor: ->
    @responderStack = []
    GameEvent.on 'pushResponder', @handlePushResponder
    GameEvent.on 'popResponder', @handlePopResponder

  onkeydown: (event) =>
    _.last(@responderStack).onkeydown(event)

  pushResponder: (responder) ->
    @responderStack.push(responder)

  popResponder: ->
    if @responderStack.length == 1
      alert('popped all responders!')
    @responderStack.pop()

  handlePushResponder: (e) =>
    @pushResponder(e.attributes.responder)

  handlePopResponder: (e) =>
    if e.attributes.responder != @popResponder()
      alert('popped responder but it did not match')
