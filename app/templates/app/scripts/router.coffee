NavbarView  = require './views/navbar.coffee'
LandingView = require './views/landing.coffee'

# Defining the application router, you can attach sub routers here.
Router = Backbone.Router.extend
  routes:
    '': 'index'

  initialize: ({@app}) ->
    unless @app?
      throw new Error('must provide app to Router')

    # set the application layout and attach views that are always present
    @app.useLayout 'layout'
    @app.layout.setView('#navbar', new NavbarView()).render()

  index: ->
    @app.layout.setView('#content',  new LandingView()).render()

module.exports = Router
