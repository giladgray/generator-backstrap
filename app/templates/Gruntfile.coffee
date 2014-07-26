"use strict"

_ = require 'lodash'

###
Installation commands:
npm install --save-dev grunt browserify coffeeify load-grunt-tasks time-grunt
npm install --save-dev grunt-browserify grunt-contrib-clean grunt-contrib-concat grunt-contrib-connect grunt-contrib-copy grunt-contrib-cssmin grunt-contrib-handlebars grunt-contrib-imagemin grunt-contrib-sass grunt-contrib-uglify grunt-contrib-watch grunt-gh-pages grunt-template grunt-usemin
###

# # Globbing
# for performance reasons we're only matching one level down:
# 'test/spec/{,*/}*.js'
# use this if you want to recursively match all subfolders:
# 'test/spec/**/*.js'
module.exports = (grunt, options) ->
  pkg = grunt.file.readJSON('package.json')

  # load all grunt tasks and time execution
  require('load-grunt-tasks') grunt
  require('time-grunt') grunt

  ###### PLUGIN CONFIGURATIONS ######
  grunt.initConfig
    options: options

    pkg: pkg

    # grunt-contrib-watch
    watch:
      browserify:
        files: 'app/scripts/{,*/}*.coffee'
        tasks: ['browserify:dev']
      handlebars:
        files: ['app/templates/{,*/}*.hbs']
        tasks: ['handlebars']
      sass:
        files: ['app/styles/{,*/}*.{scss,sass}']
        tasks: ['sass'] #, 'autoprefixer']
      livereload:
        options:
          livereload: '<%= connect.options.livereload %>'
        files: ['dist/**/*.{js,css,html,json,png}']

    clean:
      dist: ['dist']

    # grunt-browserify
    browserify:
      options:
        transform: ['coffeeify']
      dev:
        options:
          bundleOptions:
            debug: true # coffee sourcemaps!!!
        files:
          'dist/scripts/index.js': ['app/scripts/index.coffee']
      dist:
        files:
          'dist/scripts/index.js': ['app/scripts/index.coffee']

    # grunt-contrib-sass
    sass:
      dist:
        options:
          style: 'compact'
        files:
          'dist/styles/index.css': ['app/styles/**/*.{scss,sass}']

    # grunt-contrib-handlebars
    handlebars:
      dist:
        files:
          'dist/scripts/templates.js': ['app/templates/**/*.hbs']
        options:
          namespace: 'Templates'
          processName: (filename) ->
            filename.match(/templates\/(.+)\.h[bj]s$/)[1]

    # grunt-contrib-copy
    copy:
      dist:
        files: [
          {expand: true, cwd: 'app', src: ['styles/fonts/**'], dest: 'dist'},
        ]

    # grunt-contrib-imagemin
    imagemin:
      dist:
        expand: true
        cwd: 'app'
        src: ['images/*.png']
        dest: 'dist'

    # grunt-usemin
    useminPrepare:
      html: 'app/index.html'

    # grunt-usemin
    usemin:
      options:
        dirs: ['dist']
      html: ['dist/{,*/}*.html']

    # grunt-contrib-connect
    connect:
      options:
        port: 9000
        livereload: 35729
        # Change this to '0.0.0.0' to access the server from outside
        hostname: 'localhost'
      livereload:
        options:
          open: true
          base: ['app', 'dist']
      test:
        options:
          port: 9001
          base: ['app', 'dist', 'test']
      dist:
        options:
          open: true
          base: 'dist'
          livereload: false
      github:
        options:
          open: 'https://giladgray.github.io/<%= pkg.name %>'

    # grunt-gh-pages
    'gh-pages':
      options:
        base: 'dist'
      src: ['**']

  ######### TASK DEFINITIONS #########

  # compile assets for development
  grunt.registerTask 'build', 'compile assets for development', (target = 'dist') ->
    grunt.task.run [
      'clean'
      'sass'
      'handlebars'
      "browserify:#{target}"
      'copy'
    ]

  # build, dev server, watch
  grunt.registerTask 'dev', [
    'build:dev'
    'connect:livereload'
    'watch'
  ]

  # compress and obfuscate files for production
  grunt.registerTask 'minify', [
    'imagemin'
    'useminPrepare'
    'concat'
    'uglify'
    'cssmin'
    'usemin'
  ]

  # build, minify, copy production assets
  grunt.registerTask 'dist', [
    'build:dist',
    'copy',
    'minify',
    'connect:dist:keepalive'
  ]

  # publish dist/ directory to github and open page
  grunt.registerTask 'deploy', [
    'gh-pages'
    'connect:github'
  ]

  grunt.registerTask 'default', ['dev']
