# Django static generator

[Yeoman](http://yeoman.io) generator that equips an existing Django app with scaffolding for a
modern front-end workflow, with [Grunt](http://gruntjs.com)-fuelled tasks and
[Bower](http://bower.io)-powered dependecy management.

## Features

* **Libsass** *Blazing* fast sass compilation
* **Autoprefixer** No need to hand-write vendor-specific css prefixes
* **CoffeeScript** Compiles your coffeescript to javascript
* **Sandbox** Write your front-end code free of the Django back-end
* **LiveReload** Instant feedback while you code

## Directory Structure

```
└─ django-app
   └─ static
      ├─ bower_components
      ├─ django-app
      │  └─ README.md
      └─ django-app-development
         ├─ img
         ├─ scripts
         │  ├─ controllers
         │  ├─ models
         │  ├─ routers
         │  ├─ templates
         │  └─ views
         ├─ styles
         ├─ .bowerrc
         ├─ .jshintrc
         ├─ bower.json
         ├─ Gruntfile.coffee
         ├─ package.json
         └─ sandbox.html
```

## Getting Started

You already have a django application, and you want to outfit it for a modern front-end workflow.
This is the generator for you.

### Installation

Because it's not as “end-to-end” as I'd like, generator-dj-static isn't an npm yet. If you want to
try it out, you'll need to clone this repo and link to your global npm manually.

`git clone https://github.com/JorgenHookham/generator-dj-static`
`cd generator-dj-static`
`npm link`

### Usage

Change directory into your django app and tap Yeoman on the shoulder.

`cd <djangoproject>/django-app/`
`yo dj-static`

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
