module.exports = (grunt) ->

  grunt.initConfig

    coffee:
      options:
        join: true
      compile:
        files:
          'build/main.js': ['src/*.coffee']

    watch:
      options:
        livereload: true
      scripts:
        files: ['src/*.coffee']
        tasks: ['coffee']

    connect:
      server:
        options:
          port: 5000

  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-connect'

  grunt.registerTask 'default', ['connect', 'watch']
