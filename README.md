# generator-backstrap [![Build Status](https://secure.travis-ci.org/giladgray/generator-backstrap.png?branch=master)](https://travis-ci.org/giladgray/generator-backstrap)

A [Yeoman](http://yeoman.io) generator for kickass [Backbone](http://backbonejs.org/), [Bootstrap](http://getbootstrap.com/), and [CoffeeScript](http://coffeescript.org)-powered apps

## What is Backstrap?

Backstrap is the silly portmanteau I've given to my client-side web framework/toolkit. This is the product of months of learning and experimentation with the included technologies.

A Backstrap application looks something like this:
* [Backbone](http://backbonejs.org/) JavaScript MVC framework with [LayoutManager](http://layoutmanager.org/) plugin
* Follows [Backbone Boilerplate](https://github.com/backbone-boilerplate/backbone-boilerplate) best practices
* [Bootstrap 3.0](http://getbootstrap.com/) front-end CSS+JS framework
* [Handlebars](http://handlebarsjs.com/) template engine
* Written primarily in [CoffeeScript](http://coffeescript.org)
* All wired up for [RequireJS](http://requirejs.org/) optimization
* Using [Grunt](http://gruntjs.com/) task runner to develop, build, and test
* Optionally deployed on [Parse](http://parse.com) backend-as-a-service

## Getting Started

```bash
# Install generator-backstrap
$ npm install -g generator-backstrap

# Run the generator
$ yo backstrap

# Maybe write some code?

# Launch development server
$ grunt server
# Launch production server
$ grunt server:dist

# Build app for deployment
$ grunt build

# Run tests
$ grunt test
```

