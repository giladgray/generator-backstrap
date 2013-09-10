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
    message: 'What is the name of your app?'
  }];

  this.prompt(prompts, function (props) {
    this.appName = props.appName;

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

// create app folder and root-level files (index.html, etc)
BackstrapGenerator.prototype.app = function app() {
  this.mkdir('app');
  this.copy('app/favicon.ico', 'app/favicon.ico')
  this.copy('app/robots.txt', 'app/robots.txt')
  this.template('app/_index.html', 'app/index.html')
  this.template('app/_404.html', 'app/404.html')

  this.mkdir('app/images');
  this.mkdir('app/styles');
  this.mkdir('app/styles/fonts');
  this.mkdir('app/templates');
};

// create scripts folder and basic backbone+requirejs app
BackstrapGenerator.prototype.scripts = function scripts() {
  this.mkdir('app/scripts');
  this.mkdir('app/scripts/lib');
  this.mkdir('app/scripts/models');
  this.mkdir('app/scripts/views');

};
