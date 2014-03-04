class AudioManager
  constructor: ->
    if window.location.search.match("music=true")
      GameEvent.on 'playMusic', @handlePlayMusic

    GameEvent.on 'playSound', @handlePlaySound

  handlePlayMusic: (e) =>
    @music?.pause()
    @music = new Audio("assets/music/#{e.attributes.music}")
    @music.play()

  handlePlaySound: (e) =>
    audio = new Audio("assets/sound/#{e.attributes.sound}")
    audio.play()
