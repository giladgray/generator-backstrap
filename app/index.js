'use strict';
var yeoman = require('yeoman-generator');

module.exports = yeoman.generators.Base.extend({
  prompting: function() {
    var done = this.async();

    this.log('Welcome to Backstrap. Let\'s get your app strapped, shall we?')

    var prompts = [{
      name: 'appName',
      message: 'What shall we call this bad boy?'
    }, {
      type: 'confirm',
      name: 'useParse',
      message: 'Use Parse JS SDK instead of Backbone?',
      default: false
    }];

    this.prompt(prompts, function (props) {
      this.appName = props.appName;
      this.useParse = props.useParse || false;
      this.framework = this.useParse ? 'parse' : 'backbone'

      done();
    }.bind(this));
  },
  configuring: function() {
    this.copy('bowerrc', '.bowerrc');
    this.copy('gitignore', '.gitignore');
    this.copy('editorconfig', '.editorconfig');
    this.copy('Gruntfile.coffee', 'Gruntfile.coffee');
    this.copy('sublime.sublime-project', this.appName + '.sublime-project');
    this.template('_package.json', 'package.json');
    this.template('_bower.json', 'bower.json');
  },
  writing: {
    app: function() {
      this.mkdir('app');
      this.copy('app/favicon.ico', 'app/favicon.ico')
      this.copy('app/robots.txt', 'app/robots.txt')
      this.template('app/_index.html', 'app/index.html')
      this.template('app/_404.html', 'app/404.html')

      this.mkdir('app/images');
    },
    scripts: function() {
      // root-level files
      this.mkdir('app/scripts');
      this.copy('app/scripts/index.coffee',    'app/scripts/index.coffee');
      this.copy('app/scripts/plugins.coffee',  'app/scripts/plugins.coffee');
      this.copy('app/scripts/router.coffee',   'app/scripts/router.coffee');
      this.template('app/scripts/_app.coffee', 'app/scripts/app.coffee');

      // backbone models directory
      this.mkdir('app/scripts/models');

      // backbone views directory
      this.mkdir('app/scripts/views');
      this.copy('app/scripts/views/landing.coffee', 'app/scripts/views/landing.coffee')
      this.copy('app/scripts/views/navbar.coffee',  'app/scripts/views/navbar.coffee')
    },
    templates: function() {
      this.mkdir('app/templates');
      this.template('app/templates/_landing.hbs', 'app/templates/landing.hbs')
      this.template('app/templates/_navbar.hbs',  'app/templates/navbar.hbs')

      this.mkdir('app/templates/layouts');
      this.copy('app/templates/layouts/layout.hbs', 'app/templates/layouts/layout.hbs');
    },
    styles: function() {
      this.mkdir('app/styles');
      this.copy('app/styles/main.sass', 'app/styles/main.sass')

      this.mkdir('app/styles/fonts');
    }
  },
  install: function() {
    this.installDependencies()
    console.log(this.appname, this.framework)
  }
});
