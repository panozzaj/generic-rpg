class Effect.Blur
  constructor: (source) ->
    console.log 'handling blur'
    try
      glcanvas = fx.canvas()
    catch e
      console.log 'got an exception blurring'
      return

    @blurIntensity = 0.0

    # This tells glfx what to use as a source image
    texture = glcanvas.texture(source)

    # Hide the source 2D canvas and put the WebGL Canvas in its place
    source.parentNode.insertBefore(glcanvas, source)
    oldCanvasStyle = source.style.display
    source.style.display = 'none'
    glcanvas.className = source.className
    glcanvas.id = source.id
    oldSourceId = source.id
    source.id = 'old_' + source.id
    glcanvas.draw(texture)
      .zoomBlur(source.width / 2, source.height / 2, @blurIntensity).update()

    new Promise (resolve, reject) =>

      blurCanvas = setInterval =>
        # Load the background from our canvas
        texture.loadContentsOf(source)

        # Apply WebGL magic
        @blurIntensity += 0.03
        if @blurIntensity >= 0.90
          @blurIntensity = 0
          $('#' + glcanvas.id).remove()
          source.style.display = oldCanvasStyle
          source.id = oldSourceId
          clearInterval blurCanvas
          resolve()

        glcanvas.draw(texture)
          .zoomBlur(source.width / 2 + Math.random() * 30 - 15, source.height / 2 + Math.random() * 30 - 15, @blurIntensity)
          .brightnessContrast(-@blurIntensity / 6, 0)
          .update()
      , Math.floor(1000 / 40)
