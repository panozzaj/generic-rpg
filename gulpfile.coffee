gulp = require 'gulp'

watchify = require 'watchify'
source = require 'vinyl-source-stream'
duration = require 'gulp-duration'

http = require 'http'
connect = require 'connect'
open = require 'open'

gulp.task 'build', ->

  bundler = watchify
    entries: ['./src/game.coffee']
    extensions: ['.coffee']

  bundler.require './src/extensions.coffee',
    expose: 'extensions'

  bundler.require './src/game.coffee',
    expose: 'game'

  rebundle = ->

    bundler.bundle
      debug: true

    .on 'error', (err) ->
      console.warn 'error', err

    .pipe source 'main.js'
    .pipe duration 'rebundling...'
    .pipe gulp.dest './build'

  bundler.on 'update', rebundle

  rebundle()

gulp.task 'server', ->

  port = 5000

  app = connect()
    .use connect.static('.')

  http.createServer(app).listen(port)
  open "http://localhost:#{port}"

gulp.task 'default', ['build', 'server']
