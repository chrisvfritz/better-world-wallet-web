gulp       = require 'gulp'
browserify = require 'gulp-browserify'
uglify     = require 'gulp-uglify'
gzip       = require 'gulp-gzip'
rename     = require 'gulp-rename'
jade       = require 'gulp-jade'
sass       = require 'gulp-sass'
minify_css = require 'gulp-minify-css'
gutil      = require 'gulp-util'
webserver  = require 'gulp-webserver'
gh_pages   = require 'gulp-gh-pages'
git        = require 'gulp-git'
del        = require 'del'
ARGV       = require('yargs').argv

# -------------
# Configuration
# -------------

CONFIG =
  src:
    dir: 'src'
  dev:
    dir: 'tmp/live'
  prod:
    dir: 'dist'
  coffee:
    dir: 'coffee'
    main:
      name: 'main'
      extension: '.cjsx'
    extensions: [
      '.coffee'
      '.cjsx'
    ]
    transformations: [
      'coffee-reactify'
    ]
  scss:
    dir: 'scss'
    main:
      name: 'main'
      extension: '.scss'
  static:
    dir: 'static'

CONFIG.coffee.paths = [
  'node_modules'
  "#{CONFIG.src.dir}/#{CONFIG.coffee.dir}"
]

# -----------
# Development
# -----------

gulp.task 'dev:html', ->
  gulp.src "#{CONFIG.src.dir}/*.jade"
    .pipe handle_errors jade
      pretty: true
    .pipe gulp.dest CONFIG.dev.dir

gulp.task 'dev:js', ->
  gulp.src "#{CONFIG.src.dir}/#{CONFIG.coffee.dir}/#{CONFIG.coffee.main.name}#{CONFIG.coffee.main.extension}", { read: false }
    .pipe handle_errors browserify
      transform:  CONFIG.coffee.transformations
      extensions: CONFIG.coffee.extensions
      paths:      CONFIG.coffee.paths
    .pipe rename "#{CONFIG.coffee.main.name}.js"
    .pipe gulp.dest "#{CONFIG.dev.dir}/js"

gulp.task 'dev:css', ->
  gulp.src "#{CONFIG.src.dir}/#{CONFIG.scss.dir}/#{CONFIG.scss.main.name}#{CONFIG.scss.main.extension}"
    .pipe handle_errors sass()
    .pipe gulp.dest "#{CONFIG.dev.dir}/css"

gulp.task 'dev:static', ->
  gulp.src "#{CONFIG.src.dir}/#{CONFIG.static.dir}/**/*.*"
    .pipe gulp.dest "#{CONFIG.dev.dir}/assets"

gulp.task 'dev:build', ['dev:html', 'dev:js', 'dev:css', 'dev:static']

gulp.task 'serve', ['dev:build'], ->
  gulp.src CONFIG.dev.dir
    .pipe webserver
      livereload: true
      open: true

gulp.task 'watch', ->
  gulp.watch "#{CONFIG.src.dir}/**/*.jade", ['dev:html']
  gulp.watch CONFIG.coffee.extensions.map( (ext) -> "#{CONFIG.src.dir}/#{CONFIG.coffee.dir}/**/*#{ext}" ), ['dev:js']
  gulp.watch "#{CONFIG.src.dir}/#{CONFIG.scss.dir}/**/*.scss", ['dev:css']
  gulp.watch "#{CONFIG.src.dir}/#{CONFIG.static.dir}/**/*.*", ['dev:static']

gulp.task 'default', ['serve', 'watch']

# ----------
# Production
# ----------

gulp.task 'prod:clean', (callback) ->
  del [CONFIG.prod.dir], callback

gulp.task 'prod:html', ['prod:clean'], ->
  gulp.src "#{CONFIG.src.dir}/*.jade"
    .pipe handle_errors jade()
    .pipe gulp.dest CONFIG.prod.dir

gulp.task 'prod:js', ['prod:clean'], ->
  gulp.src "#{CONFIG.src.dir}/#{CONFIG.coffee.dir}/#{CONFIG.coffee.main.name}#{CONFIG.coffee.main.extension}", { read: false }
    .pipe handle_errors browserify
      transform:  CONFIG.coffee.transformations
      extensions: CONFIG.coffee.extensions
      paths:      CONFIG.coffee.paths
    .pipe handle_errors uglify()
    .pipe rename "#{CONFIG.coffee.main.name}.js"
    .pipe gulp.dest "#{CONFIG.prod.dir}/js"

gulp.task 'prod:css', ['prod:clean'], ->
  gulp.src "#{CONFIG.src.dir}/#{CONFIG.scss.dir}/#{CONFIG.scss.main.name}#{CONFIG.scss.main.extension}"
    .pipe handle_errors sass()
    .pipe handle_errors minify_css()
    .pipe gulp.dest "#{CONFIG.prod.dir}/css"

gulp.task 'prod:static', ['prod:clean'], ->
  gulp.src "#{CONFIG.src.dir}/#{CONFIG.static.dir}/**/*.*"
    .pipe gulp.dest "#{CONFIG.prod.dir}/assets"

gulp.task 'prod:build', ['prod:html', 'prod:js', 'prod:css', 'prod:static']

gulp.task 'prod:compress', ['prod:build'], ->
  gulp.src "#{CONFIG.prod.dir}/**/*.*"
    .pipe gzip()
    .pipe gulp.dest CONFIG.prod.dir

gulp.task 'deploy', ['prod:compress'], ->
  gulp.src "#{CONFIG.prod.dir}/**/*"
    .pipe gh_pages()

# ---
# Git
# ---

gulp.task 'commit', ['deploy'], ->
  gulp.src '.'
    .pipe git.add
      args: '-A'
    .pipe git.commit ARGV.m

gulp.task 'submit', ['commit'], ->
  git.push 'origin', 'master', (error) ->
    throw error if error

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