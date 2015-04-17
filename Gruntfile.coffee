#global module:false

"use strict"

module.exports = (grunt) ->
  grunt.loadNpmTasks "grunt-bower-task"
  grunt.loadNpmTasks "grunt-contrib-connect"
  grunt.loadNpmTasks "grunt-contrib-copy"
  grunt.loadNpmTasks "grunt-contrib-watch"
  grunt.loadNpmTasks "grunt-exec"

  grunt.initConfig

    copy:
      jquery:
        files: [{
          expand: true
          cwd: "bower_components/jquery/dist/"
          src: "*"
          dest: "assets/js/jquery"
        }]
      fancybox:
        files: [{
          expand: true
          cwd: "bower_components/fancybox/source/"
          src: "**"
          dest: "assets/js/fancybox"
        }]
      swipebox:
        files: [
          {
            expand: true
            cwd: "bower_components/swipebox/src/js/"
            src: "jquery.swipebox.min.js"
            dest: "assets/js/swipebox/src"
          }
          {
            expand: true
            cwd: "bower_components/swipebox/src/css/"
            src: "swipebox.min.css"
            dest: "assets/js/swipebox/css"
          }
          {
            expand: true
            cwd: "bower_components/swipebox/src/img/"
            src: "**"
            dest: "assets/js/swipebox/img"
          }
          ]
      imagesloaded:
        files: [{
          expand: true
          cwd: "bower_components/imagesloaded/"
          src: "imagesloaded.pkgd.min.js"
          dest: "assets/js/imagesLoaded"
        }]

    exec:
      jekyll:
        cmd: "jekyll build --trace"

    watch:
      options:
        livereload: true
      source:
        files: [
          "_drafts/**/*"
          "_includes/**/*"
          "_layouts/**/*"
          "_posts/**/*"
          "_sass/**/*"
          "assets/**/*"
          "css/**/*"
          "_config.yml"
          "*.html"
          "*.md"
        ]
        tasks: [
          "exec:jekyll"
        ]

    connect:
      server:
        options:
          port: 4000
          base: '_site'
          livereload: true

  grunt.registerTask "build", [
    "copy"
    "exec:jekyll"
  ]

  grunt.registerTask "serve", [
    "build"
    "connect:server"
    "watch"
  ]

  grunt.registerTask "default", [
    "serve"
  ]
