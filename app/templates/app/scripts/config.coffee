# Set the require.js configuration for your application.
require.config
  # Initialize the application with the main application file.
  deps: ['main']

  paths:
    # Libraries
    backbone: '../bower_components/backbone-amd/backbone'
    bootstrap: '../scripts/lib/bootstrap'
    handlebars: '../bower_components/handlebars/handlebars.runtime'
    jquery: '../bower_components/jquery/jquery'
    layoutmanager: '../bower_components/layoutmanager-amd/backbone.layoutmanager'
    text: '../bower_components/requirejs-text/text'
    underscore: '../bower_components/underscore-amd/underscore'

  # fix things that don't support AMD
  shim:
    handlebars:
      exports: 'Handlebars'
      init: ->
        @Handlebars = Handlebars
    parse:
      exports: 'Parse'
