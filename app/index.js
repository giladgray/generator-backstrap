'use strict';
var util = require('util');
var path = require('path');
var yeoman = require('yeoman-generator');

var BackstrapGenerator = module.exports = function BackstrapGenerator(args, options, config) {
  yeoman.generators.Base.apply(this, arguments);

  this.on('end', function () {
    this.installDependencies({ skipInstall: options['skip-install'] });
  });

  this.pkg = JSON.parse(this.readFileAsString(path.join(__dirname, '../package.json')));
};

util.inherits(BackstrapGenerator, yeoman.generators.Base);

BackstrapGenerator.prototype.askFor = function askFor() {
  var cb = this.async();

  // have Yeoman greet the user.
  console.log(this.yeoman);

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

    cb();
  }.bind(this));
};

// create root-level project files
BackstrapGenerator.prototype.projectfiles = function projectfiles() {
  this.copy('bowerrc', '.bowerrc');
  this.copy('jshintrc', '.jshintrc');
  this.copy('gitignore', '.gitignore');
  this.copy('editorconfig', '.editorconfig');
  this.copy('Gruntfile.coffee', 'Gruntfile.coffee');
  this.template('_package.json', 'package.json');
  this.template('_bower.json', 'bower.json');
};

// create app folder and top-level files (index.html, etc)
BackstrapGenerator.prototype.app = function app() {
  this.mkdir('app');
  this.copy('app/favicon.ico', 'app/favicon.ico')
  this.copy('app/robots.txt', 'app/robots.txt')
  this.template('app/_index.html', 'app/index.html')
  this.template('app/_404.html', 'app/404.html')

  this.mkdir('app/images');
};

// create scripts folder and basic backbone+requirejs app
BackstrapGenerator.prototype.scripts = function scripts() {
  // root-level files
  this.mkdir('app/scripts');
  this.copy('app/scripts/main.coffee',    'app/scripts/main.coffee');
  this.copy('app/scripts/plugins.coffee', 'app/scripts/plugins.coffee');
  this.copy('app/scripts/router.coffee',  'app/scripts/router.coffee');
  this.template('app/scripts/_app.coffee',     'app/scripts/app.coffee');
  this.template('app/scripts/_config.coffee',  'app/scripts/config.coffee');

  // backbone models directory
  this.mkdir('app/scripts/models');

  // backbone views directory
  this.mkdir('app/scripts/views');
  this.copy('app/scripts/views/landing.coffee', 'app/scripts/views/landing.coffee')
  this.copy('app/scripts/views/navbar.coffee',  'app/scripts/views/navbar.coffee')
};

BackstrapGenerator.prototype.templates = function templates() {
  this.mkdir('app/templates');
  this.template('app/templates/_landing.hbs', 'app/templates/landing.hbs')
  this.template('app/templates/_navbar.hbs',  'app/templates/navbar.hbs')
  this.mkdir('app/templates/layouts');
  this.copy('app/templates/layouts/layout.hbs', 'app/templates/layouts/layout.hbs');
}

// create styles folder
BackstrapGenerator.prototype.styles = function styles() {
  this.mkdir('app/styles');
  this.copy('app/styles/main.sass', 'app/styles/main.sass')

  this.mkdir('app/styles/fonts');
}
