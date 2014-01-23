# Django static generator

[Yeoman](http://yeoman.io) generator that equips an existing Django app for a
modern front-end workflow, with [Grunt](http://gruntjs.com)-fuelled tasks and
[Bower](http://bower.io)-powered dependecy management.

## Features

### Write stylesheets more easily
* **Libsass** *Blazing* fast sass compilation!!
* **Autoprefixer** No need to hand-write vendor-specific css prefixes
* **Zurb Foundation 5** A responsive foundation to build on

### Write coffeescript, if you want to
* **Optional CoffeeScript** Compiles your coffeescript to javascript
* **Source Maps** Work with your coffeescript source files in the browser

### Your own front-end development sandbox, if you like
* **Optional Sandbox** Write your front-end code free of the Django back-end

### Backbone
* **Backbonejs**
* **Requirejs**

## Directory Structure

```
└─ django-app
   └─ static
      ├─ bower_components
      ├─ django-app
      │  └─ README.md
      ├─ django-app-development
      │  ├─ img
      │  ├─ scripts
      │  │  ├─ controllers
      │  │  ├─ models
      │  │  ├─ routers
      │  │  ├─ templates
      │  │  ├─ views
      │  │  └─ sandbox.coffee
      │  ├─ styles
      │  ├─ .bowerrc
      │  ├─ .jshintrc
      │  ├─ bower.json
      │  ├─ Gruntfile.coffee
      │  ├─ package.json
      │  └─ sandbox.html
      └─ .gitignore
```

## Getting Started

You already have a django application, and you want to outfit it for a modern front-end workflow.
This is the generator for you.

### Installation

Because it's not as “end-to-end” as I'd like, generator-dj-static isn't an npm yet. If you want to
try it out, you'll need to clone this repo and link to your global npm manually.

```
git clone https://github.com/JorgenHookham/generator-dj-static
```
```
cd generator-dj-static
```
```
npm link
```

### Usage

Change directory into your django app and tap Yeoman on the shoulder.

```
cd <djangoproject>/django-app/
```
```
yo dj-static
```

### Prompts

## Potential Next Features

Any of these features are theoretically compatible with the generator-dj-static, but they're not
integrated yet. Feel free to pick your own poison.

### Workflow Tasks

* Testing
* JavaScript linting
* Automatic wiring of Bower components

### Frameworks

* Foundation
* Bootstrap 3
* Requirejs
* Backbone
* Angular
* Ember

### Build Tasks

* Requirejs optimization
* Minification
* Concatenation
* File revisioning

## License

[MIT License](http://en.wikipedia.org/wiki/MIT_License)
