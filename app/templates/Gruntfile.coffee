"use strict"
LIVERELOAD_PORT = 35729
lrSnippet = require("connect-livereload")(port: LIVERELOAD_PORT)
mountFolder = (connect, dir) -> connect.static require("path").resolve(dir)

### Globbing ###
# for performance reasons we're only matching one level down:
# 'test/spec/{,*/}*.js'
# use this if you want to match all subfolders:
# 'test/spec/**/*.js'
# templateFramework: 'lodash'
module.exports = (grunt) ->
  # load all grunt tasks
  require("matchdep").filterDev("grunt-*").forEach grunt.loadNpmTasks

  # configurable paths
  yeomanConfig =
    app: "app"
    dist: "dist"

  grunt.initConfig
    yeoman: yeomanConfig
    watch:
      options:
        nospawn: true
        livereload: true
      coffee:
        files: ["<%= yeoman.app %>/scripts/{,*/}/*.coffee"]
        tasks: ["coffee:dist"]
      coffeeTest:
        files: ["test/spec/{,*/}*.coffee"]
        tasks: ["coffee:test"]
      compass:
        files: ["<%= yeoman.app %>/styles/{,*/}*.{scss,sass}"]
        tasks: ["compass"]
      handlebars:
        files: ["<%= yeoman.app %>/templates/**/*.hbs"]
        tasks: ["handlebars"]
      livereload:
        options:
          livereload: LIVERELOAD_PORT
        files: [
            "<%= yeoman.app %>/*.html",
            "{.tmp,<%= yeoman.app %>}/styles/{,*/}*.css",
            "{.tmp,<%= yeoman.app %>}/scripts/{,*/}*.js",
            "<%= yeoman.app %>/images/{,*/}*.{png,jpg,jpeg,gif,webp}"
        ]

    connect:
      options:
        port: 9000
        # change this to '0.0.0.0' to access the server from outside
        hostname: "localhost"
      livereload:
        options:
          middleware: (connect) ->
            [lrSnippet, mountFolder(connect, ".tmp"), mountFolder(connect, yeomanConfig.app)]
      test:
        options:
          middleware: (connect) ->
            [mountFolder(connect, ".tmp"), mountFolder(connect, "test"), mountFolder(connect, yeomanConfig.app)]
      dist:
        options:
          middleware: (connect) ->
            [mountFolder(connect, yeomanConfig.dist)]

    open:
      server:
        path: "http://localhost:<%= connect.options.port %>"

    clean:
      dist: [".tmp", "<%= yeoman.dist %>/*"]
      server: ".tmp"

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
          # rather than compiling multiple files here you should
          # require them into your main .coffee file
          expand: true
          cwd: "<%= yeoman.app %>/scripts"
          src: "{,*/}*.coffee"
          dest: ".tmp/scripts"
          ext: ".js"
        ]
      test:
        files: [
          expand: true
          cwd: ".tmp/spec"
          src: "*.coffee"
          dest: "test/spec"
        ]

    compass:
      options:
        sassDir: "<%= yeoman.app %>/styles"
        cssDir: ".tmp/styles"
        imagesDir: "<%= yeoman.app %>/images"
        javascriptsDir: "<%= yeoman.app %>/scripts"
        fontsDir: "<%= yeoman.app %>/styles/fonts"
        importPath: "<%= yeoman.app %>/bower_components"
        relativeAssets: true
      dist: {}
      server:
        options:
          debugInfo: true

    handlebars:
      compile:
        files:
          ".tmp/scripts/templates.js": ["<%= yeoman.app %>/templates/**/*.hbs"]
        options:
          amd: true
          # extract template name from filename
          processName: (filename) -> filename.match(/^app\/templates\/(\S+)\.\w+$/)?[1]

    requirejs:
      dist:
        # Options: https://github.com/jrburke/r.js/blob/master/build/example.build.js
        options:
          # `name` and `out` is set by grunt-usemin
          # because of coffee-script, we'll have requirejs compile from .tmp folder
          baseUrl: ".tmp/scripts"
          optimize: "none"
          # paths for our own files (not bower_components)
          paths:
            templates: "../../.tmp/scripts/templates"
          preserveLicenseComments: false
          useStrict: true
          wrap: true

    #uglify2: {} // https://github.com/mishoo/UglifyJS2
    useminPrepare:
      html: "<%= yeoman.app %>/index.html"
      options:
        dest: "<%= yeoman.dist %>"

    usemin:
      html: ["<%= yeoman.dist %>/{,*/}*.html"]
      css: ["<%= yeoman.dist %>/styles/{,*/}*.css"]
      options:
        dirs: ["<%= yeoman.dist %>"]

    imagemin:
      dist:
        files: [
          expand: true
          cwd: "<%= yeoman.app %>/images"
          src: "{,*/}*.{png,jpg,jpeg}"
          dest: "<%= yeoman.dist %>/images"
        ]

    cssmin:
      dist:
        files:
          "<%= yeoman.dist %>/styles/main.css": [".tmp/styles/{,*/}*.css", "<%= yeoman.app %>/styles/{,*/}*.css"]

    htmlmin:
      dist:
        options: {}
        # removeCommentsFromCDATA: true,
        # # https://github.com/yeoman/grunt-usemin/issues/44
        # # collapseWhitespace: true,
        # collapseBooleanAttributes: true,
        # removeAttributeQuotes: true,
        # removeRedundantAttributes: true,
        # useShortDoctype: true,
        # removeEmptyAttributes: true,
        # removeOptionalTags: true
        files: [
          expand: true
          cwd: "<%= yeoman.app %>"
          src: "*.html"
          dest: "<%= yeoman.dist %>"
        ]

    copy:
      dist:
        files: [
          expand: true
          dot: true
          cwd: "<%= yeoman.app %>"
          dest: "<%= yeoman.dist %>"
          src: ["*.{ico,txt}", ".htaccess", "images/{,*/}*.{webp,gif}"]
        ]
      # copy scripts/lib folder to .tmp for requirejs
      lib:
        files: [
          expand: true
          dot: true
          cwd: "<%= yeoman.app %>"
          dest: ".tmp"
          src: ["scripts/lib/*.*"]
        ]

    bower:
      all:
        rjsConfig: ".tmp/scripts/config.js"

    jst:
      options:
        amd: true
      compile:
        files:
          ".tmp/scripts/templates.js": ["<%= yeoman.app %>/scripts/templates/*.ejs"]

    rev:
      dist:
        files:
          src: [
            "<%= yeoman.dist %>/scripts/{,*/}*.js",
            "<%= yeoman.dist %>/styles/{,*/}*.css",
            "<%= yeoman.dist %>/images/{,*/}*.{png,jpg,jpeg,gif,webp}",
            "<%= yeoman.dist %>/styles/fonts/*"
          ]

    # symlink bower_components folder into .tmp for requirejs
    symlink:
      js:
        dest: ".tmp/bower_components"
        relativeSrc: "../<%= yeoman.app %>/bower_components"
        options:
          type: "dir"

  grunt.registerTask "createDefaultTemplate", ->
    grunt.file.write ".tmp/scripts/templates.js", "this.JST = this.JST || {};"

  grunt.registerTask "server", (target) ->
    return grunt.task.run(["build", "open", "connect:dist:keepalive"])  if target is "dist"
    grunt.task.run [
      "clean:server",
      "coffee:dist",
      "createDefaultTemplate",
      "handlebars",
      "compass:server",
      "connect:livereload",
      "open",
      "watch"
    ]

  grunt.registerTask "test", [
    "clean:server",
    "coffee",
    "createDefaultTemplate",
    "handlebars",
    "compass",
    "connect:test",
    "mocha"
  ]

  grunt.registerTask "build", [
    "clean:dist",
    "coffee",
    "createDefaultTemplate",
    "handlebars",
    "compass:dist",
    "copy:lib",
    "symlink",
    "useminPrepare",
    "requirejs",
    "imagemin",
    "htmlmin",
    "concat",
    "cssmin",
    "uglify",
    "copy",
    "rev",
    "usemin"
  ]

  grunt.registerTask "default", [
    "jshint",
    "test",
    "build"
  ]
