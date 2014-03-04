class AudioManager
  constructor: ->
    if window.location.search.match("music=true")
      GameEvent.on 'playMusic', @handlePlayMusic

  handlePlayMusic: (e) =>
    @audio?.pause()
    @audio = new Audio("assets/audio/#{e.attributes.music}")
    @audio.play()
