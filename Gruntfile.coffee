module.exports = (grunt) ->

  grunt.loadNpmTasks('grunt-contrib-coffee')
  grunt.loadNpmTasks('grunt-contrib-connect')
  grunt.loadNpmTasks('grunt-contrib-jade')
  grunt.loadNpmTasks('grunt-contrib-jshint')
  grunt.loadNpmTasks('grunt-contrib-sass')
  grunt.loadNpmTasks('grunt-contrib-uglify')
  grunt.loadNpmTasks('grunt-contrib-watch')

  GRUNT_CHANGED_PATH = '.grunt-changed-file'
  if grunt.file.exists GRUNT_CHANGED_PATH
    changed = grunt.file.read GRUNT_CHANGED_PATH
    grunt.file.delete GRUNT_CHANGED_PATH
    changed_only = (file)-> file is changed
  else
    changed_only = -> true

  data = {}

  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')

    # local Server
    connect:
      server:
        options:
          port: 9000

    # watch
    watch:
      jade:
        files: '**/*.jade'
        tasks: 'jade'
      html:
        files: '**/*.html'
        options:
          livereload: true
          nospawn: true
      sass:
        files: '**/*.s*ss'
        tasks: 'sass'
        options:
          livereload: true
          nospawn: true
      coffee:
        files: 'src/coffee/*.coffee'
        tasks: ['coffee','uglify']
        options:
          livereload: true
          nospawn: true

    # jade
    jade:
      files:
        options: pretty: true
        expand : true
        cwd    : 'src/' # 対象フォルダ
        src    : ['**/*.jade', '!**/_*.jade']
        dest   : '' # コンパイルフォルダ
        ext    : '.html'
        filter : changed_only

    # sass
    sass:
      options:
        # sourcemap: true
        style: 'expanded'
      compile:
        files: 'style.css':'src/sass/style.sass'
      filter : changed_only

    # coffee
    coffee:
      compile:
        options:
          bare: true
        files:
          "lupin.js": "src/coffee/lupin.coffee"
          "app.js": "src/coffee/app.coffee"

    # 圧縮
    uglify:
      build:
        files:
          "lupin.min.js": ["lupin.js"]

  grunt.event.on 'watch', (action, changed)->
    if action is 'changed'
      if not /(layout)/.test changed
        grunt.file.write GRUNT_CHANGED_PATH, changed


  # start local server
  grunt.registerTask "default", ["connect", "watch",'connect:livereload']

  # "default" でデフォルトのタスクを設定
  grunt.registerTask "release", ["uglify:build", "coffee:build"]
