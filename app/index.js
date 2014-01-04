'use strict';
var util = require('util');
var path = require('path');
var yeoman = require('yeoman-generator');


var DjangoAppGenerator = module.exports = function DjangoAppGenerator(args, options, config) {
  yeoman.generators.Base.apply(this, arguments);

  this.on('end', function () {
    process.chdir('static/'+this.appName+'-development');
    this.installDependencies({
      skipInstall: options['skip-install'],
      callback: function () {
        var appName = this.appName;
        console.log(
          '\nYou are ready to get coding!\n' +
          'run this: cd static/'+appName+'-development && grunt develop\n'
        );
      }.bind(this)
    });
  });

  this.pkg = JSON.parse(this.readFileAsString(path.join(__dirname, '../package.json')));
};

util.inherits(DjangoAppGenerator, yeoman.generators.Base);

DjangoAppGenerator.prototype.welcome = function welcome() {
  var cb = this.async();

  // have Yeoman greet the user.
  console.log(this.yeoman);

  console.log(
    '\n'+
    'We\'re about to scaffold an existing Django app with static files for a\n'+
    'Grunt-fuelled workflow and Bower-powered dependecy management.\n'+
    '\n'+
    'Before you proceed, make sure that you are running this generator\n'+
    'from the root directory of an existing django app.\n'
  );

  var prompts = [{
    name: 'correctDirectory',
    type: 'confirm',
    message: 'Current directory is the root of an existing Django app',
    default: true
  }];

  this.prompt(prompts, function (props) {
    if (!props.correctDirectory) {
      this.exit();
    }

    cb();
  }.bind(this));
};

DjangoAppGenerator.prototype.askForAppDetails = function askForAppDetails() {
  var cb = this.async();

  var prompts = [{
    name: 'appName',
    message: 'App Name:',
    default: process.cwd().split('/').slice(-1)[0]
  },{
    name: 'appDescription',
    message: 'Description:'
  },{
    name: 'appAuthor',
    message: 'Author:'
  }];

  this.prompt(prompts, function (props) {
    this.appName = props.appName;
    this.appDescription = props.appDescription;
    this.appAuthor = props.appAuthor;

    cb();
  }.bind(this));
};

DjangoAppGenerator.prototype.askForBowerComponents = function askForBowerComponents() {
  var cb = this.async();

  var prompts = [{
    type: 'checkbox',
    name: 'bowerComponents',
    message: 'Which Bower components would you like?',
    choices: [
      {name: '...', value: '', checked: true},
      {name: 'backbone', value: 'backbone', checked: true}
    ]
  }];

  this.prompt(prompts, function (props) {
    this.bowerComponents = props.bowerComponents;

    cb();
  }.bind(this));
};

DjangoAppGenerator.prototype.askForGruntTasks = function askForGruntTasks() {
  var cb = this.async();

  var prompts = [{
    type: 'checkbox',
    name: 'gruntTasks',
    message: 'Which Grunt tasks would you like?',
    choices: [
      {name: 'css autoprefixer', value: 'autoprefixer', checked: true},
      {name: 'coffeescript compiler', value: 'coffee', checked: true},
      {name: 'sass compiler', value: 'sass', checked: true}
    ]
  }];

  this.prompt(prompts, function (props) {
    this.gruntTasks = props.gruntTasks;

    cb();
  }.bind(this));
};

DjangoAppGenerator.prototype.askForUnitTesting = function askForUnitTesting() {
  var cb = this.async();

  var prompts = [{
    type: 'confirm',
    name: 'unitTesting',
    message: 'Would you like support for javascript unit testing using Jasmine?'
  }];

  this.prompt(prompts, function (props) {
    this.unitTesting = props.unitTesting;

    cb();
  }.bind(this));
};

DjangoAppGenerator.prototype.app = function app() {
  var appName = this.appName;
  var appDescription = this.appDescription;
  var appAuthor = this.appAuthor;
  this.mkdir('static');
  this.mkdir('static/'+appName);
  this.mkdir('static/'+appName+'-development');
  this.mkdir('static/'+appName+'-development/img');
  this.mkdir('static/'+appName+'-development/styles');
  this.mkdir('static/'+appName+'-development/scripts');
  this.mkdir('static/'+appName+'-development/scripts/models');
  this.mkdir('static/'+appName+'-development/scripts/views');
  this.mkdir('static/'+appName+'-development/scripts/controllers');
  this.mkdir('static/'+appName+'-development/scripts/routers');
  this.mkdir('static/'+appName+'-development/scripts/templates');
  this.copy('_static-README.md', 'static/'+appName+'/README.md');
};

DjangoAppGenerator.prototype.bower = function bower() {
  var appName = this.appName;
  var bowerComponents = this.bowerComponents;
  this.template('_bower.json', 'static/'+appName+'-development/bower.json');
  this.copy('_.bowerrc', 'static/'+appName+'-development/.bowerrc');
};

DjangoAppGenerator.prototype.gruntfile = function gruntfile() {
  var appName = this.appName;
  var gruntTasks = this.gruntTasks;
  this.template('_Gruntfile.coffee', 'static/'+appName+'-development/Gruntfile.coffee')
  this.template('_package.json', 'static/'+appName+'-development/package.json');
}

DjangoAppGenerator.prototype.projectfiles = function projectfiles() {
  var appName = this.appName;
  this.copy('jshintrc', 'static/'+appName+'-development/.jshintrc');
};
