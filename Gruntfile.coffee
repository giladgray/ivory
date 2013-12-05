"use strict"

# # Globbing
# for performance reasons we're only matching one level down:
# 'test/spec/{,*/}*.js'
# use this if you want to recursively match all subfolders:
# 'test/spec/**/*.js'
module.exports = (grunt) ->

  # load all grunt tasks
  require("matchdep").filterDev("grunt-*").forEach grunt.loadNpmTasks

  grunt.initConfig
    watch:
      coffee:
        files: ["src/{,*/}*.coffee"]
        tasks: ["build"]

    clean:
      dist: ".tmp"

    coffee:
      dist:
        files: [
          expand: true
          cwd: "src"
          src: "{,*/}*.coffee"
          dest: ".tmp"
          ext: ".js"
        ]

      test:
        files: [
          expand: true
          cwd: "test/spec"
          src: "{,*/}*.coffee"
          dest: ".tmp/spec"
          ext: ".js"
        ]

    requirejs:
      dist:

        # Options: https://github.com/jrburke/r.js/blob/master/build/example.build.js
        options:
          name: 'ivory'
          out: 'ivory.js'
          optimize: "none"

          # because of coffee-script, we'll have requirejs compile from .tmp folder
          baseUrl: ".tmp"

          # paths for our own files (not bower_components)
          # paths:
          # TODO: Figure out how to make sourcemaps work with grunt-usemin
          # https://github.com/yeoman/grunt-usemin/issues/30
          #generateSourceMaps: true,
          # required to support SourceMaps
          # http://requirejs.org/docs/errors.html#sourcemapcomments
          preserveLicenseComments: false
          useStrict: true
          wrap: false

    mocha:
      all:
        options:
          run: true
          urls: ["http://localhost:<%= connect.options.port %>/index.html"]

    bower:
      options:
        exclude: ["modernizr"]

      all:
        rjsConfig: "<%= yeoman.app %>/scripts/main.js"

  grunt.registerTask "build", ["clean:dist", "coffee:dist", "requirejs"]
  grunt.registerTask "test", ["build", "mocha"]
