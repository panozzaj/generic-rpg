module.exports = (grunt) ->

  grunt.initConfig

    coffee:
      options:
        join: true
        bare: true
      compile:
        files:
          'build/main.js': ['src/game.coffee', 'src/**/*.coffee']

    watch:
      options:
        livereload: true
      scripts:
        files: ['src/**/*.coffee']
        tasks: ['coffee']

    connect:
      server:
        options:
          port: 5000
          open: true

  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-connect'

  grunt.registerTask 'default', ['coffee', 'connect', 'watch']
