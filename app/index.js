'use strict';
var util = require('util');
var path = require('path');
var yeoman = require('yeoman-generator');


var DjangoAppGenerator = module.exports = function DjangoAppGenerator(args, options, config) {
  yeoman.generators.Base.apply(this, arguments);

  this.on('end', function () {
    process.chdir('static/'+this.appname+'-development');
    this.installDependencies({
      skipInstall: options['skip-install'],
      callback: function () {
        var appname = this.appname;
        console.log(
          '\nYou are ready to get coding!\n' +
          'run this: cd static/'+appname+'-development && grunt serve\n'
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
    name: 'appname',
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
    this.appname = props.appname;
    this.appDescription = props.appDescription;
    this.appAuthor = props.appAuthor;

    cb();
  }.bind(this));
};

DjangoAppGenerator.prototype.askForCoffee = function askForCoffee() {
  var cb = this.async();

  var prompts = [{
    name: 'coffee',
    type: 'confirm',
    message: 'Would you like to use coffeescript?',
    default: true
  }];

  this.prompt(prompts, function (props) {
    this.coffee = props.coffee;

    cb();
  }.bind(this));
};

DjangoAppGenerator.prototype.askForSandbox = function askForSandbox() {
  var cb = this.async();

  var prompts = [{
    name: 'sandbox',
    type: 'confirm',
    message: 'Would you like a sandbox for pure and simple front-end development, without a Django back-end?',
    default: true
  }];

  this.prompt(prompts, function (props) {
    this.sandbox = props.sandbox;

    cb();
  }.bind(this));
};

DjangoAppGenerator.prototype.scaffoldApp = function scaffoldApp() {
  var appname = this.appname;
  var appDescription = this.appDescription;
  var appAuthor = this.appAuthor;
  this.mkdir('static');
  this.mkdir('static/'+appname);
  this.mkdir('static/'+appname+'-development');
  this.mkdir('static/'+appname+'-development/img');
  this.mkdir('static/'+appname+'-development/styles');
  this.mkdir('static/'+appname+'-development/scripts');
  this.copy('_static-README.md', 'static/'+appname+'/README.md');
};

DjangoAppGenerator.prototype.makeSandbox = function makeSandbox() {
  if (this.sandbox) {
    var appname = this.appname;
    this.template('_sandbox.html', 'static/'+appname+'-development/sandbox.html');
    this.template('_sandbox.coffee', 'static/'+appname+'-development/scripts/sandbox.coffee');
  }
};

DjangoAppGenerator.prototype.makeBower = function makeBower() {
  var appname = this.appname;
  var bowerComponents = this.bowerComponents;
  this.template('_bower.json', 'static/'+appname+'-development/bower.json');
  this.copy('_.bowerrc', 'static/'+appname+'-development/.bowerrc');
};

DjangoAppGenerator.prototype.makeGruntfile = function makeGruntfile() {
  var appname = this.appname;
  var gruntTasks = this.gruntTasks;
  this.template('_Gruntfile.coffee', 'static/'+appname+'-development/Gruntfile.coffee')
  this.template('_package.json', 'static/'+appname+'-development/package.json');
}

DjangoAppGenerator.prototype.makeOther = function makeOther() {
  var appname = this.appname;
  this.copy('jshintrc', 'static/'+appname+'-development/.jshintrc');
  this.template('_.gitignore', 'static/.gitignore');
};
