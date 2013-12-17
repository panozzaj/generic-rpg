module.exports = (grunt) ->

  grunt.initConfig

    coffee:
      compile:
        files:
          'build/main.js': 'src/main.coffee'

  grunt.loadNpmTasks 'grunt-contrib-coffee'

  grunt.registerTask 'default', 'coffee'
