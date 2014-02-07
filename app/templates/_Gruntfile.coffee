module.exports = (grunt) ->

  # Add these?
  # jasmine, combing, documentation

  # Load grunt tasks automatically
  require('load-grunt-tasks')(grunt)

  # Time how long tasks take. Can help when optimizing build times
  require('time-grunt')(grunt)

  # Define configuration for all the tasks
  grunt.initConfig {

    # Project files
    # 'Cause Django's static file system is a funky fun time
    project:
      app:
        static  : '../<%= appname %>'
        styles  : '<%%= project.app.static %>/styles'
        scripts : '<%%= project.app.static %>/scripts'
        images  : '<%%= project.app.static %>/images'
      dev:
        static  : '.'
        styles  : '<%%= project.dev.static %>/styles'
        scripts : '<%%= project.dev.static %>/scripts'
        images  : '<%%= project.dev.static %>/images'

    # Watches files for changes and runs tasks based on the changed files
    watch:
      sass:
        options : {cwd: '<%%= project.dev.styles %>'}
        files   : ['**/*.{scss,sass}', '!**/_*.{scss,sass}']
        tasks   : ['newer:sass:dev', 'newer:autoprefixer']
      css:
        options : {cwd: '<%%= project.dev.styles %>'}
        files   : ['**/*.css']
        tasks   : ['newer:copy:css', 'newer:autoprefixer']
      <% if (coffee) { %>coffee:
        options : {cwd: '<%%= project.dev.scripts %>'}
        files   : ['**/*.coffee']
        tasks   : ['newer:coffee:development']<% } %>
      js:
        options : {cwd: '<%%= project.dev.scripts %>'}
        files   : ['**/*.js']
        tasks   : ['newer:jshint:js', 'newer:copy:js']
      html:
        options : {cwd: '<%%= project.dev.static %>'}
        files   : ['**/*.html']
        tasks   : ['copy:other']
      livereload:
        options:
          livereload: '<%%= connect.options.livereload %>'
        files: [
          '<%%= project.app.styles %>/**/*'
          '<%%= project.app.scripts %>/**/*'
          '<%%= project.app.images %>/**/*'
          '<%%= project.app.static %>/**/*.html'
        ]

    # Runs a simple server for front-end testing and/or development
    connect:
      options:
        port: 9000
        livereload: 35729
        hostname: 'localhost'
      livereload:
        options:
          open: 'http://<%%= connect.options.hostname %>:<%%= connect.options.port %>'
          base: ['<%%= project.app.static %>']
      <% if (sandbox) { %>sandbox:
        options:
          open: 'http://<%%= connect.options.hostname %>:<%%= connect.options.port %>/sandbox.html'
          base: [
            '<%%= project.app.static %>'
            '../'
          ]
      <% } %>
      test:
        options:
          port: 9001

    # Empties folders to start fresh
    clean:
      static:
        options : {force: true}
        files   : [{
          expand  : true
          cwd     : '<%%= project.app.static %>'
          src     : [
            '**/*'
            '!**/README.md'
          ]
        }]

    # Compiles sass to css
    sass:
      dev:
        options: {outputStyle: 'nested'}
        files: [{
          expand  : true
          cwd     : '<%%= project.dev.styles %>'
          src     : ['**/*.{sass,scss}']
          dest    : '<%%= project.app.styles %>'
          ext     : '.css'
        }]

    # Adds vendor prefixes to stylesheets
    autoprefixer:
      static:
        expand  : true
        cwd     : '<%%= project.app.styles %>'
        src     : ['**/*.css']
        dest    : '<%%= project.app.styles %>'

    # Checks for common js errors and syntax
    jshint:
      js:
        options: {jshintrc: '.jshintrc'}
        files: [{
          expand  : true
          cwd     : '<%%= project.dev.scripts %>'
          src     : ['**/*.js']
          dest    : '<%%= project.app.scripts %>'
          ext     : '.js'
        }]

    <% if (coffee) { %>
    # Compiles coffeescript to javascript
    coffee:
      development:
        options: {sourceMap: true}
        files: [{
          expand  : true
          cwd     : '<%%= project.dev.scripts %>'
          src     : ['**/*.coffee']
          dest    : '<%%= project.app.scripts %>'
          ext     : '.js'
        }]
      production:
        files: [{
          expand  : true
          cwd     : '<%%= project.dev.scripts %>'
          src     : ['**/*.coffee']
          dest    : '<%%= project.app.scripts %>'
          ext     : '.js'
        }]
    <% } %>

    # Renames files for browser caching purposes
    rev:
      app:
        files: [{
          expand  : true
          cwd     : '<%%= project.app.static %>'
          src     : ['styles/**/*','scripts/**/*','images/**/*']
          dest    : '<%%= project.app.scripts %>'
          ext     : '.js'
        }]

    # Minifies images
    imagemin:
      app:
        files: [{
          expand  : true
          cwd     : '<%%= project.dev.images %>'
          src     : ['**/*.{jpg,jpeg,png,gif}']
          dest    : '<%%= project.app.images %>'
        }]

    # Minifies svg
    svgmin:
      app:
        files: [{
          expand  : true
          cwd     : '<%%= project.dev.images %>'
          src     : ['**/*.{svg}']
          dest    : '<%%= project.app.images %>'
        }]

    # Minifies css
    cssmin:
      app:
        files: [{
          expand  : true
          cwd     : '<%%= project.app.styles %>'
          src     : ['**/*.{css}']
          dest    : '<%%= project.app.styles %>'
          ext     : '.css'
        }]

    # Minfies html
    htmlmin:
      app:
        files: [{
          expand  : true
          cwd     : '<%%= project.app.static %>'
          src     : ['**/*.{html}']
          dest    : '<%%= project.app.static %>'
          ext     : '.css'
        }]

    # Minifies js
    uglify:
      app:
        files: [{
          expand  : true
          cwd     : '<%= project.app.scripts %>'
          src     : ['**/*.js']
          dest    : '<%= project.app.scripts %>'
        }]

    # Copies remaining files to places other tasks can use
    copy:
      css:
        files: [{
          expand  : true
          cwd     : '<%%= project.dev.styles %>'
          src     : ['**/*.css']
          dest    : '<%%= project.app.styles %>'
        }]
      js:
        files: [{
          expand  : true
          cwd     : '<%%= project.dev.scripts %>'
          src     : ['**/*.js']
          dest    : '<%%= project.app.scripts %>'
        }]
      other:
        files: [{
          expand  : true
          cwd     : '<%%= project.dev.static %>'
          src     : [
            '**/*.{ico,png,txt}'
            '**/*.webp'
            'styles/fonts/**/*.*'
            '**/*.html'
            '!node_modules/**/*']
          dest    : '<%%= project.app.static %>'
        }]

    # Run some tasks in parallel to speed up build process
    concurrent:
      staging: [<% if (coffee) { %>
        'coffee:development',<% } %>
        'sass:dev'
        'copy:css'
        'imagemin'
        'svgmin'
      ]
      test: []
      app: []

  }

  grunt.registerTask 'serve',
  'everything you need to start writing code', [
    'build:development'
    <% if (sandbox) { %>'connect:sandbox'<% } else { %>'connect:livereload'<% } %>
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

  grunt.registerTask 'build:staging',
  'build static files for a staging environment', [
    'clean:static'
    'concurrent:staging'
    'autoprefixer:static'
    'jshint:js'
    'copy:js'
    'cssmin'
    'uglify'
    'rev'
    'htmlmin'
  ]

  grunt.registerTask 'build:development',
  'build static files for a development environment', [
    'clean:static'
    'sass:dev'
    'copy:css'
    'copy:other'
    'autoprefixer:static'
    <% if (coffee) { %>'coffee:development'<% } %>
    'jshint:js'
    'copy:js'
  ]

  grunt.registerTask 'default', ['serve']

  # § #








