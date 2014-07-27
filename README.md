# generator-backstrap [![Build Status](https://secure.travis-ci.org/giladgray/generator-backstrap.png?branch=master)](https://travis-ci.org/giladgray/generator-backstrap)

A [Yeoman](http://yeoman.io) generator for kickass [Backbone](http://backbonejs.org/), [Bootstrap](http://getbootstrap.com/), and [CoffeeScript](http://coffeescript.org)-powered apps

## What is Backstrap?

Backstrap is the silly portmanteau I've given to my client-side web framework/toolkit. This is the product of months of learning and experimentation with the included technologies.

A Backstrap application looks something like this:
* [Backbone](http://backbonejs.org/) JavaScript MVC framework with [LayoutManager](http://layoutmanager.org/) plugin
* Follows [Backbone Boilerplate](https://github.com/backbone-boilerplate/backbone-boilerplate) best practices
* [Bootstrap 3.0](http://getbootstrap.com/) front-end CSS+JS framework
* [Sass](http://sass-lang.com) CSS preprocessor
* [Handlebars](http://handlebarsjs.com/) template engine
* Written primarily in [CoffeeScript](http://coffeescript.org)
* All wired up for [Browserify](http://browserify.org/) optimization
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
$ grunt
# Launch production server
$ grunt dist

# Deploy app to GitHub Pages
$ grunt deploy

# Run tests
$ grunt test
```

## Workflow

### Grunt Targets
* **`grunt build`**: compile sources (Coffee, Sass, templates) from `app/` to `dist/`
* **`grunt dev` &rArr; `grunt`**: compile source and launch a development server that watches changes and reloads the browser
* **`grunt minify`**: optimize and obfuscate compiled source files for production (run `grunt build` first)
* **`grunt dist`**: build and minify source code in `dist/`, copy production assets, and launch a static production preview server
* **`grunt deploy`**: upload production source to your project's GitHub Page (`http://<username>.github.io/<project>`)

### Common Workflow
Generally, you'll run `grunt dev` (or simply `grunt` for convenience) while you develop. This command launches the development server which watches for changes to source files and recompiles and reloads intelligently.

When you're ready to deploy a new version, you'll run `grunt dist` to test the compiled code. This command launches a preview server so you can interact with the compiled code. It does not watch for changes so any fixes will likely require some more `grunt dev`. Once you are satisfied with your updates, you can run `grunt deploy` to upload the contents of the `dist/` directory to a GitHub Page.

## Technologies
The Backstrap Grunt workflow comes with an opinionated set of web technologies.

**[CoffeeScript](http://coffeescript.org)** is "a little language that compiles into JavaScript." It merges the power, flexibility, and portability of JavaScript with the pure joy of developer-friendly scripting languages like Ruby and Python. It augments basic JavaScript syntax with a whitespace-sensitive syntax, Python-style comprehensions, simpler English keywords, and a useful `class` structure with basic inheritance. You're going to love it.

**[Browserify](http://browserify.org/)** lets you `require('modules')` in the browser just like in Node, and bundles all your dependencies effortlessly. This workflow uses Browserify to perform the CoffeeScript compilation and to bundle all your source files for the client.

**[Sass](http://sass-lang.com)** is "the most mature, stable, and powerful professional grade CSS extension language in the world." It's a CSS pre-processor (equivalent to LESS or Stylus) with a host of powerful features and an active developer community.

**[Handlebars](http://handlebarsjs.com/)** is "minimal templating on steroids." It's an incredibly simple languge for writing fast, reusable HTML templates. All your template files will be pre-compiled by Grunt and served to the browser in one simple file.
