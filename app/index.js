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
  writing: function() {
    this.directory('app', 'app')

    this.mkdir('app/scripts/models')
    this.mkdir('app/styles/fonts')
  },
  install: function() {
    this.installDependencies({ skipInstall: this.options['skip-install'] });
  }
});
