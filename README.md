# Django static generator

[Yeoman](http://yeoman.io) generator that scaffolds an existing Django app with
static files for a [Grunt](http://gruntjs.com)-fuelled workflow and
[Bower](http://bower.io)-powered dependecy management.

## Features
* SASS Compilation
* CSS Autoprefixing
* Coffeescript Compilation
* JS Linting

## Directory
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
         └─ package.json
```

## Getting Started
You already have a django application, and you want to outfit it for a modern
front-end workflow. This is the generator for you.

### Installation
Because it's still pretty experimental, generator-dj-static isn't an npm yet.
If you want to try it out, you'll need to clone this repo and link it up manually.

### Usage
Change directory into your django app and tap Yeoman on the shoulder.

```
cd <djangoproject>/django-app/
```

```
yo dj-static
```

## License

[MIT License](http://en.wikipedia.org/wiki/MIT_License)
