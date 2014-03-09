class AudioManager
  @shouldPlayMusic: window.location.search.match("music=true")

  @playMusic: (music) ->
    return unless @shouldPlayMusic

    @music?.pause()
    @music = new Audio("assets/music/#{music}")
    @music.loop = true

    new Promise (resolve, reject) =>
      @music.addEventListener 'canplaythrough', -> @play()
      @music.addEventListener 'ended', -> resolve()
      @music.addEventListener 'error', -> reject()

  @playSound: (sound) ->
    audio = new Audio("assets/sound/#{sound}")

    new Promise (resolve, reject) ->
      audio.addEventListener 'canplaythrough', -> @play()
      audio.addEventListener 'ended', -> resolve()
      audio.addEventListener 'error', -> reject()
