class AudioManager
  constructor: ->
    if window.location.search.match("music=true")
      GameEvent.on 'playMusic', @handlePlayMusic

    GameEvent.on 'playSound', @handlePlaySound

  handlePlayMusic: (e) =>
    @music?.pause()
    @play e.attributes.music

  handlePlaySound: (e) =>
    @play e.attributes.sound

  play: (sound) =>
    new Promise (resolve, reject) ->
      audio = new Audio("assets/sound/#{sound}")
      audio.addEventListener 'canplaythrough', -> @play()
      audio.addEventListener 'ended', -> resolve()
      audio.addEventListener 'error', -> reject()

