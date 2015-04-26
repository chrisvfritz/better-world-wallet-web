'use strict';

var path = require('path');

var applySourceMap = require('vinyl-sourcemaps-apply');
var CleanCSS = require('clean-css');
var objectAssign = require('object-assign');
var PluginError = require('gulp-util').PluginError;
var through2 = require('through2');
var VinylBufferStream = require('vinyl-bufferstream');

module.exports = function gulpMinifyCSS(options) {
  options = options || {};

  return through2.obj(function modifyContents(file, enc, cb) {
    var run = new VinylBufferStream(function(buf, done) {
      var fileOptions = objectAssign({}, options);

      // Image URLs are rebased with the assumption that they are relative to the
      // CSS file they appear in (unless "relativeTo" option is explicitly set by
      // caller)
      fileOptions.relativeTo = options.relativeTo || path.resolve(path.dirname(file.path));

      // Enable sourcemap support if initialized file comes in.
      if (file.sourceMap) {
        fileOptions.sourceMap = JSON.stringify(file.sourceMap);
      }

      new CleanCSS(fileOptions).minify(String(buf), function(errors, css) {
        if (errors) {
          done(errors.join(' '));
          return;
        }

        if (css.sourceMap && file.sourceMap) {
          var map = JSON.parse(css.sourceMap);
          map.file = path.relative(file.base, file.path);
          map.sources = map.sources.map(function(src) {
            if (/^(https?:)?\/\//.test(src)) {
              return src;
            }

            return path.relative(file.base, src === '$stdin' ? file.path : src);
          });

          applySourceMap(file, map);
        }

        done(null, new Buffer(css.styles));
      });
    });

    var self = this;

    run(file, function(err, contents) {
      if (err) {
        self.emit('error', new PluginError('gulp-minify-css', err, {fileName: file.path}));
      } else {
        file.contents = contents;
        self.push(file);
      }
      cb();
    });
  });
};
