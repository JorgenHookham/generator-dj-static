require.config

  paths:
    bower: '../../bower_components'
    text: '../../bower_components/requirejs-text/text'


define [], () ->

  ###
  Fire up the sandbox
  ###

  window.app = app = {}

  app.init = -> console.log 'App is up and running!', Backbone

  app.init()
