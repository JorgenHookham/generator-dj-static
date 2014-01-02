module.exports = (grunt) ->

  require('time-grunt')(grunt)

  #                     #
  # Directory Structure #
  #                     #

  appStatic   = '../<%= appName %>/'
  appStyles   = appStatic + 'styles/'
  appScripts  = appStatic + 'scripts/'
  appImages   = appStatic + 'images/'

  appFiles =
    styles:
      expand  : true
      cwd     : appStyles
      src     : ['**/*']
      dest    : appStyles
    scripts:
      expand  : true
      cwd     : appScripts
      src     : ['**/*']
      dest    : appScripts
    images:
      expand  : true
      cwd     : appImages
      src     : ['**/*']
      dest    : appImages
    other:
      expand  : true
      cwd     : appStatic
      src     : [
        '**/*'
        '!<%%= appStyles %>**/*'
        '!<%%= appScripts %>**/*'
        '!<%%= appImages %>**/*'
        '!README.md'
      ]
      dest    : appStatic

  devStatic  = './'
  devStyles  = devStatic + 'styles/'
  devScripts = devStatic + 'scripts/'
  devImages  = devStatic + 'images/'

  devFiles =
    sass:
      expand  : true
      cwd     : devStyles
      src     : ['**/*.{sass,scss}']
      dest    : appStyles
      ext     : '.css'
    css:
      expand  : true
      cwd     : devStyles
      src     : ['**/*.css']
      dest    : appStyles
    coffee:
      expand  : true
      cwd     : devScripts
      src     : ['**/*.coffee']
      dest    : appScripts
      ext     : '.js'
    js:
      expand  : true
      cwd     : devScripts
      src     : ['**/*.js']
      dest    : appScripts
      ext     : '.js'
    images:
      expand  : true
      cwd     : devImages
      src     : ['**/*.{jpg,jpeg,png,gif}']
      dest    : appImages
    other:
      expand  : true
      cwd     : devStatic
      src     : [
        '**/*'
        '!<%%= devStyles %>**/*'
        '!<%%= devScripts %>**/*'
        '!<%%= devImages %>**/*'
        '!node_modules/**/*'
      ]
      dest    : appStatic

  #         #
  # Plugins #
  #         #

  [
    'grunt-autoprefixer'
    'grunt-contrib-clean'
    'grunt-contrib-coffee'
    'grunt-contrib-copy'
    'grunt-contrib-jshint'
    'grunt-contrib-watch'
    'grunt-newer'
    'grunt-sass'
  ].forEach(grunt.loadNpmTasks)

  #        #
  # Config #
  #        #

  grunt.initConfig {

    pkg: grunt.file.readJSON 'package.json'

    sass:
      development:
        options: {outputStyle: 'nested'}
        files: [devFiles.sass]
      production:
        options: {outputStyle: 'compressed'}
        files: [devFiles.sass]

    autoprefixer:
      static: appFiles.styles

    jshint:
      js:
        options: {jshintrc: '.jshintrc'}
        files: [devFiles.js]

    coffee:
      development:
        options: {sourceMap: true}
        files: [devFiles.coffee]
      production:
        files: [devFiles.coffee]

    copy:
      css     : {files: [devFiles.css]}
      js      : {files: [devFiles.js]}
      images  : {files: [devFiles.images]}
      other   : {files: [devFiles.other]}
      all:
        files: [devFiles.css, devFiles.js, devFiles.images, devFiles.other]

    clean:
      styles  : {files: [appFiles.styles]}
      scripts : {files: [appFiles.scripts]}
      images  : {files: [appFiles.images]}
      other   : {files: [appFiles.other]}
      static:
        options : {force: true}
        files   : [
          appFiles.styles
          appFiles.scripts
          appFiles.images
          appFiles.other
        ]

    watch:
      sass:
        options : {cwd: devStyles}
        files   : ['**/*.{scss,sass}']
        tasks   : ['newer:sass:development', 'newer:autoprefixer']
      css:
        options : {cwd: devStyles}
        files   : ['**/*.css']
        tasks   : ['newer:copy:css', 'newer:autoprefixer']
      coffee:
        options : {cwd: devScripts}
        files   : ['**/*.coffee']
        tasks   : ['newer:coffee:development']
      js:
        options : {cwd: devScripts}
        files   : ['**/*.js']
        tasks   : ['newer:jshint:js', 'newer:copy:js']

  }

  #       #
  # Tasks #
  #       #

  grunt.registerTask 'develop',
  'everything you need to start writing code', [
    'build:development'
    'watch'
  ]

  # Unit testing
  grunt.registerTask 'test', 'run unit tests in the console', []
  grunt.registerTask 'test:browser', 'run unit tests in a browser', []

  # Building static files
  grunt.registerTask 'build:production',
  'build static files for a production environment', [
    #
  ]

  grunt.registerTask 'build:development',
  'build static files for a development environment', [
    'clean:static'
    'sass:development'
    'copy:css'
    'autoprefixer:static'
    'coffee:development'
    'jshint:js'
    'copy:js'
  ]

  grunt.registerTask 'default', ['develop']

  # § #








