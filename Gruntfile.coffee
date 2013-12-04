# Generated on 2013-08-10 using generator-webapp 0.2.6
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
        tasks: ["coffee:dist", "requirejs"]

    clean:
      dist: ".tmp"

    jshint:
      options:
        jshintrc: ".jshintrc"

      all: ["Gruntfile.js", "<%= yeoman.app %>/scripts/{,*/}*.js", "!<%= yeoman.app %>/scripts/vendor/*", "test/spec/{,*/}*.js"]

    mocha:
      all:
        options:
          run: true
          urls: ["http://localhost:<%= connect.options.port %>/index.html"]

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

    # not used since Uglify task does concat,
    # but still available if needed
    #concat: {
    #            dist: {}
    #        },
    requirejs:
      dist:

        # Options: https://github.com/jrburke/r.js/blob/master/build/example.build.js
        options:
          name: 'ivories'
          out: 'ivories.min.js'
          # `name` and `out` is set by grunt-usemin
          # because of coffee-script, we'll have requirejs compile from .tmp folder
          baseUrl: ".tmp"
          optimize: "none"

          # paths for our own files (not bower_components)
          # paths:
          # TODO: Figure out how to make sourcemaps work with grunt-usemin
          # https://github.com/yeoman/grunt-usemin/issues/30
          #generateSourceMaps: true,
          # required to support SourceMaps
          # http://requirejs.org/docs/errors.html#sourcemapcomments
          preserveLicenseComments: false
          useStrict: true
          wrap: true

    # Put files not handled in other tasks here
    copy:
      dist:
        files: [
          expand: true
          dot: true
          cwd: "<%= yeoman.app %>"
          dest: "<%= yeoman.dist %>"
          src: ["*.{ico,png,txt}", ".htaccess", "images/{,*/}*.{webp,gif}", "styles/fonts/*"]
        ,
          expand: true
          cwd: ".tmp/images"
          dest: "<%= yeoman.dist %>/images"
          src: ["generated/*"]
        ]


      # copy scripts/lib folder to .tmp for requirejs
      lib:
        files: [
          expand: true
          dot: true
          cwd: "<%= yeoman.app %>"
          dest: ".tmp"
          src: ["scripts/{vendor,lib}/*.*"]
        ]

    bower:
      options:
        exclude: ["modernizr"]

      all:
        rjsConfig: "<%= yeoman.app %>/scripts/main.js"


    # symlink bower_components folder into .tmp for requirejs
    symlink:
      js:
        dest: ".tmp/bower_components"
        relativeSrc: "../<%= yeoman.app %>/bower_components"
        options:
          type: "dir"

  # grunt.registerTask "server", (target oncurrent:server", "connect:livereload", "open", "watch"]

  grunt.registerTask "test", ["clean:server", "concurrent:test", "connect:test", "mocha"]
  grunt.registerTask "build", ["clean:dist", "coffee:dist", "requirejs"]
  # grunt.registerTask "default", ["jshint", "test", "build"]
