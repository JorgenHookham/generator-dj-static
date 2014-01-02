'use strict';
var util = require('util');
var path = require('path');
var yeoman = require('yeoman-generator');


var DjangoAppGenerator = module.exports = function DjangoAppGenerator(args, options, config) {
  yeoman.generators.Base.apply(this, arguments);

  this.on('end', function () {
    process.chdir(this.appName+'/static/'+this.appName+'-development');
    this.installDependencies({ skipInstall: options['skip-install'] });
  });

  this.pkg = JSON.parse(this.readFileAsString(path.join(__dirname, '../package.json')));
};

util.inherits(DjangoAppGenerator, yeoman.generators.Base);

DjangoAppGenerator.prototype.welcome = function welcome() {
  var cb = this.async();

  // have Yeoman greet the user.
  console.log(this.yeoman);

  var prompts = [{
    name: 'appName',
    message: 'What do you want to call your app?'
  },{
    name: 'appDescription',
    message: 'What does your app do?'
  },{
    name: 'appAuthor',
    message: 'What\'s the name of the person in charge of this app?'
  }];

  this.prompt(prompts, function (props) {
    this.appName = props.appName;
    this.appDescription = props.appDescription;
    this.appAuthor = props.appAuthor;

    cb();
  }.bind(this));
};

DjangoAppGenerator.prototype.askForCoffee = function welcome() {
  var cb = this.async();

  var prompts = [{
    type: 'confirm',
    name: 'coffee',
    message: 'Would you like to use coffeescript?',
    default: false
  }];

  this.prompt(prompts, function (props) {
    this.coffee = props.coffee;

    cb();
  }.bind(this));
};

DjangoAppGenerator.prototype.app = function app() {
  var appName = this.appName;
  var appDescription = this.appDescription;
  var appAuthor = this.appAuthor;
  this.mkdir(appName);
  this.mkdir(appName+'/templates');
  this.mkdir(appName+'/static');
  this.mkdir(appName+'/static/'+appName);
  this.mkdir(appName+'/static/'+appName+'/scripts');
  this.mkdir(appName+'/static/'+appName+'/styles');
  this.mkdir(appName+'/static/'+appName+'-development');
  this.mkdir(appName+'/static/'+appName+'-development/img');
  this.mkdir(appName+'/static/'+appName+'-development/styles');
  this.mkdir(appName+'/static/'+appName+'-development/scripts');
  this.mkdir(appName+'/static/'+appName+'-development/scripts/models');
  this.mkdir(appName+'/static/'+appName+'-development/scripts/views');
  this.mkdir(appName+'/static/'+appName+'-development/scripts/controllers');
  this.mkdir(appName+'/static/'+appName+'-development/scripts/routers');
  this.mkdir(appName+'/static/'+appName+'-development/scripts/templates');
};

DjangoAppGenerator.prototype.gruntfile = function gruntfile() {
  var appName = this.appName;
  this.template('_Gruntfile.coffee', appName+'/static/'+appName+'-development/Gruntfile.coffee')
  this.template('_package.json', appName+'/static/'+appName+'-development/package.json');
  this.copy('_bower.json', appName+'/static/'+appName+'-development/bower.json');
}

DjangoAppGenerator.prototype.projectfiles = function projectfiles() {
  var appName = this.appName;
  this.copy('editorconfig', appName+'/static/'+appName+'-development/.editorconfig');
  this.copy('jshintrc', appName+'/static/'+appName+'-development/.jshintrc');
};
