/*global describe, beforeEach, it*/
'use strict';

var path    = require('path');
var helpers = require('yeoman-generator').test;
var assert  = require('yeoman-generator').assert;

describe('backstrap generator', function () {
  before(function (done) {
    helpers.run(path.join(__dirname, '../app'))
      .inDir(path.join(__dirname, './temp'))
      .withOptions({ skipInstall: true})
      .withPrompt({ appName: 'testing', useParse: false })
      .on('end', done)
  });

  it('creates expected files', function () {
    assert.file([
      '.bowerrc',
      '.editorconfig',
      '.gitignore',
      'bower.json',
      'package.json',
      'Gruntfile.coffee',
      'testing.sublime-project',

      'app/index.html',

      'app/scripts/app.coffee',
      'app/scripts/index.coffee',
      'app/scripts/router.coffee',
      'app/scripts/views/landing.coffee',
      'app/scripts/views/navbar.coffee',

      'app/styles/main.sass',

      'app/templates/landing.hbs',
      'app/templates/navbar.hbs',
      'app/templates/layouts/layout.hbs'
    ])
  });
});
