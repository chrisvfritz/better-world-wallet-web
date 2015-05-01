gulp       = require 'gulp'
browserify = require 'gulp-browserify'
uglify     = require 'gulp-uglify'
rename     = require 'gulp-rename'
jade       = require 'gulp-jade'
sass       = require 'gulp-sass'
minify_css = require 'gulp-minify-css'
gutil      = require 'gulp-util'
gh_pages   = require 'gulp-gh-pages'

gulp.task 'html', ->
  gulp.src 'src/*.jade'
    .pipe handle_errors jade()
    .pipe gulp.dest 'dist'

gulp.task 'js', ->
  gulp.src 'src/coffee/main.cjsx', { read: false }
    .pipe handle_errors browserify
      transform: ['coffee-reactify']
      extensions: [
          '.coffee'
          '.cjsx'
        ]
      paths: [
        './node_modules'
        './src/coffee'
      ]
    .pipe handle_errors uglify()
    .pipe rename 'main.js'
    .pipe gulp.dest 'dist/js'

gulp.task 'css', ->
  gulp.src 'src/scss/main.scss'
    .pipe handle_errors sass()
    .pipe handle_errors minify_css()
    .pipe gulp.dest 'dist/css'

gulp.task 'deploy', ->
  gulp.src 'dist/**/*'
    .pipe gh_pages()

gulp.task 'default', ['html', 'js', 'css', 'watch']

gulp.task 'watch', ->
  gulp.watch 'src/**/*.jade', ['html']
  gulp.watch [
    'src/coffee/**/*.coffee'
    'src/coffee/**/*.cjsx'
  ], ['js']
  gulp.watch 'src/scss/**/*.scss', ['css']

# --------------
# Helper Methods
# --------------

# Prevents `gulp watch` from crashing when there are compile errors.
# This is supposed to be fixed in gulp 4.0 (https://github.com/gulpjs/gulp/issues/71),
# but until then, this is the best workaround I can find.

handle_errors = (stream) ->
  stream.on 'error', ->
    gutil.log.apply @, arguments
    stream.end()