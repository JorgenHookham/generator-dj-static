require.config

  paths:
    bower: '../../bower_components'
    text: '../../bower_components/requirejs-text/text'
    jquery: '../../bower_components/jquery/jquery'
    underscore: '../../bower_components/underscore/underscore'
    backbone: '../../bower_components/backbone/backbone'

  shim:
    underscore:
      exports: '_'
    backbone:
      deps: ['jquery', 'underscore']
      exports: 'Backbone'


define [], () ->

  ###
  Fire up the sandbox
  ###

  window.app = app = {}

  app.init = -> console.log 'App is up and running!', Backbone

  app.init()
