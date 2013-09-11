# all the top-level dependencies go here. simply requiring 'app' will give you all these libraries.
define ['underscore', 'jquery', 'backbone', 'layoutmanager', 'plugins'], (_, $, Backbone) ->
  "use strict"
<% if (useParse) { %>
  # Initialize Parse SDK with your application keys, available from Settings on Parse.com
  Parse.initialize('PARSE_APPLICATION_ID', 'PARSE_JAVASCRIPT_KEY')

  # Test that Parse API is working properly. Delete this block before prime-time.
  TestObject = Parse.Object.extend("TestObject");
  testObject = new TestObject();
  testObject.save { foo: "bar" },
    success: (object) -> alert("yay! it worked")
<% } %>
  # Provide a global location to place configuration settings and module creation.
  app = root: "/"

  # Mix Backbone.Events, modules, and layout management into the app object.
  _.extend app, Backbone.Events,
    # Create a custom object with a nested Views object.
    module: (additionalProps) ->
      _.extend Views: {}, additionalProps

    # Helper for using layouts.
    useLayout: (name) ->
      # If already using this Layout, then don't re-inject into the DOM.
      return @layout  if @layout and @layout.options.template is "layouts/#{name}"
      # If a layout already exists, remove it from the DOM.
      @layout.remove()  if @layout
      # Create a new Layout.
      layout = new Backbone.Layout
        template: "layouts/#{name}"
        className: "layout #{name}"
        id: "layout"
      # Insert into the DOM.
      $("#main").empty().append layout.el
      # Render the layout.
      layout.render()
      # Cache the reference.
      @layout = layout
      # Return the reference, for chainability.
      layout

