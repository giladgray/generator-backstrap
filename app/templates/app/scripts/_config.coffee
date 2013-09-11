# Set the require.js configuration for your application.
require.config
  # Initialize the application with the main application file.
  deps: ['main']

  # Libraries
  paths:
    backbone: '../bower_components/<%= useParse ? "parse-js-sdk-bbb/lib/parse" : "backbone-amd/backbone" %>'
    bootstrap: '../bower_components/bootstrap-sass/js'
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
  <% if (useParse) { %>
    # A dirty little trick where we pretend Parse is actually Backbone,
    # so the LayoutManager doesn't get confused. You can use either the
    # Parse or Backbone object in your app, although we'll continue to
    # call it Backbone in this generator.
    backbone:
        exports: 'Parse'
        init: ->
            @Backbone = Parse
            @Backbone.Model = Parse.Object
            @Backbone
  <% } %>
