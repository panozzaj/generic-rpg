module.exports = (grunt) ->

  grunt.initConfig

    coffee:
      options:
        join: true
      compile:
        files:
          'build/main.js': ['src/*.coffee']

    watch:
      scripts:
        files: ['src/*.coffee']
        tasks: ['coffee']

  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-watch'

  grunt.registerTask 'default', 'watch'
