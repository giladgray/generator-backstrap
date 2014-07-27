app    = require './app.coffee'
Router = require './router.coffee'
require './plugins.coffee'

# Configure LayoutManager with Backbone Boilerplate defaults.
Backbone.Layout.configure
  manage: true

  fetchTemplate: (path) ->
    # Handlebars pre-compiled templates make this about as easy as possible.
    # either the template exists and is ready to rock, or it doesn't and never will.
    console.error "unknown template '#{path}'" unless Templates[path]
    Templates[path]

# Define your master router on the application namespace and trigger all
# navigation from this instance.
app.router = new Router({app})

# Trigger the initial route but disable HTML5 History API support, set the
# root folder to '/' by default. Change in app.js.
# pushState does not play nice with Yeoman's connect server.
Backbone.history.start
  # pushState: true
  root: app.root

# All navigation that is relative should be passed through the navigate
# method, to be processed by the router. If the link has a `data-bypass`
# attribute, bypass the delegation completely.
$(document).on "click", "a:not([data-bypass])", (evt) ->
  # Get the absolute anchor href.
  href = $(this).attr("href")
  # If the href exists and is a hash route, run it through Backbone.
  if href and href.indexOf("#") is 0
    # Stop the default event to ensure the link will not cause a page refresh.
    evt.preventDefault()
    # `Backbone.history.navigate` is sufficient for all Routers and will
    # trigger the correct events. The Router's internal `navigate` method
    # calls this anyways.  The fragment is sliced from the root.
    Backbone.history.navigate href, true
